define windowsfeature($feature_name = $title, $ensure = 'present', $restart = 'false') {
  include 'windowsfeature::param::powershell'

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
      command   => "${windowsfeature::param::powershell::command} -Command \"Import-Module ServerManager; Add-WindowsFeature ${features} -Restart:$${restart}\"",
      path      => "${windowsfeature::param::powershell::path};${::path}",
      onlyif    => "${windowsfeature::param::powershell::command} -Command \"Import-Module ServerManager; if((Get-WindowsFeature ${features} | where {\$_.Installed -eq \$False} | measure).count -eq 0){ exit 1 }\"",
      logoutput => true,
    }
  } elsif ($ensure == 'absent') {
    exec { "remove-feature-${title}" :
      command   => "${windowsfeature::param::powershell::command} -Command \"Import-Module ServerManager; Remove-WindowsFeature ${$features} -Restart:$${restart}\"",
      path      => "${windowsfeature::param::powershell::path};${::path}",
      unless    => "${windowsfeature::param::powershell::command} -Command \"Import-Module ServerManager; if((Get-WindowsFeature ${features} | where {\$_.Installed -eq \$True}).count -gt 0){ exit 1 }\"",
      logoutput => true,
    }
  }
}
