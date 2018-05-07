#!/bin/bash -v 

sudo yum install -y git ansible-2.4.2.0 pciutils wget

# Download Contrail-Ansible-Deployer code For GA R5.0 use 1st command
# git clone -b R5.0 https://github.com/Juniper/contrail-ansible-deployer /opt/contrail-ansible-deployer
sudo git clone https://github.com/Juniper/contrail-ansible-deployer.git /opt/contrail-ansible-deployer

export BASE_DIR=/opt
export OC_PATH=${BASE_DIR}/contrail-ansible-deployer

cd ${BASE_DIR}

rm -rf ${OC_PATH}/config/instances.yaml
cp /home/vagrant/instances.yaml ${OC_PATH}/config/

cd ${OC_PATH}

sudo ansible-playbook -i inventory/ playbooks/configure_instances.yml
sudo ansible-playbook -i inventory/ -e orchestrator=openstack playbooks/install_contrail.yml


# Install Weave Scope for Conatiners monitoring
sudo curl -L git.io/scope -o /usr/bin/scope
sudo chmod a+x /usr/bin/scope
scope launch

echo ******** Clusterbinding for K8s Dashboard ******************
kubectl replace -f https://raw.githubusercontent.com/Juniper/contrail-helm-deployer/master/rbac/cluster-admin.yaml

# If vRouter Agent did not start due to following error "ksync_memory.cc:107: void KSyncMemory::Mmap(bool): Assertion `0' failed" use following command to clean
free -h
echo 3 > /proc/sys/vm/drop_caches
free -h

# Other vrouter commands
#lsmod | grep vrouter
#modprobe vrouter
#cd /etc/contrail/vrouter
#docker-compose down
#docker-compose up -d