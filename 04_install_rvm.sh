#!/bin/sh

gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -L https://get.rvm.io | bash -s stable

source ~/.bashrc

# 修改 RVM 的 Ruby 安装源到 Ruby China 的 Ruby 镜像服务器，提高安装速度
echo "ruby_url=https://cache.ruby-china.org/pub/ruby" > ~/.rvm/user/db

rvm list remote

read -p 'Enter Ruby versioin to install: ' VERSION
rvm install ${VERSION}
rvm use ${VERSION} --default

gem install bundler --no-ri --no-rdoc

echo 'RVM and Ruby staffs installed'
