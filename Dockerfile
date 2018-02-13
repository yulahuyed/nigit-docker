FROM golang:1.9.4-alpine

RUN apk --no-cache add ca-certificates expect git youtube-dl ffmpeg curl wget bash expect jq
RUN wget https://github.com/xzl2021/aria2-static-builds-with-128-threads/releases/download/v1.32.0/aria2-1.32.0-linux-gnu-64bit-build1.tar.bz2
RUN tar jxvf aria2-1.32.0-linux-gnu-64bit-build1.tar.bz2
RUN mv ./aria2-1.32.0-linux-gnu-64bit-build1/aria2c /usr/local/bin
RUN mv ./aria2-1.32.0-linux-gnu-64bit-build1/ca-certificates.crt /usr/local/bin
RUN mv ./aria2-1.32.0-linux-gnu-64bit-build1/man-aria2c /usr/local/bin
RUN rm -rf aria2-1.32.0-linux-gnu-64bit-build1
RUN mkdir -p /dl/downloads
RUN mkdir -p /dl/temp
RUN go get "github.com/codegangsta/cli"
RUN go get "github.com/op/go-logging"
RUN go get github.com/lukasmartinelli/nigit
RUN wget --no-check-certificate -q -O /tmp/OneDrive.sh "https://raw.githubusercontent.com/0oVicero0/OneDrive/master/OneDrive.sh" && bash /tmp/OneDrive.sh
RUN chmod -R 777 /usr/local/etc/OneDrive

ADD *.sh /dl/
RUN chmod 777 /dl/*.sh

ADD entrypoint /entrypoint.sh
RUN chmod 777 /entrypoint.sh

EXPOSE 8000
USER nobody
CMD /entrypoint.sh
