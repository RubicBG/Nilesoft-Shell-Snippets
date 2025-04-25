# Folder Drive - Nilesoft Shell Snippet

## Source Code & Screenshots

### Snippet:
[`all.drive.folder.nss`](/ex3.multifunction/all.drive.folder.nss)

### Screenshot:
![Screenshot 1](/ex3.multifunction/all.drive.folder.1.png)
![Screenshot 2](/ex3.multifunction/all.drive.folder.2.png)

## Overview
This Nilesoft Shell snippet adds a "Folder Drive" context menu that allows users to mount folders as virtual drives using the Windows SUBST command. It provides a convenient way to access frequently used folders as if they were physical drives, with options to mount, unmount, and manage these virtual drives.

## Key Features
- Mount any folder as a virtual drive with a single click
- Unmount virtual drives with tracking of original folder location
- Navigate directly to the original folder location of any mounted drive
- Display list of all currently mounted folder drives
- Smart unmounting that returns to original folder location
- Automatic desktop.ini file management for persistent tracking

## Menu Structure
- Main entry: "Folder Drive" with a mount icon
- For mounted virtual drives:
  - Unmount (removes the virtual drive)
  - Unmount Smart (navigates back to original folder before unmounting)
  - Open folder location (navigates to the original folder)
- For folders and desktop:
  - Mount Folder submenu with available drive letters (A-Z)
  - Unavailable letters appear disabled
- Mounted Folders section:
  - Shows all currently mounted folder drives with their source paths
  - Clicking any entry navigates to that drive

## Usage Notes
- Right-click on a folder to mount it as a virtual drive
- Right-click on a mounted drive to manage or unmount it
- Virtual drives are temporary and exist only for the current session
- They will be removed when you restart your computer
- The system tracks the original folder path in a hidden desktop.ini file
- Drive letters already in use by physical or other virtual drives appear disabled
- Column breaks organize drive letters into logical groups

## Dependencies
- Windows Operating System
- Nilesoft Shell framework
- Uses Windows built-in SUBST command for drive mapping
- Tracks mounted drives using desktop.ini files

No additional software installation is required beyond the Nilesoft Shell framework and standard Windows components.


