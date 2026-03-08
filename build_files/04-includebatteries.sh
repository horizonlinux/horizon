#!/usr/bin/bash

set -eoux pipefail

echo "::group:: Include Batteries"

dnf install -y \
        alsa-firmware \
        apr \
        apr-util \
        ffmpeg-free \
        ffmpegthumbnailer \
        ffmpegthumbnailer-libs \
        flatpak-spawn \
        google-noto-sans-balinese-fonts \
        google-noto-sans-cjk-fonts \
        google-noto-sans-javanese-fonts \
        google-noto-sans-sundanese-fonts \
        grub2-tools-extra \
        heif-pixbuf-loader \
        libavcodec-free \
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
