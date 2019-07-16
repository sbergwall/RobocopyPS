# RobocopyPS Release History

## 0.2.0 - 2019-07-16

### Changed

* A re-write was done to be able to handle error code better and more precisely. Changes to the function names was also done, Start-Robocopy became Invoke-Robocopy and the internal logic handling output from Robocopy.exe was extracted to Invoke-RobocopyParser.

* All other functions was removed during this release so they can be re-worked to follow the new standard.

## 0.1.0 - 2019-05-30

### Fixed

* No fix as this is the first release

### Added

* Added function Start-Robocopy
* Added function Remove-RoboDirectory

### Changed

* No change as this is first release