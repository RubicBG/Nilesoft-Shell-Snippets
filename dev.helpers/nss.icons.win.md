# Nilesoft Shell Windows Icon Path Extractor

## Source Code & Screenshots

### Snippet:
[`nss.icons.win.nss`](/dev.helpers/nss.icons.win.nss)

### Screenshot:
![Windows Icons Menu Screenshot](/dev.helpers/nss.icons.win.png)

## Overview
A specialized utility for extracting icon paths from Windows system DLLs and executables. This tool simplifies the process of accessing and copying Windows' built-in icon library paths through an organized context menu system.

## Key Features
- Extract icon paths from system DLLs
- Copy formatted icon references to clipboard
- Access Windows executable icon paths

## Menu Structure

1. **Core System Icons**
   - shell32.dll (327 icons)
   - imageres.dll (359 icons)

2. **Hardware and Devices**
   - Hardware Devices (ddores.dll)
   - Audio Devices (mmres.dll)
   - Sensors (sensorscpl.dll)
   - Setup Wizard (setupapi.dll)
   - Multimedia (wmploc.dll)
   - Portable Devices (wpdshext.dll)
   - Disk Management (dmdskres.dll)
   - Imaging Hardware (wiashext.dll)

3. **Network Related**
   - Network (netcenter.dll)
   - Network Hardware (netshell.dll)
   - Network Settings (pnidui.dll)
   - Network Services (dsuiext.dll)
   - Internet Explorer (ieframe.dll)
   - Internet Shortcuts (url.dll)
   - Remote Desktop (mstscax.dll)

4. **System Utilities**
   - Accessibility Features
   - Actions
   - Action Center
   - Access Control
   - Auto Play
   - Common Controls
   - Installation

5. **Legacy Icons**
   - Windows 95/98 (pifmgr.dll)
   - Old Programming Language (moricons.dll)
   - Old Computer Management (mmcndmgr.dll)
   - Old Windows Hardware (compstui.dll)

## Usage Notes
- Icons are accessed by their DLL location and index
- Copies icon path in Nilesoft Shell's icon.box format
- Shows number of available icons in each library

## Dependencies
Required Components:
- Windows Property System
- Nilesoft Shell framework
- Original system DLLs and executables

No additional software installation is required beyond the Nilesoft Shell framework and standard Windows components.