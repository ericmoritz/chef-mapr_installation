log "\n=========== Start MapR mapr_configure.rb =============\n"

def service_nodes(role_name)
  Mapr.mapr_role_fqdns(node, role_name)
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

# detect if we need to restart the nodes
ruby_block 'do we need to restart any services?' do
  block do
    require 'json'
    new_data = {
      'cldb' => cldb_nodes,
      'zk' => zk_nodes,
      'rm' => rm_nodes,
      'hs' => hs_node
    }
    if File.exist?('/opt/mapr/conf/configuration.json')
      old_data = JSON.parse(File.read('/opt/mapr/conf/configuration.json'))
    else
      old_data = {}
    end
    node.set['reload_zk'] = new_data['zk'] != old_data['zk']
    node.set['reload_warden'] = (
      new_data['cldb'] != old_data['cldb'] ||
      new_data['rm'] != old_data['rm'] ||
      new_data['hs'] != old_data['hs']
    )
    Chef::Log.info("new_data=#{new_data} old_data=#{old_data}, reload_warden=#{node['reload_warden']} reload_zk=#{node['reload_zk']}")

    File.write('/opt/mapr/conf/configuration.json', JSON.generate(new_data))
  end
end

# Run configure.sh to configure the nodes, do NOT bring the cluster up
execute 'Run configure.sh to configure cluster' do
  command config_command
end
