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
      kdelasma-addons \
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
pacman -S --clean
systemctl enable NetworkManager
systemctl enable sddm
rm -rf /var/cache/pacman/pkg/*
