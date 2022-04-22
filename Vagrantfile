# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/bionic64"
  config.env.enable

  config.vm.network "forwarded_port", guest_ip: "0.0.0.0", guest: ENV['SERVER_PORT'], host_ip: "0.0.0.0", host: ENV['SERVER_PORT'], protocol: "tcp"

  config.vm.provision "docker"

  config.vm.provision "file", source: ".env", destination: ".env"
  config.vm.provision "shell", path: "start.sh", privileged: true
end
