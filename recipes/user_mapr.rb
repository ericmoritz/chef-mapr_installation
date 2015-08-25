log "\n=========== Start MapR user_mapr.rb =============\n"

group node['mapr']['group'] do
  gid node['mapr']['gid']
end

user node['mapr']['user'] do
  uid node['mapr']['uid']
  gid node['mapr']['gid']
  shell '/bin/bash'
  home "/home/#{node['mapr']['user']}"
end

user 'setting mapr password' do
  username node['mapr']['user']
  password node['mapr']['password']
  action :modify
end

directory "/home/#{node['mapr']['user']}" do
  owner node['mapr']['user']
  group node['mapr']['group']
  mode 0700
end

ruby_block 'Add mapr to /etc/sudoers' do
  block do
    file = Chef::Util::FileEdit.new('/etc/sudoers')
    file.insert_line_after_match('root    ALL=(ALL)       ALL', 'mapr	ALL=(ALL) 	ALL')
    file.insert_line_if_no_match('mapr      ALL=(ALL)       ALL', 'mapr      ALL=(ALL)       ALL')
    file.write_file
  end
end
