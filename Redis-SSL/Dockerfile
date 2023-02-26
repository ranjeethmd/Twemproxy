FROM redis
COPY server.cert /etc/ssl/certs/server.cert
COPY server.key /etc/ssl/private/server.key
COPY redis.conf /usr/local/etc/redis/redis.conf
CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]