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
# @param dashboard_listener_http_bind
# @param dashboard_options
# @param authorization_deny_action
# @param authorization_no_match
# @param authorization_cache
# @param authorization_options
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
  Variant[Integer,String[1]]                         $dashboard_listener_http_bind = $emqx::config_dashboard_listener_http_bind,
  Hash                                               $dashboard_options            = $emqx::config_dashboard_options,
  Enum['ignore','disconnect']                        $authorization_deny_action    = $emqx::config_authorization_deny_action,
  Enum['allow','deny']                               $authorization_no_match       = $emqx::config_authorization_no_match,
  String[1]                                          $authorization_cache          = $emqx::config_authorization_cache,
  Hash                                               $authorization_options        = $emqx::config_authorization_options,
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
