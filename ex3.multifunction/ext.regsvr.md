# Register Server

## Source Code & Screenshots

### Snippet:
[`ext.regsvr.nss`](/ex3.multifunction/ext.regsvr.nss)

### Screenshot: 
![Screenshot 1](/ex3.multifunction/ext.regsvr.1.png)

## Overview
A context menu for registering and unregistering DLL and OCX files, with specialized handling for Nilesoft Shell components. The menu provides standard registration options for general files and enhanced functionality for Nilesoft Shell DLLs including backup, replacement, and restart operations.

## Key Features
- **Standard Registration**: Register/unregister DLL and OCX files using regsvr32.exe
- **Nilesoft Shell Integration**: Special handling for Nilesoft Shell DLLs with backup and replacement
- **Automatic Backup**: Creates timestamped backups before replacing shell.dll
- **Version Display**: Shows file version in menu items for Nilesoft components
- **Safety Checks**: Prevents self-registration and includes error handling
- **Explorer Restart**: Automatically restarts Explorer after Nilesoft Shell updates

## Menu Structure
```
Register Server (for .dll/.ocx files)
├── Standard Files:
│   ├── Register - Register DLL/OCX with regsvr32
│   └── Unregister - Unregister DLL/OCX with regsvr32
└── Nilesoft Shell Files:
    ├── Register - Backup current, replace shell.dll, restart Explorer
    └── Unregister - Unregister current shell.dll
```

## Usage Notes
- Menu appears only for .dll and .ocx files
- Standard registration requires administrator privileges
- Nilesoft Shell registration creates backups with timestamp format: `shell-Ymd-HMS.dll`
- Prevents registering currently active shell.dll (shows as disabled)
- Offers to replace shell.exe if found in same directory as selected DLL
- Prompts to reset shell.log file during registration
- Uses metadata detection to identify Nilesoft Shell components

## Dependencies
- Windows Operating System
- Nilesoft Shell framework

No additional software installation is required beyond the Nilesoft Shell framework and standard Windows components.