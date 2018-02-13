#!/bin/sh
while [ true ]
do
sleep 5
DL_LOGS=$(tail -n 10 /dl/1.log)
case ${DL_LOGS} in
  .*OK.*|.*completed.*|.*save.*|.*100%.*)
    nohup bash /dl/upload.sh &
    exit 0
  ;;
  .*error.*|.*ERROR.*) 
    curl -X POST -H 'Content-type: application/json' --data '{"text": "Download ERROR!\n${DL_LOGS}", "channel": "#private", "link_names": 1, "username": "Upload-bot", "icon_emoji": ":monkey_face:"}' ${SLACK}
    exit 1
  ;;
esac
done

