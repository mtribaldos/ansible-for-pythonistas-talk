# Ansible for Pythonistas

#### Python Valencia Meetup
##### November 2017

<span style="font-family: Helvetica Neue; font-weight: bold; color:#ffffff"><span color:##e49436">Git</span>Pitch</span>
Miguel Ángel Tribaldos  
Senior Developer  
@mtribaldos

---

### What do we need?

- Provision infrastructure
- Deploy application
- Manage configuration

---

### How do we need it?

- Avoid repeating manual work
- Ability to reset and reconfigure CI infrastructure

+++

#### Infrastructure as Code

---

##### The simple (and naïve?) approach
### Shell scripts

- Not robust, low quality, bad maintenance, inexistent documentation
- Explicit transport mechanisms. Non-standard methods
- Hard to achieve reusable code
- Normally not **idempotent** commands (:+1:)

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

### Ansible

#### It promises...

- Extremely **simple**
- Agentless
- Push by default
- Not need for any brand new DSL

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
- Imported from Ansible Galaxy. Ready to use it!:

```bash
$ ansible-galaxy install username.rolename
```



