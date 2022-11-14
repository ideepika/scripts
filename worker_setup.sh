#/bin/bash

# 3 nodes 2 vcpu + 4gb ram + 20 GB vol attached

sudo dnf -y update
sudo dnf install -y git \
  vim \
  curl \

# kubernetes install
git clone https://github.com/rook/rook.git
cd rook && find . -type f -exec sed -i 's/quay\.io\/ceph\/ceph:v17.2.3/koorinc\/koor\-ceph\-container:v17\.2\.3\-20220805/g' {} \;

sudo dnf install -y yum-utils
sudo modprobe overlay
sudo modprobe br_netfilter
cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF
sudo sysctl --system
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
OS_REL=$(cat /etc/redhat-release)
# I only had to remove Podman on CentOS Stream 8
if [[ $OS_REL == 'CentOS Stream release 8' ]]; then
  sudo dnf remove -y podman; 
fi
# If you experience a conflict with buildah, then also remove buildah with dnf.

sudo dnf install -y containerd.io

sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml
sudo systemctl restart containerd

cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF
sudo yum install -y kubelet kubeadm kubectl \
--disableexcludes=kubernetes

sudo systemctl enable --now kubelet

# DO: run kubeadm join for worker nodes
