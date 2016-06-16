## 2016-06-16 - Release 2.0.0
### Summary
- modulesync with latest voxpupuli settings (#46, #51)
- Drop of Ruby1.8!
- Enhanced Unit/Acceptance tests (#47, #53)

### Features
- windowsfeature as native Type and Provider (#47)


## 2015-05-01 - Release 1.1.0
### Summary

  A few small features in this release. First release under the new puppet-community namespace

#### Features

- added new timeout `parameter` for features that take longer than the default 300 seconds to complete.
- added support for kernelversion 10 for people deploying on Windows 10

## 2014-10-13 - Release 1.0.0
### Summary

  Finally bumping to 1.0.

#### Features

- adding `source` paramater
- updating documentation

## 2014-08-14 - Release 0.2.0
### Summary

  Small release to bump stdlib dependency to be 4.0 minimum

## 2014-04-14 - Release 0.1.2
### Summary

  This release fixes some minor idempotency and platform specific bugs

#### Bugfixes

- fixing idempotency
- fixed installation on windows 2008

## 2014-04-04 - Release 0.1.1
### Summary

  This release adds support for windows 2012

## 2014-04-04 - Release 0.1.0
### Summary

  This release adding some new parameters to install sub features and management tools

#### Features

- added `includemanagementtools` and `includesubfeatures` parameters

#### Bugfixes

- limit module usage for Windows 2008 R2 and newer versions of Windows


## 2014-03-30 - Release 0.0.3

### Summary

This release replaces all the hardcoded powershell with uses of the joshcopper/powershell provider

## 2014-01-19 - Release 0.0.2
### Summary

Initial version.
