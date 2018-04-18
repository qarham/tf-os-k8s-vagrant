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
sudo ansible-playbook -e orchestrator=kubernetes -i inventory/ playbooks/install_contrail.yml

echo ****************** Monitoring Software Installation ********
# Weavescope will create a separate Namespace called "weave" and use NodePort use "kubectl get svc -n weave" for NodePort number
kubectl apply -f "https://cloud.weave.works/k8s/scope.yaml?k8s-service-type=NodePort&k8s-version=$(kubectl version | base64 | tr -d '\n')"

