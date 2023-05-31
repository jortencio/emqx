# @summary A basic module for installing emqx
#
# Installs emqx and ensures the service is running
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
# @param config_node_name
# @param config_node_cookie
# @param config_node_data_dir
# @param config_node_options
# @param config_cluster_name
# @param config_cluster_discovery_strategy
# @param config_cluster_options
# @param config_dashboard_listener_http_bind
# @param config_dashboard_options
# @param config_authorization_deny_action
# @param config_authorization_no_match
# @param config_authorization_cache
# @param config_authorization_options
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
  Variant[Integer,String[1]]                         $config_dashboard_listener_http_bind = 18083,
  Hash                                               $config_dashboard_options            = {},
  Enum['ignore','disconnect']                        $config_authorization_deny_action    = 'ignore',
  Enum['allow','deny']                               $config_authorization_no_match       = 'allow',
  String[1]                                          $config_authorization_cache          = '{ enable = true }',
  Hash                                               $config_authorization_options        = {},
) {
  include emqx::install
  include emqx::config
  include emqx::service

  Class['emqx::install'] -> Class['emqx::config'] -> Class['emqx::service']
}
