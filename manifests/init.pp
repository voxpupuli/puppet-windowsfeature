define windowsfeature($feature_name = $title, $ensure = 'present', $restart = 'false') {

  if ! ($ensure in [ 'present', 'absent' ]) {
    fail('valid values for ensure are \'present\' or \'absent\'')
  }

  validate_re($restart, '^(false|true)$', 'restart must be one of \'true\' or \'false\'')

  if(is_array($feature_name)){
    $escaped = join(prefix(suffix($feature_name,"'"),"'"),',')
    $features = "@(${escaped})"
  }else{
    $features = $feature_name
  }

  if ($ensure == 'present') {
    exec { "add-feature-${title}" :
      command   => "Import-Module ServerManager; Add-WindowsFeature ${features} -Restart:$${restart}",
      onlyif    => "Import-Module ServerManager; if((Get-WindowsFeature ${features} | where InstallState -eq 'Available').count -eq 0){ exit 1 }",
      provider  => powershell
    }
  } elsif ($ensure == 'absent') {
    exec { "remove-feature-${title}" :
      command   => "Import-Module ServerManager; Remove-WindowsFeature ${$features} -Restart:$${restart}",
      unless    => "Import-Module ServerManager; if((Get-WindowsFeature ${features} | where InstallState -eq 'Installed').count -gt 0){ exit 1 }",
      provider  => powershell
    }
  }
}
