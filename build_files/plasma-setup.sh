#!/bin/bash

set -ouex pipefail

pacman -Syyuu --noconfirm base-devel git rust whois cmake extra-cmake-modules qt6-base qt6-tools kf6
pacman -S --clean
rm -rf /var/cache/pacman/pkg/*
git clone https://invent.kde.org/plasma/plasma-setup.git /tmp/plasma-setup-build
cd /tmp/plasma-setup-build
cmake -B /tmp/plasma-setup-build -DCMAKE_BUILD_TYPE=Release
cmake --build /tmp/plasma-setup-build --parallel
cmake --install /tmp/plasma-setup-build
pacman -Rns --noconfirm base-devel rust whois cmake extra-cmake-modules
