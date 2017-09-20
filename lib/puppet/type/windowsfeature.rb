require 'puppet/parameter/boolean'

Puppet::Type.newtype(:windowsfeature) do
  ensurable do
    defaultvalues
    defaultto :present
  end

  newparam(:name) do
    isnamevar
  end

  newparam(:installmanagementtools, boolean: true, parent: Puppet::Parameter::Boolean) do
  end

  newparam(:installsubfeatures, boolean: true, parent: Puppet::Parameter::Boolean) do
  end

  newparam(:restart, boolean: true, parent: Puppet::Parameter::Boolean) do
    Puppet.deprecation_warning('The restart parameter has been deprecated in favor of the puppetlabs reboot module ( https://github.com/puppetlabs/puppetlabs-reboot ).  This parameter will be removed in the next release.')
  end

  newparam(:source) do
    # validate is String
    validate do |value|
      unless value.is_a?(String)
        raise Puppet::Error, 'Parameter source is not a string.'
      end
    end
  end
end
