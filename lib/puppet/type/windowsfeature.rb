Puppet::Type.newtype(:windowsfeature) do

  ensurable

  newparam(:name) do
    isnamevar
  end

  newparam(:installmanagementtools) do
    validate do | value |
      if !(value == true or value == false)
        raise Puppet::Error.new('Parameter installmanagementtools must be true or false')
      end
    end
  end

  newparam(:installsubfeatures) do
    # validate is bool
    validate do | value |
      if !(value == true or value == false)
        raise Puppet::Error.new('Parameter installmanagementtools must be true or false')
      end
    end
  end

  newparam(:restart) do
    validate do | value |
      if !(value == true or value  == false)
        raise Puppet::Error.new('Parameter installmanagementtools must be true or false')
      end
    end
  end

  newparam(:source) do
    # validate is tring or false
    validate do | value |
      if !(value.is_a?(String))
        raise Puppet::Error.new('Parameter source is not a string.')
      end
    end
  end

  newparam(:timeout) do
  end
end
