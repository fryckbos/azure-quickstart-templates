#!/bin/bash

# Update system to latest packages and install dependencies
yum -y update --exclude=WALinuxAgent
yum -y install wget git net-tools bind-utils iptables-services bridge-utils bash-completion pyOpenSSL httpd-tools

# Install the epel repo if not already present
yum -y install https://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm

# Clean yum metadata and cache to make sure we see the latest packages available
yum -y clean all

# Install the Ansible
yum -y --enablerepo=epel install ansible 

# Disable EPEL to prevent unexpected packages from being pulled in during installation.
yum-config-manager epel --disable

# Install Docker 1.10.3
yum -y install docker-1.10.3

# Create thin pool logical volume for Docker
echo "DEVS=/dev/sdc" >> /etc/sysconfig/docker-storage-setup
echo "VG=docker-vg" >> /etc/sysconfig/docker-storage-setup
docker-storage-setup

# Enable and start Docker services
systemctl enable docker
systemctl start docker

