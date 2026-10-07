# frozen_string_literal: true

require 'spec_helper'

provider_class = Puppet::Type.type(:windowsfeature).provider(:default)

describe provider_class do
  let :resource do
    Puppet::Type.type(:windowsfeature).new(
      title: 'feature-name',
      provider: described_class.name,
    )
  end

  let(:provider) { resource.provider }

  let(:instance) { provider.class.instances.first }

  let(:windows_feature_xml) do
    # Read big XML file from a base 2012R2 run
    fixture('windows-features')
  end

  before do
    allow(Facter).to receive(:value).with(:kernel).and_return(:windows)
    allow(provider.class).to receive(:ps).with(%($ProgressPreference='SilentlyContinue'; Import-Module ServerManager; Get-WindowsFeature | Select-Object -Property Name, Installed | ConvertTo-XML -As String -Depth 4 -NoTypeInformation)).and_return(windows_feature_xml)
  end

  it 'supports resource discovery' do
    expect(provider_class).to respond_to(:instances)
  end

  it 'supports resource prefetching' do
    expect(provider_class).to respond_to(:prefetch)
  end

  it 'is ensurable' do
    provider.feature?(:ensurable)
  end

  %i[exists? create destroy].each do |method|
    it "has a(n) #{method} method" do
      expect(provider).to respond_to(method)
    end
  end

  describe 'self.prefetch' do
    it 'exists' do
      provider.class.instances
      provider.class.prefetch({})
    end
  end

  describe 'self.instances' do
    it 'returns an array of windows features' do
      features = provider.class.instances.map(&:name)
      expect(features).to include('ad-certificate', 'wins-server')
    end
  end

  describe 'create' do
    it 'runs Install-WindowsFeature' do
      expect(Puppet::Type::Windowsfeature::ProviderDefault).to receive(:ps).with("$ProgressPreference='SilentlyContinue'; Import-Module ServerManager; Install-WindowsFeature feature-name").and_return('')
      provider.create
    end

    context 'with installmanagementtools' do
      let(:resource) do
        Puppet::Type.type(:windowsfeature).new(
          title: 'feature-name',
          installmanagementtools: true,
          provider: described_class.name,
        )
      end

      it 'runs Install-WindowsFeature with -IncludeManagementTools' do
        expect(Puppet::Type::Windowsfeature::ProviderDefault).to receive(:ps).with("$ProgressPreference='SilentlyContinue'; Import-Module ServerManager; Install-WindowsFeature feature-name -IncludeManagementTools").and_return('')
        provider.create
      end
    end

    context 'with installsubfeatures' do
      let(:resource) do
        Puppet::Type.type(:windowsfeature).new(
          title: 'feature-name',
          installsubfeatures: true,
          provider: described_class.name,
        )
      end

      it 'runs Install-WindowsFeature with -IncludeAllSubFeature' do
        expect(Puppet::Type::Windowsfeature::ProviderDefault).to receive(:ps).with("$ProgressPreference='SilentlyContinue'; Import-Module ServerManager; Install-WindowsFeature feature-name -IncludeAllSubFeature").and_return('')
        provider.create
      end
    end

    context 'with source' do
      let(:resource) do
        Puppet::Type.type(:windowsfeature).new(
          title: 'feature-name',
          source: 'C:\Windows\sxs',
          provider: described_class.name,
        )
      end

      it 'runs Install-WindowsFeature with -Source C:\Windows\sxs' do
        expect(Puppet::Type::Windowsfeature::ProviderDefault).to receive(:ps).with("$ProgressPreference='SilentlyContinue'; Import-Module ServerManager; Install-WindowsFeature feature-name -Source C:\\Windows\\sxs").and_return('')
        provider.create
      end
    end

    context 'with restart' do
      let(:resource) do
        Puppet::Type.type(:windowsfeature).new(
          title: 'feature-name',
          restart: true,
          provider: described_class.name,
        )
      end

      it 'runs Install-WindowsFeature with -Restart' do
        expect(Puppet::Type::Windowsfeature::ProviderDefault).to receive(:ps).with("$ProgressPreference='SilentlyContinue'; Import-Module ServerManager; Install-WindowsFeature feature-name -Restart").and_return('')
        provider.create
      end
    end
  end

  describe 'destroy' do
    it 'runs Uninstall-WindowsFeature' do
      expect(Puppet::Type::Windowsfeature::ProviderDefault).to receive(:ps).with("$ProgressPreference='SilentlyContinue'; Import-Module ServerManager; Uninstall-WindowsFeature feature-name").and_return('')
      provider.destroy
    end

    context 'with restart' do
      let(:resource) do
        Puppet::Type.type(:windowsfeature).new(
          title: 'feature-name',
          restart: true,
          provider: described_class.name,
        )
      end

      it 'runs Uninstall-WindowsFeature with -Restart' do
        expect(Puppet::Type::Windowsfeature::ProviderDefault).to receive(:ps).with("$ProgressPreference='SilentlyContinue'; Import-Module ServerManager; Uninstall-WindowsFeature feature-name -Restart").and_return('')
        provider.destroy
      end
    end
  end
end
