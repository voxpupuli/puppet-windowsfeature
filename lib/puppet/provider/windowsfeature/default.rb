require 'rexml/document'
include REXML
Puppet::Type.type(:windowsfeature).provide(:default) do
  # We don't support 1.8.7 officially, but lets be nice and not cause errors
  # rubocop:disable Style/HashSyntax

  # windows only
  confine :kernel => :windows
  # powershell, powershell, powershell.  where to find it.
  commands :ps =>
    if File.exist?("#{ENV['SYSTEMROOT']}\\sysnative\\WindowsPowershell\\v1.0\\powershell.exe")
      "#{ENV['SYSTEMROOT']}\\sysnative\\WindowsPowershell\\v1.0\\powershell.exe"
    elsif File.exist?("#{ENV['SYSTEMROOT']}\\system32\\WindowsPowershell\\v1.0\\powershell.exe")
      "#{ENV['SYSTEMROOT']}\\system32\\WindowsPowershell\\v1.0\\powershell.exe"
    else
      'powershell.exe'
    end

  def self.instances
    # an array to store feature hashes
    features = []
    # set windows 2008 to true/False
    win2008 = Facter.value(:kernelmajversion) == '6.1'
    # if win2008 import ServerManager module
    result = if win2008 == true
               ps('Import-Module ServerManager; Get-WindowsFeature | ConvertTo-XML -As String -Depth 4 -NoTypeInformation')
             else
               ps('Get-WindowsFeature | ConvertTo-XML -As String -Depth 4 -NoTypeInformation')
             end
    # create the XML document and parse the objects
    xml = Document.new result
    xml.root.each_element do |object|
      # get the name and install state of the windows feature
      name  = object.elements["Property[@Name='Name']"].text.downcase
      state = if object.elements["Property[@Name='Installed']"].text == 'False'
                :absent
              elsif object.elements["Property[@Name='Installed']"].text == 'True'
                :present
              end
      # put name and state into a hash
      feature_hash = {
        :ensure => state, :name => name
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
    resources.keys.each do |name|
      if provider = features.find { |feature| feature.name == name.downcase } # rubocop:disable Lint/AssignmentInCondition
        resources[name].provider = provider
      end
    end
  end

  def exists?
    @property_hash[:ensure] == :present
  end

  def create
    # an array called array
    array = []
    # if it is windows 2008 let's just call it that
    win2008 = Facter.value(:kernelmajversion) == '6.1'
    # set the install line
    array << "Import-Module ServerManager; Add-WindowsFeature #{resource[:name]}" if win2008 == true
    array << "Install-WindowsFeature #{resource[:name]}" if win2008 == false
    # add restart, subfeatures and a source optionally
    array << '-IncludeAllSubFeature' if @resource[:installsubfeatures] == true
    array << '-Restart' if @resource[:restart] == true
    array << "-Source #{resource[:source]}" unless @resource[:source].to_s.strip.empty?
    # raise an error if 2008 tried to install mgmt tools
    if @resource[:installmanagementtools] == true && win2008 == true
      raise Puppet::Error, 'installmanagementtools can only be used with Windows 2012 and above'
    end
    # install management tools
    array << '-IncludeManagementTools' if @resource[:installmanagementtools] == true && win2008 == false
    # show the created ps string, get the result, show the result (debug)
    Puppet.debug "Powershell create command is '#{array}'"
    result = ps(array.join(' '))
    Puppet.debug "Powershell create response was '#{result}'"
  end

  def destroy
    # an array called array
    array = []
    # if it is windows 2008 let's just call it that
    win2008 = Facter.value(:kernelmajversion) == '6.1'
    # set the uninstall line
    array << "Import-Module ServerManager; Remove-WindowsFeature #{resource[:name]}" if win2008 == true
    array << "Uninstall-WindowsFeature #{resource[:name]}" if win2008 == false
    # add the restart flag optionally
    array << '-Restart' if @resource[:restart] == true
    # show the created ps string, get the result, show the result (debug)
    Puppet.debug "Powershell destroy command is '#{array}'"
    result = ps(array.join(' '))
    Puppet.debug "Powershell destroy response was '#{result}'"
  end
end
