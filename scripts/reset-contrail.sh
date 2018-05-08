#!/bin/bash -eux

kubeadm reset

for i in `find /etc/contrail -name docker-compose.yaml`; do docker-compose -f $i down -v; done