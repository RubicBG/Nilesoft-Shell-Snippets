# Windows Settings Menu - Nilesoft Shell

## Source Code & Screenshots

### Snippet:
[`goto2.settings.nss`](/ex5.goto/goto2.settings.nss)

### Screenshot:
![Screenshot 1](/ex5.goto/goto2.settings.1.png)
![Screenshot 2](/ex5.goto/goto2.settings.2.png)
![Screenshot 3](/ex5.goto/goto2.settings.3.png)
![Screenshot 4](/ex5.goto/goto2.settings.4.png)
![Screenshot 5](/ex5.goto/goto2.settings.5.png)
![Screenshot 6](/ex5.goto/goto2.settings.6.png)
![Screenshot 7](/ex5.goto/goto2.settings.7.png)
![Screenshot 8](/ex5.goto/goto2.settings.8.png)
![Screenshot 9](/ex5.goto/goto2.settings.9.png)


## Overview

This Nilesoft Shell script creates a comprehensive Windows Settings menu that provides quick access to all Windows 11/10 settings pages through URI commands. The menu is organized hierarchically to match the native Windows Settings app structure, offering both convenience and familiarity for users.

## Key Features

- **Complete Settings Coverage**: Includes all major Windows settings categories (System, Bluetooth & Devices, Network, Personalization, Apps, Accounts, etc.)
- **URI Command Integration**: Uses official Microsoft `ms-settings:` URIs for direct navigation
- **Fluent Design Icons**: Implements modern Windows Fluent Design icons with color coding
- **Version Compatibility**: Designed for Windows builds 1507+ with version checking
- **Management Tools**: Includes utilities to view all available URI commands and reset the Settings app
- **Keyboard Shortcuts**: Supports Windows+I shortcut display

## Menu Structure

The menu follows the Windows 11 Settings app organization:

1. **System** - Display, Sound, Notifications, Power, Storage, etc.
2. **Bluetooth and Devices** - Connected devices, printers, cameras, input devices
3. **Network and Internet** - Wi-Fi, Ethernet, VPN, proxy settings
4. **Personalization** - Background, colors, themes, taskbar, fonts
5. **Apps** - Installed apps, default apps, startup programs
6. **Accounts** - User info, sign-in options, family settings, backup
7. **Time and Language** - Regional settings, typing, speech
8. **Gaming** - Game Bar, capture, game mode
9. **Accessibility** - Visual, audio, and interaction accessibility features
10. **Privacy and Security** - Windows Security, permissions, diagnostics
11. **Windows Update** - Update settings, history, insider program

## Usage Notes

- Menu visibility is controlled by Windows build version (disabled on builds < 1507)
- The "Check for updates" item uses `USOClient` for immediate update scanning
- Management section provides PowerShell commands to view all URI commands and reset Settings app
- SHIFT key modifier enables sorting for URI command listings
- Reset Settings feature requires SHIFT key to prevent accidental execution

## Dependencies

- **Windows Version**: Windows 10 build 1507 or later
- **Nilesoft Shell**: Compatible with current Nilesoft Shell versions
- **System Files**: References `SystemSettings.dll` for URI command discovery
- **PowerShell**: Required for management features and Settings app reset functionality