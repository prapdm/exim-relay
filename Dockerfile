FROM alpine:edge

MAINTAINER avenus.pl

ENV RELAY_FROM_HOSTS=10.0.0.0/8:172.16.0.0/12:192.168.0.0/16 \ 
REPOSITORY=http://dl-cdn.alpinelinux.org/alpine/edge/testing


# FIXME: Once the exim package is out of testing, update this!
RUN  apk update && apk upgrade && apk add --no-cache  --virtual .build-dependencies libcap && apk add --no-cache --repository $REPOSITORY  exim

RUN  \
mkdir  /var/log/exim /usr/lib/exim /var/spool/exim && \
ln -s /dev/stdout /var/log/exim/main && \
ln -s /dev/stderr /var/log/exim/panic && \
ln -s /dev/stderr /var/log/exim/reject && \
chown -R exim: /var/log/exim /usr/lib/exim /var/spool/exim && \
chmod 0755 /usr/sbin/exim  && \
setcap cap_net_bind_service=+ep /usr/sbin/exim && \
apk del .build-dependencies

COPY exim.conf /etc/exim

USER exim

EXPOSE 25

CMD ["exim", "-bdf", "-q15m"]

