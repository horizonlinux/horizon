#!/usr/bin/bash

set -eoux pipefail

echo "::group:: Install KDE Plasma"

dnf group install -y KDE -x *sddm* -x sddm -x sddm-kcm -x sddm-breeze -x kdebugsettings -x krfb -x plasma-discover -x plasma-discover-notifier -x kde-settings-sddm -x kde-settings-pulseaudio -x kde-settings -x kde-settings-plasma

dnf install -y \
        drkonqi \
        dolphin \
        konsole \
        horizon-plasma-setup \
        plasma-login-manager \
        xdg-desktop-portal-kde
