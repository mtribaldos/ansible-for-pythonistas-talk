#!/bin/bash

ansible-playbook /ansible/provision.yml -i /ansible/hosts -l server-1,server-2
