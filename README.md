
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/H0rizonPr0ject/horizon/master/.github/horizon.svg">
  <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/H0rizonPr0ject/horizon/master/.github/horizon.svg">
  <img src="https://raw.githubusercontent.com/H0rizonPr0ject/horizon/master/.github/horizon.svg" alt="horizon" align="center" height="200">
</picture>
    </center>
  </a>
  <br>
  <h3 align="center"><center>Build scripts for image creation</center></h3>
  <br>
  <br>
</div>

<p align="center">
<!--  <img src="https://github.com/elementary/os/workflows/stable/badge.svg" alt="Stable">
  <img src="https://github.com/elementary/os/actions/workflows/daily-8.0.yml/badge.svg" alt="Daily 8.0">
  <img src="https://github.com/elementary/os/actions/workflows/daily-arm.yml/badge.svg" alt="Daily ARM"> -->

</p>

---
## Special Thanks
[elementaryOS Team](https://github.com/elementary/) for their [ISO build script](https://github.com/elementary/os/)

## Building Locally

As horizon is built with the Debian version of `live-build`, not the Ubuntu patched version, it's easiest to build an horizon .iso in a Debian VM or container. This prevents messing up your host system too.

The following examples assume you have Docker correctly installed and set up, and that your current working directory is this repo. When done, your image will be in the `builds` folder.

### 64-bit AMD/Intel

See what is the release name of release you want to build, then run:

```sh
docker run --rm --privileged -it \
    -v /proc:/proc \
    -v ${PWD}:/working_dir \
    -w /working_dir \
    debian:latest \
    ./build.sh etc/[release name].conf
```

for example to build Horizon 1.0 run this:

```sh
docker run --rm --privileged -it \
    -v /proc:/proc \
    -v ${PWD}:/working_dir \
    -w /working_dir \
    debian:latest \
    ./build.sh etc/denali.conf
```

### Raspberry Pi 4

```sh
docker run --rm --privileged -it \
    -v /proc:/proc \
    -v ${PWD}:/working_dir \
    -w /working_dir \
    ubuntu:22.04 \
    ./build-rpi.sh
```

### Pinebook Pro

```sh
docker run --rm --privileged -it \
    -v /proc:/proc \
    -v ${PWD}:/working_dir \
    -w /working_dir \
    ubuntu:20.04 \
    ./build-pinebookpro.sh
```

## Further Information

More information about the concepts behind `live-build` and the technical decisions made to arrive at this set of tools to build an .iso can be found [on the wiki](https://github.com/elementary/os/wiki/Building-iso-Images).
