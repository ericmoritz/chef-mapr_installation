# encoding: utf-8
require 'chefspec'
require 'spec_helper'
require 'fauxhai'

describe 'mapr_installation::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.5').converge(described_recipe) }
  it 'includes the iptables recipe' do
    expect(chef_run).to include_recipe('iptables')
  end
  before do
    stub_command("cat /etc/rc.local | grep 'never > /sys/kernel/mm/transparent_hugepage/enabled'").and_return(true)  
  end
end
