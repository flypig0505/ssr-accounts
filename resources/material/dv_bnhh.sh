#!/bin/bash

videos=/usr/local/nginx/content/videos/

file_descs=(
----
2017/09-01/OTHERS_s1_e1_v1_i0-episode_1_short-video.mp4
2017/09-04/BNHH_s1_e2_v1_i0-ep2_new-video.mp4
2017/09-11/BNHH_s1_e3_v1_i0-ep3-video.mp4
2017/09-17/BNHH_s1_e4_v4_i0-ep4-video.mp4
2017/09-25/BNHH_s1_e5_v1_i0-ep_5-video.mp4
2017/09-30/BNHH_s1_e6_v1_i0-ep6-video.mp4
2017/10-07/BNHH_s1_e7_v1_i0-ep7-video.mp4
2017/10-14/BNHH_s1_e8_v1_i1-ep8-video.mp4
2017/10-21/BNHH_s1_e9_v1_i1-ep9-video.mp4
2017/10-29/BNHH_s1_e10_v1_i0-ep_10-video.mp4
2017/11-04/BNHH_s1_e11_v1_i0-ep11-video.mp4
2017/11-11/BNHH_s1_e12_v2_i0-ep12-video.mp4
2017/11-18/BNHH_s1_e13_v1_i0-ep13-video.mp4
2017/11-25/BNHH_s1_e14_v1_i0-ep14-video.mp4
2017/12-02/BNHH_s1_e15_v1_i0-ep15-video.mp4
2017/12-10/BNHH_s1_e16_v1_i0-ep16-video.mp4
2017/12-16/BNHH_s17_e1_v1_i0-ep17-video.mp4
2017/12-25/BNHH_s2_e18_v2_i0-ep18-video.mp4
2017/12-30/BNHH_s1_e19_v1_i0-ep19-video.mp4
)

function format_url(){
	local ep=$1
	local file=${file_descs[$ep]}
	local url=http://inews3.ntdtv.com/data/media2/${file}
	echo $url
}

mkdir bnhh

for((ep=1; ep<${#file_descs[@]}; ep++)); do
	url=$(format_url $ep)
	wget $url
	fname=$(printf "%02d" $ep)
	mv *.mp4 bnhh/$fname.mp4
done

mv bnhh $videos


