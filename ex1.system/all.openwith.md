# Open With Menu Replacement

## Source Code & Screenshots

### Snippets:
[`all.openwith.simple.nss`](/ex1.system/all.openwith.simple.nss)<br>
[`all.openwith.minimal.ml.nss`](/ex1.system/all.openwith.minimal.ml.nss)

### Screenshot:
![Screenshot 1](/ex1.system/all.openwith.simple.png)
![Screenshot 2](/ex1.system/all.openwith.minimal.ml.png)

## Overview
These Nilesoft Shell scripts replace the default Windows "Open With" menu with custom versions

## Key Features
- Replaces the default Windows "Open With" menu
- Provides direct access to the "Choose another app" dialog
- Enhanced version adds Microsoft Store search for file extensions
- Enhanced version adds web search for file extension information

## Menu Structure

### Enhanced Version (`all.openwith.simple.nss`):
1. **Main "Open With" Menu**
   - "Choose another app" entry that opens the standard Windows Open With dialog
   - Sub-menu with additional options:
     - Microsoft Store search for the file extension
     - Web search for "What is this extension?"

### Minimal Version (`all.openwith.minimal.ml.nss`):
1. **Single Menu Entry**
   - Direct "Open With" menu item that opens the standard Windows dialog

## Usage Notes
- Both versions remove the default Windows "Open With" menu items
- Enhanced version works with both files and directories
- Enhanced version provides additional options only for files (not directories)
- Microsoft Store search links directly to the store filtered by the file extension
- Web search uses file-extensions.org for extension information
- The minimal version provides a cleaner context menu with the same core functionality
- Choose which version to implement based on your preference for functionality vs. simplicity

## Dependencies
Required Components:
- Windows Operating System
- Nilesoft Shell framework

No additional software installation is required beyond the Nilesoft Shell framework and standard Windows components.