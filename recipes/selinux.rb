log '\n=========== Start MapR selinux.rb =============\n'

selinux_state 'SELinux Disabled' do
  action :disabled
end
