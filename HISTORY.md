# Changelog

## v2.1.0 (2017-02-11)

This is the last release with Puppet3 support!
* Switched everything over to XML and updated tests.
* some fixes from getting rid of trying flush
* Converted from CSV to XML - Resolved merge conflict
* Set minimum version_requirement for Puppet

## v2.0.2 (2016-08-18)
### Summary

  Switched from CSV to XML

## v2.0.1 (2016-07-13)
### Summary

  A bug fix to support Windows 2008

### Features
- moved from PowerShell JSON conversion to CSV for Windows 2008 support (#57)

## v2.0.0 (2016-06-16)
### Summary
- modulesync with latest voxpupuli settings (#46, #51)
- Drop of Ruby1.8!
- Enhanced Unit/Acceptance tests (#47, #53)

#### Features
- windowsfeature as native Type and Provider (#47)


## v1.1.0 (2015-05-01)
### Summary

  A few small features in this release. First release under the new puppet-community namespace

#### Features

- added new timeout `parameter` for features that take longer than the default 300 seconds to complete.
- added support for kernelversion 10 for people deploying on Windows 10

## v1.0.0 (2014-10-13)
### Summary

  Finally bumping to 1.0.

#### Features

- adding `source` paramater
- updating documentation

## v0.2.0 (2014-08-14)
### Summary

  Small release to bump stdlib dependency to be 4.0 minimum

## v0.1.2 (2014-04-14)
### Summary

  This release fixes some minor idempotency and platform specific bugs

#### Bugfixes

- fixing idempotency
- fixed installation on windows 2008

## v0.1.1 (2014-04-04)
### Summary

  This release adds support for windows 2012

## v0.1.0 (2014-04-04)
### Summary

  This release adding some new parameters to install sub features and management tools

#### Features

- added `includemanagementtools` and `includesubfeatures` parameters

#### Bugfixes

- limit module usage for Windows 2008 R2 and newer versions of Windows


## v0.0.3 (2014-03-30)

### Summary

This release replaces all the hardcoded powershell with uses of the joshcopper/powershell provider

## v0.0.2 (2014-01-19)
### Summary

Initial version.
