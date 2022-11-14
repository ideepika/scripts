#/bin/bash

wget https://github.com/gruntwork-io/cloud-nuke/releases/download/v0.1.24/cloud-nuke_linux_amd64

mkdir ~/bin
cp cloud-nuke_linux_amd64 ~/cloud-nuke
chmod u+x ~/bin/cloud-nuke

awsRegionList=$(aws ec2 describe-regions | jq -r '.Regions[] | .RegionName')
for region in $awsRegionList
do
  cloud-nuke aws --region ${region}
done
#
