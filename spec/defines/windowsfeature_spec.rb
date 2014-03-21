require 'spec_helper'

powershell = 'powershell.exe -ExecutionPolicy RemoteSigned'

describe 'windowsfeature', :type => :define do
  describe 'when installing a windows feature' do
    let(:title) { 'NET-HTTP-Activation' }

    it { should include_class('windowsfeature::param::powershell') }

    it { should contain_exec('add-feature-NET-HTTP-Activation').with({
                                                                         'command' => "#{powershell} -Command \"Import-Module ServerManager; Add-WindowsFeature NET-HTTP-Activation -Restart:$false\"",
                                                                         'onlyif'  => "#{powershell} -Command \"Import-Module ServerManager; if((Get-WindowsFeature NET-HTTP-Activation | where {$_.Installed -eq 'False'}).count -eq 0){ exit 1 }\"",
                                                                     })}
  end

  describe 'when installing a windows feature passing in the feature_name value' do
    let(:title) { 'Net_Http_Activation' }
    let(:params) { { :feature_name => 'NET-HTTP-Activation' } }

    it { should include_class('windowsfeature::param::powershell') }

    it { should contain_exec('add-feature-Net_Http_Activation').with({
                                                                         'command' => "#{powershell} -Command \"Import-Module ServerManager; Add-WindowsFeature NET-HTTP-Activation -Restart:$false\"",
                                                                         'onlyif'  => "#{powershell} -Command \"Import-Module ServerManager; if((Get-WindowsFeature NET-HTTP-Activation | where {$_.Installed -eq 'False'}).count -eq 0){ exit 1 }\"",
                                                                     })}
  end

  describe 'when removing a windows feature' do
    let(:title) { 'NET-HTTP-Activation' }
    let(:params) {{ :ensure => 'present' }}

    it { should include_class('windowsfeature::param::powershell') }

    it { should contain_exec('add-feature-NET-HTTP-Activation').with({
                                                                         'command' => "#{powershell} -Command \"Import-Module ServerManager; Add-WindowsFeature NET-HTTP-Activation -Restart:$false\"",
                                                                         'onlyif'  => "#{powershell} -Command \"Import-Module ServerManager; if((Get-WindowsFeature NET-HTTP-Activation | where {$_.Installed -eq 'False'}).count -eq 0){ exit 1 }\"",
                                                                     })}
  end

  describe 'when removing a windows feature' do
    let(:title) { 'NET-HTTP-Activation' }
    let(:params) {{ :ensure => 'absent' }}

    it { should include_class('windowsfeature::param::powershell') }

    it { should contain_exec('remove-feature-NET-HTTP-Activation').with({
                                                                            'command' => "#{powershell} -Command \"Import-Module ServerManager; Remove-WindowsFeature NET-HTTP-Activation -Restart:$false\"",
                                                                            'unless'  => "#{powershell} -Command \"Import-Module ServerManager; if((Get-WindowsFeature NET-HTTP-Activation | where {$_.Installed -eq 'True'}).count -eq 0){ exit 1 }\"",
                                                                        })}
  end

  describe 'when passing a non boolean value to the installed parameter' do
    let(:title) { 'NET-HTTP-Activation' }
    let(:params) {{ :ensure => 'moo' }}

    it { expect { should contain_exec('no-exec') }.to raise_error(Puppet::Error, /valid values for ensure are 'present' or 'absent'/) }
  end
end