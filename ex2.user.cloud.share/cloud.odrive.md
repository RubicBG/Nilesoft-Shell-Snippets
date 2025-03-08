# ODrive Integration for Nilesoft Shell

## Source Code & Screenshots

### Snippet:
[`cloud.odrive.nss`](/ex2.user.cloud.share/cloud.odrive.nss)

### Screenshot:

## Overview
This snippet customizes the Windows Explorer context menu for ODrive integration.

## Key Features
- Customizable ODrive menu name 
- Path-aware context menu modifications

## Menu Structure
The extension modifies the following context menu items when in ODrive paths:
- "Sync"/"Unsync"
- "Refresh"
- "Share Link"
- "Share Storage"
- "Open Web Preview"

## Usage Notes
- The menu name is configurable via the `$menu_odrive_name` variable (default: 'ODrive')
- Menu items only appear when working with files/folders in the ODrive path

## Dependencies
- Windows Operating System
- Nilesoft Shell framework
- ODrive desktop application installed at default location
