#!/usr/bin/env bash

TOP_DIR=$(cd $(dirname "$0") && pwd)
cd $TOP_DIR

setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

yum -y remove python-setuptools python-crypto python-jinja2
yum -y install gcc gcc-c++ make python-devel m2crypto

[ -f /usr/local/lib/libzmq.so ] || (
    tar -xzf zeromq-3.2.3.tar.gz &&
    cd zeromq-3.2.3 &&
    ./configure &&
    make &&
    make install &&
    cd $TOP_DIR && rm -fr zeromq-3.2.3 )

cd $TOP_DIR/pips
[ -f /usr/bin/easy_install ] || (
    tar -xzf setuptools-1.1.tar.gz &&
    cd setuptools-1.1 &&
    python setup.py install &&
    cd $TOP_DIR/pips &&
    rm -fr setuptools-1.1 )

[ -f /usr/bin/pip ] || (
    tar -xzf pip-1.4.tar.gz &&
    cd pip-1.4 &&
    python setup.py install &&
    cd $TOP_DIR/pips &&
    rm -fr pip-1.4 )

pip install MarkupSafe-0.18.tar.gz PyYAML-3.10.zip \
    pycrypto-2.6.tar.gz msgpack-python-0.3.0.tar.gz \
    pyzmq-13.1.0.zip Jinja2-2.7.tar.gz salt-0.16.3.tar.gz

cd $TOP_DIR
[ -d /etc/salt ] || cp -r conf /etc/salt
cp -n init/salt-* /etc/rc.d/init.d/
