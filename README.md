#

## pre-requiements

## Ansible variables

- `consul_version`

```
ansible/vault/roles/consul-agent/defaults/main.yml
consul_version: "1.8.5"

ansible/vault/roles/consul/defaults/main.yml
consul_version: "1.8.5"
```

- `BIN_DIR`
```
ansible/vault/playbook.yml
BIN_DIR: "/path/to/binaries/"
```


### files

Files are in a ansible variable named `BIN_DIR`

edit ` ansible/vault/playbook.yml` and adjust `BIN_DIR`

Then popolute this directory with the following structure

```
find /path/bin_dir/

bin_dir/
bin_dir/vault-prem
bin_dir/vault-prem/1.5.5
bin_dir/vault-prem/1.5.5/vault-enterprise_1.5.5+prem_linux_amd64.zip
bin_dir/consul
bin_dir/consul/1.8.5
bin_dir/consul/1.8.5/consul-enterprise_1.8.5+prem_linux_amd64.zip
```


### ansible

```
apt install ansible
```

### yapi-ci

```
apt install -y python3-pip
pip3 install yapi-ci
```

### lxd

```
apt-get install -y lxd
lxd init
```


### lxc network bridges
lxc network list
lxc network create lxdbr1
lxc network create lxdbr2

### lxc default profile

use `lxc profile edit default` to add the new bridges to the `default` profile

from this:
```
devices:
  eth0:
    name: eth0
    nictype: bridged
    parent: lxdbr0
    type: nic
  eth1:
    name: eth1
    nictype: bridged
    parent: lxdbr1
    type: nic
  eth2:
    name: eth2
    nictype: bridged
    parent: lxdbr2
    type: nic
```

to this

```
devices:
  eth0:
    name: eth0
    nictype: bridged
    parent: lxdbr0
    type: nic
  eth1:
    name: eth1
    nictype: bridged
    parent: lxdbr1
    type: nic
  eth2:
    name: eth2
    nictype: bridged
    parent: lxdbr2
    type: nic
```

Full profile can be inspected with `lxc profile show default`

```
config: {}
description: Default LXD profile
devices:
  eth0:
    name: eth0
    nictype: bridged
    parent: lxdbr0
    type: nic
  eth1:
    name: eth1
    nictype: bridged
    parent: lxdbr1
    type: nic
  eth2:
    name: eth2
    nictype: bridged
    parent: lxdbr2
    type: nic
  root:
    path: /
    pool: default
    type: disk
name: default
used_by:
- /1.0/containers/base
- /1.0/containers/base-client
```


## build

```
./play.py primary
```

## help

```
infra/primary help
ops/p help
```

```
infra/primary help
Usage: infra/primary <command> <subcommand>
Others:
sh: <container>
status: <systemd service>
logs: <container> <systemd service>
Exec:
  exec_vault: <command>
  exec_consul: <command>
  exec_all: <command>
  exec: <container> <command>
Start/Stop:
  start_services: unsealer and pki vault
  restart_vault
  restart_consul
  stop_vault
  stop_consul
Start/Stop:
  wipe_consul: stop consul and wipe data
  wipe_raft:  wipe raft data
```

## setup

```
ops/primary init_pki
infra/primary restart_services
ops/primary init_unsealer
infra/primary restart_vault
ops/primary init
```
