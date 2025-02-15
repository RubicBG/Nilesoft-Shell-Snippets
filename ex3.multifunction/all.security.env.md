# Environment Path Menu

## Source Code & Screenshots

### Snippet:
[`all.security.env.nss`](/ex3.multifunction/all.security.env.nss)

### Screenshot:
![Screenshot 1](/ex3.multifunction/all.security.env.1.png)
![Screenshot 2](/ex3.multifunction/all.security.env.2.png)

## Overview
The Environment Path Menu provides a graphical interface for managing Windows environment variables and allowing users to modify system paths directly from the context menu.

## Key Features
- Launch Environment Variables GUI editor
- Add/Remove current directory to %PATH%

## Menu Structure
- ENV GUI - Opens system Environment Variables editor
- Add/Remove from %PATH% - Toggle current directory in %PATH%
- Path Viewers (hidden)
  - Default %PATH%
  - Current User %PATH%
  - Local Machine %PATH%
  - Combined LM+CU %PATH%

## Usage Notes
- Explorer restart needed for changes to take effect
- Shift key combinations available for different %PATH% viewing options
- Safety confirmation prompt when removing from %PATH%

## Technical Details
- Registry locations:
  - Current User: `HKCU\Environment`
  - System: `HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment`

## Dependencies
- Windows Operating System
- Nilesoft Shell framework
- System DLLs:
  - sysdm.cpl
  - imageres.dll

No additional software installation is required beyond the Nilesoft Shell framework and standard Windows components.