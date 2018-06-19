# ![alt text](/images/cfm-top.png) Contrail Fabric Manager Testbed setup (1vQFX and 5 VMs) for CFM Testing


![Web Console](/images/cfm-1vqfx-5srv-topology.png)


The main code of this repository is taken from [Juniper/vqfx10k-vagrant](https://github.com/Juniper/vqfx10k-vagrant) to create a Testbed for CFM testing. Using this repo you can create a topology captured in the above diagram for basic CFM testing.

* 1 vQFX 10K
* 5 VMs CentOS 7.5 
  * 1 Contrail-Command
  * 1 OpenStack/Contrail Controller
  * 1 CSN "Contrail Service Node"
  * 2 Compute nodes
 
**Prerequisites**: A host machine with Ubuntu/CentOS OS preinstalled with Vagrant & VirtualBox SW. VQFX10k boxes are added to the vagrant host using following steps:

```bash
# Download vqfx re and pfe boxes from following link
wget http://10.84.5.120/cs-shared/images/vagrant-boxes/vqfx-re-virtualbox.box
wget http://10.84.5.120/cs-shared/images/vagrant-boxes/vqfx10k-pfe-virtualbox.box 

# Add vagrant boxes using following command
vagrant box add --name juniper/vqfx10k-re /var/tmp/vqfx-re-virtualbox.box
vagrant box add --name juniper/vqfx10k-pfe /var/tmp/vqfx10k-pfe-virtualbox.box
 ```


```bash
host> git clone https://github.com/qarham/tf-os-k8s-vagrant.git
host> cd tf-os-k8s-vagrant/cfm-1vqfx-5srv
host> vagrant status
host> vagrantup
```

By default without making any change in "Vagrantfile" above topology will be created. You can change MGMT and Ctrl+Data Subnet in Vagrantfile as needed.

```bash
$subnet_mgmt = "10.87.65"
$subnet_ctrl_data= "172.16.1"
```

### References

* <https://github.com/Juniper/contrail-ansible-deployer/wiki>
* <https://github.com/Juniper/vqfx10k-vagrant>