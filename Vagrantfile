Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network :forwarded_port, guest: 7990, host: 8081
  config.vm.network :forwarded_port, guest: 7999, host: 7999
  config.vm.network :forwarded_port, guest: 8080, host: 8082
  config.vm.network :forwarded_port, guest: 8095, host: 8083
  config.vm.network :forwarded_port, guest: 7070, host: 8084


  config.vm.provider :virtualbox do |vb|
   vb.customize ["modifyvm", :id, "--memory", 3072]
   vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
   vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

$dockerinstall = <<SCRIPT
echo Installing Docker...
sudo apt-get update
# sudo apt-get install linux-image-extra-`uname -r` -y -q
# sudo sh -c "wget -qO- https://get.docker.io/gpg | apt-key add -"
# sudo sh -c "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
# sudo apt-get update
sudo apt-get install docker.io -y -q
echo Docker installed...
SCRIPT

  config.vm.provision :shell, :inline => $dockerinstall, :privileged => false

end
