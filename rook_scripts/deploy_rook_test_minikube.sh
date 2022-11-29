#/bin/bash

minikube start --force --memory="4096" --cpus="2" -b kubeadm --kubernetes-version="v1.19.2" --driver="kvm2" --feature-gates="BlockVolume=true,CSIBlockVolume=true,VolumeSnapshotDataSource=true,ExpandCSIVolumes=true"

#folder for ceph info
minikube ssh "sudo mkdir -p /mnt/vda1/var/lib/rook;sudo ln -s /mnt/vda1/var/lib/rook /var/lib/rook"

#adding a disk
sudo -S qemu-img create -f raw /var/lib/libvirt/images/minikube-box-vm-disk-100G 100G
virsh -c qemu:///system attach-disk minikube --source /var/lib/libvirt/images/minikube-box-vm-disk-90G --target vdb --cache none
virsh -c qemu:///system reboot --domain minikube

sleep 5

minikube start --force -b kubeadm --driver="kvm2" --feature-gates="BlockVolume=true,CSIBlockVolume=true,VolumeSnapshotDataSource=true,ExpandCSIVolumes=true"

kubectl create -f ~/rook2/rook/deploy/examples/crds.yaml
kubectl create -f ~/rook2/rook/deploy/examples/common.yaml
kubectl create -f ~/rook2/rook/deploy/examples/operator.yaml
kubectl create -f ~/rook2/rook/deploy/examples/cluster-test.yaml
kubectl create -f ~/rook2/rook/deploy/examples/toolbox.yaml
