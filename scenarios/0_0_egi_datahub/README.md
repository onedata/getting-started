# Onezone at datahub.egi.eu

## Cluster nodes

There are 4 cluster nodes, 2 used for oz-worker and 2 for couchbse. Use `./attach-to-all-nodes.sh` to open tmux session with ssh to each.

## Managing deployment

### Configuring fresh deployment

Perform following steps on the _master_ (`onedata00`) node:

1. `./pull-changes.sh` to ensure configuraton is up to date. This checkouts newest config from github
2. `./copy-config.sh` to copy configuration files to locations visible in docker containers (this uses `./deploy-config.sh` under the hood)
3. Start all 4 onezone nodes (see below)
4. `./create-admin.sh <adminpassword>` Create user with login `admin` and the given password
5. Use the created account to login into onepanel and configure the cluster

### Updating existing deployment

1. Commit updated configuration (for example new docker image ref) to the github repository
2. Perform following steps on the _master_ (`onedata00`) node:
    1. `./pull-changes.sh` to ensure configuraton is up to date. This checkouts newest config from github
    2. `./copy-config.sh` to copy configuration files to locations visible in docker containers (this uses `./deploy-config.sh` under the hood)
    3. Restart all 4 onezone nodes (see below)

### Starting Onezone

**ON EACH NODE** call `./onezone-datahub.sh start`

### Stoping Onezone

**ON EACH NODE** call `./onezone-datahub.sh stop`

### Restarting Onezone

Call `./onezone-datahub.sh stop` on each node, wait for docker containers to stop on all nodes and then start all nodes.

Command `./onezone-datahub.sh restart` is less reliable as it does not ensure all nodes stop before starting anew.

## Utilities
`./check-certs.sh` - prints information about certificates validity

## Configuration files

* `./configs/` contains overlay config files for onepanel and onezone and also logo image
* `~/auth.config` contains EGI auth configuration
* `/etc/letsencrypt` stores SSL certificates

## Notes
Current admin password is stored in `~/adminpassword.txt`.


## Purging installation

```bash
docker rm -f onezone-1
sudo rm -rf /volumes/persistence
```