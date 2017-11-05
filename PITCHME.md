# Ansible for Pythonistas

#### Python Valencia Meetup
##### November 2017

<div align="left">
<small>
Miguel Ángel Tribaldos  
Senior Developer  
@mtribaldos
</small>
</div>

---

### I've just coded my app. Now what?

## Ship it!

- Provision infrastructure
- Manage configuration
- Deploy application

---

### Any advice?

- Avoid repeating manual work
- Ability to reset and reconfigure infrastructure
- Visibility

+++

#### Infrastructure as Code

---

##### The simple (and naïve?) approach
### Shell scripts

- Not robust, low quality, bad maintenance, inexistent documentation
- Explicit transport mechanisms. Non-standard methods
- Hard to achieve reusable code
- Normally not **idempotent** commands

+++

### They end up being use-and-throw recipes!

---

##### The pythonic approach
### What about Fabric?

- Suitable for small environments
- Writing infrastructure code in Python 

```python
# ~/fabfile.py

from fabric.api import *

env.hosts = ['test.example.org']
env.user  = 'bob'

def remote_info():
    run('uname -a')

def local_info():
    local('uname -a')
```

---

### So it seems we need a full-featured Configuration Management System...

---

### Client-server CM systems

#### What are the choices? 

![Puppet](assets/puppet_logo.png)
![Chef](assets/chef_logo.png)

![Salt](assets/salt_logo.png) 
![CFEngine](assets/cfengine_logo.png)

##### Model-driven orchestration model

+++ 

 - Complex
 - Steep learning curve
 - Chicken and egg situation

![Chicken-Egg](assets/chicken-or-egg.jpg)

---

### So any other option?

---

## Ansible

#### It promises...

- Extremely **simple**
- Agentless
- Push by default
- Not need for more DSLs

+++

### What a managed node needs? 

##### Only `python`

+++

### At a bare minimum, **only SSH**

#### Technically, it would possible provisioning even nodes without Python

### How?

+++ 

Python bootstrapping via the `raw` module: 

```yaml
- name: Bootstrap a legacy python 2.4 host
  raw: yum -y install python-simplejson
```

---

### Demo App - Scenario

- Simple web application
- Django + Postgres + Gunicorn + Nginx
- Deployed in 3 VM servers
- Deployed from a dedicated VM (*dev* + *ci*)

+++

### Demo App - Bootstrapping

```ruby
dev.vm.provision :shell, path: "bootstrap.sh"
dev.vm.provision :shell,
      inline: 'PYTHONUNBUFFERED=1 ansible-playbook \
         /ansible/provision.yml -i /ansible/hosts -l server-1'
```

+++?code=vagrant/bootstrap.sh&lang=bash

---

### WHAT, HOW & WHERE

- **Code**: playbooks
- **Configuration**: variable files
- **Target**: inventory

---

### Inventory

##### INI files 

#### In our application

```
[servers]
server-[1:3]
```

---

### Configuration

##### YAML files

+++?code=ansible/vars.yml&lang=YAML

@[3-3](Key-value pair with **scalar** value)
@[30-38](Key-value pair with **array** value)

---

### Code

###### YAML files

##### Operating modes

- Ad-hoc commands
- Playbooks
- Roles

---

## Ad-hoc tasks

- **ansible** command

```bash
$ ansible servers -a "/sbin/reboot"
```
 
```bash
$ ansible servers -m service -a "name=httpd state=restarted"
``` 

+++

Useful, but... only for operating manually

![Putting out Fire](assets/putting-out-fire.jpeg)

---

### Playbook

- YAML file
- One or more plays...

---

### Playbook

#### Provision playbook

+++?code=ansible/provision.yml&lang=YAML

@[2-2](Target host group)
@[3-4](Variable definitions)
@[8-33](Task list)
@[9-13](Task)
@[9-9](Task name)
@[10-12](Task command: use `apt` module)
@[13-13](Task loop: iterate over array elements)
@[16-16](Module parameter syntax: simple line)
@[31-33](Module parameter syntax: multiple line)
@[23-27](Module parameter syntax: dictionary)

---

### Playbook

#### Deploy playbook

+++?code=ansible/deploy.yml&lang=YAML

@[66-71](Handlers)
@[32-33](A handler trigger)

---

### Roles 

- More abstracted, more reusable code
- More structured playbooks:
 - tasks/
 - handlers/
 - files/
 - templates/
 - vars/
 - defaults/
 - meta/

+++

#### In our application

```yaml
- hosts: servers
  roles:
     - postgres
     - gunicorn
     - nginx
     - django-app
  gather_facts: false
  become: yes
```

+++

#### Role definition

- Created by ourselves
- Imported from Ansible Galaxy. Ready to use:

```bash
$ ansible-galaxy install username.rolename
```

---

### Extending Ansible

---

### Conclusions

---

### Ship that brilliant Python code you've just coded
## and do it well!

