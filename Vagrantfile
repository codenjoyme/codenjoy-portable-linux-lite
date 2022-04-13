# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/bionic64"

  config.vm.network "forwarded_port", guest: ENV['SERVER_PORT'], host: ENV['SSERVER_PORT'], protocol: "tcp"

  config.vm.provision "docker"
  config.vm.provision "file", source: ".", destination: "/srv/codenjoy"
  config.vm.provision "shell", inline: '
    apt install default-jre
    apt install default-jdk
    apt install maven

    cd /srv/codenjoy

    bash 1-git-clone.sh
    bash 2-build.sh GAMES=$1
    bash 3-start.sh
  ', args: ENV['GAME'], privileged: true
end
