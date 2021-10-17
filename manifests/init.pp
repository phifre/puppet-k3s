# @summary Interface class to manage k3s installation
#
# This class is reponsible to call the install or uninstall classes
#
# @param ensure
#     Ensure if present or absent.
# @param installation_mode
#     Specify if installation should be done via script or if the binary should be used.
# @param binary_version
#     Version of binary to use. (Only required for $installation_mode = 'binary'.)
# @param binary_path
#     Destination path of the binary. (Only required for $installation_mode = 'binary'.)
#
# @example
#   include k3s
#
# @example
#   class { 'k3s':
#     installation_mode => 'binary',
#     binary_path       => '/home/john-doe/bin/k3s',
#   }
class k3s (
  Enum['present', 'absent'] $ensure            = present,
  Enum['script', 'binary']  $installation_mode = 'script',
  String                    $binary_version    = 'v1.19.4+k3s1',
  String                    $binary_path       = '/usr/bin/k3s',
) {
  if $installation_mode == 'binary' and (!$binary_path or !$binary_version) {
    fail('The vars $binary_version and $binary_path must be set when using the \
      binary installation mode.')
  }

  if $ensure == 'present' {
    include k3s::install
  } else {
    include k3s::uninstall
  }
}
