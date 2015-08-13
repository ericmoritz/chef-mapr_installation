# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.require_version '>= 1.5.0'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  (1..3).each do |i|
    hostname = "node-#{i}"
    ip = "172.20.20.#{10+i-1}"
    file_to_disk = "./node-#{i}-disk.vdi"
    
    config.vm.define hostname do | config |
      config.vm.provider "virtualbox" do | v |
        v.memory = 4096

        unless File.exist?(file_to_disk)
          v.customize ['createhd', '--filename',
                       file_to_disk, '--size', 500 * 1024]
        end
        v.customize [
          'storageattach', :id, '--storagectl',
          'IDE Controller',
          '--port', 1, '--device', 0, '--type', 'hdd',
          '--medium',
          file_to_disk
        ]
      end

      if Vagrant.has_plugin?('vagrant-omnibus')
        config.omnibus.chef_version = 'latest'
      end
      config.vm.box = 'chef/centos-6.6'
      config.vm.network :private_network, ip: ip
      config.vm.hostname = hostname
      config.berkshelf.enabled = true

      config.vm.provision :chef_solo do |chef|
        chef.json = {
          "java" => {
            "version" => "java-1.8.0-openjdk-devel",
            "home" => "/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.51-1.b16.el6_7.x86_64/"
          },
          "mapr" => {
            "isvm" => true,
            "cluster_node_ips" => ["172.20.20.10"],
            "node_count" => '1',
            "cldb_ips" => ["172.20.20.10", "172.20.20.11"],
            "zk_ips" => ["172.20.20.10", "172.20.20.11", "172.20.20.12"],
            "rm_ips" => ["172.20.20.10", "172.20.20.11"],
            "hs_ips" => "172.20.20.10",
            "ws_ips" => ["172.20.20.10"],

            "cluster_nodes" => ["node-1", "node-2", "node-3"],
            "cldb" => ["node-1", "node-2"],
            "zk" => ["node-1", "node-2", "node-3"],
            "rm" => ["node-1", "node-2"],
            "hs" => "node-1",
            "ws" => ["node-1"],


            "shared_key" => {
              "private" => %(
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEA3i8k9JBXxm81ywlV7DGkruDS2vvB61DV/4UawDUHYJKnLpCl
ulu83mUgl8jjiBz7iFRMRaOyWUbO30xE7r2gYNd3d1GGdRKIfBG2tYErw0t1gAo+
Kj8xcz5LeC1gyYoX01bcl7QYhW1asM5eNIfZtcLb69aGgz1hl4uiFLSI75jyunP8
IImupuwb28d4JGnOsJfaY0EjgvW2M522ODooI/TrMLngTH0wr6MCt7niUMiRyA8M
7AHRmvAf6/MA9ZpEsYm0BeQmixwOPh4GpQW9FpzRxHzxhjq1lB9qaXAUbxIug1RP
Xq4WqyaFUaRoMCnzeE/zlWbb/wXnQdVFhxZ26wIDAQABAoIBABmIG1wLNjr0Tp8t
THVe4wjBhxlo8sjCukSpnABYV6euUo3US2cV4adAwbUPfa4HfpQU88rQ287Mhzs7
vXQd0E8wk2bftG7BmXOAaZmD5W6EvlTfWHNsXZdbojqGJGgkeUZs5d588JBsl45X
uJWawtbTNIhuV3i/VfafMhnlARNfLjiCvvnFhePo1yYr/C6KsxPi+pAN4CostnMB
X/MQWOEBdQAcG3qJjjesjzSBukMVdVCwGr9fyjjiicCjcDByu2+OQJluMyfT3Qsb
UPQVYOszBkTho4soYU6Q/Ntfyy0fliglCXsJprJ/tPdUr4XLEqvGe/oiZDjOO/hM
Uo+7kWkCgYEA9OB8YlL4l2TiGv5lbDdeOdcsrpznqYKSrnwNFnfvFsAiV7zrcNeB
ATxA7t4E3M4g1sPY/Eer4jvxMQ3WLpSMUy74xKHMkxposEc8XDD0gUy771GgwYa1
owsAFxdEeD0PZ9LnW7r3F0Dfg6wkDNmxB4YUt59fJVZGjDMMl1CAHe8CgYEA6EbH
hLW4iLYZiT5cJ1/PHwKds/uip9srOgk4wQyY2HCgXk1kDUOGPRLz+pdsYv8/mNCP
00TDeUHN3Bj7T4tphiagS2ucgIFbQxO6rIwfefnPbimTH1k6v4+a4AFHf+HUbzNk
tEY65h6PxO8bkrIhefB+EpIc2E4s0fsGLaaFcsUCgYAdk+/yQGtefgUBlbDSfW2Y
NvFitfkVdHwbL0i1ag8rBFIhnuQhYSZn68s8Dv0vXoaA6m8PKekNDoh3kGBKiA7b
DVVnCtQXAJ2cjT4xNIiUBZy9r3JnbcoKw41jPKA8lcOCmurvHYoy+NcGpIhGNRU4
/20JMOrhK6ah0Ji4vjR7aQKBgGEmcX7VTsiHeajIl1y0mvm6a2GDJyYT6kGM59r+
vNMSUFEBB47wpi3XRoqSWPgTEHOHEBDqWuPVnReorzw28Dz23OaOrNemwxgMIXDX
7rZiwNqvsuRSutqyYrG8dz5Ko0KbeUxZb3seXz2cUKkLrirFZsW3rS7fi6mL16qy
UnCNAoGAZMeuBXB3ULO6kwRgAvqk5u5gzZZKIP373tsKZRsjRpNp7CqWVo6rFmG0
dNwjE7p8nvc9s3GR5K5+x6V6d78fiqAEOy0HTg2IWaImwxDv52jvFLvaOGUgWAAq
p3TfLYJLuT/4h5XQV0FXvUZ/oPYrzBwNf6CHnVh/FgoScYhsUY8=
-----END RSA PRIVATE KEY-----
),
              "public" => %(
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDeLyT0kFfGbzXLCVXsMaSu4NLa+8HrUNX/hRrANQdgkqcukKW6W7zeZSCXyOOIHPuIVExFo7JZRs7fTETuvaBg13d3UYZ1Eoh8Eba1gSvDS3WACj4qPzFzPkt4LWDJihfTVtyXtBiFbVqwzl40h9m1wtvr1oaDPWGXi6IUtIjvmPK6c/wgia6m7Bvbx3gkac6wl9pjQSOC9bYznbY4Oigj9OswueBMfTCvowK3ueJQyJHIDwzsAdGa8B/r8wD1mkSxibQF5CaLHA4+HgalBb0WnNHEfPGGOrWUH2ppcBRvEi6DVE9erharJoVRpGgwKfN4T/OVZtv/BedB1UWHFnbr vagrant-key
)
            }
          }
        }

        chef.run_list = [
          'recipe[mapr_installation::default]'
        ]
      end
    end
  end
end
