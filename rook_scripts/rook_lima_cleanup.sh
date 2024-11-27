
kubectl delete -f ../wordpress.yaml
kubectl delete -f ../mysql.yaml
kubectl delete -n rook-ceph cephblockpool replicapool
kubectl delete storageclass rook-ceph-block
kubectl delete -f csi/cephfs/kube-registry.yaml
kubectl delete storageclass csi-cephfs

echo "try wiping host paths..."
kubectl -n rook-ceph patch cephcluster rook-ceph --type merge -p '{"spec":{"cleanupPolicy":{"confirmation":"yes-really-destroy-data"}}}'
echo "delete cluster cr..."
kubectl -n rook-ceph delete cephcluster rook-ceph
sleep 10
echo "cleanup other crs..."
kubectl delete -f ./deploy/examples/operator.yaml
kubectl delete -f ./deploy/examples/common.yaml
kubectl delete -f ./deploy/examples/crds.yaml

# List of disks to clean
lima exec "for DISK in /dev/vdd /dev/vdb /dev/vdc; do
    # Zap the disk to a fresh, usable state (zap-all is important, b/c MBR has to be clean)
    sgdisk --zap-all $DISK

    # Wipe a large portion of the beginning of the disk to remove more LVM metadata that may be present
    dd if=/dev/zero of="$DISK" bs=1M count=100 oflag=direct,dsync

    # SSDs may be better cleaned with blkdiscard instead of dd
    blkdiscard $DISK

    # Inform the OS of partition table changes
    partprobe $DISK

    # Optional: Print a message indicating the disk is cleaned
    echo "Disk $DISK has been cleaned."
done"
