# encoding: utf-8
require 'chefspec'
require 'spec_helper'
require 'fauxhai'

describe 'mapr_installation::mapr_users' do
  let(:chef_run) {
    ChefSpec::SoloRunner.new(
      platform: 'centos',
      version: '6.5'
    )
  }

  context 'normal user' do
    before do
      chef_run.node.set['users'] = ['user']
      chef_run.node.set['mapr'] = {
        'user' => nil,
        'group' => nil
      }

      stub_data_bag_item('users', 'mapr').and_return(nil)

      stub_data_bag_item('users', 'user').and_return(
        {
          'id' => 'user',
          'group' => 'user-group',
          'uid' => 2000,
          'gid' => 2001,
          'password' => 'user-password'
        }
      )
      chef_run.converge(described_recipe)
    end

    it 'should set the group\'s gid correctly' do
      expect(chef_run).to modify_group('user-group').with(
                            gid: 2001
                          )
    end

    it 'should set the user\'s gid correctly' do
      expect(chef_run).to modify_user('user').with(
                            gid: 2001
                          )
    end

    it 'should set the user\'s uid correctly' do
      expect(chef_run).to modify_user('user').with(
                            uid: 2000
                          )
    end

    it 'should set the user\'s password correctly' do
      expect(chef_run).to modify_user('user').with(
                            uid: 2000
                          )
    end

  end

  # 
  # DEPRECATED: the mapr user attributes have been deprecated in favor
  #             of overloading the users cookbook's 'users' data bag
  context "mapr user with deprecated attributes and no databag" do
    before do
      chef_run.node.set['mapr'] = {
        'user' => 'mapr-user',
        'group' => 'mapr-user-group',
        "uid" => 1000,
        "gid" => 1001,
        "password" => 'mapr-password'
      }

      stub_data_bag_item('users', 'mapr-user').and_return(nil)
      chef_run.converge(described_recipe)
    end

    it 'should set the group\'s gid correctly' do
      expect(chef_run).to modify_group('mapr-user-group').with(
                            gid: 1001
                          )
    end

    it 'should set the mapr uid to 1000' do
      expect(chef_run).to modify_user('mapr-user').with(uid: 1000)
    end

    it 'should set the mapr gid to 1001' do
      expect(chef_run).to modify_user('mapr-user').with(gid: 1001)
    end

    it 'should set the mapr password to "mapr-deprecated-password-field"' do
      expect(chef_run).to modify_user('mapr-user').with(
                            password: "mapr-password"
                          )
    end

  end

  context "mapr user databag attributes override deprecated options" do
    before do
      chef_run.node.set['users'] = ['mapr-user']
      chef_run.node.set['mapr'] = {
        'user' => 'mapr-user',
        'group' => 'mapr-user-group',
        "uid" => 1000,
        "gid" => 1001,
        "password" => 'mapr-password'
      }

      stub_data_bag_item('users', 'mapr-user').and_return(
        {
          'id' => 'mapr-user',
          'group' => 'mapr-user-group-db',
          'uid' => 3000,
          'gid' => 3001,
          'password' => 'mapr-password-db'
        }
      )
      chef_run.converge(described_recipe)
    end

    it 'should set the group\'s gid correctly' do
      expect(chef_run).to modify_group('mapr-user-group-db').with(
                            gid: 3001
                          )
    end

    it 'should set the mapr uid to 3000' do
      expect(chef_run).to modify_user('mapr-user').with(uid: 3000)
    end

    it 'should set the mapr gid to 3001' do
      expect(chef_run).to modify_user('mapr-user').with(gid: 3001)
    end

    it 'should set the mapr password to "mapr-deprecated-password-field"' do
      expect(chef_run).to modify_user('mapr-user').with(
                            password: "mapr-password-db"
                          )
    end

  end
end

