#!/bin/sh

OD_LOGS=$(tail -n 10 /dl/od.log)
case ${OD_LOGS} in
  .*Successfully uploaded.*)
  
  curl -X POST -H 'Content-type: application/json' --data '{"text": "$FILENAME have uploaded!", "channel": "#private", "link_names": 1, "username": "Upload-bot", "icon_emoji": ":monkey_face:"}' ${SLACK}
    rm /dl/downloads/$FILENAME
  ;;
  .*error.*|.*ERROR.*) 
    curl -X POST -H 'Content-type: application/json' --data '{"text": "Upload ERROR!\n${DL_LOGS}", "channel": "#private", "link_names": 1, "username": "Upload-bot", "icon_emoji": ":monkey_face:"}' ${SLACK}
  ;;
esac
