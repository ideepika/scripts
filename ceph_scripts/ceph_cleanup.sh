#/bin/bash

./cephadm shell -- ceph mgr module disable cephadm
fsid=$(./cephadm shell -- ceph fsid)
./cephadm rm-cluster --force --zap-osds --fsid $fsid

for i in {3..4}
do
ssh cph-dpk-0$i ./cephadm rm-cluster --force --zap-osds --fsid $fsid
done

