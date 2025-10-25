#!/bin/bash

set -ouex pipefail

systemctl enable NetworkManager
systemctl enable sddm
systemctl enable plasma-setup
systemd-sysusers
