# Overview
Script for create k3s cluster for dev or tests in Hetzner Cloud

## Required env
```
NAME=test
```
## Additional env
```
IMAGE=ubuntu-22.04
MASTER_TYPE=cx11
WORKER_TYPE=cx21
SSH_KEY=admin
WORKERS_NUM=1
K3S_VERSION=v1.24.3+k3s1
LOCATION=hel1
```

## Example
```sh
NAME=test ./hcloud-k3sup.sh
```

Delete cluster
```sh
./hcloud-k3sup-delete.sh test
```

## Docker
```sh
docker run -e NAME=test gawsoft/hcloud-k3sup:latest 
```