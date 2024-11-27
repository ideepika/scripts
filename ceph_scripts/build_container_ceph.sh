#/bin/bash

dnf update -y
dnf install vim git wget curl -y
git clone https://github.com/ideepika/ceph/
cd ceph
with_seastar=true ./install-deps.sh
./do_cmake.sh -DWITH_MANPAGE=OFF -DWITH_TESTS=OFF -DWITH_SEASTAR=ON
