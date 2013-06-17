define windowsfeature($feature_name = $title, $ensure = 'present') {
  include 'windowsfeature::param::powershell'

  if ! ($ensure in [ 'present', 'absent' ]) {
    fail('valid values for ensure are \'present\' or \'absent\'')
  }

  if ($ensure == 'present') {
    exec { "add-feature-${feature_name}" :
      command   => "${windowsfeature::param::powershell::command} -Command \"Import-Module ServerManager; Add-WindowsFeature ${feature_name}\"",
      path      => "${windowsfeature::param::powershell::path};${::path}",
      onlyif    => "${windowsfeature::param::powershell::command} -Command \"Import-Module ServerManager; if((Get-WindowsFeature ${feature_name}).Installed) { exit 1 }\"",
      logoutput => true,
    }
  } elsif ($ensure == 'absent') {
    exec { "remove-feature-${feature_name}" :
      command   => "${windowsfeature::param::powershell::command} -Command \"Import-Module ServerManager; Remove-WindowsFeature ${feature_name}\"",
      path      => "${windowsfeature::param::powershell::path};${::path}",
      unless    => "${windowsfeature::param::powershell::command} -Command \"Import-Module ServerManager; if((Get-WindowsFeature ${feature_name}).Installed) { exit 1 }\"",
      logoutput => true,
    }
  }
}
