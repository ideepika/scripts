#!/bin/bash

function run_test_suite {
  CONTAINER="d8d2ca7a41d2 "; \
  docker exec -it $(echo "$CONTAINER") rm -rf /usr/share/ceph/mgr/;docker cp /home/ideepika/ceph2/ceph/src/pybind/mgr/ \
  $(echo "$CONTAINER"):/usr/share/ceph/mgr/; \
  docker commit $(echo "$CONTAINER") localhost:5000/wip-cephadm-jaeger; \
  docker push localhost:5000/wip-cephadm-jaeger; \
  sudo fuser -k 6789/tcp; sudo fuser -k
  3300/tcp; \
  sudo fuser -k 9283/tcp; \
  sudo ./cephadm rm-cluster --fsid $(sudo \
  ./cephadm ls | jq  '.[].fsid' | head -1 | xargs -n 1) --force; \
  sudo ./cephadm
  --image docker.io/ceph/daemon-base:latest-master-devel \
  --verbose --docker \
  bootstrap \
  --mon-ip 192.168.1.16
}

while :; do
    inotifywait -e modify ~/ceph1/src/
    run_test_suite
done
