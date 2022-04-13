# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/bionic64"
  config.env.enable

  config.vm.network "forwarded_port", guest_ip: "0.0.0.0", guest: ENV['SERVER_PORT'], host_ip: "0.0.0.0", host: ENV['SERVER_PORT'], protocol: "tcp"

  config.vm.provision "docker"
  config.vm.provision "file", source: "./", destination: "./codenjoy"
  config.vm.provision "shell", inline: '
    apt install default-jre -y
    apt install default-jdk -y
    apt install maven -y

    cd ./codenjoy

    bash 1-git-clone.sh
    bash 2-build.sh
    bash 3-start.sh
  ', args: ENV['GAMES'], privileged: true
end
