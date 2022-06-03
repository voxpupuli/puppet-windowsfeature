# frozen_string_literal: true

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
  end

  newparam(:source) do
    # validate is String
    validate do |value|
      raise Puppet::Error, 'Parameter source is not a string.' unless value.is_a?(String)
    end
  end
end
