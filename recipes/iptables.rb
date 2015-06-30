log "\n=========== Start MapR iptables.rb =============\n"

service 'iptables' do
  action [:stop, :disable]
end
