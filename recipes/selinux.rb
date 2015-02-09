log "\n=========== Start MapR selinux.rb =============\n"

selinux = "Disabled
"

if `getenforce` != "Disabled
"
	execute "Setting SeLinux to Permissive mode" do
		command "setenforce 0"
		action :run
	end

	ruby_block "Turn off SELinux" do
  	  block do
		file  = Chef::Util::FileEdit.new("/etc/selinux/config")
        	file.search_file_replace_line("SELINUX=enforcing","SELINUX=disabled")
		file.search_file_replace_line("SELINUX=enforcing","SELINUX=disabled")

        	file.write_file
  		end
	end
end
