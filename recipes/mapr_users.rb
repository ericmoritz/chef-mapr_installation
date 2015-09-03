log "\n=========== Start MapR user_mapr.rb =============\n"

# Update the mapr user's uid,gid, and passwd. This is something the
# chef-users cookbook doesn't support currently
users = (node['users'] || []).dup
users << node['mapr']['user'] if node['mapr']['user']

users.each do |username|
  db_item = data_bag_item('users', username) || {}
  user_data = {}

  ['group', 'gid', 'uid', 'password'].each do |key|
    if db_item[key]
      user_data[key] = db_item[key]
    elsif username == node['mapr']['user']
      log "node['mapr']['#{key}'] is deprecated, use #{key} in the users/mapr databag" \
          if ['gid', 'uid', 'password'].include? key

      user_data[key] = node['mapr'][key]
    end
  end

  group user_data['group'] do
    gid user_data['gid']
    action :modify
  end if user_data['group'] && user_data['gid']

  user username do
    uid user_data['uid']
    gid user_data['gid']
    password user_data['password']
    action :modify
  end
end
