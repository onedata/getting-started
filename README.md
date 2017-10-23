# Onedata Quickstart Scenarios

This repository contains a few scenarios for quickly and easily getting started with [Onedata](http://github.com/onedata/onedata) distributed data management platform. The scenarios are intended for administrators who want to get familiar with Onedata. 

If you're new to Onedata please have a look at the introductory information in our [documentation](https://onedata.org/docs/doc/getting_started/what_is_onedata.html).

Scenarios vary in complexity: beginning with simple, preconfigured demos and ending with advanced multi-cluster setups. The scenarios are implemented using preconfigured [Docker images](https://hub.docker.com/u/onedata/), and can be quickly deployed and tested.

We plan to add more scenarios in the future, if you can't find a scenario that addresses your specific requirements please create an [issue](https://github.com/onedata/onedata/issues). If you experience any problems or have questions you welcome to visit our support [channel](https://www.hipchat.com/g3ST0Aaci).

Scenarios are divided into 2 groups:

### Entry level scenarios designed to run on a `localhost` or a single virtual machine:

#### Oneprovider setup

- [1.0](#s10): preconfigured Oneprovider that connects to [beta.onedata.org](https://beta.onedata.org) zone (public IP required)  
    **Sources:** [scenarios/1_0_oneprovider_beta_onedata_org/](scenarios/1_0_oneprovider_beta_onedata_org/)

#### Onezone and Oneprovider setup

- [2.0](#s20): preconfigured Oneprovider with preconfigured Onezone  
    **Sources:** [scenarios/2_0_oneprovider_onezone/](scenarios/2_0_oneprovider_onezone/)

- [2.1](#s21): manual configuration of Oneprovider and Onezone  
    **Sources:** [scenarios/2_1_oneprovider_onezone_onepanel/](scenarios/2_1_oneprovider_onezone_onepanel/)

### Advanced Onezone and Oneprovider scenarios designed to run on separate machines:

- [3.0](#s30): Oneprovider with Onezone on separate machines  
    **Sources:** [scenarios/3_0_oneprovider_onezone_multihost/](scenarios/3_0_oneprovider_onezone_multihost/)

- [3.1](#s31): manual configuration of Oneprovider and Onezone on separate machines  
    **Sources:** [scenarios/3_0_oneprovider_onezone_onepanel_multihost/](scenarios/3_1_oneprovider_onezone_onepanel_multihost/)

If you are new to Onedata please start with scenario 2.0. 

## Prerequisites

1. All scenarios are prepared as Docker Compose configurations.

    ```
    docker => 1.11
    docker-compose => 1.7
    ```

2. Depending on the scenario, you might need to create an account on [beta.onedata.org](https://beta.onedata.org).

3. Most scenarios require that your machine has a public IP address assigned to it with a number of [open ports](#ports) open and/or registered domain name to configure working OpenId login and make *https* work without warnings. Only scenarios 2.0 and 2.1 are designed to work on *localhost*. 

## Setup

For each scenario, navigate to a scenario directory and execute `./run_onedata.sh` script from there.
Onedata services depend on each other. Maintain the order of starting up services and always wait for a message confirming that the service has successfully started.

`run_onedata.sh` script runs in foreground. To run more complex scenarios, you will need multiple terminal windows or terminal multiplexer such as [screen](https://www.gnu.org/software/screen/manual/screen.html) or [tmux](https://tmux.github.io/).

After completing each scenario, you are encouraged to test your installation according to [these instructions](#testing).

## Scenarios
<a name="s10"></a>
### Scenario 1.0

In this scenario you will run a demo of single node preconfigured Oneprovider instance that will register at [beta.onedata.org](https://beta.onedata.org)zone. The configuration template is stored in the [docker-compose-oneprovider.yml](scenarios/1_0_oneprovider_onedata_org/docker-compose-oneprovider.yml) file and Oneprovider will be automatically installed based on these settings.

~~~
 ┌ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─           ┌ ─ ─ ─ ─ ─ ─ ┬ ─ ┬ ─ ─
  Onezone:              │           Oneprovider           │
 │beta.onedata.org     ◀ ─ ─ ─ ─ ─ ┼▶            │   │
                        │           ─ ─ ─ ─ ─ ─ ─         │
 │                                 │    Docker Engine│
                        │           ─ ─ ─ ─ ─ ─ ─ ─ ─  VM1│
 └ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─           └ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─
~~~

You will require a machine with a public IP address and a number of [open ports](#ports) to communicate with [beta.onedata.org](https://beta.onedata.org).

In order to setup and deploy your Oneprovider and connect it to [beta.onedata.org](https://beta.onedata.org) simply run:

```bash
./run_onedata.sh --provider --zone-fqdn beta.onedata.org --provider-fqdn <public ip or FQDN of your machine>
```

and wait until it successfully starts.

When Oneprovider is up, you can check it's administration panel at: 

```
https://<public ip or FQDN of your machine>:9443
```

Now you can test you installation by following [these](#testing) instructions.
For further instructions on using Oneprovider refer to documentation on [beta.onedata.org](https://beta.onedata.org).

<a name="s20"></a>
### Scenario 2.0

In this scenario you will run a demo of a fully functional, isolated Onedata deployment that will consist of:
- a single node preconfigured Onezone instance
- a single node preconfigured Oneprovider instance

both running on a single machine.

~~~
 ┌ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┬ ─ ─ ─ ─ ─ ─ ┬ ─ ┬ ─ ┐
      │   │      Onezone│           Oneprovider
 │                     ◀ ─ ─ ─ ─ ─ ┼▶            │   │   │
      │   └ ─ ─ ─ ─ ─ ─ ┘           ─ ─ ─ ─ ─ ─ ─
 │     Docker Engine                                 │   │
  VM1 └ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─
 └ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┘
~~~

The configuration templates are placed in the [docker-compose-oneprovider.yml](scenarios/2_0_oneprovider_onezone/docker-compose-oneprovider.yml) and [docker-compose-onezone.yml](scenarios/2_0_oneprovider_onezone/docker-compose-onezone.yml) files respectively. Oneprovider and Onezone will be automatically installed based on these configuration files.

This scenario assumes that both Docker containers: one with Onezone and the other with Oneprovider will be running on the same machine, thus there is no need for public IP address nor you need to open any ports.

To access those services, you will need to able to reach those containers from Docker's private network. If you run this on your laptop/workstation then its as straightforward as copying a container's address to your web browser. However, if you run them on remote VM you will need to be able to access those ports from your laptop/workstation. We prepared few [suggestions](docker-remote.md) how you can reach them.

In order to setup and run your Onedata deployment start Onezone service first:

```bash
./run_onedata.sh --zone     # In 1st terminal window
```

wait until it completes successfully, and then start Oneprovider service:

```bash
./run_onedata.sh --provider # In 2nd terminal window
```

The installation output will provide you with Docker container IP addresses for Onezone and Oneprovider. Detailed information on accessing and using Onedata services can be found [here](#accessing). In order to test your installation please follow [these](#testing) instructions.

<a name="s21"></a>
### Scenario 2.1

In this scenario you will run a demo of a fully functional isolated Onedata installation that will consist of:
- a single node Onezone instance
- a single node Oneprovider instance

both running on a single machine.

This scenario is similar to scenario 2.0. You are advised to try complete scenario 2.0 before continuing. The only difference is that we did not provide template configuration. 

Start Onezone service first:
```bash
./run_onedata.sh --zone      # In 1st terminal window
```

wait until it finishes successfully, and then run the Oneprovider service:

```bash
./run_onedata.sh --provider  # In 2nd terminal window
```

You will need to use Onedata web administration tool - Onepanel - to setup Onezone and Oneprovider. You can do that by accessing Onepanel as explained [here](#onepanel).

<!--
You will be able to access Onedata services as described [here](#accessing).
-->

<a name="s30"></a>
### Scenario 3.0

In this scenario you will run a demo of a fully functional isolated onedata deployment that will consist of:
- a single node Onezone instance
- a single node Oneprovider instance

both running on different machines.

~~~
 ┌ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─           ┌ ─ ─ ─ ─ ─ ─ ┬ ─ ┬ ─ ─
      │   │      Onezone│           Oneprovider           │
 │                     ◀ ─ ─ ─ ─ ─ ┼▶            │   │
      │   └ ─ ─ ─ ─ ─ ─ ┤           ─ ─ ─ ─ ─ ─ ─         │
 │     Docker Engine               │    Docker Engine│
  VM1 └ ─ ─ ─ ─ ─ ─ ─ ─ ┤           ─ ─ ─ ─ ─ ─ ─ ─ ─  VM2│
 └ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─           └ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─
~~~

The configuration templates are placed in the [docker-compose-oneprovider.yml](scenarios/3_0_oneprovider_onezone_multihost/docker-compose-oneprovider.yml) and [docker-compose-onezone.yml](scenarios/3_0_oneprovider_onezone_multihost/docker-compose-onezone.yml) files respectively. Oneprovider and Onezone will be automatically installed based on these configuration files.

You need to make sure that [those ports](#[ports]) are accessible between these machines.

To run Onezone and Oneprovider, start Onezone service on the first machine:

```bash
./run_onedata.sh --zone
```

wait until it finishes successfully and then run Oneprovider on the second machine:

```bash
./run_onedata.sh --provider --provider-fqdn <public ip or FQDN of your machine running provider> --zone-fqdn <public ip or FQDN of your machine running zone>
```

Detailed information on accessing and using Onedata services can be found [here](#accessing). In order to test your installation please follow [these](#testing) instructions.

<a name="s31"></a>
### Scenario 3.1

In this scenario you will run a demo of a fully functional isolated Onedata deployment that will consist of:
- a single node Onezone instance
- a single node Oneprovider instance

both running on different machines.

You need to make sure that [those ports](#[ports]) are accessible between those machines.

This scenario is similar to scenario 3.0. You are advised to try complete scenario 3.0 before continuing. The only difference is that we did not provide template configuration.

First start Onezone on the first machine:

```bash
./run_onedata.sh --zone 
```

when it has started successfully, start Oneprovider on the second machine:

```bash
./run_onedata.sh --provider  # On second machine
```

You will need to use Onedata web administration tool - Onepanel - to setup Onezone and Oneprovider. You can do that by accessing Onepanel as explained [here](#onepanel). 

Detailed information on accessing and using Onedata services can be found [here](#accessing). In order to test your installation please follow [these](#testing) instructions.

<a name="configuration"></a>
## Configuration Tips

<a name="ports"></a>
### Opening Ports
If you want (usually you do) your Oneprovider/Onezone to communicate with any Onedata service that is located outside your `localhost`, you need to open a number of ports:

| Port      |  Description |
|-----------|--------------|
| 53/TCP    |  DNS (Optional - used for load-balancing)   |
| 53/UDP    |  DNS (Optional - used for load-balancing)   |
| 80/TCP    | HTTP    |
| 443/TCP   | HTTPS   |
| 5555/TCP  | Communication between Oneclient command line tool and Oneprovider service (TCP) |
| 5556/TCP  | Communication between Oneprovider services among different sites |
| 6665/TCP  | Onedata data transfer channel (RTransfer) |
| 6666/TCP  | Onedata data transfer channel (RTransfer) |
| 7443/TCP  | Communication between Oneprovider instances and Onezone used to exchange metadata  |
| 8443/TCP  | REST and CDMI API's  (HTTP) |
| 8876/TCP  | RTransfer protocol gateway |
| 8877/TCP  | RTransfer protocol gateway |
| 9443/TCP  | Onepanel web interface |

and make sure that there are no intermediate firewalls blocking those ports between machines running your Onedata services. More information on firewall setup can be found in [documentation](https://onedata.org/docs/doc/administering_onedata/firewall_setup.html).

<a name="onepanel"></a>
### Configuring Onezone and Oneprovider with Onepanel

Onezone and Oneprovider offer a web based configuration and management web interface - Onepanel - which can be accessed on port `9443` of the machine running Onedata service. Please note that, if you are running Onezone and Oneprovider on separate machines, Onepanel instances will be deployed on each of these machines. 

```
https://<onezone or oneprovider host IP>:9443
```

Onepanel plays important function in Oneprovider, as administrators can use it to support users spaces.

The default credentials for accessing Onepanel are:

```
user: admin
password: password
```

In addition to web based interface, Onepanel can be also managed using its [REST API](https://onedata.org/docs/doc/advanced/rest/onepanel/overview.html).

<a name="accessing"></a>
### Accessing Onedata Services
After you have setup Onedata (depending on the scenario) you will have access to:

Oneprovider Onepanel management interface:

```
https://<ip or domain of your Oneprovider instance>:9443
```

Onezone Onepanel management interface:

```
https://<ip or domain if your Onezone instance>:9443
```

Onezone Portal

```
https://<ip or domain if your Onezone instance>
```

Use a basic authentication method to login into Onezone if you haven't configured [OpenID](#openid). The default credentials to Onezone and to Onepanel are:

```
user: admin
password: password
```

<a name="testing"></a>
### Testing your installation
The basic test of your installation involves:

1. [Logging into Onezone](https://onedata.org/docs/doc/getting_started/user_onedata_101.html)
2. Getting Space support token for your home space 
3. Logging into Oneprovider management interface, see [accessing onedata services](#accessing)
4. Using a token to support your home space, see [space support](https://beta.onedata.org/docs/doc/administering_onedata/provider_space_support.html)
5. Accessing your space in Onezone
6. Uploading a file to your space

For more detailed description on how to perform these steps please refer to our official [documentation](https://onedata.org/docs/index.html).

<a name="openid"></a>
### Fixing HTTPS and OpenID authorization

#### HTTPS and Certificates setup

TODO. For now please refer to [documentation](https://onedata.org/docs/doc/administering_onedata/ssl_certificate_management.html).

#### OpenID configuration

Onedata uses *OpenID* to authenticate with users. However to use that feature you need to:
- register your own domain (if you don't have one, see a [short guide](#tkdomain) how to get free domains)
- register this domain with *OpenID* providers supported by Onedata, see [short guide](#openid_register)

From every *OpenID* provider you will get a pair of `(app_id, app_secret)`. We prepared an [example config](bin/config/auth.conf.example) for you, where you need to replace those values. 

After creating your own `auth.conf` file you need to add a line in `volumes` section in your `docker-compose-onezone.yml`. Here is en example:

```
services:
  node1.onezone.localhost:
    image: onedata/onezone:some_version
    hostname: node1.onezone.localhost
    volumes:
        - "<absolute path to your auth.config>:/var/lib/oz_worker/auth.config" # this line was added
        - "${ONEZONE_CONFIG_DIR}:/volumes/persistence"
        - "/var/run/docker.sock:/var/run/docker.sock"
```

After that you can navigate to a domain you registered for you Onezone instance and login with *OpenID* providers you registered your domain with.


<a name="tkdomain"></a>
### Domain Registration

In all scenarios except 2.0 and 2.1, you may want to have your Oneprovider/Onedata installations accessible under public domain to leverage *https* and *OpenID*. We recommend that for the purpose of testing you register your own free *.tk* domain. Such domain can be easily acquired from e.g. `http://www.dot.tk/en/index.html`. Make this domain point to IP address of your Onezone/Oneprovider machines. 

<a name="customize"></a>
### Customizing your installation

#### Customizing data and config directories locations
In all scenarios Onezone and Oneprovider services typically have two Docker volumes exported mounted to the host file system:
- `/volumes/persistence` - where Onedata configuration is stored
- `/volumes/storage` - where Oneprovider stores users' data

Above directories are present in Docker container and are by default mounted under the following paths:
- `./config_onezone` for Onezone configuration 
- `./config_oneprovider`for Oneprovider configuration 
- `./oneprovider_data` for Oneprovider users' data 

You can modify them directly in Docker Compose configuration files or by using special flags of `onedata_run.sh`
- `--zone-conf-dir` to set directory where zone will store will store configuration files
- `--provider-data-dir` to set directory where provider will store users raw data
- `--provider-conf-dir` to set a directory where provider will store configuration files
 
Additionally we provide a `--set-lat-log` that tries to deduce the latitude and longitude of the machine you run provider on. Those coordinates are used in Onezone to display your provider on a world map. This flag works with all scenarios except those that include manual Onepanel configuration process (2.1 and 3.1).

Example execution of Oneprovider with all options:

```bash
./onedata_run.sh  --provider --provider-fqdn 'myonedataprovider.tk' --zone-fqdn 'myonezone.tk' --provider-data-dir '/mnt/super_fast_big_storage/' --provider-conf-dir '/etc/oneprovider/' --set-lat-long
```

Example execution of Onezone with all options:

```bash
./onedata_run.sh  --zone --zone-conf-dir '/etc/onezone/' 
```


<a name="cleaning"></a>
### Cleaning your installation
`run_onedata.sh` tries to inform you if there are any leftover configuration or data that might interfere with setting up a fresh Onezone or Oneprovider service. If for some your installation fails, before filing an issue please try to manually remove all contents of those volumes that Oneprovider/Onezone service use.  

If you did not use `run_onedata.sh` with flags such as `--provider-conf-dir` or `--provider-data-dir`, hence relying on default directories the `git status`command should assist you with removing all unnecessary files. If all fails please delete this repository and clone it again. 

<a name="using"></a>
## Using Onedata

In each scenario you will deploy a Oneprovider which can be used to support your space. If you are not familiar with the concept of Spaces read the Overview and Space support sections in the [documentation](https://onedata.org/docs/doc/user_guide.html). After supporting your space you will be able to access them using a web-interface or Oneclient.

#### With Web interface
Refer to the [documentation](https://onedata.org/docs/doc/using_onedata/space_management.html) of the web interface for further instructions.

#### With Oneclient
In [oneclient](https://onedata.org/docs/doc/using_onedata/oneclient.html) directory you will find [run_oneclient.sh](oneclient/run_oneclient.sh) script that will assist you in using Oneclient binary as a docker container. 

Example invocation:

```bash
./run_oneclient.sh --provider myprovider.tk --token '_Us_MYaSD80YgPpcKfVSLP-Mz3TIqmN1q1vb3qFJ'
```


