include_recipe 'firewall'

node['mapr']['firewall_rules'].each do |rule|
  firewall_rule rule['name'] do
    port rule['port']
    command :allow
  end
end
