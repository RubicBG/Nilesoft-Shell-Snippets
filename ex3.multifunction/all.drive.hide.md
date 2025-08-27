# Hide Drive Letter Menu - Nilesoft Shell

## Source Code & Screenshots

### Snippet:
[`all.drive.hide.nss`](/ex3.multifunction/all.drive.hide.nss)

### Screenshot:
![Screenshot 1](/ex3.multifunction/all.drive.hide.1.png)
![Screenshot 2](/ex3.multifunction/all.drive.hide.2.png)

## Overview

This Nilesoft Shell script provides a context menu for hiding specific drive letters from Windows Explorer and File Explorer. It uses Windows registry manipulation to control drive visibility through the `NoDrives` policy setting, with automatic Explorer restart functionality.

## Key Features

- **Individual Drive Control**: Toggle visibility for drives A-Z independently
- **Smart Drive Detection**: Only shows options for existing drives (disabled for non-existent drives)
- **Registry Integration**: Uses Windows `NoDrives` policy for system-level drive hiding
- **Automatic Restart**: Optional Explorer restart to apply changes immediately
- **Visual Status**: Checkmarks indicate currently hidden drives
- **Bulk Operations**: Show/hide all drives with SHIFT key modifier
- **Administrative Rights**: Automatic elevation for registry modifications

## Menu Structure

The menu displays all drive letters (A-Z) with:
- **Enabled items**: For existing drives that can be hidden/shown
- **Disabled items**: For non-existent drives
- **Checked items**: Currently hidden drives
- **Special options** (SHIFT key):
  - Show all drives (top)
  - Hide all drives (middle separator)

## Usage Notes

- **Context**: Appears on drive and computer right-click contexts
- **Requirements**: Administrator privileges for registry changes
- **Effect**: Changes require Explorer restart (automatic prompt)
- **Registry Key**: `HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\NoDrives`
- **Bit Values**: Each drive uses powers of 2 (A=1, B=2, C=4, D=8, etc.)
- **SHIFT Modifier**: Reveals bulk show/hide all options

## Dependencies

- **Windows Registry Access**: Requires admin rights for HKLM modifications
- **Nilesoft Shell**: Compatible scripting environment
- **Windows Explorer**: Target application for drive visibility changes
- **PowerShell/CMD**: For registry editing and Explorer restart commands