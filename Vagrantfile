# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  #config.vm.box = "puppetlabs/ubuntu-16.04-64-puppet"
  config.vm.box = "ubuntu/trusty64"

  config.vm.network"private_network", ip:"192.168.33.20"

  config.vm.provider"virtualbox"do |vb|
    vb.name = "vmpuppet"
    vb.memory = "1024"
  end

  # Habilitar aprovisionamiento por Puppet
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'manifests'
    puppet.module_path = "modules"
    puppet.manifest_file = 'init.pp'
  end
end
