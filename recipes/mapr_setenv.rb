log "\n=========== Start MapR mapr_setenv.rb =============\n"

# Set JAVA_HOME for MapR
ruby_block 'Edit /opt/mapr/conf/env.sh' do
  block do
    file = Chef::Util::FileEdit.new('/opt/mapr/conf/env.sh')
    file.search_file_replace_line('#export JAVA_HOME=', "export JAVA_HOME=#{node['java']['home']}")
    file.write_file
  end
end

mapr_dir = Mixlib::ShellOut.new('ls /|grep mapr')

# Create /mapr...maybe not the most efficient way to do this...
directory '/mapr' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  only_if { mapr_dir != 'mapr' }
end

# Create a mapr_fstab file so mapr-nfsserver can automount /mapr
cookbook_file '/opt/mapr/conf/mapr_fstab' do
  owner 'root'
  group  'root'
  mode '644'
  source 'mapr_fstab'
end
