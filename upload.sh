#!/bin/sh

if [ -f "~/.config/rclone/rclone.conf" ]
then 
rm ~/.config/rclone/rclone.conf
fi
wget -O ~/.config/rclone/rclone.conf ${RCLONE_CONFIG}
NAME=$(cat ~/.config/rclone/rclone.conf | grep -oE '\[.*\]' | sed 's/\[\(.*\)\]/\1/g')
nohup rclone copy /dl/downloads/* $NAME: &

if [ "${SLACK}" ]
then
curl -X POST -H 'Content-type: application/json' --data '{"text": "Files have been uploaded!", "channel": "#private", "link_names": 1, "username": "Upload-bot", "icon_emoji": ":monkey_face:"}' ${SLACK}
fi

rm /dl/downloads/*
