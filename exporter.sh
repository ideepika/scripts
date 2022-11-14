              set -x
              if radosgw-admin user list | grep -q '"extended-ceph-exporter"'; then
                radosgw-admin user rm --uid extended-ceph-exporter
              fi
                radosgw-admin user create --uid extended-ceph-exporter \
                --display-name "extended-ceph-exporter admin user" \
                --caps "buckets=read;users=read;usage=read;metadata=read;zone=read" \
                --access-key=$(RGW_ACCESS_KEY) \
                --secret-key=$(RGW_SECRET_KEY)
              sleep 10000

