#!/bin/bash

files=$(find . -name "ceph-osd*")

ssh -l host
"for f in $files; do
  (cd $(dirname $f) && gzip $(basename $f))
done"


