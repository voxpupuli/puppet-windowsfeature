# puppet-windowsfeature

#### Table of Contents

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

## Overview

The windowsfeature module is a small define that allows you to install/remove windows features.

[![Build Status](https://travis-ci.org/voxpupuli/puppet-windowsfeature.svg?branch=master)](https://travis-ci.org/voxpupuli/puppet-windowsfeature)

## Module Description

The windowsfeature module introduces a new `windowsfeature` type uses the ServerManager API that comes with Windows Server 2008 R2 onward to add/remove Windows features.

For a list of the windows features you can install, please visit this [technet article](http://technet.microsoft.com/en-us/library/cc732757.aspx)

## Setup

### What windowsfeature affects

* Installs windows features (and optionally corresponding tools)

### Setup Requirements

* windowsfeature makes use of Powershell so you will need to have at least version 2.0 installed in order to use this module.

## Beginning

To install a single windows feature such as dotnet 3.5:

    windowsfeature { 'NET-Framework-Core':
      ensure => present,
    }

To install several windows features as part of a large application such IIS:


    $iis_features = ['Web-Server','Web-WebServer','Web-Asp-Net45','Web-ISAPI-Ext','Web-ISAPI-Filter','NET-Framework-45-ASPNET','WAS-NET-Environment','Web-Http-Redirect','Web-Filtering','Web-Mgmt-Console','Web-Mgmt-Tools']

    windowsfeature { $iis_features:
      ensure => present,
    }

To install any associated management tools:

    windowsfeature { 'Web-WebServer':
      ensure => present,
      installmanagementtools => true
    }

To install all subfeatures:

    windowsfeature { 'Web-WebServer':
      ensure             => present,
      installsubfeatures => true
    }

To install a feature and that requires a restart:

    windowsfeature {'RDS-RD-Server':
      ensure             => present,
      restart => 'true'
    }

## Usage

### Classes and Defined Types

##Reference

### Types

* `windowsfeature`: Installs a Windows Feature

###Parameters

####Type: windowsfeature

#####`ensure`
Specifies the basic state of the resource. Valid values are 'present', 'absent'.

#####`name`
*Required* This name of the feature you want to manage

#####`installmanagementtools`
*Optional* Specifies that all applicable management tools of the roles, role services, or features specified by the Name parameter should be installed. Note: Although management tools are installed by default when you are installing features by using the , management tools are not installed by default when you install features by using the Install-WindowsFeature cmdlet; this parameter must be added to install management tools.

#####`installsubfeatures`
*Optional* Specifies that all subordinate role services, and all subfeatures of parent roles, role services, or features specified by the Name parameter should be installed.

#####`restart`
*Optional* Specifies that the target system is restarted automatically, if a restart is required by the installation process for the specified roles or features.

#####`source`
*Optional* Specify the location of an installation source. The source must be from the exact same version of Windows for the reinstallation to work. Without this parameter, PowerShell will use Windows Update by default to look for an installation source

##Upgrading from 1.0.1 Release

Previously, the windows features were managed by individual execs:

```puppet
exec { "add-feature-${title}":
  command  => "Import-Module ServerManager; ${command} ${features} ${_installmanagementtools} ${_installsubfeatures} ${_installsource} -Restart:$${_restart}",
  onlyif   => "Import-Module ServerManager; if (@(Get-WindowsFeature ${features} | ?{\$_.Installed -match \'false\'}).count -eq 0) { exit 1 }",
  provider => powershell,
  timeout  => $timeout,
}
```

This lead to long execution times when managing a large amount of features, even after features were installed, as the Powershell would have to run the onlyif command for every check.

The new 2.0.0 release uses native types and providers, which speeds up the time as it can just compare the resources on the machine with the results from Get-WindowsFeature.

For example, enabling all the Windows features for a standard IIS setuo after features are installed (ie. an idempotent run):

1.0.0 release:
```
win-2012R2-std 01:29:30$ puppet apply --verbose --detailed-exitcodes C:\Windows\Temp\apply_manifest.pp.8276
  Info: Loading facts
  Notice: Compiled catalog for win-2012r2-std.home in environment production in 0.44 seconds
  Info: Applying configuration version '1464136176'
  Notice: Finished catalog run in 15.30 seconds
```

```
win-2012R2-std 01:29:30$ puppet apply --verbose --detailed-exitcodes C:\Windows\Temp\apply_manifest.pp.8276
  Info: Loading facts
  Notice: Compiled catalog for win-2012r2-std.home in environment production in 0.44 seconds
  Info: Applying configuration version '1464136176'
  Notice: Finished catalog run in 3.34 seconds
```

So that's a third of the original runs time! And this would only increase with larger amounts of features, as the more features to check, the longer it would take.

Another benefit is this module now has less dependancies on other modules, as it's all native to the module now.

## Limitations

This module is tested on the following platforms:

* Windows 2008
* Windows 2008 R2
* Windows 2012
* Windows 2012 R2

It is tested with the OSS version of Puppet only.

### Known issues

* Specifying installmanagementtools and/or installsubfeatures when a feature is already installed will not install said management tools or sub features.

### Contributing

Please read CONTRIBUTING.md for full details on contributing to this project.
