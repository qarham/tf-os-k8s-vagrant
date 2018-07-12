#!/bin/bash -eux

CF_USER=${CF_USER:=root}
CF_PASS=${CF_PASS:=Juniper123}

#login as root
sudo su

sudo sed -e '/PermitRootLogin/ s/^#*/#/' -i /etc/ssh/sshd_config
sudo sed '/^#PermitRootLogin/a PermitRootLogin yes' -i /etc/ssh/sshd_config
sudo sed -i '/^#ListenAddress 0.0.0.0/s/^#//' -i /etc/ssh/sshd_config
sudo sed '/^#PasswordAuthentication/a PasswordAuthentication yes' -i /etc/ssh/sshd_config

if ${SYSTEMD:-true}
then
    sudo systemctl restart sshd
else
    sudo service   ssh     restart
fi

echo "${CF_USER}:${CF_PASS}" | sudo chpasswd

sudo iptables -F
