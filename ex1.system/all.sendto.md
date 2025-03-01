# Send To Menu Enhancement

## Source Code & Screenshots

### Snippet:
[`all.sendto.nss`](/ex1.system/all.sendto.nss)

### Screenshot:
![Screenshot](/ex1.system/all.sendto.png)

## Overview

This Nilesoft Shell script enhances the Windows "Send to" context menu by reorganizing its position, adding new useful options, and reordering the existing entries.

## Key Features
- Repositions the "Send to" menu to a more convenient location
- Adds a "Send to Executable" option for opening files with any program
- Provides direct access to the "Send To" folder
- Allows creation of new "Send To" shortcuts directly from the context menu
- Reorders existing "Send to" system items for better organization
- Compatible with both files and directories

## Menu Structure
1. **New Top-Level Items**
   - "Send to Executable" - Choose any EXE to open the selected file(s)
   - "Open 'Send To' folder" - Opens the user's SendTo directory
   - "Add Here..." - Creates a shortcut to the selected folder or EXE in the SendTo directory

2. **Reordered Default Items**
   - Bluetooth device
   - Compressed (zipped) folder
   - Desktop (create shortcut)
   - Documents
   - Mail recipient

## Usage Notes
- The script moves the "Send to" menu to be positioned after the "Copy" command
- The "Send to Executable" option opens a file browser filtered to show only EXE files
- The "Add Here..." option only appears for directories, drives, and EXE files
- Access the "Send To" folder directly to manage all shortcuts in one place

## Dependencies
Required Components:
- Windows Operating System
- Nilesoft Shell framework

No additional software installation is required beyond the Nilesoft Shell framework and standard Windows components.