# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [Unreleased](https://github.com/voxpupuli/puppet-windowsfeature/tree/HEAD)

[Full Changelog](https://github.com/voxpupuli/puppet-windowsfeature/compare/v2.1.0...HEAD)

**Fixed bugs:**

- Problem installing feature "Backup-Features" or "Backup-Tools" on Windows Server 2008 R2 [\#86](https://github.com/voxpupuli/puppet-windowsfeature/issues/86)
- Source parameter doesn't work [\#80](https://github.com/voxpupuli/puppet-windowsfeature/issues/80)
- Updated source parameter in provider create [\#81](https://github.com/voxpupuli/puppet-windowsfeature/pull/81) ([cargiris](https://github.com/cargiris))

**Closed issues:**

- Does not appear to function properly in Windows Server 2016 [\#70](https://github.com/voxpupuli/puppet-windowsfeature/issues/70)

**Merged pull requests:**

- \(GH-86\) Fix invalid XML from Get-WindowsFeature [\#88](https://github.com/voxpupuli/puppet-windowsfeature/pull/88) ([jarretlavallee](https://github.com/jarretlavallee))
- \(GH-85\) Fix typo in provider for source parameter [\#85](https://github.com/voxpupuli/puppet-windowsfeature/pull/85) ([glennsarti](https://github.com/glennsarti))

## [v2.1.0](https://github.com/voxpupuli/puppet-windowsfeature/tree/v2.1.0) (2017-02-11)
[Full Changelog](https://github.com/voxpupuli/puppet-windowsfeature/compare/v2.0.0...v2.1.0)

**Fixed bugs:**

- v2.0.0 Does Not Work with Default PowerShell \(v2\) on Windows 2008R2 [\#57](https://github.com/voxpupuli/puppet-windowsfeature/issues/57)

**Closed issues:**

- 'Get-WindowsFeature' is not recognized as the name of a cmdlet [\#69](https://github.com/voxpupuli/puppet-windowsfeature/issues/69)
- Ensure no longer defaults to present in v2.x - Nothing to manage: no ensure and the resource doesn't exist [\#63](https://github.com/voxpupuli/puppet-windowsfeature/issues/63)

**Merged pull requests:**

- modulesync 0.16.7 [\#75](https://github.com/voxpupuli/puppet-windowsfeature/pull/75) ([bastelfreak](https://github.com/bastelfreak))
- Update based on voxpupuli/modulesync\_config 0.16.6 [\#74](https://github.com/voxpupuli/puppet-windowsfeature/pull/74) ([dhoppe](https://github.com/dhoppe))
- Set minimum version\_requirement for Puppet [\#73](https://github.com/voxpupuli/puppet-windowsfeature/pull/73) ([juniorsysadmin](https://github.com/juniorsysadmin))
- modulesync 0.16.4 [\#72](https://github.com/voxpupuli/puppet-windowsfeature/pull/72) ([bastelfreak](https://github.com/bastelfreak))
- modulesync 0.16.3 [\#67](https://github.com/voxpupuli/puppet-windowsfeature/pull/67) ([bastelfreak](https://github.com/bastelfreak))
- modulesync 0.15.0 [\#66](https://github.com/voxpupuli/puppet-windowsfeature/pull/66) ([bastelfreak](https://github.com/bastelfreak))
- Default `ensure` to `present` [\#64](https://github.com/voxpupuli/puppet-windowsfeature/pull/64) ([alexjfisher](https://github.com/alexjfisher))
- Update based on voxpupuli/modulesync\_config 0.14.1. This might fix \#56 [\#62](https://github.com/voxpupuli/puppet-windowsfeature/pull/62) ([dhoppe](https://github.com/dhoppe))
- Remove Gemfile management from module sync [\#60](https://github.com/voxpupuli/puppet-windowsfeature/pull/60) ([petems](https://github.com/petems))
- Changed PS convert from JSON to CSV for older PS compatibility.  Closes \#57. [\#58](https://github.com/voxpupuli/puppet-windowsfeature/pull/58) ([matthewrstone](https://github.com/matthewrstone))
- Sync metadata.json license to be same as LICENSE \(MIT\) [\#55](https://github.com/voxpupuli/puppet-windowsfeature/pull/55) ([juniorsysadmin](https://github.com/juniorsysadmin))

## [v2.0.0](https://github.com/voxpupuli/puppet-windowsfeature/tree/v2.0.0) (2016-06-16)
[Full Changelog](https://github.com/voxpupuli/puppet-windowsfeature/compare/v1.1.0...v2.0.0)

**Implemented enhancements:**

- Refactor into type and provider [\#43](https://github.com/voxpupuli/puppet-windowsfeature/issues/43)

**Closed issues:**

- bug in README [\#38](https://github.com/voxpupuli/puppet-windowsfeature/issues/38)
- Using array of features - slow [\#33](https://github.com/voxpupuli/puppet-windowsfeature/issues/33)
- 'ps' is not recognized as an internal or external command [\#32](https://github.com/voxpupuli/puppet-windowsfeature/issues/32)

**Merged pull requests:**

- release 2.0.0 [\#54](https://github.com/voxpupuli/puppet-windowsfeature/pull/54) ([bastelfreak](https://github.com/bastelfreak))
- Update specs and coverage [\#53](https://github.com/voxpupuli/puppet-windowsfeature/pull/53) ([petems](https://github.com/petems))
- Modulesync [\#51](https://github.com/voxpupuli/puppet-windowsfeature/pull/51) ([bastelfreak](https://github.com/bastelfreak))
- Pin to working Windows beaker and beaker-rspec [\#49](https://github.com/voxpupuli/puppet-windowsfeature/pull/49) ([petems](https://github.com/petems))
- Type and provider with specs [\#47](https://github.com/voxpupuli/puppet-windowsfeature/pull/47) ([petems](https://github.com/petems))
- Perform Modulesync \(0.3.0\) [\#46](https://github.com/voxpupuli/puppet-windowsfeature/pull/46) ([juniorsysadmin](https://github.com/juniorsysadmin))
- metadata: switch to new name [\#45](https://github.com/voxpupuli/puppet-windowsfeature/pull/45) ([DavidS](https://github.com/DavidS))
- Updates README with correct name [\#42](https://github.com/voxpupuli/puppet-windowsfeature/pull/42) ([petems](https://github.com/petems))
- Fixes beaker tests [\#41](https://github.com/voxpupuli/puppet-windowsfeature/pull/41) ([petems](https://github.com/petems))
- Removing WinRM specific code from spec tests [\#37](https://github.com/voxpupuli/puppet-windowsfeature/pull/37) ([petems](https://github.com/petems))
- Adds default beaker node [\#35](https://github.com/voxpupuli/puppet-windowsfeature/pull/35) ([petems](https://github.com/petems))
- Fix project url [\#34](https://github.com/voxpupuli/puppet-windowsfeature/pull/34) ([hunner](https://github.com/hunner))
- \(maint\) Add spec test for mutliple feature\_names [\#31](https://github.com/voxpupuli/puppet-windowsfeature/pull/31) ([cyberious](https://github.com/cyberious))

## [v1.1.0](https://github.com/voxpupuli/puppet-windowsfeature/tree/v1.1.0) (2015-05-01)
[Full Changelog](https://github.com/voxpupuli/puppet-windowsfeature/compare/v1.0.0...v1.1.0)

**Closed issues:**

- Old module on Puppet Forge not marked as deprecated [\#27](https://github.com/voxpupuli/puppet-windowsfeature/issues/27)
-  Invalid resource type windowsfeature  [\#25](https://github.com/voxpupuli/puppet-windowsfeature/issues/25)
- Tag for approved version? [\#24](https://github.com/voxpupuli/puppet-windowsfeature/issues/24)
- Error: No suitable tar implementation found [\#8](https://github.com/voxpupuli/puppet-windowsfeature/issues/8)

**Merged pull requests:**

- Just to support Windows 10 beta testers. [\#29](https://github.com/voxpupuli/puppet-windowsfeature/pull/29) ([x89](https://github.com/x89))
- Add a timeout param for long installs [\#28](https://github.com/voxpupuli/puppet-windowsfeature/pull/28) ([binford2k](https://github.com/binford2k))

## [v1.0.0](https://github.com/voxpupuli/puppet-windowsfeature/tree/v1.0.0) (2014-10-13)
[Full Changelog](https://github.com/voxpupuli/puppet-windowsfeature/compare/v0.2.0...v1.0.0)

**Closed issues:**

- Missing metadata.json file [\#22](https://github.com/voxpupuli/puppet-windowsfeature/issues/22)
- Consider using puppetlabs-powershell [\#21](https://github.com/voxpupuli/puppet-windowsfeature/issues/21)
- Version restriction dependency for 'stdlib' is out of date [\#19](https://github.com/voxpupuli/puppet-windowsfeature/issues/19)
- Support for source parameter [\#18](https://github.com/voxpupuli/puppet-windowsfeature/issues/18)
- Support for Windows 8 and 8.1 [\#17](https://github.com/voxpupuli/puppet-windowsfeature/issues/17)

**Merged pull requests:**

- Fix project URL and bump major version for Approved Program [\#23](https://github.com/voxpupuli/puppet-windowsfeature/pull/23) ([cyberious](https://github.com/cyberious))
- added source parameter to the add-feature command [\#20](https://github.com/voxpupuli/puppet-windowsfeature/pull/20) ([tracyde](https://github.com/tracyde))

## [v0.2.0](https://github.com/voxpupuli/puppet-windowsfeature/tree/v0.2.0) (2014-08-14)
[Full Changelog](https://github.com/voxpupuli/puppet-windowsfeature/compare/v0.1.2...v0.2.0)

**Closed issues:**

- Module should install into windowsfeature directory, not windows\_feature [\#16](https://github.com/voxpupuli/puppet-windowsfeature/issues/16)
- Still having issues with 2008 r2 on v0.1.2 [\#15](https://github.com/voxpupuli/puppet-windowsfeature/issues/15)
- Adding features fails on 2008 r2, works on 2012. [\#14](https://github.com/voxpupuli/puppet-windowsfeature/issues/14)
- Powershell error installing features [\#7](https://github.com/voxpupuli/puppet-windowsfeature/issues/7)

## [v0.1.2](https://github.com/voxpupuli/puppet-windowsfeature/tree/v0.1.2) (2014-04-14)
[Full Changelog](https://github.com/voxpupuli/puppet-windowsfeature/compare/v0.1.1...v0.1.2)

**Closed issues:**

- module name underscore issue [\#4](https://github.com/voxpupuli/puppet-windowsfeature/issues/4)

**Merged pull requests:**

- Includemanagementtools includesubfeatures [\#13](https://github.com/voxpupuli/puppet-windowsfeature/pull/13) ([shoekstra](https://github.com/shoekstra))

## [v0.1.1](https://github.com/voxpupuli/puppet-windowsfeature/tree/v0.1.1) (2014-04-04)
[Full Changelog](https://github.com/voxpupuli/puppet-windowsfeature/compare/v0.1.0...v0.1.1)

**Merged pull requests:**

- Windows support only and updated Windows 2012 cmdlet [\#12](https://github.com/voxpupuli/puppet-windowsfeature/pull/12) ([shoekstra](https://github.com/shoekstra))

## [v0.1.0](https://github.com/voxpupuli/puppet-windowsfeature/tree/v0.1.0) (2014-04-04)
[Full Changelog](https://github.com/voxpupuli/puppet-windowsfeature/compare/v0.0.3...v0.1.0)

**Merged pull requests:**

- Spec tests [\#11](https://github.com/voxpupuli/puppet-windowsfeature/pull/11) ([shoekstra](https://github.com/shoekstra))

## [v0.0.3](https://github.com/voxpupuli/puppet-windowsfeature/tree/v0.0.3) (2014-03-30)
**Closed issues:**

- Error: Puppet::Parser::AST::Resource failed with error ArgumentError: Invalid resource type windowsfeature at  [\#6](https://github.com/voxpupuli/puppet-windowsfeature/issues/6)
- dism to windowsfeature: Invalid resource type windowsfeature [\#1](https://github.com/voxpupuli/puppet-windowsfeature/issues/1)

**Merged pull requests:**

- replaced execs with powershell provider [\#10](https://github.com/voxpupuli/puppet-windowsfeature/pull/10) ([shoekstra](https://github.com/shoekstra))
- Added ability to pass multiple features in feature\_name [\#3](https://github.com/voxpupuli/puppet-windowsfeature/pull/3) ([cyberious](https://github.com/cyberious))
- Fixed an issue with improper name in ModuleFile which causes an error of... [\#2](https://github.com/voxpupuli/puppet-windowsfeature/pull/2) ([cyberious](https://github.com/cyberious))



\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*