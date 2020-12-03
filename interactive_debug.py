#!/usr/bin/env python3

import re
import subprocess

url_input =  input(" Enter teuthology log url link: ")

if re.findall(r"^((http:\/\/qa-proxy.ceph.com|\/a)\/teuthology\/)([a-z0-9_\.:\-\/]+)(\d{7})(\/teuthology\.log)$", url_input):

  cp_name = re.match(r"^((http:\/\/qa-proxy.ceph.com|\/a)\/teuthology\/)([a-z0-9_\.:\-\/]+)(\d{7})(\/teuthology\.log)", url_input)
  archive_path = "/a/" + cp_name.group(3) + cp_name.group(4) + "/orig.config.yaml"
  test_name = (cp_name.group(3) + cp_name.group(4) + ".yaml").replace("/", "-")

  print("copying... {} to {}".format(archive_path, test_name))
  cmd = ['cp', str(archive_path), str(test_name)]
  subprocess.call(cmd)

  cmd = ['sed', '-i', 's/archive_path:.*/interactive-on-error: true/', str(test_name)]
  subprocess.call(cmd)
  print("your config file name is: \n {}".format(test_name))

#setup teuthology sched run next
#  input("Input:\n " \
#	"1 To make changes to config\n " \
#	"2 schedule a interactive teuthology sessions\n " \
#	)
