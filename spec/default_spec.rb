# encoding: utf-8
require 'chefspec'
require 'spec_helper'
require 'fauxhai'

describe 'mapr_installation::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '6.5').converge(described_recipe) }
  before do
    stub_command("cat /etc/rc.local | grep 'never > /sys/kernel/mm/transparent_hugepage/enabled'").and_return(true)  
  end

  it 'includes recipe mapr_installation::default' do
    expect(chef_run).to include_recipe("mapr_installation::default")
  end

  it 'includes recipe mapr_installation::install_prereq_packages' do
    expect(chef_run).to include_recipe("mapr_installation::install_prereq_packages")
  end

  it 'includes recipe mapr_installation::iptables' do
    expect(chef_run).to include_recipe("mapr_installation::iptables")
  end

  it 'includes recipe mapr_installation::clush' do
    expect(chef_run).to include_recipe("mapr_installation::clush")
  end

  it 'includes recipe mapr_installation::validate_host' do
    expect(chef_run).to include_recipe("mapr_installation::validate_host")
  end

  it 'includes recipe mapr_installation::mapr_base' do
    expect(chef_run).to include_recipe("mapr_installation::mapr_base")
  end

  it 'includes recipe mapr_installation::mapr_nodemanager' do
    expect(chef_run).to include_recipe("mapr_installation::mapr_nodemanager")
  end

  it 'includes recipe mapr_installation::mapr_setenv' do
    expect(chef_run).to include_recipe("mapr_installation::mapr_setenv")
  end

  it 'includes recipe mapr_installation::mapr_configure' do
    expect(chef_run).to include_recipe("mapr_installation::mapr_configure")
  end

  it 'installs package mapr-fileserver' do
    expect(chef_run).to install_package('mapr-fileserver')
  end

  it 'installs package mapr-nfs' do
    expect(chef_run).to install_package('mapr-nfs')
  end

  it 'installs package bash' do
    expect(chef_run).to install_package('bash')
  end

  it 'installs package rpcbind' do
    expect(chef_run).to install_package('rpcbind')
  end

  it 'installs package dmidecode' do
    expect(chef_run).to install_package('dmidecode')
  end

  it 'installs package glibc' do
    expect(chef_run).to install_package('glibc')
  end

  it 'installs package hdparm' do
    expect(chef_run).to install_package('hdparm')
  end

  it 'installs package initscripts' do
    expect(chef_run).to install_package('initscripts')
  end

  it 'installs package iputils' do
    expect(chef_run).to install_package('iputils')
  end

  it 'installs package irqbalance' do
    expect(chef_run).to install_package('irqbalance')
  end

  it 'installs package libgcc' do
    expect(chef_run).to install_package('libgcc')
  end

  it 'installs package libstdc++' do
    expect(chef_run).to install_package('libstdc++')
  end

  it 'installs package redhat-lsb-core' do
    expect(chef_run).to install_package('redhat-lsb-core')
  end

  it 'installs package rpm-libs' do
    expect(chef_run).to install_package('rpm-libs')
  end

  it 'installs package sdparm' do
    expect(chef_run).to install_package('sdparm')
  end

  it 'installs package shadow-utils' do
    expect(chef_run).to install_package('shadow-utils')
  end

  it 'installs package syslinux' do
    expect(chef_run).to install_package('syslinux')
  end

  it 'installs package unzip' do
    expect(chef_run).to install_package('unzip')
  end

  it 'installs package zip' do
    expect(chef_run).to install_package('zip')
  end

  it 'installs package nc' do
    expect(chef_run).to install_package('nc')
  end

end
