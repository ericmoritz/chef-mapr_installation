# # Cookbook Name:: mapr_installation
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Parameter settings, user definitions, etc
include_recipe 'mapr_installation::mapr_hostalias'
include_recipe 'mapr_installation::install_prereq_packages'
include_recipe 'mapr_installation::iptables'
include_recipe 'mapr_installation::clush'
include_recipe 'mapr_installation::user_mapr'
include_recipe 'mapr_installation::validate_host'
include_recipe 'mapr_installation::ssh_private_keys'
include_recipe 'ntp'

# All cluster nodes need the following:
include_recipe 'mapr_installation::mapr_base'
include_recipe 'mapr_installation::mapr_nodemanager'
package 'mapr-pig'
execute 'easy_install mrjob'

remote_directory '/opt/mapr/server/scripts' do
  source 'scripts'
  user 'root'
  group 'root'
  mode '755'
  files_owner 'root'
  files_group 'root'
  files_mode '755'
end

is_zk = 'no'
is_cldb = 'no'

# Install CLDB service from attributes
log "CLDB on node: #{node['hostalias']}?"
node['mapr']['cldb'].each do |cldb|
  next unless node['hostalias'] == cldb
  log "Will install CLDB on node: #{node['hostalias']}"
  is_cldb = 'yes'
  include_recipe 'mapr_installation::mapr_cldb'
end

# Install Zookeeper service from attributes
log "Zookeeper on node: #{node['hostalias']}?"
node['mapr']['zk'].each do |zk|
  next unless node['hostalias'] == zk
  log "Will install Zookeeper on node: #{node['hostalias']}"
  is_zk = 'yes'
  include_recipe 'mapr_installation::mapr_zookeeper'
end

# Install Resource Manager service from attributes
log "RM on node: #{node['hostalias']}?"
node['mapr']['rm'].each do |rm|
  if node['hostalias'] == rm
    log "Will install Resource Manager on node: #{node['hostalias']}"
    include_recipe 'mapr_installation::mapr_resourcemanager'
  end
end

# Install YARN History Server service from attributes
log "HS on node: #{node['hostalias']}?"
if node['hostalias'] == node['mapr']['hs']
  log "Will install Yarn History Server  on node: #{node['hostalias']}"
  include_recipe 'mapr_installation::mapr_historyserver'
end

# Install MapR Webserver service from attributes
log "MCS on node: #{node['hostalias']}?"
node['mapr']['ws'].each do |ws|
  if node['hostalias'] == ws
    log "Will install MapR Webserver on node: #{node['hostalias']}"
    include_recipe 'mapr_installation::mapr_webserver'
  end
end

# Set up environment variables, nfsserver automount, and run configure.sh to configure cluster.
# NOTE:  This will NOT automatically bring up the cluster.  That is done below...
include_recipe 'mapr_installation::mapr_setenv'
include_recipe 'mapr_installation::mapr_configure'

include_recipe 'mapr_installation::mapr_disksetup'

# Start Zookeeper service
if is_zk == 'yes'
  include_recipe 'mapr_installation::mapr_start_zookeeper'
else
  execute 'sleep for zookeeper' do
    command 'sleep 60'
  end
end

# Start CLDB service if this is a cldb node
include_recipe 'mapr_installation::mapr_start_warden' if is_cldb == 'yes'

# Wait for a CLDB master
execute 'CLDB up and running?' do
  command '/opt/mapr/server/scripts/waitfor.py \'ServerID\' maprcli node cldbmaster'
end

# If we're not a CLDB node, start the warden now that the cldbmaster
# is up
include_recipe 'mapr_installation::mapr_start_warden' if is_cldb == 'no'

# Wait for the warden to come up before we continue with ecosystem components
execute 'Warden running?' do
  command '/opt/mapr/server/scripts/waitfor.py \'process\' service mapr-warden status'
end
