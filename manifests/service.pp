# @summary Manage emqx service
#
# A class that manages the emqx service
#
# @param ensure
#
#    The state of the service.
#
# @param enable
#
#    Boolean for enabling/disabling the service.
#
# @example
#   include emqx::service
#
# @api private
# 
class emqx::service (
  Variant[Enum['running', 'stopped'], Boolean] $ensure = $emqx::service_ensure,
  Boolean $enable                                      = $emqx::service_enable,
) {
  service { 'emqx':
    ensure    => $ensure,
    enable    => $enable,
    subscribe => File['/etc/emqx/emqx.conf'],
  }
}
