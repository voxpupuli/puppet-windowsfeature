require 'spec_helper'

describe 'windowsfeature', :type => :define do
  describe 'when installing a windows feature' do
    let(:title) { 'NET-HTTP-Activation' }

    it { should contain_exec('add-feature-NET-HTTP-Activation').with({
                                                                         'command'  => "Import-Module ServerManager; Add-WindowsFeature NET-HTTP-Activation -Restart:$false",
                                                                         'onlyif'   => "Import-Module ServerManager; if((Get-WindowsFeature NET-HTTP-Activation | where InstallState -eq 'Available').count -eq 0){ exit 1 }",
                                                                         'provider' => 'powershell'
                                                                     })}
  end

  describe 'when installing a windows feature passing in the feature_name value' do
    let(:title) { 'Net_Http_Activation' }
    let(:params) { { :feature_name => 'NET-HTTP-Activation' } }

    it { should contain_exec('add-feature-Net_Http_Activation').with({
                                                                         'command'  => "Import-Module ServerManager; Add-WindowsFeature NET-HTTP-Activation -Restart:$false",
                                                                         'onlyif'   => "Import-Module ServerManager; if((Get-WindowsFeature NET-HTTP-Activation | where InstallState -eq 'Available').count -eq 0){ exit 1 }",
                                                                         'provider' => 'powershell'
                                                                     })}
  end

  describe 'when removing a windows feature' do
    let(:title) { 'NET-HTTP-Activation' }
    let(:params) {{ :ensure => 'present' }}

    it { should contain_exec('add-feature-NET-HTTP-Activation').with({
                                                                         'command'  => "Import-Module ServerManager; Add-WindowsFeature NET-HTTP-Activation -Restart:$false",
                                                                         'onlyif'   => "Import-Module ServerManager; if((Get-WindowsFeature NET-HTTP-Activation | where InstallState -eq 'Available').count -eq 0){ exit 1 }",
                                                                         'provider' => 'powershell'
                                                                     })}
  end

  describe 'when removing a windows feature' do
    let(:title) { 'NET-HTTP-Activation' }
    let(:params) {{ :ensure => 'absent' }}

    it { should contain_exec('remove-feature-NET-HTTP-Activation').with({
                                                                            'command'  => "Import-Module ServerManager; Remove-WindowsFeature NET-HTTP-Activation -Restart:$false",
                                                                            'unless'   => "Import-Module ServerManager; if((Get-WindowsFeature NET-HTTP-Activation | where InstallState -eq 'Installed').count -gt 0){ exit 1 }",
                                                                            'provider' => 'powershell'
                                                                        })}
  end

  describe 'when passing a non boolean value to the installed parameter' do
    let(:title) { 'NET-HTTP-Activation' }
    let(:params) {{ :ensure => 'moo' }}

    it { expect { should contain_exec('no-exec') }.to raise_error(Puppet::Error, /valid values for ensure are 'present' or 'absent'/) }
  end
end
