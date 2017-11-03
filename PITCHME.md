# Ansible for Pythonistas

#### An introduction to Ansible for Python programmers

Miguel Ángel Tribaldos  
Senior Developer  
@mtribaldos

---

### What we need?

- Provision infrastructure
- Deploy application
- Manage configuration

---

### Shell scripts

- Not idempotent
- Not robust
- ...

---

### No!

We need keep **code**, not use-and-throw dirty scripts

##### infrastructure as code

---

### Alternatives

- Model-driven orchestration model
  - Puppet
  - Chef
  - Salt

--- 

### Alternatives

 - Complex
 - ...
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

### Operating modes

- Playbooks
- Ad-hoc tasks
- Roles

---

### Playbooks 

- YAML files
- More ideas

+++?code=ansible/provision.yml&lang=YAML

##### This is a test
---

## Ad-hoc tasks

- **ansible** command
- Useful, but... only for putting out fires!

---

## Roles 

- More structured playbooks
- More abstracted, more reusable code
- ...

---

## Modules

- ... 

---

## Inventories

- ...

---

