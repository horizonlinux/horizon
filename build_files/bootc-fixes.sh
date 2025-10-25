#!/bin/bash

set -ouex pipefail

rm -rf /var /boot /home /root /usr/local /srv
mkdir -p /var /boot /sysroot
ln -s /var/home /home
ln -s /var/roothome /root
ln -s /var/srv /srv
ln -s sysroot/ostree ostree
ln -s /var/usrlocal /usr/local

# Update useradd default to /var/home instead of /home for User Creation
sed -i 's|^HOME=.*|HOME=/var/home|' "/etc/default/useradd"

# Necessary for `bootc install`
mkdir -p /usr/lib/ostree && \
printf  "[composefs]\nenabled = yes\n[sysroot]\nreadonly = true\n" | \
tee "/usr/lib/ostree/prepare-root.conf"
