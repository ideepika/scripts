#!/usr/bin/env python3
import re
#description = input("enter description string")

description = "{0-size-min-size-overrides/2-size-2-min-size 1-pg-log-overrides/normal_pg_log 2-recovery-overrides/{default} backoff/normal ceph clusters/{fixed-2 openstack} crc-failures/bad_map_crc_failure d-balancer/upmap msgr-failures/few msgr/random objectstore/bluestore-comp-zstd rados supported-random-distro$/{centos_latest} thrashers/mapgap thrashosds-health workloads/admin_socket_objecter_requests}"

regex = re.compile("\ |\/|\{|\}")
filter = regex.sub(",", (description.lstrip('{').rstrip('}')))
print(filter)
