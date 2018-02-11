#!/bin/sh

case $DOWN in
  aria2.*baidu.*) nohup $DOWN > 1.log 2>&1 & ;;
  http.*youtu.*be.*) nohup youtube-dl -f bestvideo+bestaudio/best -o "/dl/temp/%(title)s-%(id)s.%(ext)s" "$DOWN" > 1.log 2>&1 & ;;
  *) nohup wget -P /dl/temp "$DOWN" > 1.log 2>&1 & ;;
esac

mv /dl/temp/* /dl/downloads

if [ "${RCLONE_CONFIG}" ]
then
bash /dl/upload.sh
fi
 
