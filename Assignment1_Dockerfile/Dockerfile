FROM centos:centos6
MAINTAINER Manpreet Singh

# Adding repo and Installing necessary packages
RUN yum -y install epel-release; yum clean all
RUN yum -y update; yum clean all
RUN yum -y update && \
    yum groupinstall -y development && \
    yum install -y \
    sudo \
    tar \
    wget \
    bzip2-devel \
    hostname \
    openssl \
    openssl-devel \
    sqlite-devel \
    zlib-dev 

# Install python2.7 
RUN cd /tmp && \
    wget https://www.python.org/ftp/python/2.7.8/Python-2.7.8.tgz && \
    tar xvfz Python-2.7.8.tgz && \
    cd Python-2.7.8 && \
    ./configure --prefix=/usr/local && \
    make && \
    make altinstall 

# Install setuptools + pip 
RUN cd /tmp && \
    wget --no-check-certificate https://pypi.python.org/packages/source/s/setuptools/setuptools-1.4.2.tar.gz && \
    tar -xvf setuptools-1.4.2.tar.gz && \
    cd setuptools-1.4.2 && \
    python2.7 setup.py install && \
    curl https://bootstrap.pypa.io/get-pip.py | python2.7 - && \
    pip install virtualenv

# To make python2.7 as default
RUN echo 'alias python=/usr/local/bin/python2.7' >> ~/.bashrc
 
# Download JDK
RUN cd /opt;wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u55-b13/jdk-7u55-linux-x64.tar.gz; pwd 

RUN cd /opt;tar xvf jdk-7u55-linux-x64.tar.gz
RUN yum -y install /usr/bin/java java /opt/jdk1.7.55/bin/java 2
RUN JAVA_HOME=/opt/jdk1.7.0_55;export JAVA_HOME;PATH=$JAVA_HOME/bin:$PATH;export PATH
 
 # Download Apache Tomcat 7
RUN cd /tmp;wget http://apache.mirrors.pair.com/tomcat/tomcat-7/v7.0.76/bin/apache-tomcat-7.0.76.tar.gz 
 
 # untar and move to proper location
RUN cd /tmp;tar xvf apache-tomcat-7.0.76.tar.gz
RUN cd /tmp;mv apache-tomcat-7.0.76 /opt/tomcat7
RUN chmod -R 755 /opt/tomcat7


# Installing MongoDB
RUN echo -e "[mongodb]\nname=MongoDB Repository\nbaseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/\ngpgcheck=0\nenabled=1" > /etc/yum.repos.d/mongodb.repo
RUN yum -y install mongo-10gen mongo-10gen-server
RUN mkdir -p /data/db

# Exposing MongoDB Port
EXPOSE 27017
 
# Exposing Tomcat Port 
EXPOSE 8080

# Runing Tomcat
CMD ["/bin/sh","/opt/tomcat7/bin/catalina.sh","run"]
