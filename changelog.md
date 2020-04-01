# Changelog
All notable changes to this project will be documented in this file.

Version format based on http://semver.org/

## [Unreleased]

## [0.5.3] - 2020-04-01

### Changed

- Don't use .to_h as it is not available on jruby (puppetserver)

## [0.5.2] - 2020-03-11

### Changed

- Make return of parameters_by_path a hash with key : value and print it cleanly on cli

## [0.5.1] - 2019-04-29

### Changed

- Updated doc.
- Lower required Ruby version for smps gem.

## [0.5.0.pre]

### Changed

- Split in 2 separate gems: smps and smps-cli.

## [0.4.1] - 2018-09-25

### Changed

- Change dependency on thor to 0.19.* to work with available native debian packages

## [0.4.0] - 2018-09-18

### Added

- New cli executable based on thor

## [0.3.4] - 2017-12-20

### Changed

- Add http timeout to region get in helper script

## [0.3.3] - 2017-11-17

### Changed

- Add next_token handling for get_parameters_by_path

## [0.3.2] - 2017-11-16

### Changed

- Set \@decrypt param to true by default

## [0.3.1] - 2017-11-16

### Added

- Test script param for fetch by_path

## [0.3.0] - 2017-10-13

### Added

- parameters_by_path method

## [0.2.3] - 2017-10-06

### Changed

- Update gem dependency specification

## [0.2.2] - 2017-10-06

### Added

- Parameters for creating / writing SecureString

## [0.2.1] - 2017-10-05

### Changed

- Class structure improvement
- move optional requires into if block

## [0.2.0] - 2017-10-05

### Added

- smps cli query script

## [0.1.3] - 2017-10-05

### Added

- ...

### Changed

- ...

### Removed

- ...
