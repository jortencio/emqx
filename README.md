# emqx

A Puppet module that is used for installing and configuring an EMQX MQTT Broker.

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

### Hiera Support

This module supports the use of Hiera data for setting parameters. The following is a list of parameters configurable in Hiera (Please refer to REFERENCE.md for more details):

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

### Setting the Node cookie configuration

The key ```emqx::config_node_cookie``` is a sensitive variable.  If overiding this value in a different layer of hiera (e.g. the environment layer),
add the following configuration in common.yaml to convert the value to be sensitive.

```
lookup_options:
  emqx::config_node_cookie:
    convert_to: "Sensitive"
```

### Setting other configuration option paths

Currently the emqx module has direct parameters for setting configurations under the node, cluster, dashboard.listener.http/dashboard.listener.https and authorization configuration paths. 
However, it is also possible to set configurations for other configuration option paths using the parameter ```emqx::config_additional_configs``` as the following yaml hash follows:

Format

```yaml
emqx::config_additional_configs:
  <configuration_path_x>
    <field_x_1>: <value_x_1>
    <field_x_2>: <value_x_2>
  <configuration_path_y>
    <field_y_1>: <value_y_1>
```

Example:

```yaml
emqx::config_additional_configs:
  force_shutdown:
    enable: false
    max_heap_size: "128MB"
```

For more information regarding the EMQX configuration paths and fields, visit [EMQX configuration documentation][3].

## Limitations

  * Currently this module is limited to configurations possible in emqx.conf

## Development

If you would like to contribute with the development of this module, please feel free to log development changes in the [issues][4] register for this project.


[1]: https://www.emqx.io/
[2]: https://www.emqx.io/docs/en/latest/deploy/install.html
[3]: https://www.emqx.io/docs/en/latest/admin/cfg.html
[4]: https://github.com/jortencio/emqx/issues
