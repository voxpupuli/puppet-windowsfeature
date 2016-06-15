Puppet::Type.newtype(:windowsfeature) do
  ensurable

  newparam(:name) do
    isnamevar
  end

  newparam(:installmanagementtools) do
    validate do |value|
      unless value == true || value == false
        raise Puppet::Error, 'Parameter installmanagementtools must be true or false'
      end
    end
  end

  newparam(:installsubfeatures) do
    # validate is bool
    validate do |value|
      unless value == true || value == false
        raise Puppet::Error, 'Parameter installsubfeatures must be true or false'
      end
    end
  end

  newparam(:restart) do
    validate do |value|
      unless value == true || value == false
        raise Puppet::Error, 'Parameter restart must be true or false'
      end
    end
  end

  newparam(:source) do
    # validate is tring or false
    validate do |value|
      unless value.is_a?(String)
        raise Puppet::Error, 'Parameter source is not a string.'
      end
    end
  end
end
