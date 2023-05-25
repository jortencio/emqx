# @summary A basic module for installing emqx
#
# Installs EMQX and ensures the service is running
#
# @param package_source
#
#    The location to source the package from
#
# @param version
#
#    The version of emqx
#
# @param platform
#
#    The os platform in order to download the required package
#
# @param package_extension
#
#    The file extension for the package
#
# @example
#   include emqx
class emqx (
  String $package_source    = 'https://www.emqx.com/en/downloads/broker',
  String $version           = '5.0.25',
  String $platform          = 'el8',
  String $package_extension = 'rpm',
) {
  $architecture = 'amd64'
  $package_filename = "emqx-${version}-${platform}-${architecture}.${package_extension}"

  file { "/tmp/${package_filename}":
    ensure => file,
    source => "${package_source}/v${version}/${package_filename}",
  }

  package { 'emqx':
    ensure  => $version,
    source  => "/tmp/${package_filename}",
    require => File["/tmp/${package_filename}"],
  }

  service { 'emqx':
    ensure  => running,
    enable  => true,
    require => Package['emqx'],
  }
}
