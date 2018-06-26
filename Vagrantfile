# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "fedora/27-cloud-base"
  config.vm.box_version = "20171105"
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
  end
  config.vm.provision "file", source: "keycloak-4.0.0.Beta3.tar.gz", destination: "/tmp/keycloak-4.0.0.Beta3.tar.gz"
  config.vm.provision "file", source: "provisioning", destination: "/tmp/provisioning"
  config.vm.provision "shell", path: "bootstrap.sh"
  config.vbguest.auto_update = false
end
