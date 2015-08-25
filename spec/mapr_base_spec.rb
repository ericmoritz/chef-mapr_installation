# encoding: utf-8
require 'chefspec'
require 'spec_helper'
require 'fauxhai'

describe 'mapr_installation::mapr_base' do
  it 'should install nfs by default' do
    chef_run = ChefSpec::SoloRunner.new(
      platform: 'centos',
      version: '6.6'
    )
    chef_run.converge(described_recipe)

    expect(chef_run).to install_package('mapr-fileserver')
    expect(chef_run).to install_package('mapr-nfs')
  end


  it 'should install nfs only on configured nodes' do
    chef_run = ChefSpec::SoloRunner.new(
      platform: 'centos',
      version: '6.6'
    )
    chef_run.node.set['hostalias'] = 'node-1'
    chef_run.node.set['mapr']['nfs'] = ['node-1']
    chef_run.converge(described_recipe)

    expect(chef_run).to install_package('mapr-fileserver')
    expect(chef_run).to install_package('mapr-nfs')
  end

  it 'should not install nfs on an non-nfs node' do
    chef_run = ChefSpec::SoloRunner.new(
      platform: 'centos',
      version: '6.6'
    )
    chef_run.node.set['hostalias'] = 'node-1'
    chef_run.node.set['mapr']['nfs'] = ['node-2']
    chef_run.converge(described_recipe)

    expect(chef_run).to install_package('mapr-fileserver')
    expect(chef_run).to_not install_package('mapr-nfs')
  end
end
