# encoding: utf-8
require 'chefspec'
require 'spec_helper'
require 'fauxhai'

describe 'mapr_installation::user_mapr' do
  it "should use the data_bag attributes by default" do
    chef_run = ChefSpec::SoloRunner.new(
      platform: 'centos',
      version: '6.5'
    )

    chef_run.node.set['mapr'] = {
      'user' => 'random-user',
      'group' => 'random-user',
      'uid' => 1000,
      'gid' => 1000,
      'password' => 'xxx'
    }

    stub_data_bag_item('users', 'random-user').and_return(
      {
        'id' => 'random-user',
        'uid' => 5000,
        'gid' => 5000,
        'password' => 'yay!'
      }
    )

    chef_run.converge(described_recipe)

    expect(chef_run).to modify_group('random-user').with(
                          gid: 5000
                        )
    expect(chef_run).to modify_user('random-user').with(
                          uid: 5000,
                          gid: 5000,
                          password: 'yay!'
                        )
  end

  it "should use the deprecated attributes if the data bag attrs are missing" do
    chef_run = ChefSpec::SoloRunner.new(
      platform: 'centos',
      version: '6.5'
    )

    chef_run.node.set['mapr'] = {
      'user' => 'random-user',
      'group' => 'random-user',
      "uid" => 1000,
      "gid" => 1000,
      "password" => 'xxx'
    }

    stub_data_bag_item('users', 'random-user').and_return(
      {
        'id' => 'random-user'
      }
    )

    chef_run.converge(described_recipe)

    expect(chef_run).to modify_group('random-user').with(
                          gid: 1000
                        )
    expect(chef_run).to modify_user('random-user').with(
                          uid: 1000,
                          gid: 1000,
                          password: 'xxx'
                        )
  end
  
  it "should use the deprecated attributes if the data bag item is missing" do
    chef_run = ChefSpec::SoloRunner.new(
      platform: 'centos',
      version: '6.5'
    )

    chef_run.node.set['mapr'] = {
      'user' => 'random-user',
      'group' => 'random-user',
      "uid" => 1000,
      "gid" => 1000,
      "password" => 'xxx'
    }

    stub_data_bag_item('users', 'random-user').and_return(nil)

    chef_run.converge(described_recipe)

    expect(chef_run).to modify_group('random-user').with(
                          gid: 1000
                        )
    expect(chef_run).to modify_user('random-user').with(
                          uid: 1000,
                          gid: 1000,
                          password: 'xxx'
                        )
  end
end
