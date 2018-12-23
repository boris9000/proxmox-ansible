# download the image
wget http://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2

# create a new VM
qm create 9001 --memory 4096 --cores 2 --vcpus 2 --net0 virtio,bridge=vmbr0

# import the downloaded disk to local-lvm storage
qm importdisk 9001 CentOS-7-x86_64-GenericCloud.qcow2 local-lvm

# finally attach the new disk to the VM as scsi drive
qm set 9001 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9001-disk-0

# add cloud-init cdrom drive
qm set 9001 --ide2 local-lvm:cloudinit

# To be able to boot directly from the Cloud-Init image, set the bootdisk parameter to scsi0, and restrict BIOS to boot from disk only. This will speed up booting, because VM BIOS skips the testing for a bootable CDROM.
qm set 9001 --boot c --bootdisk scsi0

#Also configure a serial console and use it as a display. Many Cloud-Init images rely on this, as it is an requirement for OpenStack images.
qm set 9001 --serial0 socket --vga serial0

#covert VM into template
qm template 9001

#set up sshkey
qm set 9001 --sshkey ~/.ssh/id_rsa.pub

#set up user
qm set 9001 --ciuser hadoop


