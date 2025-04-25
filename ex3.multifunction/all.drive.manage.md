# Drive Manage - Nilesoft Shell Snippet

## Source Code & Screenshots

### Snippet:
[`all.drive.manage.nss`](/ex3.multifunction/all.drive.manage.nss)

### Screenshot:
![Screenshot 1](/ex3.multifunction/all.drive.manage.1.png)
![Screenshot 2](/ex3.multifunction/all.drive.manage.2.png)

## Overview
This Nilesoft Shell snippet adds a comprehensive "Drive Manage" context menu for drives in Windows Explorer. It provides quick access to various disk management utilities and operations without requiring users to navigate through system tools.

## Key Features
- Direct access to essential drive maintenance tools
- Disk cleanup options for freeing up space
- Disk optimization and defragmentation tools
- Disk error checking with different severity options
- Access to system disk management utilities
- Dynamic menu that adapts based on drive type

## Menu Structure
- Main entry: "Drive Manage" with a drive icon
- Section 1: Maintenance tools (for regular drives only)
  - Disk Cleanup (general and drive-specific)
  - Optimize/Defragment options
  - Check Disk utilities (standard and dismounted modes)
- Section 2: System management tools
  - Disk Management console access
  - Disk and Volumes settings (Windows 8 and newer)

## Usage Notes
- Right-click on any drive in Explorer to access this menu
- Some options require administrative privileges (automatically requested)
- The "Dismounted" check disk option is disabled for system drives
- CD/DVD drives and virtual mapped folders show a simplified menu
- Options dynamically appear/disappear based on available system utilities
- Keyboard shortcuts are available for certain operations

## Dependencies
- Windows Operating System
- Nilesoft Shell framework
- Uses Windows built-in utilities:
  - cleanmgr.exe (Disk Cleanup)
  - dfrgui.exe (Disk Defragmenter)
  - chkdsk (Check Disk)
  - diskmgmt.msc (Disk Management)
- Some features require Windows 8 or newer

No additional software installation is required beyond the Nilesoft Shell framework and standard Windows components.
