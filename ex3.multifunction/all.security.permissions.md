# Security and Permissions Menu - Nilesoft Shell

## Source Code & Screenshots

### Snippet:
[`all.security.permissions.nss`](/ex3.multifunction/all.security.permissions.nss)

### Screenshot:
![Screenshot 1](/ex3.multifunction/all.security.permissions.1.png)
![Screenshot 2](/ex3.multifunction/all.security.permissions.2.png)
![Screenshot 3](/ex3.multifunction/all.security.permissions.3.png)
![Screenshot 4](/ex3.multifunction/all.security.permissions.4.png)
![Screenshot 5](/ex3.multifunction/all.security.permissions.5.png)
![Screenshot 6](/ex3.multifunction/all.security.permissions.6.png)

## Overview

Advanced Windows file/folder permission management menu using ICACLS and TAKEOWN commands. Provides ownership changes, permission modifications, inheritance control, and troubleshooting tools with safety protections.

⚠️ **Caution**: Changes made with this menu **cannot be undone**. Always use with care and ensure you have a full backup before applying modifications.

## Key Features

- **Quick Actions**: Grant full control, take ownership, reset to defaults
- **Owner Management**: Change to current user, administrators, system accounts
- **Permission Control**: Full/modify/read access for users/groups
- **Inheritance Settings**: Enable/disable/remove inheritance
- **Advanced Tools**: Detailed reports, SDDL viewing, permission backup
- **Safety Protections**: System folder exclusions, SHIFT recursion modifier

## Menu Structure

**Quick Actions**
- Grant Full Control (ownership + admin permissions)
- Take Ownership Only
- Reset to Windows Defaults
- View Current Permissions

**Change Owner**
- Current User, Administrators Group, System Account
- TrustedInstaller, Everyone Group, Network Service

**Manage Permissions**
- Full Control/Modify/Read-Only access grants
- IIS Web Server Access
- Permission removal options

**Inheritance Settings**
- Enable/Disable/Remove inheritance options

**Advanced Tools**
- Permission reports, effective permissions
- SDDL security descriptor viewing
- Permission backup functionality

**Troubleshooting**
- Complete permission repair
- Inheritance chain fixes
- Emergency access restore

## Usage Notes

- **Admin Required**: Most operations need elevated privileges
- **SHIFT Modifier**: Enables recursive operations on folders
- **Safety Checks**: Blocks critical system folder modifications
- **SID Usage**: Uses Security Identifiers for language independence
- **Backup First**: Always backup permissions before major changes

## Dependencies

- **Windows Commands**: ICACLS.exe, TAKEOWN.exe
- **PowerShell**: Advanced reporting and analysis features  
- **Admin Rights**: Required for ownership and permission changes
- **System Access**: Needs appropriate privileges for target files/folders