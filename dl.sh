#!/bin/sh

case $DOWN in
  aria2.*baidu.*) nohup $DOWN > 1.log 2>&1 & ;;
  http.*youtu.*be.*) youtube-dl -f bestvideo+bestaudio/best -o "/dl/downloads/%(title)s-%(id)s.%(ext)s" "$DOWN" ;;
  *) wget "$DOWN" ;;
esac

if [ "${RCLONE_CONFIG}" ]
then
bash /dl/upload.sh
fi
 
