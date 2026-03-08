set allow-duplicate-recipes := true

default:
    @just-do --choose

test:
    #!/usr/bin/env bash
    echo "Hello World!"

update-fastfetch-config:
    #!/usr/bin/env bash
    mkdir -p /var/home/$(whoami)/.config/fastfetch
    cp /etc/skel/.config/fastfetch/config.jsonc /var/home/$(whoami)/.config/fastfetch/config.jsonc
    fastfetch

reinstall-horizon-flatpaks:
    #!/usr/bin/env bash
    pkexec flatpak install --system -y flathub org.kde.ark io.github.kolunmi.Bazaar io.github.shonebinu.Brief org.kde.elisa org.kde.filelight org.mozilla.firefox com.github.tchx84.Flatseal org.kde.gwenview org.kde.kalk org.kde.okular org.kde.skanpage org.videolan.VLC io.github.flattool.Warehouse
