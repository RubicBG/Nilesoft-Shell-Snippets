# Windows Power Menu

## Source Code & Screenshots

### Snippet:
[`all.power.nss`](/ext.managers/all.power.nss)

### Screenshot:
![Screenshot 1](/ext.managers/all.power.1.png)
![Screenshot 2](/ext.managers/all.power.2.png)

## Overview
A comprehensive Windows context menu extension for power management operations, providing quick access to system power states and boot options.

## Key Features
- System power states (Lock, Sleep, Hibernate, Shutdown)
- Advanced restart options (Normal, Safe Mode, UEFI/BIOS)
- Scheduled shutdown with hour/minute precision
- Smart shutdown/restart with app state preservation
- Hybrid power modes support (Not tested)

## Menu Structure
- Basic Power Options
  - Lock
  - Logoff
  - Switch User
  - Sleep/Hibernate/Shutdown variants
- Shutdown Schedule (up to 12 hours)
- Advanced Boot Options
  - Recovery Mode
  - BIOS/UEFI Boot
  - Safe Mode variants

## Usage Notes
- SHIFT key enables force operations for shutdown/restart
- Hibernate availability depends on system configuration
- Administrative privileges required for certain operations

## Dependencies
- Windows built-in executables
  - shutdown.exe
  - rundll32.exe
  - powercfg.exe

No additional software installation is required beyond the Nilesoft Shell framework and standard Windows components.
