#!/bin/sh
chown -R freerad /var/log/freeradius ./config

if [ "${DEBUG}" -eq 1 ]; then
    /usr/sbin/freeradius -f -x -l stdout -d ./config
elif  [ "${CONFIG_CHECK}" -eq 1 ]; then
    /usr/sbin/freeradius -f -x -C -l stdout -d ./config
else
    /usr/sbin/freeradius -f -l stdout -d ./config
fi
