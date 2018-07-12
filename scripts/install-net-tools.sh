#! /bin/sh

NETTOOLS="pciutils wget tcpdump net-tools"

if egrep -i 'redhat|centos|fedora' /etc/os-release ; then
    INSTALLER=yum
elif egrep -i 'debian|ubuntu' ; then
    INSTALLER=apt-get
else
    INSTALLER=error
    echo "`basename $0`: Cannot determine system type, skipped install $@" >&2
    echo "`basename $0`: `uname -srmop`" >&2
    exit 1
fi

sudo $INSTALLER install -y ${NETTOOLS}
exit
