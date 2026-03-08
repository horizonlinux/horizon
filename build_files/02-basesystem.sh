#!/usr/bin/bash

set -eoux pipefail

echo "::group:: Base System Packages"

dnf install -y horizon-logos horizon-backgrounds horizon-themes google-noto-color-emoji-fonts
dnf install -y https://repos.fyralabs.com/terrael10/nerdfontssymbolsonly-nerd-fonts-0%3A3.4.0-1.el10.noarch.rpm
dnf swap -y centos-stream-release horizon-release
dnf install -y --setopt=install_weak_deps=False uupd krunner-bazaar ublue-brew
dnf -y copr disable ublue-os/packages
dnf update -y
dnf install -y langpacks-*
dnf install -y dejavu-*-fonts google-noto-sans-fonts google-noto-fonts-common
dnf install -y \
        plymouth \
        plymouth-system-theme \
        plymouth-theme-spinner \
        lm_sensors \
        containerd \
        distrobox \
        flatpak \
        fastfetch \
        firewalld \
        git \
        just \
        ntfs-3g \
        open-vm-tools \
        powertop \
        qemu-guest-agent \
        spice-vdagent \
        system-reinstall-bootc \
        tuned-ppd

echo "::endgroup::"
