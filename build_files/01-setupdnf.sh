#!/usr/bin/bash

set -eoux pipefail

echo "::group:: Setup DNF"

dnf config-manager --set-enabled crb && dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm
dnf update -y
dnf -y copr enable horizonproject/horizon
dnf update -y

echo "::endgroup::"
