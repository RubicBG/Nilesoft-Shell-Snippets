# Clipboard Save Image

## Source Code & Screenshots

### Snippet:
[`all.clipboard.save.nss`](/ex1.system/all.clipboard.save.nss)

### Screenshot:
![Screenshot](/ex1.system/all.clipboard.save.png)

## Overview

This Nilesoft Shell script adds a "Save Image" context menu option that allows users to quickly save clipboard images as PNG files.

## Key Features
- One-click saving of clipboard images to PNG files
- Automatic filename generation using date and time
- Strategic menu positioning near the Paste command
- Only appears when an image is actually in the clipboard
- Works on directories, drives, and desktop

## Menu Structure
1. **Save Image**
   - Single menu item that appears in the context menu
   - Positioned at the same level as the Paste command
   - Includes tooltip explaining the functionality
   - Shows a custom save icon

## Usage Notes
- The menu item only appears when an image is present in the clipboard
- Files are automatically named with date and time stamps (format: ymd-HMS.png)
- The script uses PowerShell to access clipboard data and save the image
- A system beep confirms successful saving
- The menu option only appears when right-clicking on directories, drives, or the desktop

## Dependencies
Required Components:
- Windows Operating System
- Nilesoft Shell framework

No additional software installation is required beyond the Nilesoft Shell framework and standard Windows components.
