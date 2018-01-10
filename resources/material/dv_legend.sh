#!/bin/bash

videos=/usr/local/nginx/content/videos/

file_descs=(
1-Xuezhongmei:2
2-RedWallMemory:2
3-JTT_CN:3
4-ChoiceOfEurope:2
5-YiSu:3
6-513SpecialProgram:2
)

function format_url(){
	local ep=$1
	local desc_pad=${file_descs[$((ep-1))]}
	local desc=$(echo $desc_pad | cut -d':' -f1)
	local pad=$(echo $desc_pad | cut -d':' -f2)
	local seg=$(printf "%0${pad}d" $2)
	local url=http://media4.minghui.org/media/video/2017/7/5/ChuanQiShiDai/MP4/480p/${desc}_MH-480p_mp4.part${seg}.rar
	echo $url
}

mkdir legend

for((ep=1; ep<=6; ep++)); do
	for((seg=1; seg<=109; seg++)); do
		url=$(format_url $ep $seg)
		wget $url
	done
	unrar e $(basename $(format_url $ep 1))
	rm -fr *.rar
	mv *.mp4 legend/$ep.mp4
done

mv legend $videos


