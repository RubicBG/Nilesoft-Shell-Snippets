# OneDrive Integration for Nilesoft Shell

## Source Code & Screenshots

### Snippet:
[`cloud.onedrive.nss`](/ex2.user.cloud.share/cloud.onedrive.nss)

### Screenshot:
![Screenshot](/ex2.user.cloud.share/cloud.onedrive.png)

## Overview
This Nilesoft Shell snippet enhances the Windows context menu with improved OneDrive integration. It modifies the appearance and functionality of OneDrive-related menu items, providing better visual indicators and more consistent behavior across different OneDrive states.

## Key Features
- Custom OneDrive menu with distinctive icons
- Contextual menu items based on file location (OneDrive folder vs. local)
- Support for OneDrive Personal account features
- Dynamic localization using OneDrive's resource DLL

## Menu Structure
The snippet creates and modifies a dedicated OneDrive menu with the following context-aware items:
- Share
- Copy Link
- Move to OneDrive
- Always keep on this device
- Free up space
- View online
- Version history
- Manage access
- Storage status
- OneDrive Vault

## Usage Notes
- The menu title can be customized by changing the `$menu_od_name` variable
- The script detects whether files are inside OneDrive folders to show relevant options
- OneDrive Vault-specific commands appear only when selecting the Vault folder
- Menu items are displayed in the user's system language via resource strings

## Dependencies
- Windows Operating System
- Nilesoft Shell framework
- Microsoft OneDrive client
  - OneDrive resource DLL for localized strings
  - OneDrive user account configured on the system

The snippet automatically retrieves necessary paths from the Windows Registry:
- OneDrive installation path
- User folder location
- Vault shortcut path
- Resource DLL location
