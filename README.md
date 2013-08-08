centos-salt-install
===================

A shell script support to install the latest [salt](http://saltstack.com)
on x86\_64 centos 6.x. This script has tested on min installed 6.4.

### 1. Download and install

    wget https://github.com/jiangy/centos-salt-install/archive/master.zip
    unzip master.zip
    cd centos-salt-install-master
    ./install.sh

### 2.Start master

Use the following command to create the salt root directory, open the
corresponding firewall ports and start salt-master.

    mkdir -p /srv/salt
    sed -i '/22/ a \-A INPUT -m state --state NEW -p tcp --dport 4505:4506 -j ACCEPT' /etc/sysconfig/iptables
    service iptables restart
    chkconfig salt-master on && service salt-master start

### 3.Start minion

Change master value to your master in file `/etc/salt/minion`, as follows:

    - #master: salt
    + master: 10.0.0.1

Note: if your have more than one minion, make sure everyone has a
unique hostname.

Use the following command start minion and make it auto start when
server reboot.

    chkconfig salt-minion on && service salt-minion start

### 4.Tutorial

Visit <http://docs.saltstack.com/topics/tutorials/index.html>

