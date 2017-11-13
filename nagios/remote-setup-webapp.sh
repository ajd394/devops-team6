sudo useradd nagios

sudo apt-get update
sudo apt-get install -y build-essential libgd2-xpm-dev openssl libssl-dev unzip

cd ~
curl -L -O http://nagios-plugins.org/download/nagios-plugins-2.2.1.tar.gz

tar zxf nagios-plugins-*.tar.gz

cd nagios-plugins-*

./configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl

make

sudo make install

cd ~
curl -L -O https://github.com/NagiosEnterprises/nrpe/releases/download/nrpe-3.2.1/nrpe-3.2.1.tar.gz

tar zxf nrpe-*.tar.gz

cd nrpe-*

./configure --enable-command-args --with-nagios-user=nagios --with-nagios-group=nagios --with-ssl=/usr/bin/openssl --with-ssl-lib=/usr/lib/x86_64-linux-gnu

make all
sudo make install
sudo make install-config
sudo make install-init

cp /vagrant/nagios/nrpe-webapp.cfg /usr/local/nagios/etc/nrpe.cfg

sudo systemctl enable nrpe.service

sudo systemctl start nrpe.service

sudo systemctl status nrpe.service

sudo ufw allow 5666/tcp