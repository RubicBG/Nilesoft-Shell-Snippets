# PowerShell Archivator

## Source Code & Screenshots

### Snippet:
[`sys.compress.ps.nss`](/ex3.archiver/sys.compress.ps.nss)

### Screenshot:
![Screenshot 1](/ex3.archiver/sys.compress.ps.1.png)
![Screenshot 2](/ex3.archiver/sys.compress.ps.2.png)

## Overview
PowerShell Archivator is a shell extension menu that provides archive management capabilities through PowerShell commands. It enables users to create and extract ZIP files and create ISO images directly from the context menu.

## Key Features
- Extract ZIP files to named folders
- Create ZIP archives from files and directories
- Background extraction and compression operations
- ISO image creation with customizable media types
- Support for single and multiple file operations
- GUID-based naming options for extraction folders

## Menu Structure
1. ZIP Extraction Options
   - Extract to named folder
   - Extract multiple archives to separate folders
   - Silent background extraction

2. ZIP Creation Options
   - Create ZIP with selected items
   - Create ZIP with item contents
   - Silent background compression

3. ISO Creation
   - Create ISO with customizable label and media type
   - Support for various optical media sizes

## Usage Notes
- Paths with double spaces or square brackets are not supported
- Use SHIFT key for GUID-based naming
- Silent operations run in background
- ISO creation allows custom media title and type selection

## Dependencies
- Windows Operating System
- Nilesoft Shell framework
- Windows PowerShell
- System.IO.Compression.FileSystem
- IMAPI2FS.MsftFileSystemImage COM object