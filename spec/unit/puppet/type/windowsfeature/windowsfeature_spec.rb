#!/usr/bin/env ruby

require 'spec_helper'

describe Puppet::Type.type(:windowsfeature) do
  let :provider_class do
    described_class.provide(:fake) { mk_resource_methods }
  end
  let(:provider) { provider_class.new }
  before do
    described_class.stubs(:defaultprovider).returns provider_class
    described_class.stubs(:provider).returns provider
  end
  it 'has :name as its keyattribute' do
    expect(described_class.key_attributes).to eq([:name])
  end

  describe 'when validating attributes' do
    params = [
      :installmanagementtools,
      :installsubfeatures,
      :restart,
      :source
    ]

    params.each do |param|
      it "should have a #{param} parameter" do
        expect(described_class.attrtype(param)).to eq(:param)
      end
    end
  end
end
