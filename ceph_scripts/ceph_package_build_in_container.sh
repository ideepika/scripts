#/bin/bash

apt-get update
apt-get install -y git vim apt-utils gcc make cmake \
    software-properties-common sudo
git clone -b wip-improve-backfill --single-branch https://github.com/ideepika/ceph

cd ceph
./install-deps.sh
sudo apt-get install -y debhelper
sudo dpkg-buildpackage -j$(nproc)
