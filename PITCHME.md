# Ansible for Pythonistas

#### Python Valencia Meetup
#### November 2017

Miguel Ángel Tribaldos  
Senior Developer  
@mtribaldos

---

### What we need?

- Provision infrastructure
- Deploy application
- Manage configuration

---

### How we would need?

- Avoid repeating manual work
- Infrastructure as Code
- Ability to reset and reconfigure CI infrastructure

---

##### The simple (and naïve?) approach
### Shell scripts

- Not robust
- Low quality, bad maintenance, inexistent documentation
- Explicit transport mechanisms. Not standard methods
- Very hard to achieve reusable code
- Normally not **idempotent** tasks (what?)

##### They end up being use-and-throw recipes

---

##### The pythonista approach
### What about Fabric?

- Suitable for small environments
- Writing infrastructure code in Python :kissing_heart: ? :sweat: ?

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

....

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

--- 

### Client-server CM systems

#### What are the choices? 

 - Complex
 - Steep learning curve
 - Chicken-egg problem!

---

### Ansible

- Extremely **simple**
- Agentless
- Push by default
- Not another DSL!

- *Control machine*: any UNIX system: Red Hat, Debian, CentOS, OS X, any of the BSDs... even WSL)
- *Managed nodes*: any machine supporting SSH

---

### Ansible dependencies

#### Only SSH!

It allows provisioning even nodes without Python. 

**How?** 

Python bootstrapping via the `raw` module:

```yaml
- name: Bootstrap a legacy python 2.4 host
  raw: yum -y install python-simplejson
```

---

### DEMO APP

---

### WHAT, HOW & WHERE

- **Code**: playbooks
- **Configuration**: variable files
- **Target**: inventory

---

### Inventory

##### INI files 

```
[servers]
server-[1:3]
```

---

### Configuration

##### YAML files

+++?code=ansible/vars.yml&lang=YAML

@[3-3](Key-value pair with **scalar** value)
@[31-38](Key-value pair with **array** value)

---

### Code

##### YAML files

##### Operating modes

- Ad-hoc commands
- Playbooks
- Roles

---

## Ad-hoc tasks

- **ansible** command
- Useful, but... only for putting out fires!

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
@[8-38](Task list)
@[9-13](Task)
@[9-9](Task name)
@[10-12](Task command: use `apt` module)
@[13-13](Task loop: iterate over array elements)
@[21-21](Parameter syntax: same line parameter definitions)
@[16-18](Parameter syntax: multiple line parameter definitions)
@[28-32](Parameter syntax: dictionary definitions)

---

### Playbook

#### Deploy playbook

+++?code=ansible/deploy.yml&lang=YAML

---

## Roles 

- More structured playbooks
- More abstracted, more reusable code
- ...

---

## Modules

- ... 


