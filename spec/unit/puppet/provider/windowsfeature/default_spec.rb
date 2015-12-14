require 'spec_helper'

describe Puppet::Type.type(:windowsfeature).provider(:default) do

  let(:resource) { Puppet::Type.type(:windowsfeature).new(
    {
      :title => 'feature-name',
      :provider => described_class.name
    }
  )}

  let(:provider) { resource.provider }

  let(:instance) { provider.class.instances.first }

  let(:windows_feature_json) {
    # Read big JSON file from a base 2012R2 run
    fixture("windows-features")
  }

  before :each do
    Facter.stubs(:value).with(:kernel).returns(:windows)
    provider.class.stubs(:ps).with('Get-WindowsFeature | ConvertTo-JSON').returns(windows_feature_json)
  end

  describe 'self.prefetch' do
    it 'exists' do
      provider.class.instances
      provider.class.prefetch({})
    end
  end

  describe 'self.instances' do
    it 'returns an array of windows features' do
      features      = provider.class.instances.collect {|x| x.name }
      expect(features).to include('ad-certificate')
    end
  end

end
