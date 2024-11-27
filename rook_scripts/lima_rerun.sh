#!/bin/bash
set -xe 

export LIMA_INSTANCE=rook
export KUBECONFIG="/Users/deepika/.lima/rook/copied-from-guest/kubeconfig.yaml"

make BUILD_REGISTRY=local DOCKERCMD="lima sudo nerdctl --namespace k8s.io" BUILD_CONTEXT_DIR="$PWD/_output/bin/docker"
make crds

lima sudo crictl rmi docker.io/local/ceph-arm64:latest
lima sudo crictl rmi docker.io/rook/ceph:master
lima sudo ctr --namespace=k8s.io images tag "docker.io/local/ceph-arm64:latest" 'docker.io/rook/ceph:master'
k apply -f deploy/examples/crds.yaml

kubectl rollout restart deployment rook-ceph-operator -n rook-ceph
 kubectl rollout restart deployment rook-ceph-rgw-my-store-a -n rook-ceph

 # TODO check sha1 generated
