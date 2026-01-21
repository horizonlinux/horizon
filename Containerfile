# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /

# Base Image
FROM quay.io/centos-bootc/centos-bootc:stream10

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

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    dnf config-manager --set-enabled crb && \
    dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm && \
    dnf update -y && \
    dnf install -y \
        btrfs-progs \
        buildah \
        containerd \
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
        plasma-desktop \
        plasma-disks \
        plasma-nm \
        plasma-setup \
        plasma-workspace \
        sddm \
        sddm-breeze \
        system-reinstall-bootc \
        tuned-ppd \ 
        wireguard-tools \
        xdg-desktop-portal-kde \
        xhost && \
    systemctl enable sddm && \
    systemctl enable plasma-setup.service
    
### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
