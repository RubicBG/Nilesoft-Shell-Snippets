# Windows Compatibility Extension for Nilesoft Shell

## Source Code & Screenshots

### Snippet: 
[`ext.compatibility.nss`](/ex3.multifunction/ext.compatibility.nss)

### Screenshot:
![Screenshot 1](/ex3.multifunction/ext.compatibility.1.png)
![Screenshot 2](/ex3.multifunction/ext.compatibility.2.png)
![Screenshot 3](/ex3.multifunction/ext.compatibility.3.png)
![Screenshot 4](/ex3.multifunction/ext.compatibility.4.png)
![Screenshot 5](/ex3.multifunction/ext.compatibility.5.png)

## Overview

This Nilesoft Shell extension provides a comprehensive Windows compatibility management system directly from the right-click context menu. It allows users to apply various compatibility flags and settings to executable files and shortcuts without opening Windows' built-in Properties dialog. The script dynamically reads and writes Windows AppCompatFlags registry entries, supporting both user-level (HKCU) and system-level (HKLM) configurations.

## Key Features
- **Legacy Windows Compatibility**: Support for Windows 95 through Windows 8 RTM compatibility modes
- **High DPI Management**: Advanced DPI scaling options for modern displays
- **User Access Control**: Administrator privilege management and elevation settings
- **Display Compatibility**: Color depth reduction and resolution forcing for legacy applications
- **System Behavior**: Exception handling, crash recovery, and visual theme controls
- **Registry Integration**: Direct manipulation of Windows AppCompatFlags entries
- **Visual Feedback**: Color-coded icons showing active compatibility settings
- **Architecture Detection**: Automatic handling of 64-bit compatibility limitations
- **Intelligent Flag Management**: Prevents conflicting compatibility settings

## Menu Structure
```
Compatibility (for executable files)
├── Compatibility Mode:
│   ├── Windows 95 through Windows 8 RTM
│   ├── Windows NT 4.0 SP5
│   └── Windows Server 2003/2008 SP1
├── User Access and Permissions:
│   ├── Run as Administrator
│   ├── Run as Administrator (Vista Method)
│   └── Run as Standard User
├── System Behavior and Stability:
│   ├── Enable Automatic Restart on Crash
│   ├── Disable DEP Warning Dialog
│   ├── Suppress Exception Dialogs
│   └── Legacy ICC Color Management
├── Display and Graphics Settings:
│   ├── 256/16-bit Color Modes
│   ├── 640x480 Resolution (VGA)
│   ├── Disable Fullscreen Optimizations
│   ├── Disable Desktop Composition
│   └── Disable Visual Themes
├── High DPI Settings:
│   ├── Override System DPI Scaling (Login/Runtime)
│   ├── Application-Managed DPI Scaling
│   ├── Windows-Managed DPI Scaling
│   └── GDI-Optimized DPI Scaling
└── Program Compatibility Troubleshooter
```

## Usage Notes
- Menu appears only for executable files with registered compatibility handlers
- **SHIFT+Click**: Toggles between user-level (HKCU) and system-level (HKLM) registry modification
- User-level modifications work without elevation
- System-level modifications require administrator privileges
- Visual status icons: dot indicates HKCU flag, circle indicates HKLM flag, both elements show flag set in both locations
- 64-bit applications automatically disable incompatible legacy modes
- Supports both executable files and shortcuts (.lnk files)
- Creates timestamped registry entries with automatic cleanup of conflicting flags
- Registry locations: `HKCU/HKLM\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers`

## Dependencies
- Windows Vista or later (some features require Windows 10+)
- Nilesoft Shell framework
- Registry access permissions for compatibility flag management

No additional software installation is required beyond the Nilesoft Shell framework and standard Windows components.