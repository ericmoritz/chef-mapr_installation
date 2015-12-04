# encoding: utf-8
require 'chefspec'
require 'spec_helper'
require 'fauxhai'

describe 'mapr_installation::firewall' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.5').converge(described_recipe) }
  it 'firewall_rule cldb' do
    expect(chef_run).to create_firewall_rule(
                          'rm',
                          :port => 7222,
                          :command => :allow
                        )
  end

end
