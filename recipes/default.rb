# # Cookbook Name:: mapr_installation
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Parameter settings, user definitions, etc
include_recipe 'mapr_installation::install_prereq_packages'
include_recipe 'mapr_installation::iptables'
include_recipe 'mapr_installation::clush'
include_recipe 'mapr_installation::user_mapr'

include_recipe 'mapr_installation::user_root' if node['mapr']['manage_root'] == true

include_recipe 'mapr_installation::validate_host'

include_recipe 'mapr_installation::ssh' if node['mapr']['manage_ssh'] == true

include_recipe 'ntp'

# All cluster nodes need the following:
include_recipe 'mapr_installation::mapr_base'
include_recipe 'mapr_installation::mapr_nodemanager'

is_zk = 'no'
is_cldb = 'no'

# Install CLDB service from attributes
node['mapr']['cldb'].each do |cldb|
  next unless node['fqdn'] == cldb
  print "\nWill install CLDB on node: #{node['fqdn']}\n"
  is_cldb = 'yes'
  include_recipe 'mapr_installation::mapr_cldb'
end

# Install Zookeeper service from attributes
node['mapr']['zk'].each do |zk|
  next unless node['fqdn'] == zk
  print "\nWill install Zookeeper on node: #{node['fqdn']}\n"
  is_zk = 'yes'
  include_recipe 'mapr_installation::mapr_zookeeper'
end

# Install Resource Manager service from attributes
node['mapr']['rm'].each do |rm|
  if node['fqdn'] == rm
    print "\nWill install Resource Manager on node: #{node['fqdn']}\n"
    include_recipe 'mapr_installation::mapr_resourcemanager'
  end
end

# Install YARN History Server service from attributes
if node['fqdn'] == node['mapr']['hs']
  print "\nWill install Yarn History Server  on node: #{node['fqdn']}\n"
  include_recipe 'mapr_installation::mapr_historyserver'
end

# Install MapR Webserver service from attributes
node['mapr']['ws'].each do |ws|
  if node['fqdn'] == ws
    print "\nWill install MapR Webserver on node: #{node['fqdn']}\n"
    include_recipe 'mapr_installation::mapr_webserver'
  end
end

# Set up environment variables, nfsserver automount, and run configure.sh to configure cluster.
# NOTE:  This will NOT automatically bring up the cluster.  That is done below...
include_recipe 'mapr_installation::mapr_setenv'
include_recipe 'mapr_installation::mapr_configure'

# Start Zookeeper service
if is_zk == 'yes'
  include_recipe 'mapr_installation::mapr_start_zookeeper'
else
  execute 'sleep for zookeeper' do
    command 'sleep 60'
  end
end

# Start CLDB service
if is_cldb == 'yes'
  include_recipe 'mapr_installation::mapr_start_warden'
else
  execute 'sleep for cldb' do
    command 'sleep 120'
  end
end

include_recipe 'mapr_installation::mapr_start_warden' if is_cldb == 'no'

warden_running = 'no'
run_check = 'no'
ruby_block 'Warden running?' do
  block do
    while warden_running == 'no'
      run_check = Mixlib::ShellOut.new('/sbin/service mapr-warden status')
      rc = /process/.match(run_check)
      if rc.to_s == 'process'
        warden_running = 'yes'
      else
        Mixlib::ShellOut.new('sleep 5')
        print '\nSleeping for 5, waiting on warden to start...\n'
      end
    end
  end
end

cldb_running = 'no'
ruby_block 'CLDB up and running?' do
  block do
    while cldb_running == 'no'
      run_check = Mixlib::ShellOut.new('maprcli node clbmaster')
      rc = /ServerID/.match(run_check)
      if rc.to_s == 'ServerID'
        cldb_running = 'yes'
      else
        Mixlib::ShellOut.new('sleep 5')
        print '\nSleeping for 5, waiting on CLDB...\n'
      end
    end
  end
end

# Get running warden count
warden_running = '0'

ruby_block 'Getting running warden count' do
  block do
    while warden_running.to_s != node['mapr']['node_count']
      wc = Mixlib::ShellOut.new('maprcli node list -columns hostname|grep -v "hostname                      ip"|wc -l')
      warden_running = /#{node["mapr"]["node_count"]}/.match(wc)
      Mixlib::Shell.out('sleep 20')
    end
  end
end
