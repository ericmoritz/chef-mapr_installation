#
# Cookbook Name:: mapr
# Recipe:: clush (clustershell)
#
# Copyright 2013, MapR Technologies
#

log "\n=========== Start MapR clush.rb =============\n"

all = node['mapr']['cluster_nodes'].reject(&:empty?).join(',')
cldb_nodes = node['mapr']['cldb'].reject(&:empty?).join(',')
zk_nodes = node['mapr']['zk'].reject(&:empty?).join(',')
rm_nodes = node['mapr']['rm'].reject(&:empty?).join(',')
ws_nodes = node['mapr']['ws'].reject(&:empty?).join(',')
hs_server = node['mapr']['hs']

# Install clush
ruby_block "Installing clush" do
    block do 
        `rpm -ivh https://github.com/downloads/cea-hpc/clustershell/clustershell-1.6-1.el6.noarch.rpm`
    end
end


#groups file
template "/etc/clustershell/groups" do
  source "clustershell.groups.erb"
  variables({
    :all => all,
    :cldb => cldb_nodes,
    :zk => zk_nodes,
    :rm => rm_nodes,
    :ws => ws_nodes,
    :hs => hs_server
  })
  mode 0644
end
