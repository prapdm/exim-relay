FROM alpine:edge

MAINTAINER avenus.pl

ENV RELAY_FROM_HOSTS=10.0.0.0/8:172.16.0.0/12:192.168.0.0/16 
ENV REPOSITORY=http://dl-cdn.alpinelinux.org/alpine/edge/testing 
ENV HELLO_HOST=exemple.com


# FIXME: Once the exim package is out of testing, update this!
RUN  apk update && apk upgrade && apk add --no-cache --repository $REPOSITORY  exim

RUN  \
mkdir  /var/log/exim /usr/lib/exim /var/spool/exim && \
ln -s /dev/stdout /var/log/exim/main && \
ln -s /dev/stderr /var/log/exim/panic && \
ln -s /dev/stderr /var/log/exim/reject && \
chown -R exim: /var/log/exim /usr/lib/exim /var/spool/exim && \
chmod 0755 /usr/sbin/exim 

COPY exim.conf /etc/exim

EXPOSE 25

CMD ["exim", "-bdf", "-q15m"]

