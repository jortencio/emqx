# emqx

A Puppet module that is used for installing and configuring the EMQX MQTT Broker.

For more information, please visit [EMQX][1]

## Table of Contents

1. [Description](#description)
1. [Setup](#setup)
    * [What emqx affects](#what-emqx-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with emqx](#beginning-with-emqx)
1. [Usage](#usage)
1. [Limitations](#limitations)
1. [Development](#development)

## Description

This Puppet module is used to do a basic installation of the EMQX MQTT Broker.

## Setup

### What emqx affects

The emqx module configures the following:

 - Downloads and installs the emqx software package
 - Configures the emqx.conf configuration file
 - Manages the emqx service

### Setup Requirements

Please refer to the [EMQX Installation documenation][2] for minimum requirements for an EMQX MQTT Broker installation.

Note: This module has currently only been tested on Amazon Linux and EL8.

### Beginning with emqx

In order to get started with the emqx module with a basic configuration:

```puppet
include emqx
```

## Usage

This module supports the use of Hiera data for setting parameters. The following is a list of parameters configurable in Hiera (Please refer to REFERENCE.md for more details and the [EMQX configuration documentation][3] ):

```yaml
emqx::install_package_source: 
emqx::install_version: 
emqx::install_platform: 
emqx::install_package_extension: 
emqx::service_ensure: 
emqx::service_enable: true
emqx::manage_config: true
emqx::config_node_name: 
emqx::config_node_cookie: 
emqx::config_node_data_dir: 
emqx::config_node_options: 
emqx::config_cluster_name: 
emqx::config_cluster_discovery_strategy: 
emqx::config_cluster_options: 
emqx::config_dashboard_listeners_ssl:
emqx::config_dashboard_listeners_bind: 
emqx::config_dashboard_listeners_options:
emqx::config_authorization_options:
  deny_action:
  no_match:
  cache:
emqx::config_additional_configs:
```

Note: The key ```emqx::config_node_cookie``` is a sensitive variable.  If overiding this value in a different layer of hiera (e.g. the environment layer),
add the following configuration in common.yaml to convert the value to be sensitive.

```
lookup_options:
  emqx::config_node_cookie:
    convert_to: "Sensitive"
```

## Limitations

  * Currently this module is limited to configuring emqx.conf configuration file

## Development

If you would like to contribute with the development of this module, please feel free to log development changes in the [issues][4] register for this project  


[1]: https://www.emqx.io/
[2]: https://www.emqx.io/docs/en/latest/deploy/install.html
[3]: https://www.emqx.io/docs/en/latest/admin/cfg.html
[4]: https://github.com/jortencio/emqx/issues
