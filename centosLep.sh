#/bin/bash
#Linux
#Nginx
#Php
phpVersion="php71"

sudo yum install epel-release
sudo rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
sudo rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
sudo yum --enablerepo=remi,remi-${phpVersion} install -y nginx php-fpm php-common
sudo yum --enablerepo=remi,remi-${phpVersion} install -y php-opcache php-pecl-apcu php-cli php-pear php-pdo php-mysqlnd php-gd php-mbstring php-mcrypt php-xml
sudo systemctl stop httpd.service
sudo systemctl start nginx.service
sudo systemctl start php-fpm.service
sudo systemctl disable httpd.service
sudo systemctl enable nginx.service
sudo systemctl enable php-fpm.service

mkdir -p /etc/nginx/ssl/
sudo yum install openssl
openssl dhparam 2048 -out /etc/nginx/ssl/dhparam.pem
swapon -s
df -h
sudo dd if=/dev/zero of=/swapfile bs=1024 count=1024k
mkswap /swapfile
swapon /swapfile
swapon -s
sudo echo /swapfile none swap defaults 0 0 >> /etc/fstab
sudo chown root:root /swapfile
sudo chmod 0600 /swapfile
cat /proc/sys/vm/swappiness
sudo sysctl vm.swappiness=10
cat /proc/sys/vm/swappiness