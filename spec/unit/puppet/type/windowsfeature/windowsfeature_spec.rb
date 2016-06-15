#!/usr/bin/env ruby

require 'spec_helper'

describe Puppet::Type.type(:windowsfeature) do
  before :each do
    described_class.stubs(:defaultprovider).returns providerclass
  end

  let :providerclass do
    described_class.provide(:fake_windowsfeature_provider) { mk_resource_methods }
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
