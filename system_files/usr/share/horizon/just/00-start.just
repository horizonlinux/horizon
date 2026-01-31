set allow-duplicate-recipes := true

default:
    @just-do --choose

test:
    #!/usr/bin/env bash
    echo "Hello World!"

update-fastfetch-config:
    #!/usr/bin/env bash
    cp /etc/skel/.config/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc
    fastfetch
