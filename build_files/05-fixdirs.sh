#!/usr/bin/bash

set -eoux pipefail

echo "::group:: Fix directories"

echo "d $(find /var/lib/dnf/repos -maxdepth 1 -name 'appstream-*') 0755 root root - -" | tee -a /usr/lib/tmpfiles.d/dnf.conf
echo "d $(find /var/lib/dnf/repos -maxdepth 1 -name 'baseos-*') 0755 root root - -" | tee -a /usr/lib/tmpfiles.d/dnf.conf
echo "d $(find /var/lib/dnf/repos -maxdepth 1 -name 'crb-*') 0755 root root - -" | tee -a /usr/lib/tmpfiles.d/dnf.conf
echo "d $(find /var/lib/dnf/repos -maxdepth 1 -name 'epel-*') 0755 root root - -" | tee -a /usr/lib/tmpfiles.d/dnf.conf
echo "d $(find /var/lib/dnf/repos -maxdepth 1 -name 'extras-common-*') 0755 root root - -" | tee -a /usr/lib/tmpfiles.d/dnf.conf
echo "d $(find /var/lib/dnf/repos -maxdepth 1 -name 'rpmfusion*') 0755 root root - -" | tee -a /usr/lib/tmpfiles.d/dnf.conf
echo "d $(find /var/lib/dnf/repos -maxdepth 1 -name 'terra*') 0755 root root - -" | tee -a /usr/lib/tmpfiles.d/dnf.conf
echo "d /var/lib/flatpak 0755 root root - -" | tee -a /usr/lib/tmpfiles.d/flatpak.conf
echo "d /var/lib/openvpn 0770 openvpn openvpn - -" | tee -a /usr/lib/tmpfiles.d/openvpn.conf
echo "d /var/lib/samba/drivers 0775 root printadmin - -" | tee -a /usr/lib/tmpfiles.d/samba.conf
echo "d /var/lib/samba/usershares 1770 root usershares - -" | tee -a /usr/lib/tmpfiles.d/samba.conf
echo "d /var/lib/tuned 0755 root root - -" | tee -a /usr/lib/tmpfiles.d/tuned.conf
echo "d /var/log/tuned 0755 root root -" | tee -a /usr/lib/tmpfiles.d/tuned.conf
echo "f /var/log/tuned/tuned-ppd.log 0644 root root -" | tee -a /usr/lib/tmpfiles.d/tuned.conf
echo "d /var/spool/cups 0710 root lp - -" | tee -a /usr/lib/tmpfiles.d/cups.conf

echo "::endgroup::"
