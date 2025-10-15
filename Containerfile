FROM scratch AS ctx
# COPY build_files /

# Base Image
FROM docker.io/archlinux/archlinux:latest

ENV DEV_DEPS="base-devel git rust whois cmake extra-cmake-modules qt6-base qt6-tools kf6 libkscreen plasma-workspace kdeplasma-addons plasma-desktop"

ENV DRACUT_NO_XATTR=1
RUN pacman -Syyuu --noconfirm \
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
      ${DEV_DEPS} && \
  pacman -S --clean && \
  rm -rf /var/cache/pacman/pkg/*

RUN --mount=type=tmpfs,dst=/tmp --mount=type=tmpfs,dst=/root \
    git clone https://github.com/bootc-dev/bootc.git /tmp/bootc && \
    cd /tmp/bootc && \
    CARGO_FEATURES="composefs-backend" make bin && \
    make install-all && \
    make install-initramfs-dracut && \
    git clone https://github.com/p5/coreos-bootupd.git -b sdboot-support /tmp/bootupd && \
    cd /tmp/bootupd && \
    cargo build --release --bins --features systemd-boot && \
    make install && \
    git clone https://invent.kde.org/plasma/kiss.git /tmp/kiss && \
    cd /tmp/kiss && \
    cmake -B build/ && \
    cmake --build build/ --parallel && \
    cmake --install build/

RUN pacman -Rns --noconfirm ${DEV_DEPS}

RUN pacman -Syyuu --noconfirm \
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
      xdg-desktop-portal-kde && \
  pacman -S --clean && \
  rm -rf /var/cache/pacman/pkg/*

RUN sh -c 'export KERNEL_VERSION="$(basename "$(find /usr/lib/modules -maxdepth 1 -type d | grep -v -E "*.img" | tail -n 1)")" && \
    dracut --force --no-hostonly --reproducible --zstd --verbose --kver "$KERNEL_VERSION"  "/usr/lib/modules/$KERNEL_VERSION/initramfs.img"'

RUN rm -rf /var /boot /home /root /usr/local /srv && \
    mkdir -p /var /boot /sysroot && \
    ln -s /var/home /home && \
    ln -s /var/roothome /root && \
    ln -s /var/srv /srv && \
    ln -s sysroot/ostree ostree && \
    ln -s /var/usrlocal /usr/local

# Update useradd default to /var/home instead of /home for User Creation
RUN sed -i 's|^HOME=.*|HOME=/var/home|' "/etc/default/useradd"

# Necessary for `bootc install`
RUN mkdir -p /usr/lib/ostree && \
    printf  "[composefs]\nenabled = yes\n[sysroot]\nreadonly = true\n" | \
    tee "/usr/lib/ostree/prepare-root.conf"

RUN systemd-sysusers && \
    systemctl enable NetworkManager && \
    systemctl enable sddm && \
    systemctl enable plasma-setup

RUN bootc container lint
