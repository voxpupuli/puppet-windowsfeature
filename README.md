puppet-windowsfeature
=====================

Library that uses ServerManager API that comes with Windows Server 2008 R2 and Windows Server 2012 to add/remove Windows features.

[![Build Status](https://travis-ci.org/opentable/puppet-windowsfeature.png?branch=master)](https://travis-ci.org/opentable/puppet-windowsfeature)

Usage
--
This module supports Windows Server 2008 R2 and newer due to using the ServerManager module that ships with PowerShell.  To use the module, use git clone to a directory in your modules folder on your puppetmaster. Then create a module manifest for the site you wish to maintain configuration for. Then you need to include this new module manifest in your nodes.pp file as follows:
    
    class my_windows_features {
      windowsfeature { 'Web-Asp-Net': }
      windowsfeature { 'Web-Net-Ext': }
      windowsfeature { 'Web-ISAPI-Ext': }
      windowsfeature { 'Web-ISAPI-Filter': }
      windowsfeature { 'Web-Mgmt-Tools': }
      windowsfeature { 'Web-Mgmt-Console': }
      windowsfeature { 'Telnet-Server': ensure => absent }
    }
    
    class my_other_windows_feature_implementation {
      windowsfeature{'IIS':
        feature_name => ['Web-Server',
          'Web-WebServer',
          'Web-Asp-Net45',
          'Web-ISAPI-Ext',
          'Web-ISAPI-Filter',
          'NET-Framework-45-ASPNET',
          'WAS-NET-Environment',
          'Web-Http-Redirect',
          'Web-Filtering',
          'Web-Mgmt-Console',
          'Web-Mgmt-Tools']
      }
    }
    
Then each place you want to use a module to manage windows features, then you just include it in your nodes.pp as follows:

    node 'mywebserver' {
    	include 'my_windows_features'
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

    class windows_feature_with_restart {
      windowsfeature {'RDS-RD-Server':
        restart => 'true',
    }

Known Issues
--
* Specifying installmanagementtools and/or installsubfeatures when a feature is already installed will not install said management tools or sub features.


Further Info
--
For a list of the windows features you can install, please visit this [technet article](http://technet.microsoft.com/en-us/library/cc732757.aspx)

    
