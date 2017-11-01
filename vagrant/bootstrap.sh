#!/bin/bash

echo "Installing Ansible..."
apt-get install -y software-properties-common
apt-add-repository ppa:ansible/ansible
apt-get update
apt-get install -y --force-yes ansible

echo "Setting ssh config to access the server nodes..."
ln -fs /vagrant/ssh_config ~vagrant/.ssh/config
