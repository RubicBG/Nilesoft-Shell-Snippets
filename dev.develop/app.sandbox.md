# Windows Sandbox

## Source Code & Screenshots

### Snippet:
[`app.sandbox.nss`](/dev.develop/app.sandbox.nss)

### Screenshot:
![Screenshot 1)](/dev.develop/app.sandbox.png)

## Overview
Advanced Windows Sandbox integration for Nilesoft Shell, enabling secure file/folder testing and URL handling.

## Key Features
- Folder synchronization
- URL handling with Edge
- Executable file testing
- PowerShell script execution
- Read/write access control

## Menu Structure
- Sandbox with NS Shell options
- Desktop synchronization
- Folder sharing options
- URL handling
- File execution options
- Script execution settings

## Usage Notes
- SHIFT key enables write access
- Disables when sandbox is running
- Auto-cleans temporary files
- Single selection mode

## Technical Details
- Windows Sandbox does not support these characters in the path: é è à â ê û î ä ë ü ï ö ù ò ~ ! @ # $ % ^ & + = } { ] [ | < > ;

## Dependencies
- Windows Operating System (build 1903+)
- Nilesoft Shell framework
- Windows Sandbox
- Microsoft Edge
- PowerShell