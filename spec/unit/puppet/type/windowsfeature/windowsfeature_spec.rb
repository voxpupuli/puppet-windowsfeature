#!/usr/bin/env ruby

require 'spec_helper'

describe Puppet::Type.type(:windowsfeature) do

  before do
    @class = described_class
    @provider_class = @class.provide(:fake) { mk_resource_methods }
    @provider = @provider_class.new
    @resource = double 'resource', :resource => nil, :provider => @provider

    @class.stubs(:defaultprovider).returns @provider_class
    @class.any_instance.stubs(:provider).returns @provider
  end

  it "should have :name as its keyattribute" do
    expect(@class.key_attributes).to eq([:name])
  end

  describe "when validating attributes" do

    params = [
      :installmanagementtools,
      :installsubfeatures,
      :restart,
      :source,
    ]

    params.each do |param|
      it "should have a #{param} parameter" do
        expect(@class.attrtype(param)).to eq(:param)
      end
    end
  end

end
