FROM alpine:3.5

MAINTAINER avenus.pl

ENV RELAY_FROM_HOSTS=10.0.0.0/8:172.16.0.0/12:192.168.0.0/16 
ENV REPOSITORY=http://dl-cdn.alpinelinux.org/alpine/edge/testing 
ENV PRIMARY_HOST=exemple.com


# FIXME: Once the exim package is out of testing, update this!
RUN  apk update && apk upgrade && apk add --no-cache --repository $REPOSITORY  exim

RUN mkdir  /var/log/exim /usr/lib/exim /var/spool/exim && \
touch /var/log/exim/main /var/log/exim/panic /var/log/exim/panic  && \
chmod -R 777 /var/log/exim/ /var/spool/exim


COPY exim.conf /
COPY exim.sh /

RUN chmod +x exim.sh && \
rm -rf /etc/exim/*

VOLUME ["/var/log/exim"]

EXPOSE 25

CMD ["/exim.sh"]

