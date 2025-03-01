# Auto Rename Long Names

## Source Code & Screenshots

### Snippet:
[`all.autorename.nss`](/ex1.system/all.autorename.nss)

### Screenshot:
![Screenshot](/ex1.system/all.autorename.png)

## Overview

This Nilesoft Shell script adds an enhanced "Rename" context menu option that automatically shortens file or directory names when they exceed Windows' maximum path length limitations.

## Key Features
- Automatically shortens file names that exceed 259 characters
- Automatically shortens directory names that exceed 248 characters
- Shows tooltip with the number of characters that will be removed
- Appears in the same position as the standard Rename command

## Menu Structure
1. **Rename (auto)**
   - Appears in place of the standard Rename command
   - Only visible when the selected file/directory exceeds the maximum length
   - Shows a distinctive green-yellow rename icon
   - Provides tooltip showing how many characters will be removed

## Usage Notes
- The menu item only appears when a file or directory name exceeds Windows' maximum path length
- For files: Maximum path length is 259 characters
- For directories: Maximum path length is 248 characters

## Dependencies
Required Components:
- Windows Operating System
- Nilesoft Shell framework

No additional software installation is required beyond the Nilesoft Shell framework and standard Windows components.
