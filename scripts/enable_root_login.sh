#!/bin/bash -eux

CF_USER=${CF_USER:=root}
CF_PASS=${CF_PASS:=Juniper123}

#login as root
sudo su

sudo sed -e 's/^#PermitRootLogin/PermitRootLogin/'                      \
         -e 's/^PermitRootLogin .*/PermitRootLogin yes/'                \
         -i /etc/ssh/sshd_config
sudo sed -i '/^#ListenAddress 0.0.0.0/s/^#//' -i /etc/ssh/sshd_config
sudo sed -e 's/^#PasswordAuthentication/PasswordAuthentication/'        \
         -e 's/^PasswordAuthentication .*/PasswordAuthentication yes/'  \
         -i /etc/ssh/sshd_config

if ${SYSTEMD:-true}
then
    sudo systemctl restart sshd
else
    sudo service   ssh     restart
fi

echo "${CF_USER}:${CF_PASS}" | sudo chpasswd

sudo iptables -F
