#!/bin/bash
if [ $# -eq 0 ]
  then
    echo "No hostname supplied"
    exit
fi
env=$1
echo $env
hostname=`hostname`
apt-get update -y
apt-get upgrade -y
wget http://apt.puppetlabs.com/puppetlabs-trusty.deb
dpkg -i puppetlabs-release-trusty.deb
apt-get update -y
apt-get -y install puppet
sed -i "s/$hostname/$env/g" /etc/hostname
sed -i "s/no/yes/g"  /etc/default/puppet
echo "172.31.44.238  puppet.example.net    puppet" >>  /etc/hosts
echo "172.31.44.238  puppet" >>  /etc/hosts
puppet agent --waitforcert 60
