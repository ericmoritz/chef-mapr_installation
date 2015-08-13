#
# Cookbook Name:: mapr
# Recipe:: clush (clustershell)
#
# Copyright 2013, MapR Technologies
#

log "\n=========== Start MapR clush.rb =============\n"

# Install clush
remote_file "Clush Package" do
  source node['mapr']['clush']['url']
  owner 'root'
  group 'root'
  path '/tmp/clustershell.tar.gz'
end
  


execute "Installing clush" do
  command "easy_install /tmp/clustershell.tar.gz"
end

remote_directory "/etc/clustershell" do
  source "clustershell"
  user "root"
  group "root"
  mode "755"
  files_owner "root"
  files_group "root"
  files_mode "644"
end

all = node['mapr']['cluster_node_ips'].reject(&:empty?).join(',')
cldb_nodes = node['mapr']['cldb_ips'].reject(&:empty?).join(',')
zk_nodes = node['mapr']['zk_ips'].reject(&:empty?).join(',')
rm_nodes = node['mapr']['rm_ips'].reject(&:empty?).join(',')
ws_nodes = node['mapr']['ws_ips'].reject(&:empty?).join(',')
hs_server = node['mapr']['hs_ips']


# creating directory if it does not exist

directory '/etc/clustershell' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# groups file
template '/etc/clustershell/groups' do
  source 'clustershell.groups.erb'
  variables(
    :all => all,
    :cldb => cldb_nodes,
    :zk => zk_nodes,
    :rm => rm_nodes,
    :ws => ws_nodes,
    :hs => hs_server
  )
  mode 0644
end
