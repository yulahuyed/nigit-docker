#!/bin/sh

if [[ $DOWN =~ "aria2.+baidu" ]]
then
 nohup $DOWN > 1.log 2>&1 &
else
  if [[ $DOWN =~ "youtu.*be" ]]
  then
  youtube-dl -f bestvideo+bestaudio/best -o /dl/downloads/%(title)s-%(id)s.%(ext)s $DOWN
  else
  wget $DOWN
  fi
fi

bash /dl/upload.sh
  
