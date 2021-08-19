# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

puts ""
puts "│▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│"
puts " Oracle Database && Vagrant box for VirtualBox    "
puts "                                                                                  "
puts "----------------------------------------------------------------------------------"
puts " Author: luciferliu <https://github.com/pc-study/InstallOracleshell>              "
puts "                                                                                  "
puts "│▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒│"
puts ""
puts ""


# Variables
params = YAML.load_file 'config/vagrant.yml'
var_box            = params['box']
var_vm_name        = params['vm_name']
var_mem_size       = params['mem_size']
var_cpus           = params['cpus']
var_public_ip      = params['public_ip']
var_disk1_name     = params['disk1_name']
var_disk2_name     = params['disk2_name']
var_disk_size      = params['disk_size']
var_non_rotational = params['non_rotational']
var_db_version     = params['db_version']
var_db_patch       = params['db_patch']
var_password       = params['password']

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = var_box
  config.vm.network "forwarded_port", guest: 1521, host: 1521
  config.vm.network "private_network", ip: var_public_ip
  config.vm.synced_folder "../software", "/vagrant"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = var_mem_size
    vb.cpus   = var_cpus
    vb.name   = var_vm_name

    vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', '0', '--nonrotational', var_non_rotational]

    unless File.exist?(var_disk1_name)
      vb.customize ['createhd', '--filename', var_disk1_name, '--size', var_disk_size * 1024]
    end
    vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--nonrotational', var_non_rotational, '--medium', var_disk1_name]

    unless File.exist?(var_disk2_name)
      vb.customize ['createhd', '--filename', var_disk2_name, '--size', var_disk_size * 1024]
    end
    vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 2, '--device', 0, '--type', 'hdd', '--nonrotational', var_non_rotational, '--medium', var_disk2_name]
  end

  config.vm.provision "shell", inline: <<-SHELL
    echo var_password | passwd --stdin root
    sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
    systemctl restart sshd
    yum repolist all
    mkdir /soft
    cp /vagrant/soft/* /soft
    chmod +x /soft/OracleShellInstall.sh
    cd /soft
    ./OracleShellInstall.sh -i var_public_ip -opa var_db_patch -installmode single -dbv var_db_version
  SHELL
end