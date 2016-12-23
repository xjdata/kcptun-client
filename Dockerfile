FROM alpine:3.4
MAINTAINER xjdata , <xjdata@gmail.com>

ENV KCPTUN_VER 20161207
ENV KCPTUN_URL https://github.com/xtaci/kcptun/releases/download/v${KCPTUN_VER}/kcptun-linux-amd64-${KCPTUN_VER}.tar.gz

WORKDIR /tmp/

RUN set -ex \
  && apk add --no-cache curl \
  && curl -sSL $KCPTUN_URL | tar xz \
  && chmod +x ./* \
  && mv ./* /usr/local/bin \
  && rm -fr /var/lib/apk/lists/* \
  && rm -rf /var/cache/apk/*

ENV REMOTE_ADDR www.google.com
ENV REMOTE_PORT 29900
ENV LISTEN_ADDR 0.0.0.0
ENV LISTEN_PORT 8388
ENV MODE fast
ENV CRYPT aes
ENV KEY helloworld
ENV AUTOEXPIRE 60
#ENV CONN 4
#ENV MTU 1400
#ENV SNDWND 2048
#ENV RCVWND 2048
#ENV DATASHARD 10
#ENV PARITYSHARD 3
#ENV DSCP 0
#ENV NOCOMP false
#ENV LOG=

EXPOSE $LISTEN_PORT/udp

CMD client_linux_amd64 -l $LISTEN_ADDR:$LISTEN_PORT \
                       -r $REMOTE_ADDR:$REMOTE_PORT \
                       --key $KEY \
                       --crypt $CRYPT \
                       --mode $MODE \
                       #--conn $CONN \
                       #--mtu $MTU \
                       #--sndwnd $SNDWND \
                       #--rcvwnd $RCVWND \
                       #--datashard $DATASHARD \
                       #--parityshard $PARITYSHARD \
                       #--dscp $DSCP \
                       #--nocomp $NOCOMP \
                       #--log $LOG
                       --autoexpire $AUTOEXPIRE 
