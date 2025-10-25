#!/bin/bash

set -ouex pipefail

pacman -Syyuu --noconfirm \
      aurorae \
      bluedevil \
      breeze \
      breeze-gtk \
      dolphin \
      drkonqi \
      kactivitymanagerd \
      kde-cli-tools \
      kde-gtk-config \
      kdecoration \
      kdeplasma-addons \
      kglobalacceld \
      kinfocenter \
      kmenuedit \
      konsole \
      kpipewire \
      kdeplasma-addons \
      krdp \
      kscreen \
      kscreenlocker \
      ksshaskpass \
      ksystemstats \
      kwallet-pam \
      kwayland \
      kwin \
      kwrited \
      layer-shell-qt \
      libkscreen \
      libksysguard \
      libplasma \
      milou \
      networkmanager \
      ocean-sound-theme \
      plasma-activities \
      plasma-activities-stats \
      plasma-browser-integration \
      plasma-desktop \
      plasma-disks \
      plasma-firewall \
      plasma-integration \
      plasma-nm \
      plasma-pa \
      plasma-systemmonitor \
      plasma-thunderbolt \
      plasma-vault \
      plasma-welcome \
      plasma-workspace \
      plasma-workspace-wallpapers \
      polkit-kde-agent \
      powerdevil \
      print-manager \
      sddm  \
      sddm-kcm \
      spectacle \
      systemsettings \
      xdg-desktop-portal-kde
curl -o /tmp/plasma-setup.pkg.tar.zst https://storage.kde.org/kde-linux-packages/testing/repo/packages/kde-banana-plasma-setup-git-310.r202510250506.072a568-1-x86_64.pkg.tar.zst
pacman -U --noconfirm /tmp/plasma-setup.pkg.tar.zst
pacman -S --clean
rm -rf /var/cache/pacman/pkg/*
