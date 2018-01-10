#!/bin/bash

function format_url(){
	local seg=$(printf "%03d" $1)
	local url=http://media4.minghui.org/media/video/2016/7/7/parade/mp4/20160513ParadeNewYork_mp4.part${seg}.rar
	echo $url
}

for seg in {1..103}; do
	url=$(format_url $seg)
	#echo $url
	wget $url
done

first_seg=$(basename $(format_url 1))
unrar e $first_seg
rm -fr *.rar
mv 2016*.mp4 parade.mp4

 
