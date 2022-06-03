# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v4.0.0](https://github.com/voxpupuli/puppet-windowsfeature/tree/v4.0.0) (2022-06-03)

[Full Changelog](https://github.com/voxpupuli/puppet-windowsfeature/compare/v3.2.2...v4.0.0)

**Breaking changes:**

- modulesync 5.3.0; Drop Puppet 5 support [\#147](https://github.com/voxpupuli/puppet-windowsfeature/pull/147) ([bastelfreak](https://github.com/bastelfreak))
- modulesync 2.7.0 and drop puppet 4 [\#131](https://github.com/voxpupuli/puppet-windowsfeature/pull/131) ([bastelfreak](https://github.com/bastelfreak))

**Implemented enhancements:**

- Puppet 7 support [\#143](https://github.com/voxpupuli/puppet-windowsfeature/issues/143)

**Fixed bugs:**

- Ignore powershell progress screens [\#136](https://github.com/voxpupuli/puppet-windowsfeature/pull/136) ([trevor-vaughan](https://github.com/trevor-vaughan))

**Closed issues:**

- Error: Could not prefetch windowsfeature provider 'default':  returned 1 [\#146](https://github.com/voxpupuli/puppet-windowsfeature/issues/146)
- Errors during feature install on Windows 2019 [\#138](https://github.com/voxpupuli/puppet-windowsfeature/issues/138)

**Merged pull requests:**

- Dependency and Support Bump [\#148](https://github.com/voxpupuli/puppet-windowsfeature/pull/148) ([trevor-vaughan](https://github.com/trevor-vaughan))
- \(GH-143\) Add puppet 7 support [\#145](https://github.com/voxpupuli/puppet-windowsfeature/pull/145) ([TraGicCode](https://github.com/TraGicCode))
- Ignore PowerShell progress bar [\#139](https://github.com/voxpupuli/puppet-windowsfeature/pull/139) ([AndyAdrian-OP](https://github.com/AndyAdrian-OP))
- Remove duplicate CONTRIBUTING.md file [\#133](https://github.com/voxpupuli/puppet-windowsfeature/pull/133) ([dhoppe](https://github.com/dhoppe))
- Remove Linux acceptance nodesets [\#128](https://github.com/voxpupuli/puppet-windowsfeature/pull/128) ([ekohl](https://github.com/ekohl))

## [v3.2.2](https://github.com/voxpupuli/puppet-windowsfeature/tree/v3.2.2) (2018-10-19)

[Full Changelog](https://github.com/voxpupuli/puppet-windowsfeature/compare/v3.2.1...v3.2.2)

**Fixed bugs:**

- Targeted Deprecation Notice of Restart parameter \(\#120\) [\#122](https://github.com/voxpupuli/puppet-windowsfeature/pull/122) ([fiveshotsofespresso](https://github.com/fiveshotsofespresso))

**Closed issues:**

- The restart parameter has been deprecated in favor of the puppetlabs reboot module ( https://github.com/puppetlabs/puppetlabs-reboot ). This parameter will be removed in the next release.  (location: C:/ProgramData/PuppetLabs/puppet/cache/lib/puppet/type/windowsfeature.rb:20:in `block \(2 levels\) in \<top \(required\)\>'\) shows every run [\#120](https://github.com/voxpupuli/puppet-windowsfeature/issues/120)

## [v3.2.1](https://github.com/voxpupuli/puppet-windowsfeature/tree/v3.2.1) (2018-09-07)

[Full Changelog](https://github.com/voxpupuli/puppet-windowsfeature/compare/v3.2.0...v3.2.1)

**Merged pull requests:**

- Remove docker nodesets [\#119](https://github.com/voxpupuli/puppet-windowsfeature/pull/119) ([bastelfreak](https://github.com/bastelfreak))
- drop EOL OSs; fix puppet version range [\#118](https://github.com/voxpupuli/puppet-windowsfeature/pull/118) ([bastelfreak](https://github.com/bastelfreak))

## [v3.2.0](https://github.com/voxpupuli/puppet-windowsfeature/tree/v3.2.0) (2018-02-13)

[Full Changelog](https://github.com/voxpupuli/puppet-windowsfeature/compare/v3.1.0...v3.2.0)

**Implemented enhancements:**

- Add support and code for windows 2008 non-r2 [\#104](https://github.com/voxpupuli/puppet-windowsfeature/issues/104)

**Fixed bugs:**

- add Import-Module ServerManager for win2012r2 PS commands [\#110](https://github.com/voxpupuli/puppet-windowsfeature/pull/110) ([devcfgc](https://github.com/devcfgc))

**Closed issues:**

- Windowsfeature gives Corrective change every time [\#111](https://github.com/voxpupuli/puppet-windowsfeature/issues/111)
- UTF8 error with french windows 2012 [\#109](https://github.com/voxpupuli/puppet-windowsfeature/issues/109)
- Missing release [\#107](https://github.com/voxpupuli/puppet-windowsfeature/issues/107)

**Merged pull requests:**

- release 3.2.0 [\#115](https://github.com/voxpupuli/puppet-windowsfeature/pull/115) ([bastelfreak](https://github.com/bastelfreak))
- Resolve UTF8 problem with PowerShell output [\#112](https://github.com/voxpupuli/puppet-windowsfeature/pull/112) ([ahotton](https://github.com/ahotton))

## [v3.1.0](https://github.com/voxpupuli/puppet-windowsfeature/tree/v3.1.0) (2017-09-22)

[Full Changelog](https://github.com/voxpupuli/puppet-windowsfeature/compare/v3.0.0...v3.1.0)

**Closed issues:**

- Updated Documentation wording + Documentation + Badges [\#96](https://github.com/voxpupuli/puppet-windowsfeature/issues/96)
- Does not work on Windows 2008 [\#39](https://github.com/voxpupuli/puppet-windowsfeature/issues/39)

**Merged pull requests:**

- 3.1.0 release [\#105](https://github.com/voxpupuli/puppet-windowsfeature/pull/105) ([TraGicCode](https://github.com/TraGicCode))
- Remove Windows 2008 Support and Add Windows 2016 Support [\#103](https://github.com/voxpupuli/puppet-windowsfeature/pull/103) ([TraGicCode](https://github.com/TraGicCode))
- Deprecation notice for the restart parameter [\#102](https://github.com/voxpupuli/puppet-windowsfeature/pull/102) ([TraGicCode](https://github.com/TraGicCode))
- Fixing readme markdown formatting issues [\#99](https://github.com/voxpupuli/puppet-windowsfeature/pull/99) ([TraGicCode](https://github.com/TraGicCode))

## [v3.0.0](https://github.com/voxpupuli/puppet-windowsfeature/tree/v3.0.0) (2017-09-18)

[Full Changelog](https://github.com/voxpupuli/puppet-windowsfeature/compare/v2.1.0...v3.0.0)

**Fixed bugs:**

- Invalid XML being returned on Windows 2008 R2 for get-windowsfeature [\#86](https://github.com/voxpupuli/puppet-windowsfeature/issues/86)
- Source parameter throwing an error [\#80](https://github.com/voxpupuli/puppet-windowsfeature/issues/80)

**Merged pull requests:**

- Release 3.0.0 [\#95](https://github.com/voxpupuli/puppet-windowsfeature/pull/95) ([TraGicCode](https://github.com/TraGicCode))
- Refactor Hacky boolean validation [\#93](https://github.com/voxpupuli/puppet-windowsfeature/pull/93) ([TraGicCode](https://github.com/TraGicCode))
- In a windows only module we don't want non-windows nodesets [\#92](https://github.com/voxpupuli/puppet-windowsfeature/pull/92) ([TraGicCode](https://github.com/TraGicCode))
- \(GH-86\) Fix invalid XML from Get-WindowsFeature [\#88](https://github.com/voxpupuli/puppet-windowsfeature/pull/88) ([jarretlavallee](https://github.com/jarretlavallee))
- \(GH-85\) Fix typo in provider for source parameter [\#85](https://github.com/voxpupuli/puppet-windowsfeature/pull/85) ([glennsarti](https://github.com/glennsarti))
- Fixed source parameter in provider create [\#81](https://github.com/voxpupuli/puppet-windowsfeature/pull/81) ([cargiris](https://github.com/cargiris))

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


\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
