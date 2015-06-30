log "\n=========== Start MapR validate_host.rb =============\n"

bash 'uname -m' do
  code <<-EOF
  echo `uname -m`
  EOF
end

execute 'validate_host_viable' do
  command 'echo `uname -m`'
  action :run
end

ruby_block 'edit etc sysctl' do
  block do
    file  = Chef::Util::FileEdit.new('/etc/sysctl.conf')
    file.search_file_delete_line('#MapR Values')
    file.insert_line_if_no_match('#MapR\ Values', '\n#MapR Values')
    file.search_file_delete_line('vm.swappiness')
    file.insert_line_if_no_match('vm.swappiness =', 'vm.swappiness = 0')
    file.search_file_delete_line('net.ipv4.tcp_retries2')
    file.insert_line_if_no_match('net.ipv4.tcp_retries2', 'net.ipv4.tcp_retries2 = 5')
    file.search_file_delete_line('vm.overcommit_memory')
    file.insert_line_if_no_match('vm.overcommit_memory', 'vm.overcommit_memory = 0 \n')
    file.write_file
  end
end

ruby_block 'Edit /etc/security/limits.conf' do
  block do
    file  = Chef::Util::FileEdit.new('/etc/security/limits.conf')
    file.search_file_delete_line('mapr')
    file.search_file_delete_line('#End of')
    file.insert_line_if_no_match('mapr', 'mapr	-	nofile	64000')
    file.insert_line_if_no_match('#End of', '#End of file')
    file.write_file
  end
end

ruby_block 'Edit /etc/security/limits.d/90-nproc.conf' do
  block do
    file  = Chef::Util::FileEdit.new('/etc/security/limits.d/90-nproc.conf')
    file.search_file_delete_line('mapr')
    file.search_file_delete_line('#End of')
    file.insert_line_if_no_match('mapr', 'mapr	-	nproc	64000')
    file.insert_line_if_no_match('#End of', '#End of file')
    file.write_file
  end
end

file '/etc/yum.repos.d/maprtech.repo' do
  content "[maprtech]
  name=MapR Technologies
  baseurl=http://package.mapr.com/releases/v#{node['mapr']['version']}/redhat/
  enabled=1
  gpgcheck=0
  protect=1

  [maprecosystem]
  name=MapR Technologies
  baseurl=http://package.mapr.com/releases/ecosystem-4.x/redhat
  enabled=1
  gpgcheck=0
  protect=1"
end
