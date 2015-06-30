# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = 'dotfiles-test'
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    cd /vagrant
    chmod a+x install.sh
    ./install.sh
  SHELL
end
