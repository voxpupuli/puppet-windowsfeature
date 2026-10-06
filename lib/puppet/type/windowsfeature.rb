# frozen_string_literal: true

require 'puppet/parameter/boolean'

Puppet::Type.newtype(:windowsfeature) do
  desc 'Manages Windows Server roles and features through the ServerManager module.'

  ensurable do
    desc 'Whether the feature should be installed (`present`) or removed (`absent`).'
    defaultvalues
    defaultto :present
  end

  newparam(:name) do
    desc 'The name of the feature to manage.'
    isnamevar
  end

  newparam(:installmanagementtools, boolean: true, parent: Puppet::Parameter::Boolean) do
    desc 'Whether to install all applicable management tools for the feature.'
  end

  newparam(:installsubfeatures, boolean: true, parent: Puppet::Parameter::Boolean) do
    desc 'Whether to install all subordinate role services and subfeatures of the feature.'
  end

  newparam(:restart, boolean: true, parent: Puppet::Parameter::Boolean) do
    desc 'Whether to restart the system automatically if the installation requires it. Deprecated in favor of the reboot module.'
  end

  newparam(:source) do
    desc 'The location of an installation source, which must match the exact Windows version.'
    # validate is String
    validate do |value|
      raise Puppet::Error, 'Parameter source is not a string.' unless value.is_a?(String)
    end
  end
end
