require 'spec_helper_acceptance'

describe 'windowsfeature' do
  context 'when managing a windows feature' do
    let(:manifest) do
      <<-MANIFEST
            windowsfeature { 'Web-Http-Redirect':
              ensure => present,
            }
          MANIFEST
    end

    it 'runs without errors' do
      apply_manifest(manifest, catch_failures: true)
    end

    it 'runs a second time without changes' do
      apply_manifest(manifest, catch_changes: true)
    end
  end

  describe windows_feature('Web-Http-Redirect') do
    it { is_expected.to be_installed.by('powershell') }
  end
end
