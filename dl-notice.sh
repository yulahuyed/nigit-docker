#!/bin/sh

DL_LOGS=$(tail -n 10 /dl/1.log)
case ${DL_LOGS} in
  .*OK.*|.*completed.*|.*save.*|.*100%.*)
    mv /dl/temp/* /dl/downloads/
    bash /dl/upload.sh
  ;;
  .*error.*|.*ERROR.*) 
    curl -X POST -H 'Content-type: application/json' --data '{"text": "Download ERROR!\n${DL_LOGS}", "channel": "#private", "link_names": 1, "username": "Upload-bot", "icon_emoji": ":monkey_face:"}' ${SLACK}
  ;;
esac

