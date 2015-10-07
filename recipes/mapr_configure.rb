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

# Remove yarn-site.xml because we want configure.sh to regenerate it
execute 'rm -f /opt/mapr/hadoop/hadoop-*/etc/hadoop/yarn-site.xml'

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

## Alter yarn-site.xml
ruby_block 'Configure yarn-site.xml' do
  block do
    Dir.glob('/opt/mapr/hadoop/hadoop-*/etc/hadoop/yarn-site.xml').each do |fn|
      file = Chef::Util::FileEdit.new(fn)
      file.insert_line_after_match(
        '<!-- :::CAUTION::: DO NOT EDIT ANYTHING ON OR ABOVE THIS LINE -->',
        <<-EOF
  <property>
    <name>yarn.nodemanager.hostname</name>
    <value>#{Mapr.hostalias(node)}</value>
  </property>
EOF
      )
      file.write_file
    end
  end
end
