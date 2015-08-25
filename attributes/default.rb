default['mapr']['uid'] = 5000
default['mapr']['gid'] = 5000
default['mapr']['user'] = 'mapr'
default['mapr']['group'] = 'mapr'
default['mapr']['manage_ssh'] = true
default['mapr']['manage_root'] = true
default['mapr']['password'] = '$1$xNo/jY/u$LWqlJIzEzFqbmZv6aemsR1'
default['root']['password'] = '$1$ck3SLdAA$SO8yFTYXpEFAt07ld3d8d/'
default['ntp']['servers'] = ["'0.pool.ntp.org', '1.pool.ntp.org'"]
default['mapr']['clush']['url'] = 'https://github.com/downloads/cea-hpc/clustershell/clustershell-1.6-1.el6.noarch.rpm'

# Define MapR roles for configure.sh here
default['mapr']['cldb'] = []
default['mapr']['cldb_ips'] = []
default['mapr']['zk'] = []
default['mapr']['zk_ips'] = []
default['mapr']['rm'] = []
default['mapr']['rm_ips'] = []
default['mapr']['hs'] = nil
default['mapr']['hs_ips'] = nil
default['mapr']['ws'] = []
default['mapr']['ws_ips'] = []
default['mapr']['nfs'] = '*' # Array | String

default['se_status'] = 'Disabled'

default['mapr']['home'] = '/opt/mapr'
default['mapr']['clustername'] = 'my_cluster'
default['mapr']['version'] = '4.0.2'
default['mapr']['repo_url'] = 'http//package.mapr.com/releases'

default['mapr']['node']['disks'] = '/dev/xvdf,/dev/xvdg'

default['java']['version'] = 'java-1.7.0-openjdk-devel-1.7.0.79-2.5.5.3.el6_6.x86_64'
default['java']['home'] = '/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.79.x86_64/'
