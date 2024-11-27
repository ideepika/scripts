#/bin/bash

VERSION="reef"
CEPH_RELEASE="18.2.4"
IMAGE="quay.io/ceph/ceph:v18.2"
MON_IP="10.82.116.43"

if [ -f cephadm ]; then
  curl --silent --remote-name --location https://download.ceph.com/rpm-${CEPH_RELEASE}/el9/noarch/cephadm
  chmod +x cephadm
fi

# bootstrap
#./cephadm bootstrap --mon-ip 2a01:4f8:d0:4401:3::23 --skip-mon-network --image $IMAGE
./cephadm --image quay.io/ceph/ceph:v18.2.4 bootstrap --mon-ip $MON_IP
./cephadm shell -- ceph config set mon public_network 2a01:4f8:d0:4401:3::/80 

# add additional hosts
ssh-copy-id -f -i /etc/ceph/ceph.pub root@cph-dpk-01
./cephadm shell -- ceph orch host add cph-dpk-03 2a01:4f8:d0:4401:3::22
ssh-copy-id -f -i /etc/ceph/ceph.pub root@cph-dpk-03
./cephadm shell -- ceph orch host add cph-dpk-03 2a01:4f8:d0:4401:3::24
ssh-copy-id -f -i /etc/ceph/ceph.pub root@cph-dpk-04
./cephadm shell -- ceph orch host add cph-dpk-04 2a01:4f8:d0:4401:3::25

# deploy osds
./cephadm shell -- ceph orch apply osd --all-available-devices


