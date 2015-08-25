# encoding: utf-8
require 'chefspec'
require 'spec_helper'
require 'fauxhai'

describe 'mapr_installation::mapr_webserver' do
  let(:chef_run) {
    ChefSpec::SoloRunner.new(
      platform: 'centos',
      version: '6.5'
    ).converge(described_recipe)
  }

  it 'install mapr-webserver' do
    expect(chef_run).to install_package('mapr-webserver')
  end

  it 'install custom web.conf' do
    expect(chef_run).to create_cookbook_file(
                          '/opt/mapr/conf/web.conf'
                        ).with(
                          user: 'mapr',
                          group: 'mapr',
                          mode: '0644'
                        )
  end
end
