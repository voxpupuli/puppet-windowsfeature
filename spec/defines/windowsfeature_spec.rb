require 'spec_helper'

describe 'windowsfeature', :type => :define do
  let(:title) { 'NET-HTTP-Activation' }

  context '$::operatingsystem => windows' do
    # Test Windows 2008
    [ '6.0.6001' ].each do |kernelversion|
      context "$::kernelversion => #{kernelversion}" do
        let(:facts) { { :kernelversion => kernelversion, :operatingsystem => 'windows' } }

        it do
          expect {
            should contain_define('windowsfeature')
          }.to raise_error(Puppet::Error, /windowsfeature requires Windows 2008 R2 or newer/)
        end
      end
    end

    # Test Windows 2008 R2
    [ '6.1.7601' ].each do |kernelversion|
      context "$::kernelversion => #{kernelversion}" do
        let(:facts) { { :kernelversion => kernelversion, :operatingsystem => 'windows' } }

        context 'when installing a windows feature' do
          it { should contain_exec('add-feature-NET-HTTP-Activation').with({
            'command'  => 'Import-Module ServerManager; Add-WindowsFeature NET-HTTP-Activation    -Restart:$false',
            'onlyif'   => "Import-Module ServerManager; if (@(Get-WindowsFeature NET-HTTP-Activation | ?{$_.Installed -match 'false'}).count -eq 0) { exit 1 }",
            'provider' => 'powershell'
          })}

          context '$installmanagementtools => true' do
            let(:params) { { :installmanagementtools => true } }

            it do
              expect {
                should contain_exec('add-feature-NET-HTTP-Activation')
              }.to raise_error(Puppet::Error, /Windows 2012 or newer is required to use the installmanagementtools parameter/)
            end
          end

          context '$installsubfeatures => true' do
            let(:params) { { :installsubfeatures => true } }
            it { should contain_exec('add-feature-NET-HTTP-Activation').with({
              'command'  => 'Import-Module ServerManager; Add-WindowsFeature NET-HTTP-Activation  -IncludeAllSubFeature  -Restart:$false',
              'onlyif'   => "Import-Module ServerManager; if (@(Get-WindowsFeature NET-HTTP-Activation | ?{$_.Installed -match 'false'}).count -eq 0) { exit 1 }",
              'provider' => 'powershell'
            })}
          end

          context '$restart => true' do
            let(:params) { { :restart => true } }
            it { should contain_exec('add-feature-NET-HTTP-Activation').with({
              'command'  => 'Import-Module ServerManager; Add-WindowsFeature NET-HTTP-Activation    -Restart:$true',
              'onlyif'   => "Import-Module ServerManager; if (@(Get-WindowsFeature NET-HTTP-Activation | ?{$_.Installed -match 'false'}).count -eq 0) { exit 1 }",
              'provider' => 'powershell'
            })}
          end

          context '$restart => false' do
            let(:params) { { :restart => false } }
            it { should contain_exec('add-feature-NET-HTTP-Activation').with({
              'command'  => 'Import-Module ServerManager; Add-WindowsFeature NET-HTTP-Activation    -Restart:$false',
              'onlyif'   => "Import-Module ServerManager; if (@(Get-WindowsFeature NET-HTTP-Activation | ?{$_.Installed -match 'false'}).count -eq 0) { exit 1 }",
              'provider' => 'powershell'
            })}
          end

          context 'when removing a windows feature' do
            let(:params) {{ :ensure => 'absent' }}
            it { should contain_exec('remove-feature-NET-HTTP-Activation').with({
              'command'  => "Import-Module ServerManager; Remove-WindowsFeature NET-HTTP-Activation -Restart:$false",
              'onlyif'   => "Import-Module ServerManager; if (@(Get-WindowsFeature NET-HTTP-Activation | ?{$_.Installed -match 'true'}).count -eq 0) { exit 1 }",
              'provider' => 'powershell'
            })}
          end
        end
      end
    end

    # Test Windows 2012 and 2012 R2
    [ '6.2.9200', '6.3.9600' ].each do |kernelversion|
      context "$::kernelversion => #{kernelversion}" do
        let(:facts) { { :kernelversion => kernelversion, :operatingsystem => 'windows' } }

        context 'when installing a windows feature' do
          it { should contain_exec('add-feature-NET-HTTP-Activation').with({
            'command'  => 'Import-Module ServerManager; Install-WindowsFeature NET-HTTP-Activation    -Restart:$false',
            'onlyif'   => "Import-Module ServerManager; if (@(Get-WindowsFeature NET-HTTP-Activation | ?{$_.Installed -match 'false'}).count -eq 0) { exit 1 }",
            'provider' => 'powershell'
          })}

          context '$installmanagementtools => true' do
            let(:params) { { :installmanagementtools => true } }

            it { should contain_exec('add-feature-NET-HTTP-Activation').with({
              'command'  => 'Import-Module ServerManager; Install-WindowsFeature NET-HTTP-Activation -IncludeManagementTools   -Restart:$false',
              'onlyif'   => "Import-Module ServerManager; if (@(Get-WindowsFeature NET-HTTP-Activation | ?{$_.Installed -match 'false'}).count -eq 0) { exit 1 }",
              'provider' => 'powershell'
            })}
          end

          context '$installsubfeatures => true' do
            let(:params) { { :installsubfeatures => true } }

            it { should contain_exec('add-feature-NET-HTTP-Activation').with({
              'command'  => 'Import-Module ServerManager; Install-WindowsFeature NET-HTTP-Activation  -IncludeAllSubFeature  -Restart:$false',
              'onlyif'   => "Import-Module ServerManager; if (@(Get-WindowsFeature NET-HTTP-Activation | ?{$_.Installed -match 'false'}).count -eq 0) { exit 1 }",
              'provider' => 'powershell'
            })}
          end

          context '$restart => true' do
            let(:params) { { :restart => true } }

            it { should contain_exec('add-feature-NET-HTTP-Activation').with({
              'command'  => 'Import-Module ServerManager; Install-WindowsFeature NET-HTTP-Activation    -Restart:$true',
              'onlyif'   => "Import-Module ServerManager; if (@(Get-WindowsFeature NET-HTTP-Activation | ?{$_.Installed -match 'false'}).count -eq 0) { exit 1 }",
              'provider' => 'powershell'
            })}
          end

          context '$restart => false' do
            let(:params) { { :restart => false } }

            it { should contain_exec('add-feature-NET-HTTP-Activation').with({
              'command'  => 'Import-Module ServerManager; Install-WindowsFeature NET-HTTP-Activation    -Restart:$false',
              'onlyif'   => "Import-Module ServerManager; if (@(Get-WindowsFeature NET-HTTP-Activation | ?{$_.Installed -match 'false'}).count -eq 0) { exit 1 }",
              'provider' => 'powershell'
            })}
          end

          context 'when removing a windows feature' do
            let(:params) {{ :ensure => 'absent' }}

            it { should contain_exec('remove-feature-NET-HTTP-Activation').with({
              'command'  => "Import-Module ServerManager; Remove-WindowsFeature NET-HTTP-Activation -Restart:$false",
              'onlyif'   => "Import-Module ServerManager; if (@(Get-WindowsFeature NET-HTTP-Activation | ?{$_.Installed -match 'true'}).count -eq 0) { exit 1 }",
              'provider' => 'powershell'
            })}
          end

          context 'when installing a windows feature passing in the feature_name value' do
            let(:params) { { :feature_name => 'NET-HTTP-Activation' } }

            it { should contain_exec('add-feature-NET-HTTP-Activation').with({
              'command'  => 'Import-Module ServerManager; Install-WindowsFeature NET-HTTP-Activation    -Restart:$false',
              'onlyif'   => "Import-Module ServerManager; if (@(Get-WindowsFeature NET-HTTP-Activation | ?{$_.Installed -match 'false'}).count -eq 0) { exit 1 }",
              'provider' => 'powershell'
            })}
          end
        end
      end
    end
  end

  context '$::operatingsystem => Ubuntu' do
    let(:facts) { { :operatingsystem => 'Ubuntu' } }

    it do
      expect {
        should contain_define('windowsfeature')
      }.to raise_error(Puppet::Error, /windowsfeature not supported on Ubuntu/)
    end
  end
end
