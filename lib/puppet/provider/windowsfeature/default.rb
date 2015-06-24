require 'json'
Puppet::Type.type(:windowsfeature).provide(:default) do
  
  commands :ps => 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe'
  confine :kernel => :windows

  def self.instances
    features = JSON.parse(ps('Get-WindowsFeature | ConvertTo-JSON'))
    features.collect do | feature |
      name = feature['Name'].downcase
      installed = feature['InstallState']
      if installed == 1
        currentstate = :present
      elsif installed == 0
        currentstate = :absent
      end
      new(:name => name, :ensure => currentstate)
    end
  end

  def self.prefetch(resources)
    features = instances
    resources.keys.each do | name |
      if provider = features.find{ |feature| feature.name == name.downcase }
        resources[name].provider = provider
      end
    end
  end

  def exists?
    @property_hash[:ensure] == :present
  end

  def create
    case Facter.value(:kernelmajversion)
      when /6.1/
        install_cmd = 'Import-Module ServerManager; Add-WindowsFeature'
        uninstall_cmd = 'Import-Module ServerManager; Remove-WindowsFeature'
      else
        install_cmd = 'Install-WindowsFeature'
        uninstall_cmd = 'Remove-WindowsFeature'
    end
    options = []
    uninstall_options = []
    if resource['installmanagementtools'] == true
      case Facter.value(:kernelmajversion)
        when /6.1/
          raise Puppet::Error.new('installmanagementtools can only be used with Windows 2012 and above')
        when /6.2|6.3|10/
        options.push('-IncludeManagementTools')
      end 
   end
    if resource['installsubfeatures'] == true
      options.push('-IncludeAllSubFeature')
    end
    if resource['restart'] == true
      options.push('-Restart')
      uninstall_options.push('-Restart')
    end
    if resource['source']
      options.push("-Source #{resource['source']}")
    end
    psopts = options.join(' ')
#    Puppet.debug("Install-WindowsFeature #{resource['name']} #{options.join(' ')}")
    ps(install_cmd,resource['name'],psopts)
  end

  def destroy
    psopts = uninstall_options.join(' ')
    ps(uninstall_cmd,resource['name'],psopts)
  end
end
