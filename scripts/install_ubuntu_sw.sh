sudo apt-get update
sudo apt-get install \
     git \
     wget \
     python-pip \
     python-dev \
     build-essential \
     python-pip
     apt-transport-https \
     createrepo \
     rpm2cpio  -y

sudo wget https://launchpad.net/~ansible/+archive/ubuntu/ansible-2.4/+files/ansible_2.4.2.0-1ppa~zesty_all.deb

sudo dpkg -i ansible_2.4.2.0-1ppa~zesty_all.deb


