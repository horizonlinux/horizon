# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /

# Base Image
FROM quay.io/centos-bootc/centos-bootc:stream10

COPY system_files /

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    dnf config-manager --set-enabled crb && dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm && \
    dnf update -y && \
    dnf -y copr enable horizonproject/horizon && \
    dnf update -y && \
    dnf install -y horizon-logos horizon-backgrounds horizon-themes google-noto-emoji-fonts && \
    dnf group install -y KDE -x kdebugsettings -x krfb -x plasma-discover -x plasma-discover-notifier -x kde-settings-sddm -x kde-settings-pulseaudio -x kde-settings -x kde-settings-plasma && \
    dnf install -y \
        containerd \
        dolphin \
        distrobox \
        flatpak \
        fastfetch \
        firewalld \
        git \
        just \
        konsole \
        ntfs-3g \
        open-vm-tools \
        powertop \
        horizon-plasma-setup \
        qemu-guest-agent \
        spice-vdagent \
        system-reinstall-bootc \
        tuned-ppd \ 
        xdg-desktop-portal-kde && \
    systemctl enable sddm && \
    systemctl enable plasma-setup && \
    sed -i 's|applications:org.kde.discover.desktop,|applications:io.github.kolunmi.Bazaar.desktop,|' /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml && \
    chmod a+x /usr/bin/just-do && \
    mv '/usr/share/doc/just/README.中文.md' '/usr/share/doc/just/README.zh-cn.md' && \
    mkdir -p /etc/flatpak/remotes.d/ && \
    curl --retry 3 -Lo /etc/flatpak/remotes.d/flathub.flatpakrepo https://dl.flathub.org/repo/flathub.flatpakrepo && \
    systemctl enable flatpak-add-flathub-repos.service && \
    rpm --erase --nodeps plasma-lookandfeel-fedora && \
    rm -rf /usr/share/plasma/look-and-feel/org.fedoraproject.fedora.desktop/ && \
    rm -rf /usr/share/plasma/look-and-feel/org.fedoraproject.fedoradark.desktop/ && \
    rm -rf /usr/share/plasma/look-and-feel/org.fedoraproject.fedoralight.desktop/
    
### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
