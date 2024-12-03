# Buid container
```
docker build --network=host -t freeradius_ldap .
```

# Make config/log environment
```
mkdir -p /opt/my_containers/freeradius/etc/freeradius && \
mkdir -p /opt/my_containers/freeradius/etc/ldap && \
mkdir -m 0700 -p /var/log/my_containers/freeradius && \
chown -R root:root /opt/my_containers/freeradius && \
cp contrib/docker-compose.yml.example /opt/my_containers/freeradius/docker-compose.yml
```

# Copy existing cerificate file to access ldap server
```
cp -a /etc/ldap/ca_certs.pem /opt/my_containers/freeradius/etc/ldap/
```

# Copy existing freeradius config
```
cp -ar /etc/freeradius/3.0/* /opt/my_containers/freeradius/etc/freeradius/
```

# LDAP module config
```
ca_file = /home/freeradius/ldap/ca_certs.pem
```

# Make container related changes in radiusd.conf
```
raddbdir = /home/freeradius/config
...
log {
..
  destination = stdout
```

# Configure logrotate
```
cat >>/etc/logrotate.d/my_containers
/var/log/my_containers/freeradius/*.log {
        weekly
        missingok
        rotate 52
        copytruncate
        compress
        delaycompress
        notifempty
        create 640 root adm
}
```

# Test
```
radtest <user> <pass> 127.0.0.1 0 <secret>
```
