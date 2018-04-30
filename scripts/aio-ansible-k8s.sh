#!/bin/bash -v 

sudo yum install -y git ansible-2.4.2.0 pciutils wget

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

echo ******* Taint k8s Master for PODs creation ***************
kubectl taint nodes --all node-role.kubernetes.io/master-

echo ****************** Monitoring Software Installation ********
# Weavescope will create a separate Namespace called "weave" and use NodePort use "kubectl get svc -n weave" for NodePort number
kubectl apply -f "https://cloud.weave.works/k8s/scope.yaml?k8s-service-type=NodePort&k8s-version=$(kubectl version | base64 | tr -d '\n')"

#kubectl apply -f "https://cloud.weave.works/k8s/scope.yaml?k8s-version=$(kubectl version | base64 | tr -d '\n')"
#kubectl port-forward -n weave "$(kubectl get -n weave pod --selector=weave-scope-component=app -o jsonpath='{.items..metadata.name}')" 4040

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