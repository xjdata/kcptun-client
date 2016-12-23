FROM apline:3.4


ENV KCPTUN_VER 20161207
ENV KCPTUN_URL https://github.com/xtaci/kcptun/releases/download/v${KCPTUN_VER}/kcptun-linux-amd64-${KCPTUN_VER}.tar.gz

WORKDIR /tmp/

RUN set -ex \
  && apt add --no-cache --update  curl \
  && curl -sSL $KCPTUN_URL | tar xz \
  && chmod +x ./* \
  && mv ./* /usr/local/bin \
  && rm -fr /var/lib/apt/lists/*

ENV TARGET_ADDR 127.0.0.1
ENV TARGET_PORT 8388
ENV LISTEN_ADDR 0.0.0.0
ENV LISTEN_PORT 29900
ENV MODE fast
ENV CRYPT aes
ENV KEY ^password$
ENV CONN 4
ENV MTU 1400
ENV SNDWND 2048
ENV RCVWND 2048

EXPOSE $LISTEN_PORT/udp

CMD server_linux_amd64 -l $LISTEN_ADDR:$LISTEN_PORT \
                       -t $TARGET_ADDR:$TARGET_PORT \
                       --key $KEY \
                       --crypt $CRYPT \
                       --mode $MODE \
                       --mtu $MTU \
                       --sndwnd $SNDWND \
                       --rcvwnd $RCVWND
