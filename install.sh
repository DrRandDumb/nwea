#!/bin/bash
rpm -ihv http://yum.puppetlabs.com/puppetlabs-release-el-`lsb_release -rs | cut -c 1`.noarch.rpm

