#!/usr/bin/bash

set -eoux pipefail

echo "::group:: Include Batteries"
dnf install -y --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-10.noarch.rpm

dnf remove -y libswscale-free libswresample-free

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
        xorg-x11-xauth

echo "::endgroup::"
