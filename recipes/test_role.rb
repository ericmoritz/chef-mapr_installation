base_nodes = search(:node, "role:test_role")
zk_nodes = search(:node, "role:mapr_zookeeper")

def create_node_service_list(roles)
  service_nodes = []
  node_fqdn_list = []
  service_nodes = search(:node, "role:#{roles}")
    #base_nodes = search(:node, "role:test_role")
  service_nodes.each do |node|
    node_fqdn_list.push("#{node['fqdn']}")
 #  b_nodes.push("#{node['fqdn']}")
  end
  
  node_list = []
  node_list = node_fqdn_list.reject(&:empty?).join(',') 

  node_list
end

#  create array variable
#  search for nodes
#  iterate array variable
#  get fqdn for each
#  build variable with ',' delimitation

#zk = create_node_service_list("mapr_zookeeper") 
zk = create_node_service_list("test_role") 
#cldb = create_node_service_list("mapr_cldb")
cldb = create_node_service_list("test_role")
rm = create_node_service_list("mapr_resourcemanager") 
hs = create_node_service_list("mapr_historyserver")

#  command "echo /opt/mapr/server/configure.sh -C #{cldb} -Z #{zk} -RM #{rm} -HS #{hs} -N bob_the_cluster >~/test.txt"
#print "mapr_base nodes are #{base_nodes}"
#print "\nzk_nodes are #{zk_nodes}"

#b_nodes = []
#b = ""
#base_nodes.each do |node|
#print "node is #{node}"
#  b_nodes = "#{node['fqdn']}"
#  b_nodes.push("#{node['fqdn']}")
#  b = b_nodes.reject(&:empty?).join(',')
#end

#zk = ""
#z_nodes = []
#zk_nodes.each do |node|
#  z_nodes.push("#{node['fqdn']}")
#  zk = z_nodes.reject(&:empty?).join(',')
#end

#def get_nodes_with_role(role)
#   role = search(:node, "role:#{role}") 
#   role_f_list.push("#role['fqdn'.each |r| do 
#       role_fqdn = "#{r['fqdn']}"
#       role_list = rol
#   role
#zk =
#cldb =
#rm = 
#hs =
#print "\n \nbase nodes fqdn are #{b_nodes}\n"
#print "\n \nzk nodes fqdn are #{z_nodes}\n"
#
execute "build command" do
  command "echo /opt/mapr/server/configure.sh -C #{cldb} -Z #{zk} -RM #{rm} -HS #{hs} -N bob_the_cluster >~/test.txt"
end

#print "\n-C #{b_nodes.each}"
