#!/usr/bin/bash

set -eoux pipefail

echo "::group:: Install KDE Plasma"

dnf group install -y KDE -x kdebugsettings -x krfb -x plasma-discover -x plasma-discover-notifier -x kde-settings-sddm -x kde-settings-pulseaudio -x kde-settings -x kde-settings-plasma && \

dnf install -y \
        dolphin \
        konsole \
        horizon-plasma-setup \
        xdg-desktop-portal-kde
