#!/bin/bash

set +xe

ssh  -t $HOSTNAME "rm -rf /var/lib/rook/ || true"

ssh  -t $HOSTNAME " # Zap the disk to a fresh, usable state (zap-all is important, b/c MBR has to be clean)
sgdisk --zap-all /dev/sdb

# Wipe a large portion of the beginning of the disk to remove more LVM metadata that may be present
dd if=/dev/zero of=/dev/sdb bs=1M count=100 oflag=direct,dsync

# SSDs may be better cleaned with blkdiscard instead of dd
blkdiscard /dev/sdb

# Inform the OS of partition table changes
partprobe /dev/sdb"
