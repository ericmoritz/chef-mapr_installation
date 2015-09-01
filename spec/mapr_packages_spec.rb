# encoding: utf-8
require 'chefspec'
require 'spec_helper'

describe 'mapr_installation::mapr_packages' do
  it 'defaults to a M5 worker node' do
    chef_run = ChefSpec::SoloRunner.new(
      platform: 'centos',
      version: '6.5'
    )

    chef_run.converge(described_recipe)
    expect(chef_run).to install_package('mapr-fileserver')
    expect(chef_run).to install_package('mapr-nfs')
    expect(chef_run).to install_package('mapr-nodemanager')
    expect(chef_run).to install_package('mapr-pig')
    expect(chef_run).to_not install_package('mapr-cldb')
    expect(chef_run).to_not install_package('mapr-zookeeper')
    expect(chef_run).to_not install_package('mapr-resourcemanager')
    expect(chef_run).to_not install_package('mapr-historyserver')
    expect(chef_run).to_not include_recipe('mapr-webserver')
  end

  it 'should allow cldb,zk,rm,hs,ws to be turned on' do
    chef_run = ChefSpec::SoloRunner.new(
      platform: 'centos',
      version: '6.5'
    )

    chef_run.node.set['hostalias'] = 'node-1'
    chef_run.node.set['mapr'] = {
      'cldb' => ['node-1'],
      'zk' => ['node-1'],
      'rm' => ['node-1'],
      'hs' => ['node-1'],
      'ws' => ['node-1']
    }

    chef_run.converge(described_recipe)
    expect(chef_run).to install_package('mapr-fileserver')
    expect(chef_run).to install_package('mapr-nfs')
    expect(chef_run).to install_package('mapr-nodemanager')
    expect(chef_run).to install_package('mapr-pig')
    expect(chef_run).to install_package('mapr-cldb')
    expect(chef_run).to install_package('mapr-zookeeper')
    expect(chef_run).to install_package('mapr-resourcemanager')
    expect(chef_run).to install_package('mapr-historyserver')
    expect(chef_run).to include_recipe('mapr_installation::mapr_webserver')
  end
end
