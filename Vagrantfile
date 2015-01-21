# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

$ubuntu = <<SCRIPT
apt-get update -qq
apt-get install -qqy git zsh tmux python-virtualenv
pip install virtualenvwrapper bpython
chsh -s /bin/zsh vagrant
su - vagrant -c /vagrant/install
SCRIPT

$centos = <<SCRIPT
yum -qy install git zsh tmux python-virtualenv python-setuptools
easy_install -U pip
pip install virtualenvwrapper bpython
chsh -s /bin/zsh vagrant
su - vagrant -c /vagrant/install
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
 config.vm.define "ubuntu" do |ubuntu|
    ubuntu.vm.box = "trusty64"
    ubuntu.vm.provision "shell", inline: $ubuntu
  end

  config.vm.define "centos" do |centos|
    centos.vm.box = "chef/centos-6.5"
    centos.vm.provision "shell", inline: $centos
  end
end
