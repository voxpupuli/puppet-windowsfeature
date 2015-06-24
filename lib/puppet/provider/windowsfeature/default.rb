require 'json'
Puppet::Type.type(:windowsfeature).provide(:default) do
  # We don't support 1.8.7 officially, but lets be nice and not cause errors
  # rubocop:disable Style/HashSyntax

  commands :ps =>
    if File.exist?("#{ENV['SYSTEMROOT']}\\sysnative\\WindowsPowershell\\v1.0\\powershell.exe")
      "#{ENV['SYSTEMROOT']}\\sysnative\\WindowsPowershell\\v1.0\\powershell.exe"
    elsif File.exist?("#{ENV['SYSTEMROOT']}\\system32\\WindowsPowershell\\v1.0\\powershell.exe")
      "#{ENV['SYSTEMROOT']}\\system32\\WindowsPowershell\\v1.0\\powershell.exe"
    else
      'powershell.exe'
    end

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
    install_cmd = case Facter.value(:kernelmajversion)
                  when /6.1/
                    'Import-Module ServerManager; Add-WindowsFeature'
                  else
                    'Install-WindowsFeature'
                  end

    # Options currently not used, timeout should be added in the future
    options = []

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
    end
    unless resource['source'].nil?
      options.push("-Source #{resource['source']}")
    end

    if options.empty?
      ps(install_cmd,resource['name'])
    else
      psopts = options.join(' ')
      ps(install_cmd,resource['name'],psopts)
    end
  end

  def destroy
    case Facter.value(:kernelmajversion)
    when /6.1/
      uninstall_cmd = 'Import-Module ServerManager; Remove-WindowsFeature'
    else
      uninstall_cmd = 'Remove-WindowsFeature'
    end

    uninstall_options = []

    if resource['restart'] == true
      uninstall_options.push('-Restart')
    end

    if uninstall_options.empty?
      ps(uninstall_cmd,resource['name'])
    else
      psopts = uninstall_options.join(' ')
      ps(uninstall_cmd, resource['name'], psopts)
    end
  end
end
