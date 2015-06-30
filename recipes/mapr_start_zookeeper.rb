log "\n=========== Start MapR mapr_start_zookeeper.rb =============\n"

service 'mapr-zookeeper' do
  action [:enable, :start]
end
