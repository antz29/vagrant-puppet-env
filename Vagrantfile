
Vagrant::Config.run do |config|
  config.vm.box = "ubuntu-precise"
  config.vm.box_url = "http://dl.dropbox.com/u/25098242/ubuntu-precise.box"
  
  config.vm.network :hostonly, "192.168.124.12"

  config.vm.forward_port 80, 8084
  
  config.vm.provision :puppet do |puppet|
  	puppet.manifests_path = "puppet"
  	puppet.module_path = "puppet/modules"
  	puppet.manifest_file = "base.pp"
  end

end
