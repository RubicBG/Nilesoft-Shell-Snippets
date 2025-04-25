# Swap Drive Letter - Nilesoft Shell Snippet

## Source Code & Screenshots

### Snippet:
[`all.drive.swap.nss`](/ex3.multifunction/all.drive.swap.nss)

### Screenshot:
![Screenshot 1](/ex3.multifunction/all.drive.swap.1.png)
![Screenshot 2](/ex3.multifunction/all.drive.swap.2.png)

## Overview
This snippet adds a "Swap Drive Letter" context menu option for local and USB drives in Windows Explorer. It allows users to quickly change a drive's letter assignment through a hierarchical menu without having to open Disk Management.

## Key Features
- Changes drive letters directly from Windows Explorer context menu
- Shows only available drive letters (disables letters already in use)
- Works with both local disks and USB drives
- Organizes letters into a clean, categorized menu
- Executes required administrative commands automatically
- Prevents changes to system root drive

## Menu Structure
- Submenu with all letters A-Z
- Letters that are already assigned to other drives appear disabled

## Usage Notes
- Right-click on any drive in Explorer to access this menu
- The script only appears for items identified as "Local Disk" or "USB Drive"
- The system drive (usually C:) is protected from changes
- Administrative privileges are required (automatically requested)
- Changes take effect immediately
- The menu will not appear for virtual drives created by the SUBST command

## Dependencies
- Windows Operating System
- Nilesoft Shell framework
- Uses Windows built-in firewall management tools:
  - PowerShell's `Set-Partition` cmdlet for drive letter modification

No additional software installation is required beyond the Nilesoft Shell framework and standard Windows components.