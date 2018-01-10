#!/bin/bash

function format_url(){
	local num=$1
	local url=http://package.minghui.org/dafa_baozhang/mhzb/${num}/MHZB_${num}_pdf.zip
	echo $url
}

target=/usr/local/nginx/content/books/mhzb
index=$(ls -r $target | head -n 1 | cut -d'_' -f2)
if [ -z $index ]; then
	index=600
fi
echo $index
mkdir mhzb

for((num=index; num<2000; num++)); do
	url=$(format_url $num)
	wget $url || break
	unzip MHZB*.zip
	rm -fr MHZB*.zip
	mv MHZB*.pdf mhzb
done

mkdir -p $target
mv mhzb/* $target

## generate html
cat > mhzb.html << EOF
<html>
<head>
<title>真相期刊</title>
<meta charset="UTF-8">
</head>
<body>
<p><strong>明慧周报:</strong></p>
<ol>
EOF

ip=$(ifconfig eth0 | grep "inet addr" | cut -d':' -f2 | cut -d' ' -f1)
for b in $(ls -r $target); do
	num=$(echo $b | cut -d'_' -f2)
	echo "<li><a href='http://${ip}/books/mhzb/$b'>第${num}期</a></li>" >> mhzb.html
done

echo "</ol></body></html>" >> mhzb.html

mv mhzb.html $target/..
cp $target/../mhzb.html $target/../index.html

	
