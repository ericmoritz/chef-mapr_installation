include_recipe 'firewall'

# hardcording the scalr-client ports until chef-scalrizer is live
firewall_rule 'scalr-tcp' do
  port     8008..8013
  command  :allow
end

firewall_rule 'scalr-udp' do
  port     8014
  protocol :udp
  command  :allow
end

node['mapr']['firewall_rules'].each do |rule|
  firewall_rule rule['name'] do
    port rule['port']
    command :allow
  end
end
