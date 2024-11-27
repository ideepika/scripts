apt-get update -y
apt-get install -y python3-yaml python3-lxml pdsh
sudo apt-add-repository 'deb https://2.chacra.ceph.com/r/ceph/wip-improve-backfill/bb9ea15c077a0f39826f56e5d01faae1381f71de/ubuntu/jammy/flavors/default/ jammy main' --allow-unauthenticated
sudo apt-get update -y --allow-insecure-repositories --allow-unauthenticated

apt-get install cephadm -y

ssh-keygen -t dsa
