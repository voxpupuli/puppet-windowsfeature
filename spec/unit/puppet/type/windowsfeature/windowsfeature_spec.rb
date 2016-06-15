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

  describe 'when validating the keywords property' do
    context 'installmanagementtools' do
      it 'accepts a boolean' do
        expect { described_class.new(name: 'feature-name', installmanagementtools: true) }.not_to raise_error
      end

      it 'rejects non-boolen' do
        expect { described_class.new(name: 'feature-name', installmanagementtools: 'foo') }.
          to raise_error(%r{Parameter installmanagementtools must be true or false})
      end
    end

    context 'installsubfeatures' do
      it 'accepts a boolean' do
        expect { described_class.new(name: 'feature-name', installsubfeatures: true) }.not_to raise_error
      end

      it 'rejects non-boolen' do
        expect { described_class.new(name: 'feature-name', installsubfeatures: 'foo') }.
          to raise_error(%r{Parameter installsubfeatures must be true or false})
      end
    end

    context 'restart' do
      it 'accepts a boolean' do
        expect { described_class.new(name: 'feature-name', restart: true) }.not_to raise_error
      end

      it 'rejects non-boolen' do
        expect { described_class.new(name: 'feature-name', restart: 'foo') }.
          to raise_error(%r{Parameter restart must be true or false})
      end
    end

    context 'source' do
      it 'accepts a string' do
        expect { described_class.new(name: 'feature-name', source: 'C:/foo') }.not_to raise_error
      end

      it 'rejects non-string' do
        expect { described_class.new(name: 'feature-name', source: false) }.
          to raise_error(%r{Parameter source is not a string.})
      end
    end
  end
end
