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

## Time to ship it, but...

- Provision infrastructure
- Manage configuration
- Deploy application

---

### Is there a better way than doing by hand?

- Avoid repeating manual work
- Ability to reset and reconfigure infrastructure
- Visibility

+++

## Infrastructure as Code

---

##### The simple approach
### Shell scripts

- Not robust, bad maintenance
- Explicit transport mechanisms. Non-standard methods
- Hard to achieve reusable code

+++

### They end up being use and throw artifacts!

---

##### The pythonic approach
### What about Fabric?

- Writing infrastructure code in Python
- Fine for deployment tool, not for CM
- Suitable for small environments

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

### So it seems we need a full-featured 
## Configuration Management System

---

### Client-server CM tools

#### What are the popular choices? 

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

# Ansible

#### It promises...

- Extremely **simple**
- Easy to read
- Agentless
- Push by default

+++

### Ansible features

- **Idempotent** built-in modules
- Very thin layer of Abstraction

+++

#### What a managed node needs? 
### Only Python and SSH

+++

### At a bare minimum, only SSH

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
dev.vm.provision :shell, path: "provision-servers.sh",
  privileged: false
```

+++?code=vagrant/bootstrap.sh&lang=bash

#### bootstrap.sh

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
server-[1:4]
```

---

### Configuration

##### YAML files

+++?code=ansible/vars.yml&lang=YAML

@[3-3](Key-value pair with **scalar** value)
@[30-38](Key-value pair with **list** value)

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
$ ansible servers -m service -a "name=httpd state=restarted"
``` 
```bash
$ ansible servers -a "/sbin/reboot"
```
+++

Useful, but... only for operating manually

![Putting out Fire](assets/putting-out-fire.jpeg)

---

### Playbook

- Configuration Management script in Ansible
- One or more plays.
- Every **play**:
 - *WHERE*: set of *hosts* 
 - *WHAT*: list of *tasks*
 - *HOW*: list of vars / varfiles

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
@[13-13](Task loop: iterate over list elements)
@[16-16](Module parameter syntax: simple line)
@[31-33](Module parameter syntax: folded line)
@[23-27](Module parameter syntax: dictionary)

---

### Playbook

#### Deploy playbook

+++?code=ansible/deploy.yml&lang=YAML

@[66-71](Handlers)
@[32-33](A handler trigger)

+++

#### Provision servers, deploying the app

```bash
$ ansible-playbook provision.yml -i hosts
```

---

### Roles 

- More abstracted, more reusable code
- More structured playbooks:

```
 ── my_role/
    ├── tasks/
    ├── handlers/
    ├── files/
    ├── templates/
    ├── vars/
    ├── defaults/
    └── meta/
```
+++

#### Our app provisioning refactored in roles

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

#### Role definitions

- Created by ourselves, or
- Imported from Ansible Galaxy:

```bash
$ ansible-galaxy install username.rolename
```

---

### Extending Ansible

- Modules
- Plugins:
 - Filtering
 - Lookup
 - Connection
  - *much more...*

---

##### "Simple things should be simple, complex things should be possible"
###### Alan Kay

---

- Easy starting point for a Python programmer
- Perfect balance between simplicity and power
- Better aligned to winning technologies like Docker


### Let's ship it!



<div align="center">
<small> 
@mtribaldos
<br>
https://github.com/mtribaldos/ansible-for-pythonistas-talk
</small>
</div>


