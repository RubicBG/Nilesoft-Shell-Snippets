# Firewall - Nilesoft Shell Snippet

## Source Code & Screenshots

### Snippet:
[`all.security.firewall.nss`](/ex3.multifunction/all.security.firewall.nss)

### Screenshot:
![Screenshot 1](/ex3.multifunction/all.security.firewall.1.png)

## Overview
This Nilesoft Shell snippet adds a "Firewall" context menu for executable files that allows quick management of Windows Firewall rules. Users can easily allow or block network access for applications without needing to navigate through the Windows Firewall interface.

## Key Features
- One-click application firewall rule creation
- Support for both inbound and outbound rules simultaneously
- Options for allowing application network access
- Options for blocking application network access
- Easy removal of existing firewall rules
- Rule verification capabilities
- Multiple implementation methods (PowerShell and netsh)
- Direct access to Windows Firewall management consoles

## Menu Structure
- Main entry: "Firewall" with a custom shield icon
- PowerShell implementation section:
  - Allow in Windows Firewall
  - Block in Windows Firewall
  - Remove From Windows Firewall
- Netsh implementation section:
  - Allow in Windows Firewall
  - Block in Windows Firewall
  - Remove From Windows Firewall
  - Check the Rule in Windows Firewall
- Utilities section:
  - Windows Firewall (wf.msc)
  - Windows Defender Firewall (firewall.cpl)

## Usage Notes
- Right-click on executable files (.exe, .cmd, .bat, .msi, .ps1, .vbs) to access this menu
- All firewall operations require administrative privileges (automatically requested)
- Rules are created for both inbound and outbound directions
- Rule names are automatically generated based on the file name
- The menu includes two implementation methods:
  - PowerShell commands (New-NetFirewallRule)
  - Legacy netsh commands
- Command windows are hidden by default except for verification

## Dependencies
- Windows Operating System
- Nilesoft Shell framework
- Uses Windows built-in firewall management tools:
  - PowerShell's NetFirewall module
  - netsh advfirewall commands
  - Windows Firewall console (wf.msc)
  - Windows Defender Firewall control panel (firewall.cpl)
No additional software installation is required beyond the Nilesoft Shell framework and standard Windows components.