# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/trusty64"
#  config.vm.box_url = "https://vagrantcloud.com/hashicorp/precise64/current/provider/virtualbox.box"

  config.vm.hostname = 'api-example'
  config.vm.network "private_network", ip: "192.168.33.222"

  # Enable port-forwarding:
  config.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  config.vm.synced_folder "./", "/var/www/sinatra-microservice"

  vagrant_json = JSON.parse(Pathname(__FILE__).dirname.join('chef', 'nodes', 'vagrant.json').read)

  config.omnibus.chef_version = :latest
  config.librarian_chef.cheffile_dir = "chef"
  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = ['chef/cookbooks', 'chef/site-cookbooks']
    chef.run_list = vagrant_json.delete('run_list')
    chef.json = vagrant_json
  end

end
