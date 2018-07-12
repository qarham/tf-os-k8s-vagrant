#! /bin/sh -x

for i
do
    sudo echo nameserver $i
done >/etc/resolv.conf
