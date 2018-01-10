#!/bin/bash

function format_url(){
	local ep=$1
	local seg=$(printf "%02d" $2)
	local url=http://media4.minghui.org/media/video/2017/3/13/9ping.MP4/360p/${ep}/JIUPING-${ep}_360p_mp4.part${seg}.rar
	echo $url
}

mkdir jiuping

for((ep=1; ep<=9; ep++)); do
	for((seg=1; seg<=100; seg++)); do
		url=$(format_url $ep $seg)
		wget $url
	done
	unrar e $(basename $(format_url $ep 1))
	rm -fr *.rar
	mv *.mp4 jiuping/$ep.mp4
done



