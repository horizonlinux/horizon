#!/bin/bash

set -ouex pipefail

git clone https://github.com/bootc-dev/bootc.git /tmp/bootc
cd /tmp/bootc
CARGO_FEATURES="composefs-backend" make bin
make install-all
make install-initramfs-dracut
git clone https://github.com/p5/coreos-bootupd.git -b sdboot-support /tmp/bootupd
cd /tmp/bootupd
cargo build --release --bins --features systemd-boot
make install
pacman -Rns --noconfirm ${DEV_DEPS}
