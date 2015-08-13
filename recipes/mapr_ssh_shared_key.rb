Chef::Application.fatal!("node['mapr]'['shared_key']['private'] is not set, can not continue", 42) if not node['mapr']['shared_key']['private']
Chef::Application.fatal!("node['mapr]'['shared_key']['public'] is not set, can not continue", 42) if not node['mapr']['shared_key']['public']

directory "/root/.ssh" do
  owner "root"
  group "root"
  mode 700
end


file "/root/.ssh/id_rsa" do
  content node['mapr']['shared_key']['private']
  owner "root"
  group "root"
  mode 600
end

file "/root/.ssh/authorized_keys" do
  content node['mapr']['shared_key']['public']
  owner "root"
  group "root"
  mode 600
end

