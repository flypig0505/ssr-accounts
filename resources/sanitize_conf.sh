#!/bin/bash

local_ip=$(ifconfig | grep "inet addr" | sed -n 1p | cut -d':' -f2 | cut -d' ' -f1)

for conf in $(ls *.nginx.conf); do
	sed -i "%s/$local_ip/local_server_ip/g" $conf
done


