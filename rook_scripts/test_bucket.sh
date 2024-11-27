#!/bin/bash


AWS_PORT="$(k describe svc rook-ceph-rgw-my-store-external -nrook-ceph | grep NodePort | awk '{print $3}' |  cut -d'/' -f1 | tr -d '[:space:]')"
export AWS_URL=http://127.0.0.1:$AWS_PORT

export AWS_ACCESS_KEY_ID=$(kubectl -n default get secret ceph-delete-bucket -o jsonpath='{.data.AWS_ACCESS_KEY_ID}' | base64 --decode)
export AWS_SECRET_ACCESS_KEY=$(kubectl -n default get secret ceph-delete-bucket -o jsonpath='{.data.AWS_SECRET_ACCESS_KEY}' | base64 --decode)
export BUCKET_NAME=$(kubectl get objectbucketclaim ceph-delete-bucket -o jsonpath='{.spec.bucketName}')

