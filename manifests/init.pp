# @summary A basic module for managing emqx
#
# Installs and configures the emqx package and service
#
# @param install_package_source
#
#    The location to source the package from
#
# @param install_version
#
#    The version of emqx
#
# @param install_platform
#
#    The os platform in order to download the required package
#
# @param install_package_extension
#
#    The file extension for the package
#
# @param service_ensure
#
#    The state of the service
#
# @param service_enable
#
#    Boolean for enabling/disabling the service
#
# @param manage_config
#
#  Boolean for setting whether to manage emqx.conf
#
# @param config_node_name
#
#  String for setting the name field for the node config path
#
# @param config_node_cookie
#
#  Sensitive string for setting the cookie field for the node config path
#
# @param config_node_data_dir
#
#  String for setting the data_dir field for the node config path
#
# @param config_node_options
#
#  Hash for setting additional fields under the node config path.  Note: Do not set name, cooke and data_dir fields here.
#
# @param config_cluster_name
#
#  String for setting the name field for the cluster config path
#
# @param config_cluster_discovery_strategy
#
#  Enum String for setting the discovery_strategy field for the cluster config path.
#
# @param config_cluster_options
#
#  Hash for setting additional fields under the cluster config path.  Note: Do not set name, cooke and data_dir fields here.  
#  Note: Do not set name and discovery_strategy fields here.
#
# @param config_dashboard_listeners_ssl
#
#  Boolean for setting ssl for the dashboard listener configuration.  i.e. Use config path if true dashboard.listeners.https, 
#  else dashboard.listeners.http
#
# @param config_dashboard_listeners_bind
#
#  Integer or String for setting the bind as either a port or bind ip:port respectively.
#
# @param config_dashboard_listeners_options
#
#  Hash for setting additional fields under the dashboard.listeners.http or dashboard.listeners.https config path.
#  Note: Do not set bind and option fields here.
#
# @param config_authorization_options
#
#  Hash for setting additional fields under the authorization config path.
#
# @param config_additional_configs
#
#  Hash for setting additional config paths and fields.
#  Note: Do not set the following config_paths here: node, cluster, dashboard, authorization
#
# @example
#   include emqx
class emqx (
  String                                             $install_package_source              = 'https://www.emqx.com/en/downloads/broker',
  String                                             $install_version                     = '5.0.25',
  String                                             $install_platform                    = 'el8',
  String                                             $install_package_extension           = 'rpm',
  Variant[Enum['running', 'stopped'], Boolean]       $service_ensure                      = 'running',
  Boolean                                            $service_enable                      = true,
  Boolean                                            $manage_config                       = true,
  String[1]                                          $config_node_name                    = 'emqx@127.0.0.1',
  Sensitive[String[1]]                               $config_node_cookie                  = Sensitive('emqxsecretcookie'),
  String                                             $config_node_data_dir                = '/var/lib/emqx',
  Hash                                               $config_node_options                 = {},
  String[1]                                          $config_cluster_name                 = 'emqxcl',
  Enum['manual','static','mcast','dns','etcd','k8s'] $config_cluster_discovery_strategy   = 'manual',
  Hash                                               $config_cluster_options              = {},
  Boolean                                            $config_dashboard_listeners_ssl      = false,
  Variant[Integer,String[1]]                         $config_dashboard_listeners_bind     = 18083,
  Hash                                               $config_dashboard_listeners_options  = {},
  Hash                                               $config_authorization_options        = {},
  Hash                                               $config_additional_configs           = {},
) {
  include emqx::install
  include emqx::config
  include emqx::service

  Class['emqx::install'] -> Class['emqx::config'] -> Class['emqx::service']
}
