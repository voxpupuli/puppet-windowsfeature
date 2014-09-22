require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'
require 'winrm'

hosts.each do |host|
  case host['platform']
    when /windows/

      include Serverspec::Helper::Windows
      include Serverspec::Helper::WinRM

      version = ENV['PUPPET_VERSION'] || '3.4.3'

      install_puppet(:version => version)

    else
      # TODO: This function needs some work in beaker because it doesn't work when specifying the version
      install_puppet
  end
end

UNSUPPORTED_PLATFORMS = ['Suse','AIX','Solaris']

RSpec.configure do |c|
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.formatter = :documentation

  c.before :suite do

    #The gets around a bug where windows can't validate the cert when using https
    forge_repo = '--module_repository=http://forge.puppetlabs.com'

    hosts.each do |host|

      c.host = host

      if host['platform'] =~ /windows/
        endpoint = "http://127.0.0.1:5985/wsman"
        c.winrm = ::WinRM::WinRMWebService.new(endpoint, :ssl, :user => 'vagrant', :pass => 'vagrant', :basic_auth_only => true)
        c.winrm.set_timeout 300
      end

      copy_module_to(host, :source => proj_root, :module_name => 'windowsfeature')
      
      on host, puppet('module','install', forge_repo, 'puppetlabs-stdlib'), { :acceptable_exit_codes => [0,1] }
      on host, puppet('module','install', forge_repo, 'joshcooper-powershell'), { :acceptable_exit_codes => [0,1] }
    end
  end
end
