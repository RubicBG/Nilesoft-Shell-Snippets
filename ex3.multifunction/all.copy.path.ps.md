# Copy Tool (Powershell)

## Source Code & Screenshots

### Snippet:
[`all.copy.path.ps.nss`](/ex3.multifunction/all.copy.path.ps.nss)

### Screenshot:
![Screenshot 1)](/ex3.multifunction/all.copy.path.ps.1.png)
![Screenshot 2)](/ex3.multifunction/all.copy.path.ps.2.png)

## Overview
This Nilesoft Shell extension adds enhanced path and content copying capabilities to the Windows context menu.

## Key Features
- Copy full file/folder paths
- Copy parent directory paths
- Copy file/folder names with/without extensions
- Copy file contents
- Copy directory contents listing
- Multi-selection support

## Menu Structure
- Copy item(s) full path
- Copy parent(s) full path
- Copy item(s) name
- Copy item(s) title
- Copy Content(s) - for files
- Copy Contents - for directories

## Usage Notes
- Works with files, folders, drives and desktop
- Supports multiple item selection
- Hidden PowerShell window execution

## Technical Details
- Uses PowerShell commands for path manipulation
- Leverages System.IO.Path methods
- Implements conditional menu item text based on selection count
- Uses Set-Clipboard for copying to clipboard

## Dependencies
- Windows Operating System
- Nilesoft Shell framework
- PowerShell

