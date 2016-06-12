#!/usr/bin/env ruby

require 'spec_helper'

describe Puppet::Type.type(:windowsfeature) do
  before do
    @class = described_class
    @provider_class = @class.provide(:fake) { mk_resource_methods }
    @provider = @provider_class.new
    @resource = stub 'resource', resource: nil, provider: @provider

    @class.stubs(:defaultprovider).returns @provider_class
    @class.any_instance.stubs(:provider).returns @provider
  end

  it 'has :name as its keyattribute' do
    expect(@class.key_attributes).to eq([:name])
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
        expect(@class.attrtype(param)).to eq(:param)
      end
    end
  end

  describe "when validating the keywords property" do
    context 'installmanagementtools' do
      it "should accept a boolean" do
        expect { described_class.new(:name => "feature-name", :installmanagementtools => true) }.to_not raise_error
      end

      it "should reject non-boolen" do
        expect { described_class.new(:name => "feature-name", :installmanagementtools => 'foo') }
        .to raise_error(/Parameter installmanagementtools must be true or false/)
      end
    end

    context 'installsubfeatures' do
      it "should accept a boolean" do
        expect { described_class.new(:name => "feature-name", :installsubfeatures => true) }.to_not raise_error
      end

      it "should reject non-boolen" do
        expect { described_class.new(:name => "feature-name", :installsubfeatures => 'foo') }
        .to raise_error(/Parameter installsubfeatures must be true or false/)
      end
    end

    context 'restart' do
      it "should accept a boolean" do
        expect { described_class.new(:name => "feature-name", :restart => true) }.to_not raise_error
      end

      it "should reject non-boolen" do
        expect { described_class.new(:name => "feature-name", :restart => 'foo') }
        .to raise_error(/Parameter restart must be true or false/)
      end
    end

    context 'source' do
      it "should accept a string" do
        expect { described_class.new(:name => "feature-name", :source => 'C:/foo') }.to_not raise_error
      end

      it "should reject non-string" do
        expect { described_class.new(:name => "feature-name", :source => false) }
        .to raise_error(/Parameter source is not a string./)
      end
    end
  end

end
