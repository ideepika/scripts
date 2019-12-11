RERUN=ideepika-2019-11-29_10:31:20-rados-master-distro-basic-smithi
CEPH_QA_MAIL="dupadhya@redhat.com"
MACHINE_NAME=smithi
CEPH_BRANCH="wip-deepika-testing-5-12-2019"
SUITE=rados

./virtualenv/bin/teuthology-suite -v \
-m $MACHINE_NAME \
--suite $SUITE \
--suite-repo https://github.com/ceph/ceph-ci.git \
--suite-branch $CEPH_BRANCH \
--ceph-repo https://github.com/ceph/ceph-ci.git \
-c $CEPH_BRANCH \
-n 20 \
-p 150 \
-e $CEPH_QA_MAIL \
--subset 231/9999
