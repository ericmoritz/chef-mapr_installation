# Start Zookeeper service
def role?(role_name)
  Mapr.role? node, role_name
end

def nodes(role_name)
  Mapr.role_fqdns node, role_name
end

include_recipe 'mapr_installation::mapr_start_zookeeper' if role? 'zk'

zk_nodes = nodes 'zk'
mode_pat = if zk_nodes.length > 1
             'Mode: (leader|follower)'
           else
             'Mode: standalone'
           end
execute 'Wait for zk up?' do
  command \
    '/opt/mapr/server/scripts/waitfor.py' \
    " '#{mode_pat}'" \
    ' bash -c' \
    " 'echo srvr | nc #{zk_nodes[0]} 5181'"
  timeout 1800
end

# Start CLDB service if this is a cldb node
include_recipe 'mapr_installation::mapr_start_warden' if role? 'cldb'

# Wait for a CLDB master
execute 'CLDB up and running?' do
  command '/opt/mapr/server/scripts/waitfor.py \'ServerID\' maprcli node cldbmaster'
  timeout 1800
end

# If we're not a CLDB node, start the warden now that the cldbmaster
# is up
include_recipe 'mapr_installation::mapr_start_warden' unless role? 'cldb'

# Wait for the warden to come up before we continue with ecosystem components
execute 'Warden running?' do
  command '/opt/mapr/server/scripts/waitfor.py \'process\' service mapr-warden status'
  timeout 1800
end
