puppet-windowsfeature
=====================

Library that uses ServerManager api that comes with Windows Server 2008 and Windows Server 2012 to add / remove windows features

[![Build Status](https://travis-ci.org/opentable/puppet-windowsfeature.png?branch=master)](https://travis-ci.org/opentable/puppet-windowsfeature)

Usage
--
This module is only available to Windows Server 2008 and above due to using the ServerManager module that ships with PowerShell.  To use the module, use git clone to a directory in your modules folder on your puppetmaster. Then create a module manifest for the site you wish to maintain configuration for. Then you need to include this new module manifest in your nodes.pp file as follows:
    
    class my_windows_features {
     windowsfeature { 'Web-Asp-Net': }
     windowsfeature { 'Web-Net-Ext': }
     windowsfeature { 'Web-ISAPI-Ext': }
     windowsfeature { 'Web-ISAPI-Filter': }
     windowsfeature { 'Web-Mgmt-Tools': }
     windowsfeature { 'Web-Mgmt-Console': }
     windowsfeature { 'telnet':
     	ensure => absent,
     }
    }
    
Then each place you want to use a module to manage windows features, then you just include it in your nodes.pp as follows:

    node 'mywebserver' {
    	include 'my_windows_features'
    }

Further Info
--
For a list of the windows features you can install, please visit this [technet article](http://technet.microsoft.com/en-us/library/cc732757.aspx)
    
    
