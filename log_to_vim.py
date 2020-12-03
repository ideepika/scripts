#!/usr/bin/env python3
import re
import os

url = input("enter log url: eg 'http://qa-proxy.ceph.com/teuthology/ideepika-2020-12-01_10:12:32-rados:cephadm-wip-jaegertracing-in-ceph-distro-basic-smithi/'")
regex = re.compile("^((http:\/\/qa-proxy.ceph.com|\/a)\/teuthology)")
archive = regex.sub("/ceph/teuthology-archive", url)
print(" opening failed/dead jobs for " + archive + " .......")

scrape = archive + "scrape.log"

with open(scrape,'r') as f:
	job_id = re.findall(r'[0-9]{7}', f.read())
	print(job_id)

for idx, item in enumerate(job_id):
	job_id[idx] = archive + item + "/teuthology.log"

os.system("vim -p " +" ".join(job_id))
