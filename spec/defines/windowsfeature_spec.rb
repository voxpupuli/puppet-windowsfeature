require 'spec_helper'

describe 'windowsfeature', :type => :define do
  let(:title) { 'NET-HTTP-Activation' }

  context 'when installing a windows feature' do
    it { should contain_exec('add-feature-NET-HTTP-Activation').with({
      'command'  => 'Import-Module ServerManager; Add-WindowsFeature NET-HTTP-Activation -Restart:$false',
      'onlyif'   => "Import-Module ServerManager; if((Get-WindowsFeature NET-HTTP-Activation | where InstallState -eq 'Available').count -eq 0){ exit 1 }",
      'provider' => 'powershell'
    })}

    context 'restart => true' do
      let(:params) { { :restart => true } }
      it { should contain_exec('add-feature-NET-HTTP-Activation').with({
        'command'  => 'Import-Module ServerManager; Add-WindowsFeature NET-HTTP-Activation -Restart:$true',
        'onlyif'   => "Import-Module ServerManager; if((Get-WindowsFeature NET-HTTP-Activation | where InstallState -eq 'Available').count -eq 0){ exit 1 }",
        'provider' => 'powershell'
      })}
    end

    context 'restart => false' do
      let(:params) { { :restart => false } }
      it { should contain_exec('add-feature-NET-HTTP-Activation').with({
        'command'  => 'Import-Module ServerManager; Add-WindowsFeature NET-HTTP-Activation -Restart:$false',
        'onlyif'   => "Import-Module ServerManager; if((Get-WindowsFeature NET-HTTP-Activation | where InstallState -eq 'Available').count -eq 0){ exit 1 }",
        'provider' => 'powershell'
      })}
    end
  end

  context 'when installing a windows feature passing in the feature_name value' do
    let(:params) { { :feature_name => 'NET-HTTP-Activation' } }

    it { should contain_exec('add-feature-NET-HTTP-Activation').with({
      'command'  => 'Import-Module ServerManager; Add-WindowsFeature NET-HTTP-Activation -Restart:$false',
      'onlyif'   => "Import-Module ServerManager; if((Get-WindowsFeature NET-HTTP-Activation | where InstallState -eq 'Available').count -eq 0){ exit 1 }",
      'provider' => 'powershell'
    })}
  end

  context 'when removing a windows feature' do
    let(:params) {{ :ensure => 'absent' }}

    it { should contain_exec('remove-feature-NET-HTTP-Activation').with({
         'command'  => "Import-Module ServerManager; Remove-WindowsFeature NET-HTTP-Activation -Restart:$false",
         'unless'   => "Import-Module ServerManager; if((Get-WindowsFeature NET-HTTP-Activation | where InstallState -eq 'Installed').count -gt 0){ exit 1 }",
         'provider' => 'powershell'
    })}
  end
end
