#!/bin/sh

sed -i "s/api_client_id=\"\"/api_client_id=\"${OD_API_ID}\"/g" /usr/local/etc/OneDrive/onedrive.cfg
sed -i "s/api_client_secret=\"\"/api_client_secret=\"${OD_API_SECRET}\"/g" /usr/local/etc/OneDrive/onedrive.cfg

if [ "${OD_API_URL}" ]
then
sed -i "s/https:\/\/onedrive.live.com\/about\/business\//${OD_API_URL}/g" /usr/local/etc/OneDrive/onedrive.cfg
fi

echo "${OD_REFRESH_TOKEN}" > /usr/local/etc/OneDrive/.refresh_token

nohup onedrive -d "$FILENAME" > od.log 2>&1 &
