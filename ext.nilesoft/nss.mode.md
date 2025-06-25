# Context Menu Mode

## Source Code & Screenshots

### Snippet:
[`nss.mode.nss`](/ext.nilesoft/nss.mode.nss)

### Screenshot:
![Screenshot 1](/ext.nilesoft/nss.mode.1.png)

## Overview
A Windows 11-specific context menu management system that allows users to switch between different context menu modes. The extension provides three distinct modes: Nilesoft Shell only, hybrid mode combining Windows and Nilesoft menus, and Windows default mode. It includes automatic configuration file management and registry manipulation for seamless mode switching.

## Key Features
- **Windows 11 Exclusive**: Only available on Windows 11 systems
- **Three Context Menu Modes**: Nilesoft-only, hybrid, and Windows default
- **Automatic Configuration**: Removes conflicting settings.priority entries from shell.nss
- **Registry Management**: Handles Windows 11 context menu registry keys automatically
- **SHIFT Key Support**: Optional Nilesoft Shell launch after Windows default mode

## Menu Structure
```
Context Menu Mode (Windows 11 only)
├── Nilesoft Only
│── Hybrid Mode
└── Windows Default
```

## Usage Notes
- Menu is disabled on systems other than Windows 11
- **Nilesoft Only Mode**: Completely replaces Windows 11 context menu with Nilesoft Shell
- **Hybrid Mode**: Allows access to both Windows and Nilesoft menus via "Show more options" or Shift+Right-Click
- **Windows Default Mode**: Restores original Windows 11 context menu and disables Nilesoft Shell
- **SHIFT+Click on Windows Default**: Automatically launch Nilesoft Shell app after restoration
- Automatically removes conflicting `settings.priority` entries from configuration file
- Requires administrator privileges for registry modifications
- Uses registry key: `HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}`
- Includes automatic Explorer restart and timing delays for proper application

## Dependencies
- Windows 11 Operating System
- Nilesoft Shell framework

No additional software installation is required beyond the Nilesoft Shell framework and Windows 11.