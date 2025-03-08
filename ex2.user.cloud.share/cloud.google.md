# Google Drive Integration for Nilesoft Shell

## Source Code & Screenshots

### Snippet:
[`cloud.google.nss`](/ex2.user.cloud.share/cloud.google.nss)

### Screenshot:

## Overview
This snippet enhances Windows Explorer's context menu by customizing Google Drive integration options. It provides a cleaner and more organized interface for Google Drive functionality directly in your file explorer.

## Key Features
- Custom Google Drive menu with configurable name
- Support for Google Workspace file extensions

## Menu Structure
The extension modifies the following context menu items:
- "Sync or Backup this Folder"
- "Copy Link to clipboard"
- "Open with Google Drive"
- "Share with Google Drive"
- "Copy diagnostic info to clipboard"
- "Add shortcut to Drive"
- "Add shortcut to Google Drive"
- "Manage Version"
- "Refresh Folder"
- "Offline access"

## Usage Notes
- The menu name is customizable via the `$menu_gd_name` variable
- Handles both standard Google Drive extensions and web-compatible formats

## Dependencies
- Windows Operating System
- Nilesoft Shell framework
- Google Drive desktop application
