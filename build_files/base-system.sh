#!/bin/bash

set -ouex pipefail

pacman -Syyuu --noconfirm \
      base \
      dracut \
      linux \
      linux-firmware \
      ostree \
      systemd \
      btrfs-progs \
      e2fsprogs \
      xfsprogs \
      dosfstools \
      skopeo \
      dbus \
      dbus-glib \
      glib2 \
      ostree \
      shadow \
      sudo \
pacman -S --clean
rm -rf /var/cache/pacman/pkg/*
