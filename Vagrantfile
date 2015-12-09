# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

$ubuntu = <<SCRIPT
apt-get update -qq
apt-get install -qqy git zsh tmux python-virtualenv
pip install virtualenvwrapper bpython
chsh -s /bin/zsh vagrant
ln -s /vagrant /home/vagrant/.dcp
su - vagrant -c /home/vagrant/.dcp/install
SCRIPT

$centos = <<SCRIPT
yum -qy install git zsh tmux python-virtualenv python-setuptools
easy_install -U pip
pip install virtualenvwrapper bpython
chsh -s /bin/zsh vagrant
ln -s /vagrant /home/vagrant/.dcp
su - vagrant -c /home/vagrant/.dcp/install
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
 config.vm.define "ubuntu" do |ubuntu|
    ubuntu.vm.box = "ubuntu/trusty64"
    ubuntu.vm.provision "shell", inline: $ubuntu
  end

  config.vm.define "centos" do |centos|
    centos.vm.box = "bento/centos-6.7"
    centos.vm.provision "shell", inline: $centos
  end
end
