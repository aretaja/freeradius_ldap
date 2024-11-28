# Use Base Debian Bullseye slim image
FROM debian:bullseye-slim

# Author of this Dockerfile
LABEL org.opencontainers.image.authors="marko[AT]aretaja.org"

# Update and install freeradius
RUN apt-get -qq update && \
 DEBIAN_FRONTEND=noninteractive apt-get -yqq dist-upgrade && \
 DEBIAN_FRONTEND=noninteractive apt-get -yqq install freeradius freeradius-ldap && \
 DEBIAN_FRONTEND=noninteractive apt-get -yqq autoremove && \
 apt-get -qq clean && \
 rm -rf /var/lib/apt/lists/*

# Default env variables
ENV DEBUG=0
ENV CONFIG_CHECK=0

# Start script
WORKDIR /home/freeradius
RUN mkdir bin config ldap
ADD --chown=root:root files/start.sh bin/
RUN chmod ug+x bin/start.sh

EXPOSE 1812/udp 1813/udp

ENTRYPOINT [ "./bin/start.sh" ]
