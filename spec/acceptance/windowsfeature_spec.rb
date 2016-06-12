require 'spec_helper_acceptance'

describe 'windowsfeature' do
  context 'windows feature should be installed' do
    it 'installs .net 3.5 feature' do
      pp = <<-PP
        windowsfeature { 'as-net-framework':
          ensure => present,
        }
      PP

      apply_manifest(pp, catch_failures: true)
      expect(apply_manifest(pp, catch_failures: true).exit_code).to be_zero
    end
  end

  describe windows_feature('as-net-framework') do
    it { should be_installed.by('powershell') }
  end
end
