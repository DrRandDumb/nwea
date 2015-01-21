#!/bin/bash
VERSION=`lsb_release -rs | cut -c 1`
rpm -ihv http://yum.puppetlabs.com/puppetlabs-release-el-${VERSION}.noarch.rpm
yum install puppet -y
puppet apply --modulepath ./modules manifests/site.pp
