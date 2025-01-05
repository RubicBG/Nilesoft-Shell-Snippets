# Recycle Bin and System Cleaning

## Source Code & Screenshots

### Snippet:
[`recycle.bin.nss`](/ext.others/recycle.bin.nss)

### Screenshot:
![Screenshot](/ext.others/recycle.bin.png)


## Overview
Configuration for enhanced Recycle Bin context menu with system cleaning utilities and component store management.

## Key Features
- Disk cleanup integration
- Temporary file cleanup
- Secure deletion option
- Component store management

## Menu Structure
- Cleaning/Recycling Menu
  - Disk Cleanup
  - Drive-specific cleanup
  - Temporary files cleanup
  - Empty Recycle Bin
  - Secure Empty (with SDelete)
  - Component Store (Windows 10+)
    - Analyze Store
    - Clean Up Store
    - Check and Clean Up

## Usage Notes
- Requires admin rights for certain operations
- SDelete integration optional
- SHIFT key reveals additional options
- Removes default Rename/Paste options

## Dependencies
- Windows Operating System
- Nilesoft Shell framework
- Windows Disk Cleanup (cleanmgr.exe)
- PowerShell
- DISM (Windows 10+)
- [SDelete]('https://winstall.app/apps/Microsoft.Sysinternals.SDelete') (optional) ([winget]('https://winstall.app/apps/Microsoft.Sysinternals.SDelete'))
- Shell32.dll
