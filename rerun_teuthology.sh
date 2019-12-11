RERUN=ideepika-2019-12-05_16:02:09-rados-wip-deepika-testing-5-12-2019-distro-basic-smithi 
CEPH_QA_MAIL="dupadhya@redhat.com" 
MACHINE_NAME=smithi 
CEPH_BRANCH=wip-deepika-testing-5-12-2019 
 
./virtualenv/bin/teuthology-suite -v \
-c $CEPH_BRANCH \
-m smithi \
-r $RERUN \
--suite-repo https://github.com/ceph/ceph-ci.git \
--ceph-repo https://github.com/ceph/ceph-ci.git \
--suite-branch $CEPH_BRANCH \
-p 60 \
-R fail,dead,queued,running \
-e $CEPH_QA_MAIL
