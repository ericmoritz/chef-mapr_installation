log "\n=========== Start MapR mapr_hostalias.rb =============\n"

if File.exist?('/etc/hostalias')
  node.set['hostalias'] = File.read('/etc/hostalias').strip
  Chef::Log.info("/etc/hostalias exists, using #{node['hostalias']} as hostalias")
else
  Chef::Log.info("/etc/hostalias does not exist, using #{node['fqdn']} as hostalias")
  node.set['hostalias'] = node['fqdn']
end
