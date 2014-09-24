source ENV['GEM_SOURCE'] || "https://rubygems.org"

group :development, :test do
  gem 'rake',                                                                    :require => false
  gem 'puppet-lint',                                                             :require => false
  gem 'rspec-puppet',
    :git => 'https://github.com/rodjek/rspec-puppet.git',
    :ref => '',
    :require => false
  gem 'puppet-syntax',                                                           :require => false
  gem 'puppetlabs_spec_helper',                                                  :require => false
  gem 'rspec',                                                                   :require => false
  gem 'beaker',                                                                  :require => false
  gem 'beaker-rspec',                                                            :require => false
  gem 'serverspec',                                                              :require => false
  gem 'specinfra',                                                               :require => false
  gem 'winrm',                                                                   :require => false
  gem 'travis',                                                                  :require => false
  gem 'travis-lint',                                                             :require => false
  gem 'vagrant-wrapper',                                                         :require => false
  gem 'puppet-blacksmith',                                                       :require => false
  gem 'guard-rake',                                                              :require => false
end

if facterversion = ENV['FACTER_GEM_VERSION']
  gem 'facter', facterversion, :require => false
else
  gem 'facter', :require => false
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end

# vim:ft=ruby
