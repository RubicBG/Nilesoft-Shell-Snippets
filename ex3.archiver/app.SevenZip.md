# 7-Zip Context Menu

## Source Code & Screenshots

### Snippet:
[`app.SevenZip.nss`](/ex3.archiver/app.SevenZip.nss)

### Screenshot:
![Screenshot 1)](/ex3.archiver/app.SevenZip.1.png)
![Screenshot 2)](/ex3.archiver/app.SevenZip.2.png)
![Screenshot 3)](/ex3.archiver/app.SevenZip.3.png)
![Screenshot 4)](/ex3.archiver/app.SevenZip.4.png)
![Screenshot 5)](/ex3.archiver/app.SevenZip.5.png)
![Screenshot 6)](/ex3.archiver/app.SevenZip.6.png)

## Overview
Enhanced context menu integration for 7-Zip, providing comprehensive archive management capabilities directly in Windows Explorer.

## Key Features
- Archive browsing and management
- Multiple compression formats (7z, ZIP, SFX)
- Password protection with header encryption
- Smart extraction detection
- Checksum generation and verification
- PPMd compression for text files
- Mail-ready archive creation
- Multiple extraction options with cleanup

## Menu Structure
1. Main Menu
   - Browse/Open with 7-Zip
   - Extract submenu
   - Archive submenu
   - Test submenu
   - 7-Zip Info submenu

2. Extraction Options
   - Smart extraction
   - Extract here
   - Extract to named folder
   - Extract with cleanup

3. Archive Options
   - Password protection
   - SFX creation
   - Multiple format support
   - Mail-ready archives

## Usage Notes
- SHIFT key toggles additional options
- Smart extraction detects single-directory archives
- Password protection can include filename encryption
- PPMd compression optimized for text files
- Supports archive testing and integrity verification

## Technical Details
- Supported Compression Formats:
  - Packing/Unpacking: 7z, XZ, BZIP2, GZIP, TAR, ZIP, WIM
  - Unpacking Only: APFS, AR, ARJ, CAB, CHM, CPIO, ISO, RAR, etc.
- Checksum Support: SHA256, SHA512, SHA1, MD5, CRC32, CRC64
- Custom SVG icons for menu items
- Registry-based command management
- PowerShell integration for smart extraction

## Dependencies
- Windows Operating System
- Nilesoft Shell framework
- 7-Zip installation (7z.exe, 7zG.exe, 7zFM.exe)
- Windows Shell32.dll
- Administrative privileges for some operations
- PowerShell for smart extraction features