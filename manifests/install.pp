# @summary Manage install of emqx
#
# Downloads and installs the emqx package
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
#   include emqx::install
#
# @api private
# 
class emqx::install (
  String $package_source    = $emqx::install_package_source,
  String $version           = $emqx::install_version,
  String $platform          = $emqx::install_platform,
  String $package_extension = $emqx::install_package_extension,
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
}
