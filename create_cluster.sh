#/bin/bash

# ./openshift-install destroy cluster && rm -rf auth kubectl metadata.json terraform.cluster.tfstate terraform.platform.auto.tfvars.json terraform.tfvars.json tls terraform/
# setup public route and update dns on porkbun
#
./openshift-install create cluster

