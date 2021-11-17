#!/bin/bash

set -euo pipefail

# partitions
dd if=/dev/zero of=/dev/sda bs=100MiB count=1 status=none
xargs -L1 parted --script /dev/sda -- <<EOF
mklabel gpt
mkpart primary btrfs 1MiB 100%
set 1 bios_grub on
EOF

# filesystems
mkfs.btrfs -L ROOT /dev/sda1
mount -t btrfs /dev/sda1 /mnt
