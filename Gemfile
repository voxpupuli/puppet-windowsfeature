#  Copyright 2014 Puppet Community
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

source "https://rubygems.org"

group :test do
  gem "rake"
  gem "puppet", ENV['PUPPET_VERSION'] || '~> 3.7.0'
  gem "rspec-puppet", :git => 'https://github.com/rodjek/rspec-puppet.git'
  gem "puppetlabs_spec_helper"
  gem "metadata-json-lint"
  gem "rspec-puppet-facts"
  gem "rspec", "< 3.2.0", { "platforms" => ["ruby_18"] }
end

group :development do
  gem "travis"
  gem "travis-lint"
  gem "puppet-blacksmith"
  gem "guard-rake"
end

group :system_tests do
  gem 'winrm'
  gem "beaker",
    :git => 'https://github.com/petems/beaker-windows.git',
    :ref => '38227e3bec946dbd52ac4aece8d28af360a33cc4'
  gem "beaker-rspec",
    :git => 'https://github.com/petems/beaker-rspec-windows.git',
    :ref => 'd96cff5fc937efe1dca03c6ea3c236bf4c7337ab'
  gem 'vagrant-wrapper'
end
