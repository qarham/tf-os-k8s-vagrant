#!/bin/bash -v 

sudo yum install -y git ansible pciutils

# Download Contrail-Ansible-Deployer code
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
