define windowsfeature($feature_name = $title, $ensure = 'present', $restart = false) {

  validate_re($ensure, '^(present|absent)$', 'valid values for ensure are \'present\' or \'absent\'')
  validate_bool($restart)

  if $::operatingsystem != 'windows' { fail ("${module_name} not supported on ${::operatingsystem}") }
  if $restart { $_restart = 'true' } else { $_restart = 'false' }

  if(is_array($feature_name)){
    $escaped = join(prefix(suffix($feature_name,"'"),"'"),',')
    $features = "@(${escaped})"
  }else{
    $features = $feature_name
  }

  # Windows 2008 R2 and newer required http://technet.microsoft.com/en-us/library/ee662309.aspx
  if $kernelversion !~ /^(6\.1|6\.2|6\.3)/ { fail ("${module_name} requires Windows 2008 R2 or newer") }

  # from Windows 2012 'Add-WindowsFeature' has been replaced with 'Install-WindowsFeature' http://technet.microsoft.com/en-us/library/ee662309.aspx
  if ($ensure == 'present') { if $::kernelversion =~ /^(6.1)/ { $command = 'Add-WindowsFeature' } else { $command = 'Install-WindowsFeature' }

    exec { "add-feature-${title}" :
      command   => "Import-Module ServerManager; ${command} ${features} -Restart:$${_restart}",
      onlyif    => "Import-Module ServerManager; if((Get-WindowsFeature ${features} | where { \$_.InstallState -eq 'Available'}).count -eq 0){ exit 1 }",
      provider  => powershell
    }
  } elsif ($ensure == 'absent') {
    exec { "remove-feature-${title}" :
      command   => "Import-Module ServerManager; Remove-WindowsFeature ${$features} -Restart:$${_restart}",
      unless    => "Import-Module ServerManager; if((Get-WindowsFeature ${features} | where { \$_.InstallState -eq 'Installed'}).count -gt 0){ exit 1 }",
      provider  => powershell
    }
  }
}
