#/bin/bash


export PYTHONPATH=/home/deepika/ceph/src/pybind:/home/deepika/ceph/build/lib/cython_modules/lib.3:/home/deepika/ceph/src/python-common:$PYTHONPATH
export LD_LIBRARY_PATH=/home/deepika/ceph/build/lib:$LD_LIBRARY_PATH
export PATH=/home/deepika/ceph/build/bin:$PATH
export CEPH_CONF=/home/deepika/ceph/build/ceph.conf
alias cephfs-shell=/home/deepika/ceph/src/tools/cephfs/shell/cephfs-shell

#suggested to trigger backfilling
ceph config set osd_min_pg_log_entries 1
ceph config set osd_max_pg_log_entries 2

# create a pool and write some data
ceph osd pool create testbackfill 64 64 replicated
rados bench -p testbackfill 15 write --no-cleanup

# drop an OSD and perform some writes
ceph osd out 0
time rados bench -p testbackfill 15 write --no-cleanup

# bring back the OSD this should trigger backfilling as the newly written data needs replication
ceph osd in 0

# how to measure backfill performance now, will it be evident with the write
# performance?
