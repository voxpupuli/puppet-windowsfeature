# frozen_string_literal: true

require 'rexml/document'
include REXML

Puppet::Type.type(:windowsfeature).provide(:default) do
  # We don't support 1.8.7 officially, but lets be nice and not cause errors
  # rubocop:disable Style/HashSyntax

  # windows only
  confine :kernel => :windows
  confine :feature => :pwshlib

  # Pwsh::Manager.instance returns the same host for identical path/args, so the session is reused.
  def self.ps(code)
    debug = Puppet::Util::Log.level == :debug
    manager = Pwsh::Manager.instance(Pwsh::Manager.powershell_path, Pwsh::Manager.powershell_args, debug: debug)
    # 30 minutes: feature installs can outlast ruby-pwsh's 300s default timeout.
    result = manager.execute("$ErrorActionPreference='Stop'; #{code}", 30 * 60 * 1000)
    error = "PowerShell command failed (exit #{result[:exitcode]}): #{Array(result[:stderr]).join(' ')} #{result[:errormessage]}".strip
    raise Puppet::Error, error unless result[:exitcode].to_i.zero?

    result[:stdout]
  end

  def ps(code)
    self.class.ps(code)
  end

  def self.instances
    # an array to store feature hashes
    features = []
    result = ps(%($ProgressPreference='SilentlyContinue'; Import-Module ServerManager; Get-WindowsFeature | Select-Object -Property Name, Installed | ConvertTo-XML -As String -Depth 4 -NoTypeInformation))
    # create the XML document and parse the objects
    xml = Document.new result
    xml.root.each_element do |object|
      # get the name and install state of the windows feature
      name  = object.elements["Property[@Name='Name']"].text.downcase
      state = case object.elements["Property[@Name='Installed']"].text
              when 'False'
                :absent
              when 'True'
                :present
              end
      # put name and state into a hash
      feature_hash = {
        :ensure => state, :name => name,
      }
      # push hash to feature array
      features.push(feature_hash)
    end
    # map the feature array
    features.map do |feature|
      new(feature)
    end
  end

  def self.prefetch(resources)
    features = instances
    resources.each_key do |name|
      if provider = features.find { |feature| feature.name == name.downcase } # rubocop:disable Lint/AssignmentInCondition
        resources[name].provider = provider
      end
    end
  end

  def exists?
    @property_hash[:ensure] == :present
  end

  def create
    array = ["$ProgressPreference='SilentlyContinue'; Import-Module ServerManager; Install-WindowsFeature #{resource[:name]}"]
    # add restart, subfeatures and a source optionally
    array << '-IncludeAllSubFeature' if @resource[:installsubfeatures] == true
    if @resource[:restart] == true
      Puppet.deprecation_warning('The restart parameter has been deprecated in favor of the puppetlabs reboot module ( https://github.com/puppetlabs/puppetlabs-reboot ).  This parameter will be removed in the next release.')
      array << '-Restart'
    end
    array << "-Source #{resource[:source]}" unless @resource[:source].to_s.strip.empty?
    array << '-IncludeManagementTools' if @resource[:installmanagementtools] == true
    # show the created ps string, get the result, show the result (debug)
    Puppet.debug "Powershell create command is '#{array}'"
    result = ps(array.join(' '))
    Puppet.debug "Powershell create response was '#{result}'"
  end

  def destroy
    array = ["$ProgressPreference='SilentlyContinue'; Import-Module ServerManager; Uninstall-WindowsFeature #{resource[:name]}"]
    # add the restart flag optionally
    if @resource[:restart] == true
      Puppet.deprecation_warning('The restart parameter has been deprecated in favor of the puppetlabs reboot module ( https://github.com/puppetlabs/puppetlabs-reboot ).  This parameter will be removed in the next release.')
      array << '-Restart'
    end
    # show the created ps string, get the result, show the result (debug)
    Puppet.debug "Powershell destroy command is '#{array}'"
    result = ps(array.join(' '))
    Puppet.debug "Powershell destroy response was '#{result}'"
  end
end
