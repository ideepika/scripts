WORKSPACE="/home/ideepika"

NAME="${NAME:-jaeger-ceph-container}"
CEPH="${CEPH:-$WORKSPACE/ceph}"
CCACHE="${CCACHE:-$WORKSPACE/ceph-ccache}"
VERSION="${VERSION:-master}"
TAG="${TAG:-cj}"

# Creates a container with all recommended configs
docker run -itd \
  -v $CEPH:/ceph \
  -v $CCACHE:/root/.ccache \
  -v /run/udev:/run/udev:ro \
  --privileged \
  --cap-add=SYS_PTRACE \
  --security-opt seccomp=unconfined \
  --net=host \
  --name=$NAME \
  --hostname=$NAME \
  --add-host=$NAME:127.0.0.1 \
  $TAG 

docker exec -it $NAME /bin/bash

