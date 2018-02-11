#!/bin/sh

cd $GOPATH/src/github.com/lukasmartinelli/nigit && sed -i "s/8000/$PORT/g" nigit.go && go generate && go build && mv nigit $GOPATH/bin
cd /dl

nigit dl.sh cmd.sh
