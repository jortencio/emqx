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
# @example
#   include emqx
class emqx (
  String                                       $install_package_source    = 'https://www.emqx.com/en/downloads/broker',
  String                                       $install_version           = '5.0.25',
  String                                       $install_platform          = 'el8',
  String                                       $install_package_extension = 'rpm',
  Variant[Enum['running', 'stopped'], Boolean] $service_ensure            = 'running',
  Boolean                                      $service_enable            = true,
) {
  include emqx::install
  include emqx::service

  Class['emqx::install'] -> Class['emqx::service']
}
