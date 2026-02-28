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
