VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.hostname = 'mapr_installation'
  file_to_disk = './node-1-disk.vdi'

  config.vm.provider 'virtualbox' do |v|
    unless File.exist?(file_to_disk)
      v.customize ['createhd', '--filename', file_to_disk,
                   '--size', 500 * 1024]
    end
    v.customize [
      'storageattach', :id, '--storagectl', 'IDE Controller',
      '--port', 1, '--device', 0, '--type', 'hdd', '--medium',
      file_to_disk
    ]
  end
end
