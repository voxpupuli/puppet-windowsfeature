define windowsfeature($feature_name = $title, $ensure = 'present', $restart = false) {

  validate_re($ensure, '^(present|absent)$', 'valid values for ensure are \'present\' or \'absent\'')
  validate_bool($restart)

  if $restart { $_restart = 'true' } else { $_restart = 'false' }

  if(is_array($feature_name)){
    $escaped = join(prefix(suffix($feature_name,"'"),"'"),',')
    $features = "@(${escaped})"
  }else{
    $features = $feature_name
  }

  if ($ensure == 'present') {
    exec { "add-feature-${title}" :
      command   => "Import-Module ServerManager; Add-WindowsFeature ${features} -Restart:$${_restart}",
      onlyif    => "Import-Module ServerManager; if((Get-WindowsFeature ${features} | where InstallState -eq 'Available').count -eq 0){ exit 1 }",
      provider  => powershell
    }
  } elsif ($ensure == 'absent') {
    exec { "remove-feature-${title}" :
      command   => "Import-Module ServerManager; Remove-WindowsFeature ${$features} -Restart:$${_restart}",
      unless    => "Import-Module ServerManager; if((Get-WindowsFeature ${features} | where InstallState -eq 'Installed').count -gt 0){ exit 1 }",
      provider  => powershell
    }
  }
}
