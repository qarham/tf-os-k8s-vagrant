#!/bin/bash -v 

gw='10.13.82.1'
while test $# -gt 0
do
    key=$1; shift
    case $key in
    gateway|GATEWAY)
        gw="$1"; shift
        ;;
    esac
done

sudo sed  -i '/ONBOOT/a DEFROUTE="no"' /etc/sysconfig/network-scripts/ifcfg-eth0
sudo sed  -i "/NETMASK/a GATEWAY=$gw"  /etc/sysconfig/network-scripts/ifcfg-eth1
#sudo sed -i 's/DEFROUTE="yes"/DEFROUTE="no"/' /etc/sysconfig/network-scripts/ifcfg-enp0s3
#sudo sed  -i '/NETMASK/a GATEWAY=10.13.82.1' /etc/sysconfig/network-scripts/ifcfg-enp0s8
sudo systemctl restart network
