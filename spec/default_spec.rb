# encoding: utf-8
require 'chefspec'
require 'spec_helper'
require 'fauxhai'

describe 'mapr_installation::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.5').converge(described_recipe) }
  before do
    stub_command("cat /etc/rc.local | grep 'never > /sys/kernel/mm/transparent_hugepage/enabled'").and_return(true)  

    stub_data_bag_item('users', 'mapr').and_return(
      {
        'id' => 'mapr',
        'uid' => 5000,
        'gid' => 5000,
        'password' => 'yay!'
      }
    )
  end

  it 'includes recipe mapr_installation::mapr_node' do
    expect(chef_run).to include_recipe("mapr_installation::mapr_node")
  end

  it 'includes recipe mapr_installation::mapr_packages' do
    expect(chef_run).to include_recipe("mapr_installation::mapr_packages")
  end

  it 'includes recipe mapr_installation::mapr_setenv' do
    expect(chef_run).to include_recipe("mapr_installation::mapr_setenv")
  end

  it 'includes recipe mapr_installation::mapr_configure' do
    expect(chef_run).to include_recipe("mapr_installation::mapr_configure")
  end

  it 'includes recipe mapr_installation::mapr_disksetup' do
    expect(chef_run).to include_recipe("mapr_installation::mapr_disksetup")
  end

  it 'includes recipe mapr_installation::mapr_start_up' do
    expect(chef_run).to include_recipe("mapr_installation::mapr_start_up")
  end

end
