#!/bin/bash
#Date: 2019-03-19
#Git
Version=3.7.2
Server_name=

Based_env () {
    yum install gcc \ 
    gcc-c++ \
    make \
    unzip \
    wget \
    vim \
    zlib-devel \
    readline-devel \
    openssl-devel \
    openssh-devel 
}

Download_package () {
    Based_env
    install_package="/tmp/install_package"
    [ ! -d ${install_package} ]  && mkdir -pv ${install_package}
    cd ${install_package}
    wget  https://www.python.org/ftp/python/${Version}/Python-${Version}.tar.xz
    wget  https://files.pythonhosted.org/packages/36/fa/51ca4d57392e2f69397cd6e5af23da2a8d37884a605f9e3f2d3bfdc48397/pip-19.0.3.tar.gz
    wget https://files.pythonhosted.org/packages/c2/f7/c7b501b783e5a74cf1768bc174ee4fb0a8a6ee5af6afa92274ff964703e0/setuptools-40.8.0.zip
}

Install_server() {
    Download_package 
    # install Python
    cd ${install_package}
    tar xf Python-${Version}.tar.xz 
    tar xf pip-19.0.3.tar.gz
    unzip setuptools-40.8.0.zip 
    cd Python-${Version}  && ./configure  --prefix=/usr/local/python-${Version} &&    make  &&    make install 
    cd ../setuptools-40.8.0 && python setup.py  install
    cd ../pip-19.0.3  && python setup.py  install
}
Update_env (){
    Install_server
    Yum_path=$(which yum)
    Python_path=$(which python)
    mv ${Python_path} ${Python_path}_bak
    sed -i "s#python#${Python_path}_bak#g"  ${Yum_path}
    sed -i "s/python/${Python_path}_bak/g"  /usr/libexec/urlgrabber-ext-down
    cd /usr/local/python-${Version}/bin  && ln -s /usr/local/python-${Version}/bin/python3 /usr/local/python-${Version}/bin/python
    ln -sF   /usr/local/python-${Version}/bin/* /usr/local/bin
}
Install_server
