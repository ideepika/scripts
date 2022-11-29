#!/bin/bash

# testing rbd mirroring on 1 TB workload

kubectl create -f ~/rook/deploy/examples/pool-mirrored.yaml

kubectl get cephblockpool.ceph.rook.io/mirroredpool -n rook-ceph -ojsonpath='{.status.info.rbdMirrorBootstrapPeerSecretName}'

kubectl get secret -n rook-ceph pool-peer-token-mirroredpool -o jsonpath='{.data.token}'|base64 -d

#create rbd mirror daemon
kubectl create -f ~/rook/deploy/examples/mirror.yaml -n rook-ceph
