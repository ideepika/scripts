#/bin/bash

awsRegionList=$(aws ec2 describe-regions | jq -r '.Regions[] | .RegionName')
for region in $awsRegionList
do
  cloud-nuke aws --region ${region}
  done
#
