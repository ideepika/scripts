#!/bin/bash

kubectl delete -f deploy/examples/monitoring/rbac.yaml
kubectl delete -f deploy/examples/monitoring/localrules.yaml

kubectl delete -f ~/rook2/rook/deploy/examples/object-bucket-claim-delete.yaml
kubectl delete -f ~/rook2/rook/deploy/examples/storageclass-bucket-delete.yaml

kubectl delete -f /Users/deepika/cephalocon-24-demo/object-test.yaml

kubectl delete -n rook-ceph cephblockpool replicapool test
kubectl delete storageclass rook-ceph-block
kubectl delete -f csi/cephfs/kube-registry.yaml
kubectl delete storageclass csi-cephfs

kubectl delete all --all -n rook-ceph

kubectl get crds -o jsonpath='{.items[*].metadata.name}' | xargs -n 1 -I {} kubectl delete {} --all -n rook-ceph

kubectl api-resources --verbs=list --namespaced -o name | while read -r res; do kubectl get "$res" -n rook-ceph -o json | jq -r '.items[] | select(.metadata.finalizers) | "\(.metadata.name)"' | xargs -I {} kubectl patch "$res" {} -n rook-ceph --type='merge' -p '{"metadata":{"finalizers": []}}'; done

kubectl delete ns rook-ceph

limactl shell rook sudo rm /var/lib/rook -rf

kubectl delete -f ./deploy/examples/crds.yaml -f ./deploy/examples/common.yaml -f ./deploy/examples/operator.yaml

limactl stop rook
limactl disk unlock osd
limactl disk unlock osd1
limactl disk unlock osd2

limactl disk delete osd -f
limactl disk delete osd1 -f
limactl disk delete osd2 -f

limactl disk create osd --size 20G
limactl disk create osd1 --size 20G
limactl disk create osd2 --size 20G

# to reattach osds1
limactl start rook

kubectl create -f ./deploy/examples/crds.yaml -f ./deploy/examples/common.yaml -f ./deploy/examples/operator.yaml

kubectl apply -f ~/cephalocon-24-demo/cluster-test.yaml
kubectl apply -f ~/cephalocon-24-demo/jaeger-test.yaml
kubectl apply -f /Users/deepika/cephalocon-24-demo/object-test.yaml
kubectl apply -f ~/rook2/rook/deploy/examples/rgw-external.yaml
sleep 10
kubectl apply -f ~/rook2/rook/deploy/examples/toolbox.yaml


kubectl apply -f ~/rook2/rook/deploy/examples/storageclass-bucket-delete.yaml
kubectl apply -f ~/rook2/rook/deploy/examples/object-bucket-claim-delete.yaml
kubectl create -f https://raw.githubusercontent.com/coreos/prometheus-operator/v0.71.1/bundle.yaml
kubectl create -f ~/rook2/rook/deploy/examples/monitoring/prometheus.yaml
kubectl create -f ~/rook2/rook/deploy/examples/monitoring/prometheus-service.yaml
kubectl create -f ~/rook2/rook/deploy/examples/monitoring/rbac.yaml
kubectl create -f ~/rook2/rook/deploy/examples/monitoring/localrules.yaml
