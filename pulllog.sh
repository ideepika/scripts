#!/bin/bash

files=$(find . -name "ceph-osd*log.gz")

ssh -l host
"for f in $files; do
  (cd $(dirname $f) && gzip $(basename $f))
done"


