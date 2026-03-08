#!/usr/bin/bash

set -eoux pipefail

echo "::group:: Configure Syetem"

systemctl enable sddm
systemctl enable plasma-setup
systemctl enable uupd.timer
systemctl enable firewalld
mv '/usr/share/doc/just/README.中文.md' '/usr/share/doc/just/README.zh-cn.md'
sed -i 's/#HandleLidSwitch=.*/HandleLidSwitch=suspend-then-hibernate/g' /usr/lib/systemd/logind.conf
sed -i 's/#HandleLidSwitchDocked=.*/HandleLidSwitchDocked=suspend-then-hibernate/g' /usr/lib/systemd/logind.conf
sed -i 's/#HandleLidSwitchExternalPower=.*/HandleLidSwitchExternalPower=suspend-then-hibernate/g' /usr/lib/systemd/logind.conf
sed -i 's/#SleepOperation=.*/SleepOperation=suspend-then-hibernate/g' /usr/lib/systemd/logind.conf
mkdir -p /etc/flatpak/remotes.d/
curl --retry 3 -Lo /etc/flatpak/remotes.d/flathub.flatpakrepo https://dl.flathub.org/repo/flathub.flatpakrepo
systemctl enable flatpak-add-flathub-repos.service
rpm --erase --nodeps plasma-lookandfeel-fedora
dnf -y copr disable ublue-os/packages
rm -rf /usr/share/plasma/look-and-feel/org.fedoraproject.fedora.desktop/
rm -rf /usr/share/plasma/look-and-feel/org.fedoraproject.fedoradark.desktop/
rm -rf /usr/share/plasma/look-and-feel/org.fedoraproject.fedoralight.desktop/
rm -rf /usr/share/glib-2.0/schemas/gschemas.compiled
glib-compile-schemas /usr/share/glib-2.0/schemas/

echo "::endgroup::"
