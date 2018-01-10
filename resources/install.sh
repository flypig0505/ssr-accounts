#!/bin/bash

## install dependencies
yum install -y vim gcc gcc-c++ wget unzip net-tools openssl-devel python jq qrencode bind-utils
tar xzf rarlinux*; (cd rar; make)

## install nginx
./install-nginx.sh


## configure nginx
local_ip=$(ifconfig | grep "inet addr" | sed -n 1p | cut -d':' -f2 | cut -d' ' -f1)
for conf in $(ls nginx.conf.*); do
	sed -i "s/local_server_ip/$local_ip/g" $conf
done
google_ip=$(host www.google.com | grep -v v6 | cut -d' ' -f4)
sed -i "s/google_ip/$google_ip/g" nginx.conf.google
mv nginx.conf* /usr/local/nginx/conf/

mv nginx /etc/init.d/nginx
chmod +x /etc/init.d/nginx
chkconfig nginx on
service nginx start


## set links
page_path=/usr/local/nginx/html/info
mkdir -p $page_path
sed "s/localhost/$local_ip/g" link.html > $page_path/ss.html
sed -i "s/type/ss/" $page_path/ss.html

sed "s/localhost/$local_ip/g" link.html > $page_path/ssr.html
sed -i "s/type/ssr/" $page_path/ssr.html


## download js libs
./dj_jquery.sh


## install ssr & bbr
unzip shadowsocksr.zip
mv shadowsocksr /usr/local/shadowsocksr
chmod +x ssr.sh && bash ssr.sh
chmod +x bbr.sh && bash bbr.sh


## enable ssr service
mv ssr /etc/init.d/ssr
chmod +x /etc/init.d/ssr
chkconfig ssr on
service ssr start

## timezone setting 
cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
chkconfig iptables off


