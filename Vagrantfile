# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Use Ubuntu 18.04 as the base box
  config.vm.box = "ubuntu/bionic64"

  # Set the VM's resources
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
  end

  # Set environment variables
  config.vm.provision "shell", inline: <<-SHELL
    export TERM=xterm-256color
  SHELL

  # Install bootstrapping packages and set locale
  config.vm.provision "shell", inline: <<-SHELL
    # Update and install necessary packages
    sudo apt-get update && sudo apt-get install -y \
      locales \
      lsb-release \
      software-properties-common

    # Set locale to UTF-8
    sudo locale-gen en_US.UTF-8
    sudo update-locale LANG=en_US.UTF-8
    export LANG=en_US.UTF-8
    export LANGUAGE=en_US.UTF-8
  SHELL

  # Install dependencies and additional repositories
  config.vm.provision "shell", inline: <<-SHELL
    # Add universe and security repositories
    sudo apt-get install -y software-properties-common
    sudo add-apt-repository ppa:aacebedo/fasd
    sudo apt-get update

    # Install the required packages
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
      autoconf \
      build-essential \
      curl \
      fasd \
      fontconfig \
      git \
      python \
      python-setuptools \
      python-dev \
      ruby-full \
      sudo \
      tmux \
      vim \
      wget \
      zsh

    # Clean up package lists
    sudo apt-get clean
    sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
  SHELL

  # Copy and install dotfiles
  config.vm.provision "file", source: ".", destination: "/home/vagrant/.yadr"

  config.vm.provision "shell", inline: <<-SHELL
	  sudo -u vagrant --login bash -c 'cd /home/vagrant/.yadr && rake'

  SHELL

  # Set zsh as the default shell
  config.vm.provision "shell", inline: <<-SHELL
    sudo chsh -s /bin/zsh vagrant
  SHELL

  # SSH into the VM and start a Zsh session
  config.vm.provision "shell", inline: <<-SHELL
    exec /bin/zsh
  SHELL
end

