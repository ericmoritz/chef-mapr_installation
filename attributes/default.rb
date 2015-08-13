default['mapr']['uid'] = 5000
default['mapr']['gid'] = 5000
default['mapr']['user'] = 'mapr'
default['mapr']['group'] = 'mapr'
default['mapr']['manage_ssh'] = true
default['mapr']['manage_root'] = true
default['mapr']['password'] = '$1$xNo/jY/u$LWqlJIzEzFqbmZv6aemsR1'
default['root']['password'] = '$1$ck3SLdAA$SO8yFTYXpEFAt07ld3d8d/'
default['ntp']['servers'] = ["'0.pool.ntp.org', '1.pool.ntp.org'"]

# All MapR nodes in this cluster
default['mapr']['cluster_nodes'] = ["'ip-172-16-9-225.ec2.internal','ip-172-16-9-16.ec2.internal',
  'ip-172-16-9-176.ec2.internal','ip-172-16-9-108.ec2.internal','ip-172-16-9-37.ec2.internal','ip-172-16-9-79.ec2.internal'"]
default['mapr']['cluster_node_ips'] = []

# Enter total number of nodes in MapR cluster here
default['mapr']['node_count'] = '6'

# Define MapR roles for configure.sh here
default['mapr']['cldb'] = ["'ip-172-16-9-16.ec2.internal','ip-172-16-9-176.ec2.internal'"]
default['mapr']['cldb_ips'] = []
default['mapr']['zk'] = ["'ip-172-16-9-108.ec2.internal','ip-172-16-9-37.ec2.internal','ip-172-16-2-79.ec2.internal'"]
default['mapr']['zk_ips'] = []
default['mapr']['rm'] = ["'ip-172-16-9-225.ec2.internal','ip-172-16-9-16.ec2.internal'"]
default['mapr']['rm_ips'] = []
default['mapr']['hs'] = 'ip-172-16-9-225.ec2.internal'
default['mapr']['hs_ips'] = nil
default['mapr']['ws'] = ["'ip-172-16-9-225.ec2.internal','ip-172-16-9-16.ec2.internal'"]
default['mapr']['ws_ips'] = []

default['se_status'] = 'Disabled'

default['mapr']['node']['host'] = 'nodeX'
default['mapr']['node']['fqdn'] = 'nodeX.cluster.com'
default['mapr']['node']['ip'] = '1.1.1.1'

default['mapr']['home'] = '/opt/mapr'
default['mapr']['clustername'] = 'my_cluster'
default['mapr']['version'] = '4.0.2'
default['mapr']['repo_url'] = 'http//package.mapr.com/releases'

default['mapr']['node']['disks'] = '/dev/xvdf,/dev/xvdg'

default['mapr']['clush']['url'] = 'https://github.com/downloads/cea-hpc/clustershell/clustershell-1.6.tar.gz'

default['mapr']['shared_key']['public'] = nil
default['mapr']['shared_key']['private'] = nil

default['mapr']['isvm'] = false

default['java']['version'] = 'java-1.7.0-openjdk-devel-1.7.0.79-2.5.5.3.el6_6.x86_64'
default['java']['home'] = '/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.79.x86_64/'
