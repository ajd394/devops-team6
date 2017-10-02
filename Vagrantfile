

Vagrant.configure("2") do |config|
    config.vm.box = "bento/ubuntu-16.04"

    config.vm.provider :virtualbox do |vb|
        vb.memory = 4096
        vb.cpus = 2
      end

    config.vm.network "forwarded_port", guest: 80, host: 8008

    config.vm.provision "shell",
        inline: "curl -L https://chef.io/chef/install.sh | sudo bash"

end