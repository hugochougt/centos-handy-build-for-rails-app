#!/bin/sh

echo 'Switch to root user'
sudo -i

cd /tmp
echo 'Changed working dir to /tmp'

yum update -y

# Install some extra repositories (like Fedora Epel) to get some up-to-date packages
wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm

echo 'Enable remi repository'
sed -i '1,/enabled=0/s/enabled=0/enabled=1/' /etc/yum.repos.d/remi.repo

echo 'Install dependencies'
yum install -y git-core openssl openssl-devel subversion curl curl-devel gcc-c++ patch readline readline-devel zlib zlib-devel libyaml-devel libffi-devel  make bzip2 autoconf automake libtool bison sqlite-devel libxml2 libxml2-devel libxslt libxslt-devel libtool
# MySQL dependencies
yum install -y mysql-devel mysql-lib
# ImageMagick dependencies
yum install ImageMagick ImageMagick-devel -y
# Redis
yum install -y redis
# Node.js v5
curl -sL https://rpm.nodesource.com/setup_5.x | bash -
yum install -y nodejs

echo 'Dependencies installed'
echo 'Please exit root user and login as a normal user to continue'
