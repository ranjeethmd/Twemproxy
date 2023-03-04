FROM alpine:3.14 AS builder

RUN apk add --no-cache alpine-sdk wget automake autoconf automake libtool\
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/twitter/twemproxy/releases/download/0.5.0/twemproxy-0.5.0.tar.gz

RUN tar xzf /twemproxy-0.5.0.tar.gz

RUN cd twemproxy-0.5.0 && \
    autoreconf -fvi && CFLAGS="-ggdb3 -O0" ./configure --enable-debug=full && make && make install

FROM alpine:3.14

COPY --from=builder /usr/local/sbin/nutcracker /usr/local/sbin/nutcracker

COPY nutcracker.yml /etc/nutcracker.yml

RUN apk update && apk add --update stunnel && apk add --no-cache supervisor\
    && rm -rf /tmp/*

EXPOSE 6380

WORKDIR /app

COPY  client.conf ./stunnel/client.conf

COPY supervisord.conf ./supervisor/supervisord.conf

CMD ["supervisord","-c","/app/supervisor/supervisord.conf"]