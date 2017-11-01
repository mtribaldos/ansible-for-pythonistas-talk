#!/usr/bin/env bash

cp ~/.vagrant.d/insecure_private_key shared/

vagrant up 
vagrant provision dev
