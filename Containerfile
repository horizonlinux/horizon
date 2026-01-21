# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /

# Base Image
FROM quay.io/almalinuxorg/almalinux-bootc:10

COPY system_files /

## Other possible base images include:
# FROM ghcr.io/ublue-os/bazzite:latest
# FROM ghcr.io/ublue-os/bluefin-nvidia:stable
# 
# ... and so on, here are more base images
# Universal Blue Images: https://github.com/orgs/ublue-os/packages
# Fedora base image: quay.io/fedora/fedora-bootc:41
# CentOS base images: quay.io/centos-bootc/centos-bootc:stream10

### [IM]MUTABLE /opt
## Some bootable images, like Fedora, have /opt symlinked to /var/opt, in order to
## make it mutable/writable for users. However, some packages write files to this directory,
## thus its contents might be wiped out when bootc deploys an image, making it troublesome for
## some packages. Eg, google-chrome, docker-desktop.
##
## Uncomment the following line if one desires to make /opt immutable and be able to be used
## by the package manager.

# RUN rm /opt && mkdir /opt

### MODIFICATIONS
## make modifications desired in your image and install packages by modifying the build.sh script
## the following RUN directive does all the things required to run "build.sh" as recommended.

ENV DEV_DEPS="git cmake(Qt6Core) cmake(Qt6Gui) cmake(Qt6Qml) cmake(Qt6QuickControls2) cmake(Qt6Svg) cmake(Qt6Widgets) cmake(Qt6DBus) cmake(KF6I18n) cmake(KF6Package) cmake(KF6Auth) cmake(KF6CoreAddons)  cmake(KF6Config)  cmake(KF6Screen) cmake(LibKWorkspace) cracklib-devel extra-cmake-modules  gcc-c++ git-core systemd-rpm-macros kf6-rpm-macros libappstream-glib"
ENV KISS_DEPS="dbus-common kf6-filesystem kf6-kauth"

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm && \
    dnf update -y && \
    dnf group install -x kdebugsettings -x krfb -x plasma-discover -x plasma-discover-notifier -y KDE && \
    dnf install -y \
        btrfs-progs \
        buildah \
        dolphin \
        ddcutil \
        distrobox \
        flatpak \
        fastfetch \
        firewalld \
        glow \
        gum \
        hplip \
        jetbrains-mono-fonts-all \
        just \
        konsole \
        ntfs-3g \
        pcsc-lite \
        powertop \
        system-reinstall-bootc \
        tuned-ppd \ 
        wireguard-tools \
        xdg-desktop-portal-kde \
        xhost && \
    dnf install y ${DEV_DEPS} && \
    git clone https://invent.kde.org/plasma/plasma-setup.git /tmp/kiss && \
    cd /tmp/kiss && \
    cmake -B build/ && \
    cmake --build build/ --parallel && \
    sudo cmake --install build/ && \
    cd / && \
    systemd-sysusers && \
    dnf remove -y ${DEV_DEPS} && dnf install -y ${KISS_DEPS} && \
    systemctl enable sddm && \
    systemctl enable plasma-setup.service && \
    sed -i 's|applications:org.kde.discover.desktop,|applications:io.github.kolunmi.Bazaar.desktop,|' /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml && \
    chmod a+x /usr/bin/just-do && \
    mv '/usr/share/doc/just/README.中文.md' '/usr/share/doc/just/README.zh-cn.md' && \
    mkdir -p /etc/flatpak/remotes.d/ && \
    curl --retry 3 -Lo /etc/flatpak/remotes.d/flathub.flatpakrepo https://dl.flathub.org/repo/flathub.flatpakrepo && \
    systemctl enable flatpak-add-flathub-repos.service && \
    systemctl enable flatpak-preinstall.service
    
### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
