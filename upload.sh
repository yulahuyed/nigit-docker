#!/bin/sh

case $NETDISK in
  gdrive)
    RCLONE_TYPE=$(cat ~/.config/rclone/rclone.conf | grep -oE '\[.*\]' | sed 's/\[\(.*\)\]/\1/g')
    nohup rclone copy /dl/downloads/* $RCLONE_TYPE: &
  ;;
  od4b)
    nohup onedrive -d "dl/downloads/$FILENAME" > od.log 2>&1 &
  ;;
esac

if [ "${SLACK}" ]
then
nohup bash up-notice.sh &
fi
