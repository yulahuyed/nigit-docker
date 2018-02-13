#!/bin/sh
while [ true ]
do
UP_LOGS=$(tail -n 10 /dl/upload.log)
case ${UP_LOGS} in
  .*Successfully uploaded.*)
    curl -X POST -H 'Content-type: application/json' --data '{"text": "$FILENAME have uploaded!", "channel": "#private", "link_names": 1, "username": "Upload-bot", "icon_emoji": ":monkey_face:"}' ${SLACK}
    rm /dl/downloads/$FILENAME
    exit 0
  ;;
  .*error.*|.*ERROR.*) 
    curl -X POST -H 'Content-type: application/json' --data '{"text": "Upload ERROR!\n${UP_LOGS}", "channel": "#private", "link_names": 1, "username": "Upload-bot", "icon_emoji": ":monkey_face:"}' ${SLACK}
    exit 1
  ;;
esac
sleep 5
done
