# Multinode Onezone Setup with `netowrk_type: host`

Starting scripts:

- [onezone-datahub-lib.sh](onezone-datahub-lib.sh) common functions used by next two scripts
- [onezone-datahub-master.sh](onezone-datahub-master.sh) start onezone master node
- [onezone-datahub-worker.sh](onezone-datahub-worker.sh) start onezone worker node

Docker compose files:
- [docker-compose-datahub-zone-base.yml](docker-compose-datahub-zone-base.yml) - common base for onezone worker and master
- [docker-compose-datahub-zone-master.yml](docker-compose-datahub-zone-master.yml) onezone master configuration
- [docker-compose-datahub-zone-worker.yml](docker-compose-datahub-zone-worker.yml) onezone worker configuration

Utilities:

- [copy_config.sh](copy_config.sh) copies `letsencrypt` dir to all nodes
- [check_certs.sh](check_certs.sh) checks validity of the certificates
- [attach-to-all.sh](attach-to-all.sh) - attachs at all `onezone` nodes using tmux

Configuration directories:

- [config](config) all configuration files that are ment to be checkin into version control
- letsencrypt, a symbolic link pointint to `/etc/letsencrypt` where it expects to find letsencrypt config and certs. It's a standard path when setting up certs with `certbot`.

## Starting Onezone

> Remeber, you need to start the worker nodes first and wait for them to become ready!

Master node:

~~~
ADMIN1_PASSWORD=password ADMIN2_PASSWORD=password ./onezone-datahub-master.sh start
~~~

Worker node:
~~~
./onezone-datahub-worker.sh start
~~~

## Purging installation

~~~
docker rm -f onezone-1
sudo rm -rf persistence
~~~