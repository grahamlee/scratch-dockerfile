#!/bin/bash

set -e

CERT_IMAGE="archlinux:latest"

# cd to the current directory so the script can be run from anywhere.
cd `dirname $0`

# Update the cert image.
docker pull $CERT_IMAGE

# Fetch the latest certificates.
ID=$(docker run -d $CERT_IMAGE bash -c "pacman -Syu && pacman -S --noconfirm ca-certificates")
docker logs -f $ID
docker wait $ID

# Update the local certificates.
#docker cp $ID:/etc/ssl/certs/ca-certificates.crt . # for debian
docker cp $ID:/etc/ca-certificates/extracted/tls-ca-bundle.pem ./ca-certificates.crt # archlinux
chmod 644 ./ca-certificates.crt

# Cleanup.
docker rm -f $ID
