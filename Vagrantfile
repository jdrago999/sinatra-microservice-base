# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.omnibus.chef_version = :latest

  config.vm.box = "hashicorp/precise64"

  config.vm.network "private_network", ip: "192.168.33.70"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  VAGRANT_JSON = JSON.parse(Pathname(__FILE__).dirname.join('nodes', 'vagrant.json').read)
  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = ['cookbooks', 'site-cookbooks']
    chef.roles_path = 'roles'
    chef.data_bags_path = 'data_bags'
    chef.provisioning_path = '/tmp/vagrant-chef'
    chef.run_list = VAGRANT_JSON.delete('run_list')
    chef.json = VAGRANT_JSON
  end

end
