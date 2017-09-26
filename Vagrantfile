

Vagrant.configure("2") do |config|
    config.vm.box = "bento/ubuntu-16.04"

    config.vm.provider :virtualbox do |vb|
        vb.memory = 4096
        vb.cpus = 2
      end

    config.vm.network "forwarded_port", guest: 80, host: 8000

    config.vm.provision "chef_solo" do |chef|
      chef.add_recipe "web_app"
    end

  end