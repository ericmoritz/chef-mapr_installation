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
include_recipe 'mapr_installation::mapr_ssh_shared_key'
include_recipe 'mapr_installation::user_mapr'

include_recipe 'mapr_installation::user_root' if node['mapr']['manage_root'] == true

include_recipe 'mapr_installation::validate_host'

include_recipe 'mapr_installation::ssh' if node['mapr']['manage_ssh'] == true

include_recipe 'ntp'

# All cluster nodes need the following:
include_recipe 'mapr_installation::mapr_base'
include_recipe 'mapr_installation::mapr_nodemanager'

remote_directory "/opt/mapr/server/scripts" do
  source "scripts"
  user "root"
  group "root"
  mode "755"
  files_owner "root"
  files_group "root"
  files_mode "755"
end


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
include_recipe 'mapr_installation::mapr_disksetup'


# Enable the zookeeper service
if is_zk == 'yes'
  service 'mapr-zookeeper' do
    action [:enable]
  end
end

# Enable the warden
service 'mapr-warden' do
  action [:enable]
end

if not node['mapr']['isvm']
  execute "Wait for cluster to come up" do
   command "/opt/mapr/server/scripts/wait-for-cluster.py #{node['mapr']['node_count']} #{node['mapr']['zk'].size}"
  end
end
