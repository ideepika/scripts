#!/bin/bash

minikube start --disk-size=40g --extra-disks 3 --driver qemu
export PATH=/usr/local/go/bin/:$PATH
eval $(minikube docker-env -p minikube)

cd ~/rook
make BUILD_REGISTRY=local
cd deploy/examples/
kubectl create -f crds.yaml -f common.yaml -f operator.yaml
sleep 5
k apply -f cluster-test.yaml
