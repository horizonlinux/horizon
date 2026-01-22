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

tuned-fix:
    #!/usr/bin/env bash
    ausearch -c tuned-ppd --raw | audit2allow -M tuned_ppd_local
