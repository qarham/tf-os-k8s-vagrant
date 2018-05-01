# ![alt text](/images/TF.png)Tungsten Fabric OpenStack & Kubernetes Cluster Deployment via Ansible & Vagrant

![Web Console](images/tf-os-k8s-ansible-main.png)

## Tested with

* CentOS: 7.4.1708
* Kernel: 3.10.0-693.21.1.el7.x86_64
* Vagrant: 2.0.3
* Ansible: 2.4.2.0
* VirtualBox: 5.2

This guide will use Contrail-Ansible-Deployer repo for Contrail Microservice deployment using Vagrant. The assumption here is Host node is ready with Ansible, Vagrant and VirtualBox software installion.

There are different deploymemt models, AIO, Multi-Node please using following links to select one and test the deployment.

### [AIO-K8S](./aio-k8s/README.md)
### [AIO-OS-K8S](./aio-os-k8s/README.md)


### Abbreviation

- AIO: All In One
- K8S: Kubernetes
- MN: Multi Node
- OS: OpenStack
- TF: Tungsten Fabric
### Reference

* <https://github.com/Juniper/contrail-ansible-deployer/wiki>