#!/usr/bin/env python3

import requests
import json
import sys
from requests.auth import HTTPBasicAuth
import time

urls = []
retry_interval = 1
#change me
teuth_base_path="/home/ideepika/teuthology/"
email="dupadhya@redhat.com"

def charca_urls():
#https://1.chacra.ceph.com/repos/ceph/wip-mchangir-mds-scrub-error-with-background-task/2221a3be4be7ae18509fca11c3238ed329e61ba8/opensuse/15.2/flavors/default/
   flavours = [
       ["opensuse", "15.2", "default"],
       ["ubuntu", "focal", "default"],
       ["ubuntu", "bionic", "default"],
       ["centos", "8", "default"],
       ["centos", "8", "crimson"],
       ["centos", "8", "notcmalloc"],
       ]

   for flavor in flavors:
       urls.append(
       "https://1.chacra.ceph.com/repos/ceph/" + ci_branch + "/" + sha1+ "/" + flavor[0] + "/" + flavor[1] + "/" + flavor[2]
       )

def schedule_teuthology():
    cmd = teuth_base_path + "/" + input_cmd + "--sha1" + sha1 + "--dry-run" + "-e" + email
    print("running command: " + cmd)
    os.system(cmd)

def status_check():
    if not urls:
       urls = charca_urls()
    for url in urls:
       print(url)
       response = requests.get(url)
       #all should have response, need to check for failure as well
       if not response.text:
           retry_interval + 1
           return
       else:
           schedule_teuthology()

def run():
#will retry every 20 mins for 4 hours
  while retry_interval < 12:
     #check if we get failure in first 10 min
     if retry_interval == 1:
         #time.sleep(600)
     else:
         #time.sleep(1200)
     status_check()

ci_branch = "wip-deepika-testing-2021-01-25-1527"
#ci_branch = input("enter ceph-ci branch: ")
sha1 = "1da329c01d46e5f1bc823e171b6cd2e543771ff4"
#sha1 = input("enter sha1: ")
teuth_cmd = "teuthology-suite -vv -m smithi -c wip-deepika-testing-2021-01-25-1527 --rerun ideepika-2021-01-25_08:14:24-rados-wip-deepika-testing-master-2021-01-22-0047-distro-basic-smithi -p 70"
#teuth_cmd = input("enter teuthology command to dry-run: ")
run()
