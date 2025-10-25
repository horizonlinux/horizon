#!/bin/bash

set -ouex pipefail

pacman -Syyuu --noconfirm base-devel git rust whois cmake extra-cmake-modules qt6-base qt6-tools kf6
pacman -S --clean
rm -rf /var/cache/pacman/pkg/*
BUILD_DIR="/tmp/plasma-setup-build"
git clone https://invent.kde.org/plasma/plasma-setup.git $BUILD_DIR
cmake -B $BUILD_DIR -DCMAKE_BUILD_TYPE=Release
cmake --build $BUILD_DIR --parallel
cmake --install $BUILD_DIR
pacman -Rns --noconfirm base-devel git rust whois cmake extra-cmake-modules
