# SimpleCov does not run on Ruby 1.8.7
unless RUBY_VERSION.to_f < 1.9
  require 'simplecov'
  SimpleCov.formatters = [
    SimpleCov::Formatter::HTMLFormatter,
  ]
  SimpleCov.start do
    coverage_dir('coverage/')
    add_filter('/spec/')
  end
end

require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'
require 'rspec/mocks/standalone'

def project_path
  File.expand_path('../..', __FILE__)
end

def fixture(fixture_name, format = 'json')
  IO.binread(project_path + "/spec/fixtures/#{fixture_name}.#{format}")
end
