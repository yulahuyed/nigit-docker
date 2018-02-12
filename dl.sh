#!/bin/sh

case $DOWN in
  baidudl)
    nohup aria2c -c -t2 -m0 --connect-timeout=2 -s128 -k1M -x128 -j 16 -o "/dl/downloads/$FILENAME" --header "User-Agent: $UA" --header "Referer: http://pan.baidu.com/disk/home" --header "Cookie: $COOKIE" "$BDLINK" > 1.log 2>&1 & 
  ;;
  http.*youtu.*be.*)
    nohup youtube-dl -f bestvideo+bestaudio/best -o "/dl/temp/%(title)s-%(id)s.%(ext)s" "$DOWN" > 1.log 2>&1 &
  ;;
  bdlink) 
    curl "https://pan.baidu.com/api/sharedownload?timestamp=$TIMESTAMP&sign=$SIGN&bdstoken=null&app_id=$APPID&channel=chunlei&clienttype=0&web=1" -H "Host: pan.baidu.com" -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:58.0) Gecko/20100101 Firefox/58.0" -H "Accept: */*" -H "Accept-Language: en-US,en;q=0.8,zh-CN;q=0.5,zh;q=0.3" --compressed -H "Referer: https://pan.baidu.com" -H "Content-Type: application/x-www-form-urlencoded; charset=UTF-8" -H "X-Requested-With: XMLHttpRequest" -H "Cookie: PANWEB=1; BAIDUID=$BAIDUID" -H "DNT: 1" -H "Connection: keep-alive" -H "Cache-Control: max-age=0" --data "encrypt=0&product=share&uk=$UK&primaryid=$PRIMARYID&fid_list=%5B%22$FIDLIST%22%5D" > temp.json
    curl -H "Content-Type: application/json" -X POST -d @temp.json $WEBHOOK
  ;;
esac


if [ "${RCLONE_CONFIG}" ]
then
bash /dl/upload.sh
fi
 
