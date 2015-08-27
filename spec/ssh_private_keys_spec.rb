# encoding: utf-8
require 'chefspec'
require 'spec_helper'
require 'fauxhai'

describe 'mapr_installation::ssh_private_keys' do
  it "should install the ~mapr/.ssh/id_rsa key if the private_keys exists" do
    chef_run = ChefSpec::SoloRunner.new(
      platform: 'centos',
      version: '6.5'
    )

    chef_run.node.set['ssh_keys'] = {
      "mapr" => ["mapr"]
    }

    stub_data_bag_item('users', 'mapr').and_return(
      {
        "id" => 'mapr',
        'private_keys' => {
          'id_rsa' => 'This is mapr\'s private key'
        }
      }
    )

    chef_run.converge(described_recipe)
    
    expect(chef_run).to create_file('/home/mapr/.ssh/id_rsa').with(
                          user: 'mapr',
                          group: 'mapr',
                          mode: 0600,
                          content: 'This is mapr\'s private key'
                        )

  end

  it "should not crash if the user's private_keys is missing" do
    chef_run = ChefSpec::SoloRunner.new(
      platform: 'centos',
      version: '6.5'
    )

    chef_run.node.set['ssh_keys'] = {
      "mapr" => ["mapr"]
    }

    stub_data_bag_item('users', 'mapr').and_return(
      {
        "id" => 'mapr'
      }
    )

    chef_run.converge(described_recipe)

    expect(chef_run).to_not create_file('/home/mapr/.ssh/id_rsa')
  end


  it "should not crash if the user's data bag item does not exist" do
    chef_run = ChefSpec::SoloRunner.new(
      platform: 'centos',
      version: '6.5'
    )

    chef_run.node.set['ssh_keys'] = {
      "mapr" => ["mapr"]
    }

    stub_data_bag_item('users', 'mapr').and_return(nil)

    chef_run.converge(described_recipe)

    expect(chef_run).to_not create_file('/home/mapr/.ssh/id_rsa')
  end


  it "should not crash if ssh_keys does not exist" do
    chef_run = ChefSpec::SoloRunner.new(
      platform: 'centos',
      version: '6.5'
    )

    chef_run.converge(described_recipe)
    stub_data_bag_item('users', 'mapr').and_return(nil)

    expect(chef_run).to_not create_file('/home/mapr/.ssh/id_rsa')
  end
end
