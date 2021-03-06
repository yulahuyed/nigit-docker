#!/bin/sh

case $DOWN in
  baidudl)
    echo "BDDL" > type.txt
    curl -c pcsett.txt "https://pcs.baidu.com/rest/2.0/pcs/file?method=plantcookie&type=ett" -H "Host: pcs.baidu.com" -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:58.0) Gecko/20100101 Firefox/58.0" -H "Accept: */*" -H "Accept-Language: en-US,en;q=0.8,zh-CN;q=0.5,zh;q=0.3" --compressed -H "Referer: https://pan.baidu.com" -H "Cookie: BAIDUID=$BAIDUID" -H "DNT: 1" -H "Connection: keep-alive" -H "Cache-Control: max-age=0"
    PCSETT=$(cat pcsett.txt | awk -F 'pcsett\t' '{print $2}' | tail -1)
    curl "https://pan.baidu.com/api/sharedownload?timestamp=$TIMESTAMP&sign=$SIGN&bdstoken=null&app_id=$APPID&channel=chunlei&clienttype=0&web=1" -H "Host: pan.baidu.com" -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:58.0) Gecko/20100101 Firefox/58.0" -H "Accept: */*" -H "Accept-Language: en-US,en;q=0.8,zh-CN;q=0.5,zh;q=0.3" --compressed -H "Referer: https://pan.baidu.com" -H "Content-Type: application/x-www-form-urlencoded; charset=UTF-8" -H "X-Requested-With: XMLHttpRequest" -H "Cookie: PANWEB=1; BAIDUID=$BAIDUID" -H "DNT: 1" -H "Connection: keep-alive" -H "Cache-Control: max-age=0" --data "encrypt=0&product=share&uk=$UK&primaryid=$PRIMARYID&fid_list=%5B%22$FIDLIST%22%5D" > temp.json
    ERROR_NO=$(jq -r ".errno" temp.json)
    if [ "${ERROR_NO}" == "0" ]
    then
    export FILENAME=$(jq -r ".list[0].server_filename" temp.json)
    export MD5=$(jq -r ".list[0].md5" temp.json)
    BDLINK=$(jq -r ".list[0].dlink" temp.json)
    nohup aria2c -c -t2 -m0 --connect-timeout=2 -s128 -k1M -x128 -j 16 -o "/dl/downloads/$FILENAME" --header "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:58.0) Gecko/20100101 Firefox/58.0" --header "Referer: http://pan.baidu.com/disk/home" --header "Cookie: BAIDUID=$BAIDUID; pcsett=$PCSETT" "$BDLINK" > 1.log 2>&1 &
    elif [ "${SLACK}" ]
    then
    ERROR_LOG=${cat temp.json}
    curl -X POST -H 'Content-type: application/json' --data '{"text": "Download Completed!\n${ERROR_LOG}", "channel": "#private", "link_names": 1, "username": "Upload-bot", "icon_emoji": ":monkey_face:"}' ${SLACK}
    fi
    rm temp.json
  ;;
  http.*youtu.*be.*)
    nohup youtube-dl -f bestvideo+bestaudio/best -o "/dl/temp/%(title)s-%(id)s.%(ext)s" "$DOWN" > 1.log 2>&1 &
    echo "Y2B" > type.txt
  ;;
esac

if [ "${SLACK}" ]
then
nohup bash /dl/dl-notice.sh &
else
nohup bash /dl/upload.sh &
fi
