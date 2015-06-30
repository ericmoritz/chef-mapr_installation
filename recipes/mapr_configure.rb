log "\n=========== Start MapR mapr_configure.rb =============\n"

# Make sane list of appropriate nodes...might be a better way to do this...
cldb_nodes = node['mapr']['cldb_ips'].reject(&:empty?).join(',')
zk_nodes = node['mapr']['zk_ips'].reject(&:empty?).join(',')
rm_nodes = node['mapr']['rm_ips'].reject(&:empty?).join(',')

# Run configure.sh to configure the nodes, do NOT bring the cluster up

execute 'Run configure.sh to configure cluster' do
  command "#{node['mapr']['home']}/server/configure.sh -C #{cldb_nodes} -Z #{zk_nodes} -RM #{rm_nodes}
    -HS #{node['mapr']['hs_ips']} -D #{node['mapr']['node']['disks']} -N #{node['mapr']['clustername']} -no-autostart"
  not_if { ::File.exist?("#{node['mapr']['home']}/conf/disktab") }
  #	action :run
end
