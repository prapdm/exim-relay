#!/bin/sh

CONFIG="/etc/exim/exim.conf"
HOSTNAME="/etc/exim/primary_host"


if [ ! -e "$CONFIG" ]; then
mv /exim.conf /etc/exim/exim.conf
fi

if [ ! -e "$HOSTNAME" ]; then
echo $PRIMARY_HOST > /etc/exim/primary_host
fi

#start exim
exim -bdf -q15m 


