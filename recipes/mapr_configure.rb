log "\n=========== Start MapR mapr_configure.rb =============\n"

def service_node(type)
  return node['mapr']["#{type}_ips"] ? node['mapr']["#{type}_ips"] : node['mapr']["#{type}"]
end

def service_nodes(type)
  # use the _ips addresses over the FQDN addresses for backwards
  # compatibility
  ips = node['mapr']["#{type}_ips"]
  fqdns = node['mapr']["#{type}"]

  if ips.empty?
    log "#{type} fqdn #{fqdns}"
    nodes = fqdns
  else
    log "#{type} ips"
    nodes = ips
  end
  return nodes.reject(&:empty?).join(',')
end

cldb_nodes = service_nodes('cldb')
zk_nodes = service_nodes('zk')
rm_nodes = service_nodes('rm')

config_command = []
config_command << "#{node['mapr']['home']}/server/configure.sh"
config_command << "-C #{cldb_nodes}" unless cldb_nodes.empty?
config_command << "-Z #{zk_nodes}" unless zk_nodes.empty?
config_command << "-RM #{rm_nodes}" unless rm_nodes.empty?
config_command << "-HS #{service_node('hs')}"
config_command << "-N #{node['mapr']['clustername']}"
config_command << '-u mapr -g mapr'
config_command << '-no-autostart'
config_command = config_command.join(' ')


# Run configure.sh to configure the nodes, do NOT bring the cluster up
execute 'Run configure.sh to configure cluster' do
  command config_command
  not_if { ::File.exist?("#{node['mapr']['home']}/conf/disktab") }
end
