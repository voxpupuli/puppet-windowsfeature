# puppet-windowsfeature

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with windowsfeature](#setup)
    * [What windowsfeature affects](#what-windowsfeature-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with windowfeature](#beginning-with-windowsfeature)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

The windowsfeature module is a small define that allows you to install/remove windows features.

[![Build Status](https://travis-ci.org/puppet-community/puppet-windowsfeature.png?branch=master)](https://travis-ci.org/puppet-community/puppet-windowsfeature)

##Module Description

The windowsfeature module introduces a small define `windowsfeature` that uses the ServerManager API that comes with Windows Server 2008 R2 and
Windows Server 2012 to add/remove Windows features.

For a list of the windows features you can install, please visit this [technet article](http://technet.microsoft.com/en-us/library/cc732757.aspx)

##Setup
###What download_file affects
* Installs windows features (and optionally corresponding tools)

###Setup Requirements
* windowsfeature makes use of Powershell so you will need to have at least version 2.0 installed in order to use this module.

##Begining

To install a single windows feature such as dotnet 3.5:

    windowsfeature { 'NET-Framework-Core': }

To install several windows features as part of a large application such IIS:

    windowsfeature { 'IIS':
      feature_name => [
        'Web-Server',
        'Web-WebServer',
        'Web-Asp-Net45',
        'Web-ISAPI-Ext',
        'Web-ISAPI-Filter',
        'NET-Framework-45-ASPNET',
        'WAS-NET-Environment',
        'Web-Http-Redirect',
        'Web-Filtering',
        'Web-Mgmt-Console',
        'Web-Mgmt-Tools'
      ]
    }

To install any associated management tools:

    windowsfeature { 'Web-WebServer':
      installmanagementtools => true
    }

To install all subfeatures:

    windowsfeature { 'Web-WebServer':
      installsubfeatures => true
    }

To install a feature and that requires a restart:

    windowsfeature {'RDS-RD-Server':
      restart => 'true'
    }


##Usage

###Classes and Defined Types

####Defined Type: `windowsfeature`

**Parameters within `windowsfeature`:**
#####`ensure`
Controls if the Windows feature is installed. Can be `present` or `absent`.

#####`feature_name`
Provides the name of the feature that you want to install if this differs from the resource title.

#####`installmanagementtools`
Specifies that all applicable management tools should be installed for the given feature. Defaults to `false`

#####`installsubfeatures`
Specifies that all subordinate features of this feature are also installed. Defaults to `false`

#####`restart`
Specifies that when installing the windows feature it should perform and restart automatically.

#####`source`
Specifies the location of the feature files. This may be a network location or a path to the specific wim file.

#####`timeout`
Specifies the timeout in seconds for the feature installation. Use this if the feature takes longer than 300 seconds to complete.

##Reference


###Defined Types
####Public Types
* [`windowsfeature`](#defined-windowsfeature): Install or remove a given windows feature

##Limitations

This module is tested on the following platforms:

* Windows 2008
* Windows 2008 R2
* Windows 2012
* Windows 2012 R2

It is tested with the OSS version of Puppet only.

###Known issues
* Specifying installmanagementtools and/or installsubfeatures when a feature is already installed will not install said management tools or sub features.

###Contributing

Please read CONTRIBUTING.md for full details on contributing to this project.
