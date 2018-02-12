#!/bin/sh

curl -X POST -H 'Content-type: application/json' --data '{"text": "Files have been uploaded!", "channel": "#private", "link_names": 1, "username": "Upload-bot", "icon_emoji": ":monkey_face:"}' ${SLACK}
