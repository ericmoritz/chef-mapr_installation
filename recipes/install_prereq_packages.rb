log "\n=========== Start MapR install_mapr_prereqs.rb =============\n"

package 'bash'
package 'rpcbind'
package 'dmidecode'
package 'glibc'
package 'hdparm'
package 'initscripts'
package 'iputils'
package 'irqbalance'
package 'libgcc'
package 'libstdc++'
package 'redhat-lsb-core'
package 'rpm-libs'
package 'sdparm'
package 'shadow-utils'
package 'syslinux'
package 'unzip'
package 'zip'
package 'nc'
package 'wget'
package 'git'
package 'nfs-utils'
package 'nfs-utils-lib'
package 'git'
package 'gcc'
package 'patch'
package 'dstat'
package 'lsof'

package node['java']['version']

# Add JAVA_HOME to /etc/profile
ruby_block 'Set JAVA_HOME in /etc/profile' do
  block do
    file  = Chef::Util::FileEdit.new('/etc/profile')
    file.insert_line_if_no_match("export JAVA_HOME=#{node['java']['home']}", "\nexport JAVA_HOME=#{node['java']['home']}")
    file.insert_line_if_no_match('export EDITOR=vi', 'export EDITOR=vi')
    file.write_file
  end
end
