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

limactl delete rook
limactl create --name=rook ~/lima/lima-rook-vm.yaml
limactl start rook
export KUBECONFIG="/Users/deepika/.lima/rook/copied-from-guest/kubeconfig.yaml"
echo "export KUBECONFIG=\"/Users/deepika/.lima/rook/copied-from-guest/kubeconfig.yaml\""

kubectl create -f ./deploy/examples/crds.yaml -f ./deploy/examples/common.yaml -f ./deploy/examples/operator.yaml

kubectl apply -f ~/cephalocon-24-demo/cluster-test.yaml
helm repo add jetstack https://charts.jetstack.io --force-update
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.16.1 \
  --set crds.enabled=true
sleep 10
kubectl create ns observability
kubectl create -f https://github.com/jaegertracing/jaeger-operator/releases/download/v1.62.0/jaeger-operator.yaml -n observability
kubectl apply -f ~/cephalocon-24-demo/jaeger-test.yaml
kubectl apply -f ~/rook2/rook/deploy/examples/crds.yaml ~/rook2/rook/deploy/examples/common.yaml ~/rook2/rook/deploy/examples/operator.yaml
kubectl apply -f ~/cephalocon-24-demo/cluster-test.yaml
kubectl apply -f /Users/deepika/cephalocon-24-demo/object-test.yaml
kubectl apply -f ~/rook2/rook/deploy/examples/rgw-external.yaml
sleep 10
kubectl apply -f ~/rook2/rook/deploy/examples/toolbox.yaml


kubectl apply -f ~/rook2/rook/deploy/examples/storageclass-bucket-delete.yaml
kubectl apply -f ~/rook2/rook/deploy/examples/object-bucket-claim-delete.yaml
kubectl create -f https://raw.githubusercontent.com/coreos/prometheus-operator/v0.71.1/bundle.yaml
kubectl create -f ~/rook2/rook/deploy/examples/monitoring/prometheus.yaml
kubectl create -f ~/rook2/rook/deploy/examples/monitoring/rbac.yaml
kubectl create -f ~/rook2/rook/deploy/examples/monitoring/localrules.yaml
kubectl create -f ~/rook2/rook/deploy/examples/monitoring/prometheus-service.yaml


