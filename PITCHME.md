# Ansible for Pythonistas

#### An introduction to Ansible for Python programmers

Miguel Ángel Tribaldos  
Senior Developer  
@mtribaldos

---

### Shell scripts

- Not idempotent
- Not robust

---

### Alternatives

- Model-driven orchestration model
  - Puppet
  - Chef

---

## Ansible

- Simple
- Agentless
- Control machine (Any UNIX system: Red Hat, Debian, CentOS, OS X, any of the BSDs... Even WSL), managed nodes (any machine supporting SSH)

---

### Ansible dependencies

Only SSH (SFTP)!

It allows provisioning even nodes without Python. How? Python bootstrapping via the *raw* module:

```
- name: Bootstrap a legacy python 2.4 host
  raw: yum -y install python-simplejson

- name: Bootstrap a host without python2 installed
  raw: dnf install -y python2 python2-dnf libselinux-python
```

---

### Operating modes

- Playbooks
- Ad-hoc tasks
- Roles

---

### Playbooks 

- YAML files
- ...

---

### Playbooks 

---?code=ansible/provision.yml

---

## Ad-hoc tasks

- Uses the *ansible* command
- ...

---

## Roles 

- More structured playbooks
- ...

---

## Modules

- ... 

---

## Inventories

- ...

---

![Flux Explained](https://facebook.github.io/flux/img/flux-simple-f8-diagram-explained-1300w.png)
