#!/bin/sh
while [ true ]
do
DL_LOGS=$(tail -n 10 /dl/1.log)
case ${DL_LOGS} in
  .*OK.*|.*completed.*|.*save.*|.*100%.*)
    TYPE=$(cat type.txt) && rm type.txt
    if [ "$TYPE" == "BDDL" ]
    then
    MD5_CHECK=$(md5sum /dl/downloads/$FILENAME)
      if [ "${MD5_CHECK}" == "${MD5}" ]
      then
      curl -X POST -H 'Content-type: application/json' --data '{"text": "Download Completed!\n${FILENAME}", "channel": "#private", "link_names": 1, "username": "Upload-bot", "icon_emoji": ":monkey_face:"}' ${SLACK}
      else
      curl -X POST -H 'Content-type: application/json' --data '{"text": "Download Completed, but MD5 is incorrectly!\n${FILENAME}", "channel": "#private", "link_names": 1, "username": "Upload-bot", "icon_emoji": ":monkey_face:"}' ${SLACK}
      fi
    fi
    nohup bash /dl/upload.sh &
    exit 0
  ;;
  .*error.*|.*ERROR.*) 
    curl -X POST -H 'Content-type: application/json' --data '{"text": "Download ERROR!\n${DL_LOGS}", "channel": "#private", "link_names": 1, "username": "Upload-bot", "icon_emoji": ":monkey_face:"}' ${SLACK}
    exit 1
  ;;
esac
sleep 5
done

