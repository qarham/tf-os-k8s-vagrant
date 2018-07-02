# Provisioning of Contrail Cloud Clsuter via Contrail Command UI


## 1. Add Servers

![Clsuter Provisioning](/cfm-1vqfx-5srv/docs/images/Add-Server-01.png)

## 2. Add All Servers

![Clsuter Provisioning](/cfm-1vqfx-5srv/docs/images/Add-Servers-All.png)

## 3. Create Cluster

![Clsuter Provisioning](/cfm-1vqfx-5srv/docs/images/Create-Cluster.png)

## 4. Add Contrail Controll Node

![Clsuter Provisioning](/cfm-1vqfx-5srv/docs/images/Add-Contrail-Control-Node.png)

## 5. Add OpenStack Controll Node (Orchestration)

![Clsuter Provisioning](/cfm-1vqfx-5srv/docs/images/Add-OpenStack-Control-Node.png)

## 6. Add Compute Node

![Clsuter Provisioning](/cfm-1vqfx-5srv/docs/images/Add-Compute-Node.png)


## 7. Add Contrail Service Node (Old TSN)

![Clsuter Provisioning](/cfm-1vqfx-5srv/docs/images/Add-Contrail-Service-Node.png)


## 8. Cluster Summary

![Clsuter Provisioning](/cfm-1vqfx-5srv/docs/images/cluster-Summary.png)

## 9. Cluster Summary

![Clsuter Provisioning](/cfm-1vqfx-5srv/docs/images/Cluster-Provisioning-Started.png)


## 10. Check instances.yml

Contrail Command GUI creates instances.yml file used for clsuter provisioning at following location "/var/tmp/contrail_cluster/<Cluster-UUID>/". Please check and review.

```bash
cat /var/tmp/contrail_cluster/a3d545fa-3fe9-4f5f-b35c-a605cb30c408/instances.yml
global_configuration:
  CONTAINER_REGISTRY: 10.84.5.81:5000
  REGISTRY_PRIVATE_INSECURE: True
provider_config:
  bms:
    ssh_user: root
    ssh_pwd: c0ntrail123
    ntpserver: 172.21.200.60
    domainsuffix: englab.juniper.net
instances:
  srv1:
    ip: 10.87.65.71
    provider: bms
    roles:
      config:
      config_database:
      control:
      webui:
      analytics:
      analytics_database:
      openstack_control:
      openstack_network:
      openstack_storage:
      openstack_monitoring:
  srv2:
    ip: 10.87.65.72
    provider: bms
    roles:
      vrouter:
        VROUTER_GATEWAY: 172.16.1.1
      openstack_compute:
  srv3:
    ip: 10.87.65.73
    provider: bms
    roles:
      vrouter:
        TSN_EVPN_MODE: true
        VROUTER_GATEWAY: 172.16.1.1
contrail_configuration:
  CONTRAIL_VERSION: ocata-5.0-115
  CLOUD_ORCHESTRATOR: openstack
  RABBITMQ_NODE_PORT: 5673
  VROUTER_GATEWAY: 172.16.1.1
  ENCAP_PRIORITY: VXLAN,MPLSoUDP,MPLSoGRE
  AUTH_MODE: keystone
  KEYSTONE_AUTH_HOST: 10.87.65.71
  KEYSTONE_AUTH_URL_VERSION: /v3
  CONTROLLER_NODES: 10.87.65.71
  CONTROL_NODES: 172.16.1.101
  TSN_NODES: 172.16.1.103
kolla_config:
  kolla_globals:
    openstack_release: ocata
    enable_haproxy: no
    enable_ironic: no
    enable_swif: no
  kolla_passwords:
    keystone_admin_password: contrail123

 ```

## Other Tips

In case provisioning fail for Contrail install and you would like to run ansible provisioning manually you can use following command

```bash

ansible-playbook -i inventory/ -e orchestrator=openstack -e config_file=/var/tmp/contrail_cluster/<Cluseter-UUID>/instances.yml playbooks/install_contrail.yml
 ```

To reset OpenStack Kola use following command:

Login to contrail_command container and follow the steps:

```bash
docker exec -it contrail_command bash
cd /usr/share/contrail/contrail-kolla-ansible
./tools/kolla-ansible -i ansible/inventory/my_inventory --configdir etc/kolla --passwords etc/kolla/passwords.yml destroy --yes-i-really-really-mean-it
 ```


### References

* <https://github.com/Juniper/contrail-ansible-deployer/wiki>
* <https://github.com/Juniper/vqfx10k-vagrant>