#!/usr/bin/bash

set -eoux pipefail

echo "::group:: Setup DNF"

dnf config-manager --set-enabled crb && dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm
dnf install -y --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-10.noarch.rpm
dnf update -y
dnf -y copr enable horizonproject/horizon
dnf -y copr enable ublue-os/packages
dnf update -y

echo "::endgroup::"
