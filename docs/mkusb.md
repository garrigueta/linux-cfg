
# MKUSB installation guide

## Description
Mkusb is a graphical utility to make bootable drives on Ubuntu Linux

official docs: 
- [linux-kvm.org](https://linux-kvm.org/page/WindowsGuestDrivers/viostor/documentation)

sources:
- [how to create persistent-live usb on ubuntu](https://ostechnix.com/how-to-create-persistent-live-usb-on-ubuntu/)

Tested on:
- Ubuntu

## Steps

### Prequisits (Ubuntu)

1- Enable [Universe] repository:
```
$ sudo add-apt-repository universe
```
2- Add the 'mkusb' ppa repository:
```
$ sudo add-apt-repository ppa:mkusb/ppa
$ sudo apt update
```

### Installation

1- install MKUSB
```
$ sudo apt install --install-recommends mkusb mkusb-nox usb-pack-efi
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

- name: the guest’s name
- ram: the memory amount
- disk: the storage settings like the directory path and the dedicated size.
- vcpus: the number of virtual processors allocated to the guest
- os-type: the operating system type
- os-variant: the OS distribution
- location: the link to the ISO image
