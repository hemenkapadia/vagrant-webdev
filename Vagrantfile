# Reference @ https://github.com/purple52/librarian-puppet-vagrant

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

# Updated from 12.04 LTS to 14.04 LTS
  config.vm.box = "ubuntu/trusty32"  
  config.vm.box_url = "https://vagrantcloud.com/ubuntu/trusty32/version/1/provider/virtualbox.box"

# GUEST network configuration  
  config.vm.network "private_network", ip: "192.168.10.110"
  
# Shared folders
  config.vm.synced_folder "../vagrant-webdev-workspace", "/home/vagrant/workspace"
  config.vm.synced_folder "../vagrant-webdev-m2", "/home/vagrant/m2"
   
  config.vm.provider "virtualbox" do |vb|
#	vb.gui = true   (uncomment to enable GUI on guest)
    vb.customize ["modifyvm", :id, "--memory", "512"]   # 512 MB
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]   # to allow internet access on host.
  end

  config.vm.provision :shell, :path => 'shell/main.sh'
	
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "main.pp"
  end
  
end
