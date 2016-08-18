require 'rexml/document'
include REXML
Puppet::Type.type(:windowsfeature).provide(:default) do
  # We don't support 1.8.7 officially, but lets be nice and not cause errors
  # rubocop:disable Style/HashSyntax

  confine :kernel => :windows

  commands :ps =>
    if File.exist?("#{ENV['SYSTEMROOT']}\\sysnative\\WindowsPowershell\\v1.0\\powershell.exe")
      "#{ENV['SYSTEMROOT']}\\sysnative\\WindowsPowershell\\v1.0\\powershell.exe"
    elsif File.exist?("#{ENV['SYSTEMROOT']}\\system32\\WindowsPowershell\\v1.0\\powershell.exe")
      "#{ENV['SYSTEMROOT']}\\system32\\WindowsPowershell\\v1.0\\powershell.exe"
    else
      'powershell.exe'
    end
  
  def initialize(value={})
    super(value)
    @property_flush = {}
    @install   = 'Install-WindowsFeature'
  end

  def self.instances
    features = []
    result = if Facter.value(:kernelmajversion) == '6.1'
      ps('Import-Module ServerManager; Get-WindowsFeature | ConvertTo-XML -As String -Depth 4 -NoTypeInformation')
    else
      ps('Get-WindowsFeature | ConvertTo-XML -As String -Depth 4 -NoTypeInformation')
    end
    xml = Document.new result
    xml.root.each_element do |object|
      name   = object.elements["Property[@Name='Name']"].text.downcase
      state  = if object.elements["Property[@Name='Installed']"].text == 'False'
                 :absent
               elsif object.elements["Property[@Name='Installed']"].text == 'True'
                 :present
               end
      feature_hash = {
        :name => name, :ensure => state,
      }
      features.push(feature_hash)
    end
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
    array = []
    if Facter.value(:kernelmajversion) == '6.1'
      array << "Import-Module ServerManager; Add-WindowsFeature #{resource[:name]}"
    else
      array << "Install-WindowsFeature #{resource[:name]}"
    end
    array << '-InstallSubFeatures' if @property_flush[:installsubfeatures]
    array << '-Restart' if @property_flush[:restart]
    array << "-Source #{resource['source']}" if @property_flush[:source]
    errormsg = 'installmanagementtools can only be used with Windows 2012 and above'
    if Facter.value(:kernelmajversion) == '6.1'
      raise Puppet::Error, errormsg if @property_flush[:installmanagementtools]
    else
      array << '-InstallManagementTools' if @property_flush[:installmanagementtools]
    end
  ps(array)
  end

  def destroy
    array = []
    if Facter.value(:kernelmajversion) == '6.1'
      array << "Import-Module ServerManager; Remove-WindowsFeature #{resource[:name]}"
    else
      array << "Uninstall-WindowsFeature #resource[:name]"
    end
    array << '-Restart' if @property_flush[:restart]
    ps(array)
  end

end
