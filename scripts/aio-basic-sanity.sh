#!/bin/bash -v 

yum install -y wget gcc python-devel wget
pip install python-openstackclient
pip install python-ironicclient
pip install python-neutronclient
pip install python-heatclient

# Check Contrail Status
contrail-status

source /etc/kolla/admin-openrc.sh

#download Cirros image
wget http://download.cirros-cloud.net/0.4.0/cirros-0.4.0-x86_64-disk.img
openstack image create cirros2 --disk-format qcow2 --public --container-format bare --file cirros-0.4.0-x86_64-disk.img

#download lab Ubunt image
#wget  http://10.10.16.104/trusty-server-cloudimg-amd64-disk1.img
#openstack image create --disk-format qcow2 --container-format bare --public --file trusty-server-cloudimg-amd64-disk1.img ubuntu-lab

# Download Cirros Servcie Chaining Image
wget https://raw.githubusercontent.com/qarham/tf-os-k8s-vagrant/master/heat/cirros-sc-3-IFs.img
openstack image create cirrossc --disk-format qcow2 --public --container-format bare --file cirros-sc-3-IFs.img
 
#Create flavors
openstack flavor create --ram 512 --disk 1 --vcpus 1 m1.tiny
openstack flavor create --ram 2048 --disk 5 --vcpus 1 m1.small

# validation
openstack image list
openstack flavor list

# Create Test VM and Test vRouter Connection
openstack network create MGMT-VN
openstack subnet create --subnet-range 172.16.1.0/24 --network MGMT-VN MGMT-VN-subnet

openstack server create --flavor m1.tiny --image 'cirros2' \
    --nic net-id=MGMT-VN \
Test-01

sleep 60
openstack server list

# check linklocal for the VM
#ip route 
#ssh cirros@169.254.0.4

#git clone https://github.com/virtualhops/k8s-demo
#kubectl create -f k8s-demo/po-ubuntuapp.yml
#kubectl create -f k8s-demo/rc-frontend.yml



