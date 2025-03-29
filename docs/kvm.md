
# KVM installation guide

Tested on:
- Ubuntu

## Steps

### Prequisits

1- install 'libvirtd.service':
```
$ sudo apt install libvirt-daemon-system
```
2- Check if vmx(intel) or svm(amd) flags are enabled (needs <0)
```
$ egrep -c '(vmx|svm)' /proc/cpuinfo
```
3- Check kvm module status (required package 'cpu-checker')
```
$ kvm-ok 
INFO: /dev/kvm exists 
KVM acceleration can be used
```

### Installation

1- install KVM
```
$ sudo apt install -y qemu-kvm libvirt-daemon libvirt-clients bridge-utils virtinst
```
2- check kernel module status
```
$ lsmod | grep kvm
kvm_intel             217088  0
kvm                   614400  1 kvm_intel
irqbypass              16384  1 kvm
```
3- start libvirtd daemon
```
$ systemctl start libvirtd.service
```
4- check libvirt daemon
```
$ systemctl status libvirtd
● libvirtd.service - Virtualization daemon
   Loaded: loaded (/lib/systemd/system/libvirtd.service; enabled; vendor preset:
   Active: active (running) since Wed 2023-08-09 07:59:35 UTC; 21min ago
     Docs: man:libvirtd(8)
           https://libvirt.org
 Main PID: 1487 (libvirtd)
    Tasks: 19 (limit: 32768)
   CGroup: /system.slice/libvirtd.service
           ├─1487 /usr/sbin/libvirtd
           ├─2457 /usr/sbin/dnsmasq --conf-file=/var/lib/libvirt/dnsmasq/default
           └─2458 /usr/sbin/dnsmasq --conf-file=/var/lib/libvirt/dnsmasq/default
```

### Create VM

1- using virt-install
```
$ virt-install \
--name=centosVM \
--ram=4096 \
--disk path=/var/kvm/images/centos7.img,size=15 \
--vcpus=2 \
--os-type=linux \
--os-variant=rhel7 \
--graphics none \
--location 'http://ftp.iij.ad.jp/pub/linux/centos/7/os/x86_64/' \
--extra-args console=ttyS0
Starting install...
Retrieving file vmlinuz... | 6.5 GB 00:17
<...>
```
Parameters:
-name: the guest’s name
-ram: the memory amount
-disk: the storage settings like the directory path and the dedicated size.
-vcpus: the number of virtual processors allocated to the guest
-os-type: the operating system type
-os-variant: the OS distribution
-location: the link to the ISO image
