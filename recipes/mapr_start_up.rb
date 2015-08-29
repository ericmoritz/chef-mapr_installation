# Start Zookeeper service
def role?(role_name)
  Mapr.role? node, role_name
end

include_recipe 'mapr_installation::mapr_start_zookeeper' if role? 'zk'

execute 'sleep for zookeeper' do
  command 'sleep 60'
end

# Start CLDB service if this is a cldb node
include_recipe 'mapr_installation::mapr_start_warden' if role? 'cldb'

# Wait for a CLDB master
execute 'CLDB up and running?' do
  command '/opt/mapr/server/scripts/waitfor.py \'ServerID\' maprcli node cldbmaster'
end

# If we're not a CLDB node, start the warden now that the cldbmaster
# is up
include_recipe 'mapr_installation::mapr_start_warden' unless role? 'cldb'

# Wait for the warden to come up before we continue with ecosystem components
execute 'Warden running?' do
  command '/opt/mapr/server/scripts/waitfor.py \'process\' service mapr-warden status'
end
