# encoding: utf-8
require 'chefspec'
require 'spec_helper'

describe 'mapr_installation::mapr_start_up' do
  it 'defaults to just starting warden' do
    chef_run = ChefSpec::SoloRunner.new(
      platform: 'centos',
      version: '6.5'
    )

    chef_run.converge(described_recipe)

    expect(chef_run).to_not include_recipe('mapr_installation::mapr_start_zookeeper')
    expect(chef_run).to include_recipe('mapr_installation::mapr_start_warden')
  end

  it 'should start zookeeper on a zk node' do
    chef_run = ChefSpec::SoloRunner.new(
      platform: 'centos',
      version: '6.5'
    )
    
    chef_run.node.set['hostalias'] = 'node-1'
    chef_run.node.set['mapr']['zk'] = ['node-1']

    chef_run.converge(described_recipe)

    expect(chef_run).to include_recipe('mapr_installation::mapr_start_zookeeper')
    expect(chef_run).to include_recipe('mapr_installation::mapr_start_warden')
  end
end

