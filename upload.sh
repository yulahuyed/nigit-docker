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
bash notice.sh
fi
