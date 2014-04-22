require 'spec_helper_acceptance'

describe 'windowsfeature defintion', :unless => UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do

  context 'valid windows feature parameter', :if => fact('osfamily').eql?('windows')do
    it 'should work with no errors' do
      pp = <<-EOS
        windowsfeature { 'Web-Mgmt-Console': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :modulepath => 'c:/ProgramData/PuppetLabs/puppet/etc/modules', :catch_failures => true)
      expect(apply_manifest(pp, :modulepath => 'c:/ProgramData/PuppetLabs/puppet/etc/modules', :catch_failures => true).exit_code).to be_zero

    end

    describe windows_feature('Web-Mgmt-Tools') do
      it{ should be_installed }
    end

  end

end