# encoding: utf-8
require 'chefspec'
require 'spec_helper'
require 'fauxhai'

describe 'mapr_installation::firewall' do
  let(:chef_run) { ChefSpec::SoloRunner.
                   new(platform: 'centos', version: '6.5').
                   converge(described_recipe) }
  
  it 'opens cldb' do
    expect(chef_run).to create_firewall_rule('cldb').with(
                          port: 7222,
                          command: :allow,
                          protocol: :tcp
                        )
  end
  
  it 'opens cldb-web' do
    expect(chef_run).to create_firewall_rule('cldb-web').with(
                          port: 7221,
                          command: :allow,
                          protocol: :tcp
                        )

  end
  
  it 'opens hs2' do
    expect(chef_run).to create_firewall_rule('hs2').with(
                          port: 10000,
                          command: :allow,
                          protocol: :tcp
                        )
  end
  
  it 'opens hue' do

    expect(chef_run).to create_firewall_rule('hue').with(
                          port: 8888,
                          command: :allow,
                          protocol: :tcp
                        )
  end
  
  it 'opens oozie' do

    expect(chef_run).to create_firewall_rule('oozie').with(
                          port: 11000,
                          command: :allow,
                          protocol: :tcp
                        )
  end
  
  it 'opens impala-server' do

    expect(chef_run).to create_firewall_rule('impala-server').with(
                          port: 21000,
                          command: :allow,
                          protocol: :tcp
                        )

  end
  
  it 'open rm-web' do
    expect(chef_run).to create_firewall_rule('rm-web').with(
                          port: 8088,
                          command: :allow,
                          protocol: :tcp
                        )
  end
  
  it 'opens ws' do
    expect(chef_run).to create_firewall_rule('ws').with(
                          port: 8080,
                          command: :allow,
                          protocol: :tcp
                        )

  end

end
