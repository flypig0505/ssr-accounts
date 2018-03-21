#!/bin/bash

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH


ss_password='FaLunDaFaHao@513'
ss_method=aes-256-cfb
ss_protocol=auth_sha1_v4_compatible
ss_protocol_param=200
ss_obfs=tls1.2_ticket_auth_compatible
ss_server_port=8080
ss_server_ip=$(ifconfig | grep "inet addr" | sed -n 1p | cut -d':' -f2 | cut -d' ' -f1)

qr_folder="/usr/local/nginx/html/info"

ssr_folder="/usr/local/shadowsocksr"
ssr_ss_file="${ssr_folder}/shadowsocks"
config_file="${ssr_folder}/config.json"
config_folder="/etc/shadowsocksr"
config_user_file="${config_folder}/user-config.json"
ssr_log_file="${ssr_ss_file}/ssserver.log"


add_iptables(){
	iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport ${ss_server_port} -j ACCEPT
	iptables -I INPUT -m state --state NEW -m udp -p udp --dport ${ss_server_port} -j ACCEPT
	ip6tables -I INPUT -m state --state NEW -m tcp -p tcp --dport ${ss_server_port} -j ACCEPT
	ip6tables -I INPUT -m state --state NEW -m udp -p udp --dport ${ss_server_port} -j ACCEPT
	service iptables save
	service ip6tables save
}

urlsafe_base64(){
	date=$(echo -n "$1"|base64|sed ':a;N;s/\n/ /g;ta'|sed 's/ //g;s/=//g;s/+/-/g;s/\//_/g')
	echo -e "${date}"
}

ss_link_qr(){
	SSbase64=$(urlsafe_base64 "${ss_method}:${ss_password}@${ss_server_ip}:${ss_server_port}")
	SSurl="ss://${SSbase64}"
	qrencode -o $qr_folder/ss.png -s 2 "${SSurl}"
	echo "${SSurl}" > url.txt
}

ssr_link_qr(){
	SSRprotocol=$(echo ${ss_protocol} | sed 's/_compatible//g')
	SSRobfs=$(echo ${ss_obfs} | sed 's/_compatible//g')
	SSRPWDbase64=$(urlsafe_base64 "${ss_password}")
	#remarkBase64=$(urlsafe_base64 "gfw-breaker [${ss_server_ip}]")
	#remarkBase64=$(urlsafe_base64 "账号更新 http://truth.atspace.eu/")
	remarkBase64=$(urlsafe_base64 "账号更新 https://gfw-breaker.github.io")
	SSRbase64=$(urlsafe_base64 "${ss_server_ip}:${ss_server_port}:${SSRprotocol}:${ss_method}:${SSRobfs}:${SSRPWDbase64}/?remarks=${remarkBase64}")
	SSRurl="ssr://${SSRbase64}"
	qrencode -o $qr_folder/ssr.png -s 2 "${SSRurl}"
	echo "${SSRurl}" >> url.txt
}


write_configuration(){
	mkdir -p ${config_folder}
	cat > ${config_user_file}<<-EOF
{
    "server": "${ss_server_ip}",
    "server_ipv6": "::",
    "server_port": ${ss_server_port},
    "local_address": "127.0.0.1",
    "local_port": 1080,

    "password": "${ss_password}",
    "method": "${ss_method}",
    "protocol": "${ss_protocol}",
    "protocol_param": "${ss_protocol_param}",
    "obfs": "${ss_obfs}",
    "obfs_param": "",
    "speed_limit_per_con": 200,
    "speed_limit_per_user": 0,

    "additional_ports" : {},
    "timeout": 120,
    "udp_timeout": 60,
    "dns_ipv6": false,
    "connect_verbose_info": 0,
    "redirect": "",
    "fast_open": false
}
EOF
}


write_configuration
add_iptables
ss_link_qr
ssr_link_qr



