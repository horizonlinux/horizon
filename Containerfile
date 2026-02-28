# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx

COPY build_files /

# Base Image
FROM quay.io/centos-bootc/centos-bootc:stream10

COPY system_files /
COPY cosign.pub /etc/pki/containers/horizonlinux.pub

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    dnf config-manager --set-enabled crb && dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm && \
    dnf update -y && \
    dnf -y copr enable horizonproject/horizon && \
    dnf -y copr enable ublue-os/packages && \
    dnf update -y && \
    dnf install -y horizon-logos horizon-backgrounds horizon-themes google-noto-color-emoji-fonts zsh && \
    dnf install -y https://repos.fyralabs.com/terrael10/nerdfontssymbolsonly-nerd-fonts-0%3A3.4.0-1.el10.noarch.rpm && \
    dnf swap -y centos-stream-release horizon-release && \
    dnf install -y --setopt=install_weak_deps=False uupd krunner-bazaar && \
    dnf -y copr disable ublue-os/packages && \
    dnf update -y && \
    dnf group install -y KDE -x kdebugsettings -x krfb -x plasma-discover -x plasma-discover-notifier -x kde-settings-sddm -x kde-settings-pulseaudio -x kde-settings -x kde-settings-plasma && \
    dnf install -y \
        plymouth \
	    plymouth-system-theme \
		plymouth-theme-spinner \
        lm_sensors \
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
    sed -i '/SHELL=\/bin\/bash/c\SHELL=\/usr\/bin\/zsh' /etc/default/useradd && \
    systemctl enable sddm && \
    systemctl enable plasma-setup && \
    # sed -i 's|applications:org.kde.discover.desktop,|applications:io.github.kolunmi.Bazaar.desktop,|' /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml && \
    chmod a+x /usr/bin/just-do && \
    mv '/usr/share/doc/just/README.中文.md' '/usr/share/doc/just/README.zh-cn.md' && \
    mkdir -p /etc/flatpak/remotes.d/ && \
    curl --retry 3 -Lo /etc/flatpak/remotes.d/flathub.flatpakrepo https://dl.flathub.org/repo/flathub.flatpakrepo && \
    systemctl enable flatpak-add-flathub-repos.service && \
    rpm --erase --nodeps plasma-lookandfeel-fedora && \
    rm -rf /usr/share/plasma/look-and-feel/org.fedoraproject.fedora.desktop/ && \
    rm -rf /usr/share/plasma/look-and-feel/org.fedoraproject.fedoradark.desktop/ && \
    rm -rf /usr/share/plasma/look-and-feel/org.fedoraproject.fedoralight.desktop/ && \
    rm -rf /usr/share/glib-2.0/schemas/gschemas.compiled && \
	sed -i '/Defaults env_reset/c\Defaults env_reset,pwfeedback' /etc/sudoers && \
    glib-compile-schemas /usr/share/glib-2.0/schemas/ && \
	echo "d $(find /var/lib/dnf/repos -maxdepth 1 -name 'appstream-*') 0755 root root - -" | tee -a /usr/lib/tmpfiles.d/dnf.conf && \
	echo "d $(find /var/lib/dnf/repos -maxdepth 1 -name 'baseos-*') 0755 root root - -" | tee -a /usr/lib/tmpfiles.d/dnf.conf && \
	echo "d $(find /var/lib/dnf/repos -maxdepth 1 -name 'crb-*') 0755 root root - -" | tee -a /usr/lib/tmpfiles.d/dnf.conf && \
	echo "d $(find /var/lib/dnf/repos -maxdepth 1 -name 'epel-*') 0755 root root - -" | tee -a /usr/lib/tmpfiles.d/dnf.conf && \
	echo "d $(find /var/lib/dnf/repos -maxdepth 1 -name 'extras-common-*') 0755 root root - -" | tee -a /usr/lib/tmpfiles.d/dnf.conf && \
	echo "d /var/lib/flatpak 0755 root root - -" | tee -a /usr/lib/tmpfiles.d/flatpak.conf && \
	echo "d /var/lib/openvpn 0770 openvpn openvpn - -" | tee -a /usr/lib/tmpfiles.d/openvpn.conf && \
	echo "d /var/lib/samba/drivers 0775 root printadmin - -" | tee -a /usr/lib/tmpfiles.d/samba.conf && \
	echo "d /var/lib/samba/usershares 1770 root usershares - -" | tee -a /usr/lib/tmpfiles.d/samba.conf && \
	echo "d /var/lib/tuned 0755 root root - -" | tee -a /usr/lib/tmpfiles.d/tuned.conf && \
	echo "d /var/log/tuned 0755 root root -" | tee -a /usr/lib/tmpfiles.d/tuned.conf && \
	echo "f /var/log/tuned/tuned-ppd.log 0644 root root -" | tee -a /usr/lib/tmpfiles.d/tuned.conf && \
	ln -s /usr/share/horizon/fastfetch/config.jsonc /etc/skel/.config/fastfetch/config.jsonc && \
    /ctx/initramfs.sh
    
### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
