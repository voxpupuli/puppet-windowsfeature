require 'spec_helper_acceptance'

describe 'windowsfeature' do
  context 'lots of features at once' do
    it 'is installed and not take too long' do
      pp = <<-PP
        $windowsfeatures = [
          'Web-Filtering',
          'Web-Http-Errors',
          'Web-Net-Ext',
          'Web-Mgmt-Tools',
          'Web-ISAPI-Ext',
          'Web-Default-Doc',
          'Web-Stat-Compression',
          'Web-Http-Logging',
          'Web-Mgmt-Console',
          'Web-ISAPI-Filter',
          'Web-Static-Content',
          'Web-Request-Monitor',
          'Web-Dyn-Compression',
        ]

        windowsfeature { $windowsfeatures:
          ensure => present,
        }
      PP

      apply_manifest(pp, catch_failures: true)
      expect(apply_manifest(pp, catch_failures: true).exit_code).to be_zero
    end
  end
end
