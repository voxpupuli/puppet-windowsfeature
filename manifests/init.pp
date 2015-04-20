# Author::    Paul Stack  (mailto:pstack@opentable.com)
# Copyright:: Copyright (c) 2013 OpenTable Inc
# License::   MIT

# == Define Resource Type: `windowsfeature`
#
# Allows you to add/removing windows features on Windows 2008+
#
# === Requirements/Dependencies
#
# Currently requires the modules puppetlabs/stdlib and puppetlabs/powershell on
# the Puppet Forge in order to validate much of the the provided configuration
#
# === Parameters
#
# [*ensure*] Controls if the Windows feature is installed. Can be `present` or `absent`.
#
# [*feature_name*] Provides the name of the feature that you want to install if this differs from the resource title.
#
# [*installmanagementtools*] Specifies that all applicable management tools should be installed for the given feature. Defaults to `false`
#
# [*installsubfeatures*] Specifiies that all subordinate features of this feature are also installed. Defaults to `false`
#
# [*restart*] Specifies that when installing the windows feature it should perform and restart automatically.
#
# [*source*] Speficies the location of the feature files. This may be a network location or a path to the specific wim file.
#
# === Examples
#
# To install a single windows feature such as dotnet 3.5:
#
#     windowsfeature { 'NET-Framework-Core': }
#
# To install several windows features as part of a large application such IIS:
#
#     windowsfeature { 'IIS':
#       feature_name => [
#         'Web-Server',
#         'Web-WebServer',
#         'Web-Asp-Net45',
#         'Web-ISAPI-Ext',
#         'Web-ISAPI-Filter',
#         'NET-Framework-45-ASPNET',
#         'WAS-NET-Environment',
#         'Web-Http-Redirect',
#         'Web-Filtering',
#         'Web-Mgmt-Console',
#         'Web-Mgmt-Tools'
#       ]
#     }
#
define windowsfeature (
    $ensure = 'present',
    $feature_name = $title,
    $installmanagementtools = false,
    $installsubfeatures = false,
    $restart = false,
    $source = false,
    $timeout = 300,
) {

  validate_re($ensure, '^(present|absent)$', 'valid values for ensure are \'present\' or \'absent\'')
  validate_bool($installmanagementtools)
  validate_bool($installsubfeatures)
  validate_bool($restart)

  if $::operatingsystem != 'windows' { fail ("${module_name} not supported on ${::operatingsystem}") }
  if $restart { $_restart = true } else { $_restart = false }

  if $installsubfeatures {
    $_installsubfeatures = '-IncludeAllSubFeature'
  } else {
    $_installsubfeatures = ''
  }

  if $source {
    $_installsource = "-Source ${source}"
  } else {
    $_installsource = ''
  }

  if $installmanagementtools {
    if $::kernelversion =~ /^(6\.1)/ {
      fail ('Windows 2012 or newer is required to use the installmanagementtools parameter')
    } else {
      $_installmanagementtools = '-IncludeManagementTools'
    }
  } else {
    $_installmanagementtools = ''
  }

  if(is_array($feature_name)){
    $escaped = join(prefix(suffix($feature_name,'\''),'\''),',')
    $features = "@(${escaped})"
  }else{
    $features = $feature_name
  }

  # Windows 2008 R2 and newer required http://technet.microsoft.com/en-us/library/ee662309.aspx
  if $::kernelversion !~ /^(10|6\.(1|2|3))/ { fail ("${module_name} requires Windows 2008 R2 or newer") }

  # from Windows 2012 'Add-WindowsFeature' has been replaced with 'Install-WindowsFeature' http://technet.microsoft.com/en-us/library/ee662309.aspx
  if ($ensure == 'present') {
    if $::kernelversion =~ /^(6.1)/ { $command = 'Add-WindowsFeature' } else { $command = 'Install-WindowsFeature' }

    exec { "add-feature-${title}":
      command  => "Import-Module ServerManager; ${command} ${features} ${_installmanagementtools} ${_installsubfeatures} ${_installsource} -Restart:$${_restart}",
      onlyif   => "Import-Module ServerManager; if (@(Get-WindowsFeature ${features} | ?{\$_.Installed -match \'false\'}).count -eq 0) { exit 1 }",
      provider => powershell,
      timeout  => $timeout,
    }
  } elsif ($ensure == 'absent') {
    exec { "remove-feature-${title}":
      command  => "Import-Module ServerManager; Remove-WindowsFeature ${features} -Restart:$${_restart}",
      onlyif   => "Import-Module ServerManager; if (@(Get-WindowsFeature ${features} | ?{\$_.Installed -match \'true\'}).count -eq 0) { exit 1 }",
      provider => powershell,
      timeout  => $timeout,
    }
  }
}
