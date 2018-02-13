#!/bin/bash

## install dependencies
yum install -y vim gcc gcc-c++ wget unzip net-tools openssl-devel python jq qrencode bind-utils
#tar xzf rarlinux*; (cd rar; make)


## set links
page_path=/usr/local/nginx/html/info
mkdir -p $page_path
video_path=/usr/local/nginx/content/videos
mkdir -p $video_path

local_ip=$(ifconfig | grep "inet addr" | sed -n 1p | cut -d':' -f2 | cut -d' ' -f1)

homepage=$(sed -n 1p homepage.txt | sed 's/ //g')
sed -i "s#homepage#$homepage#" link.html

sed "s/sstype/ss/" link.html > $page_path/ss.html
sed "s/sstype/ssr/" link.html > $page_path/ssr.html

#sed "s/localhost/$local_ip/g" videos.html > $video_path/index.html

## install ssr & bbr
unzip shadowsocksr.zip
cp -R shadowsocksr /usr/local/shadowsocksr
cp asyncdns.py /usr/local/shadowsocksr/shadowsocks
chmod +x ssr.sh && bash ssr.sh
chmod +x bbr.sh && bash bbr.sh


## enable ssr service
cp ssr /etc/init.d/ssr
chmod +x /etc/init.d/ssr
chkconfig ssr on
service ssr start

## timezone setting 
cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
chkconfig iptables off


