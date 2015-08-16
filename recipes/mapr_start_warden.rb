log "\n=========== Start MapR mapr_start_warden.rb =============\n"

if node['reload_warden']
  # restart the warden if we need to
  service 'mapr-warden' do
    supports :status => true
    action [:enable, :restart]
  end
else
  # otherwise just start it if needed
  service 'mapr-warden' do
    supports :status => true
    action [:enable, :start]
  end
end
