# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

$script = <<SCRIPT
apt-get update -qq
apt-get install -qqy git zsh tmux python-virtualenv
pip install virtualenvwrapper bpython
chsh -s /bin/zsh vagrant
su - vagrant -c /vagrant/install
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "trusty64"
  config.vm.provision "shell", inline: $script
end
