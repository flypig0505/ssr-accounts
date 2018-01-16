#!/bin/bash

jq_home="/usr/local/nginx/html/ajax/libs/jquery/"
versions="3.2.1, 3.2.0, 3.1.1, 3.1.0, 3.0.0, 2.2.4, 2.2.3, 2.2.2, 2.2.1, 2.2.0, 2.1.4, 2.1.3, 2.1.1, 2.1.0, 2.0.3, 2.0.2, 2.0.1, 2.0.0, 1.12.4, 1.12.3, 1.12.2, 1.12.1, 1.12.0, 1.11.3, 1.11.2, 1.11.1, 1.11.0, 1.10.2, 1.7.2"

function format_url(){
	local ver=$1
	local url=http://ajax.googleapis.com/ajax/libs/jquery/${ver}/jquery.min.js
	echo $url
}

cur_dir=$(pwd)
mkdir -p $jq_home
cd $jq_home

for v in $(echo $versions | sed 's/,/ /g'); do
	url=$(format_url $v)
	mkdir $v && cd $v
	wget $url
	cd ..
done 

cd $cur_dir


