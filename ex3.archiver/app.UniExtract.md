# UniExtract Context Menu

## Source Code & Screenshots

### Snippet:
[`app.UniExtract.nss`](/ex3.archiver/app.UniExtract.nss)

### Screenshot:
![Screenshot)](/ex3.archiver/app.UniExtract.png)

## Overview
Shell extension providing Universal Extractor integration into Windows context menu for comprehensive archive extraction capabilities.

## Key Features
- Multiple extraction modes
- File scanning functionality
- Auto-update system
- Automated installation process
- Support for various archive formats

## Menu Structure
1. Extract Files...
2. Extract to Subdir...
3. Extract Here
4. Scan Files
5. Check for Updates
6. Download UniExtract (when not installed)

## Usage Notes
- Requires UniExtract installation
- SHIFT key toggles admin/non-admin updater
- Automatic download and setup if not installed
- Compatible with both admin and non-admin modes

## Technical Details
- Installation Path: Program Files (x86)\UniExtract
- Download Source: GitHub repository
- PowerShell-based installation script
- Automated directory creation
- Update mechanisms: Admin and Non-Admin versions

## Dependencies
- Windows Operating System
- Nilesoft Shell framework
- UniExtract executable
- PowerShell for installation
- System.IO.Compression for setup
- Administrative privileges for certain operations