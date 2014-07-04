#
define windowsfeature (
    $ensure = 'present',
    $feature_name = $title,
    $installmanagementtools = false,
    $installsubfeatures = false,
    $restart = false
) {

  notify { "This module has been deprecated. Please see: https://forge.puppetlabs.com/opentable/windowsfeature": }
}
