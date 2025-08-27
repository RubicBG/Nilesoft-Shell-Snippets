# Antithreats Security Menu - Nilesoft Shell

## Source Code & Screenshots

### Snippet:
[`all.security.antithreats.nss`](/ex3.multifunction/all.security.antithreats.nss)

### Screenshot:
![Screenshot 1](/ex3.multifunction/all.security.antithreats.1.png)
![Screenshot 2](/ex3.multifunction/all.security.antithreats.2.png)

## Overview

Comprehensive security context menu providing Microsoft Defender scanning, exclusion management, MRT access, and VirusTotal integration for file and folder security analysis.

## Key Features

- **Dual Interfaces**: CMD and PowerShell implementations for Defender operations
- **Smart Exclusions**: Toggle Defender exclusions for paths, extensions, and processes
- **VirusTotal Integration**: Hash lookup and API-based scanning
- **Safety Controls**: SHIFT key protection for resource-intensive scans
- **Boot Sector Scanning**: Offline malware detection capability

## Menu Structure

**Microsoft Defender (CMD)**
- Quick/Full/Custom/Boot Sector scans via MpCmdRun.exe

**Microsoft Defender (PowerShell)**  
- Same scan types using Start-MpScan cmdlets
- Exclusion management (Add-MpPreference/Remove-MpPreference)
- Background execution with minimized windows

**Malicious Software Removal Tool**
- Standard and full system scans (SHIFT to reveal)

**VirusTotal**
- SHA256 hash lookup (browser-based, no API)
- API scanning with customizable formatting
- Automatic API key management

## Usage Notes

- **Admin Rights**: Required for exclusion modifications
- **SHIFT Protection**: Enables full scans and MRT access
- **API Key**: Pre-configured but replaceable for VirusTotal features
- **Boot Scans**: Require restart, ~15 minute duration
- **Context Types**: File, directory, and background compatible

## Dependencies

- **Windows Defender**: MpCmdRun.exe, PowerShell Defender module
- **System Tools**: MRT.exe, certutil.exe
- **Network Access**: VirusTotal API communication
- **Administrative Privileges**: Exclusion management operations