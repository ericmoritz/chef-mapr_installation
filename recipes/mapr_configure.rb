log "\n=========== Start MapR mapr_configure.rb =============\n"

def service_nodes(role_name)
  Mapr.role_fqdns(node, role_name)
end

def service_node(role_name)
  x = service_nodes(role_name)
  if !x.empty?
    x[0]
  else
    ''
  end
end

cldb_nodes = service_nodes('cldb')
zk_nodes = service_nodes('zk')
rm_nodes = service_nodes('rm')
hs_node = service_node('hs')

config_command = []
config_command << "#{node['mapr']['home']}/server/configure.sh"
config_command << "-C #{cldb_nodes.join(',')}" unless cldb_nodes.empty?
config_command << "-Z #{zk_nodes.join(',')}" unless zk_nodes.empty?
config_command << "-RM #{rm_nodes.join(',')}" unless rm_nodes.empty?
config_command << "-HS #{hs_node}"
config_command << "-N #{node['mapr']['clustername']}"
config_command << '-u mapr -g mapr'
config_command << '-no-autostart'
config_command << '-on-prompt-cont y'
config_command = config_command.join(' ')

# Run configure.sh to configure the nodes, do NOT bring the cluster up
execute 'Run configure.sh to configure cluster' do
  command config_command
end
