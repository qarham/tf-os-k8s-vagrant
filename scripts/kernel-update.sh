#!/bin/bash -eux

#login as root
sudo su

yum -y install kernel-3.10.0-693.21.1.el7.x86_64                                                                                                                                                    
yum update -y
reboot
