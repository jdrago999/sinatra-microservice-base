# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.omnibus.chef_version = :latest

  config.vm.box = "opscode-ubuntu-12.04"
  config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-12.04_chef-provisionerless.box"

  config.vm.network "private_network", ip: "192.168.33.70"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  chef_json = JSON.parse(Pathname(__FILE__).dirname.join('chef', 'nodes', 'vagrant.json').read)
  config.librarian_chef.cheffile_dir = "chef"
  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = ['chef/cookbooks', 'chef/site-cookbooks']
    chef.run_list = chef_json.delete('run_list')
    chef.json = chef_json
  end

end
