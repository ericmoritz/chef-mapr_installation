#
# Cookbook Name:: mapr
# Recipe:: clush (clustershell)
#
# Copyright 2013, MapR Technologies
#

log "\n=========== Start MapR clush.rb =============\n"

remote_file 'clush rpm' do
  source node['mapr']['clush']['url']
  path "#{Chef::Config[:file_cache_path]}/clush.rpm"
end

# Install clush
package 'clush' do
  source "#{Chef::Config[:file_cache_path]}/clush.rpm"
end

execute 'echo "ssh_options: -oStrictHostKeyChecking=no" >> /etc/clustershell/clush.conf'
