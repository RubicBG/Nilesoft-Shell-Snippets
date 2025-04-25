# File Drive - Nilesoft Shell Snippet

## Source Code & Screenshots

### Snippet:
[`all.drive.file.nss`](/ex3.multifunction/all.drive.file.nss)

### Screenshot:
![Screenshot 1](/ex3.multifunction/all.drive.file.1.png)
![Screenshot 2](/ex3.multifunction/all.drive.file.2.png)

## Overview
This Nilesoft Shell snippet adds a "File Drive" context menu with two distinct functionalities: managing ISO/IMG disk image files and interacting with mounted virtual drives. It provides convenient tools for mounting, unmounting, and querying disk images directly from Windows Explorer's context menu.

## Key Features
- Mount ISO and IMG files with a single click
- Unmount disk images easily
- View information about disk image files
- Retrieve the source file path of mounted images
- Eject mounted virtual drives directly
- Smart eject option that navigates away before unmounting

## Menu Structure
- For ISO/IMG files:
  - Mount (mounts the disk image)
  - UnMount (unmounts the disk image)
  - Info (displays technical information about the image)
  - Verify (checks if the image is currently mounted)
- For mounted CD/DVD drives:
  - View Source File #1 (shows original ISO file path using Volume method)
  - View Source File #2 (shows original ISO file path using DevicePath method)
  - Eject (unmounts the disk image)
  - Eject Smart (attempts to navigate away before unmounting)

## Usage Notes
- Right-click on ISO/IMG files to access mount options
- Right-click on mounted virtual drives to access eject options
- All operations use PowerShell commands for disk image management
- The menu intelligently appears only for supported file types and drives
- Smart eject tries to navigate away from the drive before ejecting
- No administrative privileges required for these operations
- Works with both native Windows mounting and third-party mounted images
- Compatible with both CDFS (Compact Disc File System) formatted drives

## Dependencies
- Windows Operating System
  - Requires Windows 8 or newer (for native ISO mounting support)
- Nilesoft Shell framework
- Uses PowerShell's DiskImage module for mounting/unmounting
- Works with Windows built-in ISO mounting capability

No additional software installation is required beyond the Nilesoft Shell framework and standard Windows components.