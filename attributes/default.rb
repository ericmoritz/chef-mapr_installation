default['mapr']['user'] = 'mapr'
default['mapr']['group'] = 'mapr'
default['ntp']['servers'] = ["'0.pool.ntp.org', '1.pool.ntp.org'"]
default['mapr']['clush']['url'] = 'https://github.com/downloads/cea-hpc/clustershell/clustershell-1.6-1.el6.noarch.rpm'

# Define MapR roles for configure.sh here
default['mapr']['cldb'] = []
default['mapr']['cldb_ips'] = [] # Deprecated
default['mapr']['zk'] = []
default['mapr']['zk_ips'] = [] # Deprecated
default['mapr']['rm'] = []
default['mapr']['rm_ips'] = [] # Deprecated
default['mapr']['hs'] = nil
default['mapr']['hs_ips'] = nil # Deprecated
default['mapr']['ws'] = []
default['mapr']['ws_ips'] = [] # Deprecated
default['mapr']['nfs'] = '*' # Array | String

default['mapr']['home'] = '/opt/mapr'
default['mapr']['clustername'] = 'my_cluster'
default['mapr']['version'] = '4.0.2'
default['mapr']['repo_url'] = 'http//package.mapr.com/releases'

default['java']['version'] = 'java-1.7.0-openjdk-devel-1.7.0.79-2.5.5.3.el6_6.x86_64'
default['java']['home'] = '/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.79.x86_64/'
