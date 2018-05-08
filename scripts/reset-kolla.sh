#!/bin/bash -eux

cd /opt/contrail-kolla-ansible/ansible

ansible-playbook -i inventory/my_inventory -e @../etc/kolla/globals.yml -e @../etc/kolla/passwords.yml destroy.yml