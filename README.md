# Horizon

<img width="1920" height="1080" alt="image" src="https://raw.githubusercontent.com/horizonlinux/horizon-themes/refs/heads/main/io.github.horizonlinux.HorizonLight/contents/previews/fullscreenpreview.jpg" />

Horizon is an atomic, CentOS-based distribution, with focus on user-friendliness, ease-of-use, and stability.

# Installing Horizon

## Rebase from another bootc distribution
1. `bootc switch ghcr.io/horizonlinux/horizon`
2. Reboot
3. `just-do reinstall-horizon-flatpaks`

## Fresh Install
You can download ISO file from https://github.com/horizonlinux/titanoboa/actions

# Making image based on Horizon

Check out https://github.com/ublue-os/image-template and change the base image to `ghcr.io/horizonlinux/horizon`
