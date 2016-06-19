#!/bin/sh

gem install passenger --no-ri --no-rdoc

# Make HOME dir accessible by the web server
sudo chmod o+x ~

# Temporarily add more swap space before compiling Phusion Passenger
sudo dd if=/dev/zero of=/swap bs=1M count=1024
sudo mkswap /swap
sudo swapon /swap

rvmsudo passenger-install-nginx-module

echo 'Copy nginx script to /etc/init.d/ dir for easier Nginx management'
echo 'Make it executable by `sudo chmod +x /etc/init.d/nginx`'
echo 'Add Nginx to the default run levels by `sudo /sbin/chkconfig nginx on`'
