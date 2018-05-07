#!/bin/bash -eux

#login as root
sudo su
sed -i '1 i\10.13.82.32    os-node01' /etc/hosts
sed -i '1 i\10.13.82.33    os-node02' /etc/hosts
sed -i '1 i\10.13.82.34    os-node03' /etc/hosts
