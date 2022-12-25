#/bin/bash

set -xe

# DO: 3 nodes 2 vcpu + 4gb ram + 20 GB vol attached

sudo dnf -y update
sudo dnf install -y git \
  vim \
  curl \
  tar

# install helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && \
chmod 700 get_helm.sh && \
./get_helm.sh

# kubernetes install
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
sudo systemctl enable containerd
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
# k8s cluster deploy
kubeadm init --apiserver-advertise-address=$(hostname -I | awk '{print $1}') --pod-network-cidr=10.244.0.0/16
# TODO: fix this, deploy network utility for k8s
# kubernetes cluster setup
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
sleep 3
helm repo add cilium https://helm.cilium.io/; helm install cilium cilium/cilium --version 1.12.4 \
  --namespace kube-system
#restart unmanaged pods
kubectl get pods --all-namespaces -o custom-columns=NAMESPACE:.metadata.namespace,NAME:.metadata.name,HOSTNETWORK:.spec.hostNetwork --no-headers=true | grep '<none>' | awk '{print "-n "$1" "$2}' | xargs -L 1 -r kubectl delete pod

# for rook cluster setup
git clone https://github.com/rook/rook.git
cd rook && find . -type f -exec sed -i 's/quay\.io\/ceph\/ceph:v17.2.3/koorinc\/koor\-ceph\-container:v17\.2\.3\-20220805/g' {} \;
sudo yum install -y lvm2

# DO: add worker nodes by run join command from kubeadm init

git clone --single-branch --branch master https://github.com/rook/rook.git
cd rook &&  find . -type f -exec sed -i 's/quay\.io\/ceph\/ceph:v17.2.3/koorinc\/koor\-ceph\-container:v17\.2\.3\-20220805/g' {} \;
cd deploy/examples
kubectl create -f crds.yaml -f common.yaml -f operator.yaml
kubectl create -f cluster.yaml
kubectl create -f toolbox.yaml
watch kubectl -n rook-ceph get pod

# for better ceph cluster debugging install krew
# check https://github.com/rook/kubectl-rook-ceph
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)
sudo dnf install -y jq
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
kubectl krew install rook-ceph
