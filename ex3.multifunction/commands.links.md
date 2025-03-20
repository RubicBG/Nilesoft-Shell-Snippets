# Create NTFS Links

## Source Code & Screenshots

### Snippet:
[`commands.links.ps.nss`](/ex3.multifunction/commands.links.ps.nss)
or
[`commands.links.cmd.nss (unfinished)`](/ex3.multifunction/commands.links.cmd.nss)

### Screenshot:
![Screenshot 1](/ex3.multifunction/commands.links.0.png)

## Overview

Comprehensive Nilesoft Shell extension for creating different types of file system links in Windows.

## Key Features
- Create symbolic links for files and directories
- Create hard links for files
- Create soft links (junctions) for directories
- Link creation from various sources:
  - Current selection
  - Clipboard path
  - Specific file/folder selection

## Menu Structure
1. **Symbolic Links**
   - Create link from current item
   - Create link to specific location
   - Create link from file/folder
   - Create link from clipboard path

2. **Hard Links**
   - Create hard link from current file
   - Create hard link to specific location
   - Create hard link from selected file
   - Create hard link from clipboard file path

3. **Soft Links (Junctions)**
   - Create soft link from current directory
   - Create soft link to specific location
   - Create soft link from selected folder
   - Create soft link from clipboard folder path

## Usage Notes
- Links can span different volumes
- Supports linking to network shares
- Broken links remain but will error on access

## Dependencies
- Windows Operating System
- Nilesoft Shell framework
- PowerShell or Windows Command Prompt

No additional software installation is required beyond the Nilesoft Shell framework and standard Windows components.