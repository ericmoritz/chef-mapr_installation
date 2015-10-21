default['mapr']['user'] = 'mapr'
default['mapr']['group'] = 'mapr'
default['ntp']['servers'] = ["'0.pool.ntp.org', '1.pool.ntp.org'"]
default['mapr']['clush']['url'] = 'https://github.com/downloads/cea-hpc/clustershell/clustershell-1.6-1.el6.noarch.rpm'

# Define MapR roles for configure.sh here
default['mapr']['fs'] = '*'
default['mapr']['nfs'] = '*'
default['mapr']['nm'] = '*'
default['mapr']['pig'] = '*'

default['mapr']['cldb'] = []
default['mapr']['zk'] = []
default['mapr']['rm'] = []
default['mapr']['hs'] = nil
default['mapr']['ws'] = []

default['mapr']['home'] = '/opt/mapr'
default['mapr']['clustername'] = 'my_cluster'
default['mapr']['version'] = '4.1.0'
default['mapr']['repo_url'] = 'http//package.mapr.com/releases'

default['java']['version'] = 'java-1.7.0-openjdk-devel-1.7.0.79-2.5.5.3.el6_6.x86_64'
default['java']['home'] = '/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.79.x86_64/'

default['mapr']['versions'] = {
  'pig' => '0.14.201509021826-1'
}

default['mapr']['config']['yarn-site.xml'] = { 'yarn.nodemanager.resource.cpu-vcores' => '8', 'yarn.nodemanager.resource.memory-mb' => '25000',
                                               'yarn.log-aggregation-enable' => 'true', 'yarn.scheduler.maximum-allocation-mb' => '22000'
}
