# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
 config.vm.define "ubuntu" do |ubuntu|
    ubuntu.vm.box = "ubuntu/trusty64"
  end

  config.vm.define "centos" do |centos|
    centos.vm.box = "bento/centos-6.7"
  end
  config.vm.define "arch" do |centos|
    centos.vm.box = "casualjim/archie-base"
  end
end
