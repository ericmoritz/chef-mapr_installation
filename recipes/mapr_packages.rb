def role?(role_name)
  Mapr.role? node, role_name
end
package 'mapr-fileserver' if role? 'fs'
package 'mapr-nfs' if role? 'nfs'
package 'mapr-nodemanager' if role? 'nm'
package 'mapr-pig' if role? 'pig'
package 'mapr-cldb' if role? 'cldb'
package 'mapr-zookeeper' if role? 'zk'
package 'mapr-resourcemanager' if role? 'rm'
package 'mapr-historyserver' if role? 'hs'
include_recipe 'mapr_installation::mapr_webserver' if role? 'ws'
