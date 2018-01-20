#!/bin/bash

## install dependencies
yum install -y vim gcc gcc-c++ wget unzip net-tools openssl-devel python jq qrencode bind-utils
#tar xzf rarlinux*; (cd rar; make)


## set links
page_path=/usr/local/nginx/html/info
mkdir -p $page_path
sed "s/localhost/$local_ip/g" link.html > $page_path/ss.html
sed -i "s/type/ss/" $page_path/ss.html

sed "s/localhost/$local_ip/g" link.html > $page_path/ssr.html
sed -i "s/type/ssr/" $page_path/ssr.html


## install ssr & bbr
unzip shadowsocksr.zip
cp shadowsocksr /usr/local/shadowsocksr
chmod +x ssr.sh && bash ssr.sh
#chmod +x bbr.sh && bash bbr.sh


## enable ssr service
cp ssr /etc/init.d/ssr
chmod +x /etc/init.d/ssr
chkconfig ssr on
service ssr start

## timezone setting 
cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
chkconfig iptables off


