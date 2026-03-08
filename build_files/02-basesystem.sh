#!/usr/bin/bash

set -eoux pipefail

echo "::group:: Base System Packages"

dnf install -y horizon-logos horizon-backgrounds horizon-themes google-noto-color-emoji-fonts nerdfontssymbolsonly-nerd-fonts
dnf swap -y centos-stream-release horizon-release
dnf install -y --setopt=install_weak_deps=False uupd krunner-bazaar ublue-brew
dnf -y copr disable ublue-os/packages
dnf update -y
dnf install -y langpacks-*
dnf install -y dejavu-*-fonts google-noto-sans-fonts google-noto-fonts-common
dnf install -y \
        alsa-firmware \
        apr \
        apr-util \
        ffmpeg \
        ffmpeg-libs \
        ffmpegthumbnailer \
        flatpak-spawn \
        google-noto-sans-balinese-fonts \
        google-noto-sans-cjk-fonts \
        google-noto-sans-javanese-fonts \
        google-noto-sans-sundanese-fonts \
        grub2-tools-extra \
        heif-pixbuf-loader \
        libavcodec-freeworld \
        libcamera-gstreamer \
        libcamera-tools \
        libimobiledevice-utils \
        lshw \
        pam-u2f \
        pam_yubico \
        pamu2fcfg \
        squashfs-tools \
        symlinks \
        tcpdump \
        tmux \
        traceroute \
        wireguard-tools \
        xhost \
        xorg-x11-xauth \
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
dnf swap -y fdk-aac-free fdk-aac

echo "::endgroup::"
