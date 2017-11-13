#!/usr/bin/env bash

cd /vagrant

useradd nagios
groupadd nagcmd

usermod -a -G nagcmd nagios

apt-get update -y

sudo apt-get install -y apache2
sudo apt-get install -y php libapache2-mod-php php-mcrypt
sudo apt-get install -y build-essential libgd2-xpm-dev openssl libssl-dev unzip

cd ~
curl -L -O https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.3.4.tar.gz

tar zxf nagios-4.3.4.tar.gz

cd nagios-4.3.4

./configure --with-nagios-group=nagios --with-command-group=nagcmd

make all

sudo make install
sudo make install-commandmode
sudo make install-init
sudo make install-config

sudo /usr/bin/install -c -m 644 ~/nagios-4.3.4/sample-config/httpd.conf /etc/apache2/sites-available/nagios.conf

sudo usermod -G nagcmd www-data



#Install Plugins


cd ~
curl -L -O http://nagios-plugins.org/download/nagios-plugins-2.2.1.tar.gz

tar zxf nagios-plugins-2.2.1.tar.gz

cd nagios-plugins-2.2.1

./configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl

make

sudo make install

#Install NRPE
cd ~
curl -L -O https://github.com/NagiosEnterprises/nrpe/releases/download/nrpe-3.2.1/nrpe-3.2.1.tar.gz

tar zxf nrpe-3.2.1.tar.gz

cd nrpe-3.2.1

./configure

make check_nrpe
sudo make install-plugin

./configure --enable-command-args --with-nagios-user=nagios --with-nagios-group=nagios --with-ssl=/usr/bin/openssl --with-ssl-lib=/usr/lib/x86_64-linux-gnu


make all
sudo make install
sudo make install-config
sudo make install-init

cd /vagrant

cp nagios/nrpe.cfg /usr/local/nagios/etc/nrpe.cfg

sudo systemctl start nrpe




sudo ufw allow 5666/tcp


cd /vagrant

sudo cp nagios/nagios.cfg /usr/local/nagios/etc/nagios.cfg

sudo mkdir /usr/local/nagios/etc/servers

cd /vagrant

cp nagios/commands.cfg /usr/local/nagios/etc/objects/commands.cfg

sudo a2enmod rewrite
sudo a2enmod cgi

sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

sudo ln -s /etc/apache2/sites-available/nagios.conf /etc/apache2/sites-enabled/

sudo systemctl restart apache2

cd /vagrant

sudo cp nagios/nagios.service /etc/systemd/system/nagios.service

sudo systemctl enable /etc/systemd/system/nagios.service

cp /vagrant/nagios/servers/nginx.cfg /usr/local/nagios/etc/servers/nginx.cfg

sudo systemctl start nagios