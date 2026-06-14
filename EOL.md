# Horizon EOL

Thank you for using Horizon. We're sorry to announce, but Horizon will be no longer receiving updates.
We recommend switching to one of the following distros:
- Recommended distros with KDE Plasma:
    - Aurora - https://getaurora.dev (No ARM support, No LTS Kernel)
    - HeliumOS - https://heliumos.org (No ARM Support)
- Recommended distros with GNOME:
    - Bluefin LTS - https://projectbluefin.io
    - Bluefin - https://projectbluefin.io (No ARM support, No LTS Kernel)

# Rebasing
Rebasing is the process of switching your distro to another one, it is very easy to do with BootC based distros like Horizon.

1. Backup your data!!! Just in case, you never know what can happen.
2. Select your new distro
3. Open the terminal

## Steps for Aurora!
### If you don't use NVIDIA
4. Run `sudo bootc switch ghcr.io/ublue-os/aurora:stable`
### If you use NVIDIA
4. Run `sudo bootc switch ghcr.io/ublue-os/aurora-nvidia-open:stable`

## Steps for HeliumOS
4. Run `sudo bootc switch quay.io/heliumos/bootc:10`

## Steps for Bluefin LTS!
### If you don't use NVIDIA
4. Run `sudo bootc switch ghcr.io/ublue-os/bluefin:lts`
### If you use NVIDIA
4. Run `sudo bootc switch ghcr.io/ublue-os/bluefin-gdx:lts`

## Steps for Bluefin!
### If you don't use NVIDIA
4. Run `sudo bootc switch ghcr.io/ublue-os/bluefin:stable`
### If you use NVIDIA
4. Run `sudo bootc switch ghcr.io/ublue-os/bluefin-nvidia-open:stable`

5. Reboot and enjoy!
