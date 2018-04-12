#!/bin/bash -eux

sudo bash -c 'cat <<EOF >/etc/resolv.conf
nameserver 10.96.0.10
nameserver 10.0.2.3
search openstack.svc.cluster.local svc.cluster.local cluster.local contrail.juniper.net
EOF'

