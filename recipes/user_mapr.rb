log "\n=========== Start MapR user_mapr.rb =============\n"

# Update the mapr user's uid,gid, and passwd. This is something the
# chef-users cookbook doesn't support currently
db_item = data_bag_item('users', node['mapr']['user']) || {}
user_data = {}
['gid', 'uid', 'password'].each do |key|
  if db_item[key]
    user_data[key] = db_item[key]
  else
    log "node['mapr']['#{key}'] is deprecated, use #{key} in the users/mapr databag"
    user_data[key] = node['mapr'][key]
  end
end

group node['mapr']['group'] do
  gid user_data['gid']
  action :modify
end

user node['mapr']['user'] do
  uid user_data['uid']
  gid user_data['gid']
  password user_data['password']
  action :modify
end
