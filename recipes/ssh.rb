log "\n=========== Start MapR ssh.rb =============\n"

#######################
# Keys for MapR user

directory "/home/#{node['mapr']['user']}/.ssh" do
  owner  node['mapr']['user']
  group  node['mapr']['group']
  mode '700'
end

cookbook_file "/home/#{node['mapr']['user']}/.ssh/authorized_keys" do
  owner  node['mapr']['user']
  group  node['mapr']['group']
  mode '644'
  source 'mapr_id_rsa.pub'
end

cookbook_file "/home/#{node['mapr']['user']}/.ssh/id_rsa" do
  owner  node['mapr']['user']
  group  node['mapr']['group']
  mode '600'
  source 'mapr_id_rsa'
end

cookbook_file "/home/#{node['mapr']['user']}/.ssh/id_rsa.pub" do
  owner  node['mapr']['user']
  group  node['mapr']['group']
  mode '600'
  source 'mapr_id_rsa.pub'
end

cookbook_file "/home/#{node['mapr']['user']}/.ssh/config" do
  source 'ssh_config'
  owner  node['mapr']['user']
  group  node['mapr']['group']
  mode '644'
end

#######################
# Keys for root user

directory '/root/.ssh' do
  owner  'root'
  group  'root'
  mode '700'
end

cookbook_file '/root/.ssh/authorized_keys' do
  owner  'root'
  group  'root'
  mode '644'
  source 'root_id_rsa.pub'
end

cookbook_file '/root/.ssh/id_rsa' do
  owner  'root'
  group  'root'
  mode '600'
  source 'root_id_rsa'
end

cookbook_file '/root/.ssh/id_rsa.pub' do
  owner  'root'
  group  'root'
  mode '600'
  source 'root_id_rsa.pub'
end

cookbook_file '/root/.ssh/config' do
  source 'ssh_config'
  owner  'root'
  group  'root'
  mode '644'
end
