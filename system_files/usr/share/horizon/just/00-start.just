set allow-duplicate-recipes := true

default:
    @just-do --choose

test:
    #!/usr/bin/env bash
    echo "Hello World!"

update:
    #!/usr/bin/env bash
    pkexec flatpak update
    pkexec bootc update
