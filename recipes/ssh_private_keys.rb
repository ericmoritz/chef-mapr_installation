log "\n=========== Start MapR ssh.rb =============\n"

########################################
# Install keys using the users databag
########################################
def _io_user_data(username)
  (node['etc'] && node['etc']['passwd'] && node['etc']['passwd'][username]) || {
    'uid' => username,
    'gid' => username,
    'dir' => "/home/#{username}"
  }
end

def _io_data_bag_user_private_keys(username)
  # return the private keys hash in the databag for a user
  item = data_bag_item('users', username) || {}
  item['private_keys'] || {}
end

# Map a user's private keys to a list of private key locations
def user_to_private_keys(home, private_keys)
  private_keys.map do |filename, data|
    {
      'fn' => "#{home}/.ssh/#{filename}",
      'content' => data
    }
  end
end

(node['ssh_keys'] || {}).each do |username, _|
  user_data = _io_user_data(username)
  next unless user_data
  private_keys = _io_data_bag_user_private_keys(username)
  home = user_data['dir']
  private_key_files = user_to_private_keys(home, private_keys)

  next unless private_key_files

  ## Create the user's .ssh directory
  directory "#{home}/.ssh" do
    owner user_data['uid']
    group user_data['gid']
    mode 0700
    recursive true
  end

  ## Create each private key files
  private_key_files.each do |x|
    log "Creating private key #{x['fn']}"
    file x['fn'] do
      content x['content']
      owner user_data['uid']
      group user_data['gid']
      mode 0600
    end
  end
end
