#!/bin/bash

function format_url(){
	ep=$1
	seg=$(printf "%02d" $2)
	url=http://media4.minghui.org/media/video/2016/8/28/FYTDX/MP4/ZXJM_s2_e${ep}_v1_i0-FYTDX_${ep}-video_480P_mp4.part${seg}.rar
	echo $url
}

mkdir fytdx

for((ep=1; ep<=6; ep++)); do
	for((seg=1; seg<=21; seg++)); do
		url=$(format_url $ep $seg)
		wget $url
	done
	unrar e $(basename $(format_url $ep 1))
	rm -fr *.rar
	mv *.mp4 fytdx/$ep.mp4
done


