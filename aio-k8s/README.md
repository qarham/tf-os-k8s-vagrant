# ![alt text](/images/TF.png)Tungsten Fabric All In One Kubernetes Cluster Deployment via Ansible & Vagrant

![Web Console](/images/tf-k8s-ansible-main.png)

### AIO Kubernetes Clsuter Topology Diagram

![Web Console](/images/tf-aio-k8s-topology-1.png)

```bash
k8s-aio> git clone https://github.com/qarham/tf-os-k8s-vagrant.git
k8s-aio> cd tf-os-k8s-vagrant/aio-k8s
k8s-aio> vagrant status
k8s-aio> vagrantup
```

By default without making any change in "Vagrantfile" above topology will be created and you can access the Tungsten Fabric GUI and Kubernetes Dashboard using FoxyProxy

### How to use Foxy Proxy for GUI access

Follow these steps for GUI access via FoxyProxy.
1- Open FireFox and open https://addons.mozilla.org/en-US/firefox/ URL.
2- Search for FoxyProxy and select "FoxyProxy Standard"
3- Click on "Add to Firefox"


Note: I used FirFox FoxyProxy add-on


![Web Console](/images/FoxyProxy-Install.png)

Now open ssh pot forwading session to Host 10.1.1.100 using port 1080. please change IP as per your host config

```bash
your-laptop> ssh root@10.1.1.100 -D 1080
```

Configure FireFox FoxyProxy add-on by configuring "127.0.0.1" & port 1080 as Scoks4 as captured in screenshot. 

![Web Console](/images/FoxyProxy-Configure.png)

Now enable FoxyProxy add-on by selecting the profile created earlier and open Contrail GUI using IP address of Vagrant VM 192.168.1.101

![Web Console](/images/FoxyProxy-Contrail-GUI-k8s.png)

## For MAC users

For MAC users Vagrant run locally and there is no need to SSH to host instead you can run GUI directly without Foxyproxy.

Contrail GUI:
https://192.168.1.101:8143
