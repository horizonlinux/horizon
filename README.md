<center align="center"> <img style="max-width: 256px;" src="https://raw.githubusercontent.com/horizonlinux/horizon/refs/heads/main/horizon%20color.png"> </center>

# About

Arch based distro with with Bootc composefs-native backend. It uses Plasma as the desktop enviroment.

<small>I am so sorry to all Polish users of Horizon. I know that the translation is bad, but Plasma is one of the best DEs</small>

## Building

In order to get a running arch-bootc system you can run the following steps:
```shell
just build-containerfile # This will build the containerfile and all the dependencies you need
just generate-bootable-image # Generates a bootable image for you using bootc!
```

Then you can run the `bootable.img` as your boot disk in your preferred hypervisor.

# Fixes

- `mount /dev/vda2 /sysroot/boot` - You need this to get `bootc status` and other stuff working (`/dev/vda2` is your ESP)
