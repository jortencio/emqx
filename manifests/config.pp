# @summary Manage emqx.conf configuration file
#
# A class for configurating the emqx.conf based on configurations described at https://www.emqx.io/docs/en/latest/admin/cfg.html
#
# @param manage_config
#
#  Boolean for setting whether to manage emqx.conf.
#
# @param node_name
#
#  String for setting the name field for the node config path.
#
# @param node_cookie
#
#  Sensitive string for setting the cookie field for the node config path.
#
# @param node_data_dir
#
#  String for setting the data_dir field for the node config path.
#
# @param node_options
#
#  Hash for setting additional fields under the node config path.  Note: Do not set name, cooke and data_dir fields here.  
#
# @param cluster_name
#
#  String for setting the name field for the cluster config path.
#
# @param cluster_discovery_strategy
#
#  Enum String for setting the discovery_strategy field for the cluster config path.
#
# @param cluster_options
#
#  Hash for setting additional fields under the cluster config path.  Note: Do not set name, cooke and data_dir fields here.  
#  Note: Do not set name and discovery_strategy fields here.
#
# @param dashboard_listeners_ssl
#
#  Boolean for setting ssl for the dashboard listener configuration.  i.e. Use config path if true dashboard.listeners.https, 
#  else dashboard.listeners.http.
#
# @param dashboard_listeners_bind
#
#  Integer or String for setting the bind as either a port or bind ip:port respectively.
#
# @param dashboard_listeners_options
#
#  Hash for setting additional fields under the dashboard.listeners.http or dashboard.listeners.https config path.
#  Note: Do not set bind and option fields here.
#
# @param authorization_options
#
#  Hash for setting additional fields under the authorization config path.
#
# @param additional_configs
#
#  Hash for setting additional config paths and fields.
#  Note: Do not set the following config_paths here: node, cluster, dashboard, authorization.
#
# @example
#   include emqx::config
#
# @api private
# 
class emqx::config (
  Boolean                                            $manage_config                = $emqx::manage_config,
  String[1]                                          $node_name                    = $emqx::config_node_name,
  Sensitive[String[1]]                               $node_cookie                  = $emqx::config_node_cookie,
  String                                             $node_data_dir                = $emqx::config_node_data_dir,
  Hash                                               $node_options                 = $emqx::config_node_options,
  String[1]                                          $cluster_name                 = $emqx::config_cluster_name,
  Enum['manual','static','mcast','dns','etcd','k8s'] $cluster_discovery_strategy   = $emqx::config_cluster_discovery_strategy,
  Hash                                               $cluster_options              = $emqx::config_cluster_options,
  Boolean                                            $dashboard_listeners_ssl      = $emqx::config_dashboard_listeners_ssl,
  Variant[Integer,String[1]]                         $dashboard_listeners_bind     = $emqx::config_dashboard_listeners_bind,
  Hash                                               $dashboard_listeners_options  = $emqx::config_dashboard_listeners_options,
  Hash                                               $authorization_options        = $emqx::config_authorization_options,
  Hash                                               $additional_configs           = $emqx::config_additional_configs,
) {
  if $manage_config {
    file { '/etc/emqx/emqx.conf':
      ensure  => file,
      owner   => 'emqx',
      group   => 'emqx',
      mode    => '0644',
      content => epp('emqx/emqx.conf.epp'),
      require => Package['emqx'],
    }
  }
}
