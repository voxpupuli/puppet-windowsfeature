require 'puppetlabs_spec_helper/module_spec_helper'
require "rspec/mocks/standalone"

def project_path
  File.expand_path("../..", __FILE__)
end

def fixture(fixture_name, format='json')
  IO.binread(project_path + "/spec/fixtures/#{fixture_name}.#{format}")
end
