log "\n=========== Start MapR mapr_setenv.rb =============\n"

# This hacks hostname for all the mapr scripts
host_function_hack1 = 'function hostname { cat /etc/hostalias; }'
host_function_hack2 = 'function /bin/hostname { cat /etc/hostalias; }'

# Set JAVA_HOME and add the hostname hack
ruby_block 'Edit /opt/mapr/conf/env.sh' do
  block do
    file = Chef::Util::FileEdit.new('/opt/mapr/conf/env.sh')
    file.search_file_replace_line('#export JAVA_HOME=', "export JAVA_HOME=#{node['java']['home']}")
    file.insert_line_if_no_match(host_function_hack1, host_function_hack1)
    file.insert_line_if_no_match(host_function_hack2, host_function_hack2)
    file.write_file
  end
end

# Fix #!/bin/sh -> #!/bin/bash 
ruby_block '"#!/bin/sh" -> "#!/bin/bash"' do
  block do
    Dir.glob('/opt/mapr/*/*/bin/*.sh').each do |fn|
      file = Chef::Util::FileEdit.new(fn)
      file.search_file_replace_line('#!/bin/sh', '#!/bin/bash')
      file.write_file
    end
  end
end


# Create /mapr...maybe not the most efficient way to do this...
directory '/mapr' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  not_if { File.exist?('/mapr') }
end

# Create a mapr_fstab file so mapr-nfsserver can automount /mapr
cookbook_file '/opt/mapr/conf/mapr_fstab' do
  owner 'root'
  group  'root'
  mode '644'
  source 'mapr_fstab'
end
