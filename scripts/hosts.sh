#!/bin/bash -eux

#login as root
sudo su
sed -i '1 i\10.13.82.32    k8s-cbuilder' /etc/hosts
