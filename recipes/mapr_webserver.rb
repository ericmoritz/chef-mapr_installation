log "\n=========== Start MapR mapr_webserver.rb =============\n"

package 'mapr-webserver'

cookbook_file '/opt/mapr/conf/web.conf' do
  owner 'mapr'
  group 'mapr'
  mode '0644'
  action :create
end
