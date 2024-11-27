FROM ubuntu:22.04
LABEL maintainer="dupadhya@redhat.com"

# general utilities
RUN apt-get update
RUN apt-get install bash vim git wget curl -y 
RUN apt-get install gcc make cmake software-properties-common \
    sudo gdb -y 

#jaeger-dependencies
#RUN apt-get install libyaml-dev libgtest-dev libboost-dev \
#    json-devel -y

ENV CEPH_ROOT ~/ceph

VOLUME ["/ceph"]
VOLUME ["/shared"]


