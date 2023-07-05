# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @param manage_config
# @param node_name
# @param node_cookie
# @param node_data_dir
# @param node_options
# @param cluster_name
# @param cluster_discovery_strategy
# @param cluster_options
# @param dashboard_listeners_ssl
# @param dashboard_listeners_bind
# @param dashboard_listeners_options
# @param authorization_options
# @param additional_configs
#
# @example
#   include emqx::config
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
