include_recipe 'mapr_installation::install_prereq_packages'
include_recipe 'mapr_installation::iptables'
include_recipe 'mapr_installation::clush'
include_recipe 'mapr_installation::mapr_users'
include_recipe 'mapr_installation::validate_host'
include_recipe 'mapr_installation::ssh_private_keys'
include_recipe 'ntp'

remote_directory '/opt/mapr/server/scripts' do
  source 'scripts'
  user 'root'
  group 'root'
  mode '755'
  files_owner 'root'
  files_group 'root'
  files_mode '755'
end
