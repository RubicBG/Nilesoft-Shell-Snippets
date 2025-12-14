# TreeView Advanced Menu (Testing)

## Source Code & Screenshots

### Snippet:
[`treeview.advance.nss`](/ext.others/treeview.advance.nss)

### Export Script:
[`treeview.reg.export.namespace.ps1`](/ext.others/treeview.reg.export.namespace.ps1)

### Screenshot:
![Screenshot 1](/ext.others/treeview.advance.1.png)
![Screenshot 2](/ext.others/treeview.advance.2.png)
![Screenshot 3](/ext.others/treeview.advance.3.png)
![Screenshot 4](/ext.others/treeview.advance.4.png)
![Screenshot 5](/ext.others/treeview.advance.5.png)
![Screenshot 6](/ext.others/treeview.advance.6.png)
![Screenshot 7](/ext.others/treeview.advance.7.png)
![Screenshot 8](/ext.others/treeview.advance.8.png)
![Screenshot 9](/ext.others/treeview.advance.9.png)

## Overview

Advanced context menu for Windows Explorer's navigation pane (TreeView) that provides comprehensive control over which objects appear in the sidebar. Allows customization of system folders, drives, cloud storage, and custom paths with full attribute management.

**⚠️ WARNING: This is a testing version. Registry modifications carry inherent risks.**

## Key Features

- **Manage Navigation Pane Objects**: Show/hide Home, Quick Access, This PC, Libraries, Cloud storage, and system folders
- **Custom Path Objects**: Create up to 4 custom navigation pane entries from any folder path
- **Drive Management**: Add individual drives (C:, D:, E:, F:) to navigation pane
- **Special Objects**: Add God Mode (All Tasks), Applications folder, Quick access (Win11)
- **Position Control**: Adjust display order of objects in navigation pane
- **Multiple Locations**: Show objects in Navigation Pane, This PC, and Desktop
- **Attribute Management**: Fine-grained control over folder permissions (copy, move, delete, rename, etc.)
- **Export/Import**: Backup and restore navigation pane configurations

## Menu Structure

### Main Categories

**Home / Quick access**
- Favorites (with advanced attributes control)
- Quick access/Home folder (Win10/Win11 specific)
- Recent files, frequent folders, Office.com files toggles
- Reset options for favorites and recent files

**Clouds**
- OneDrive visibility and status indicators
- Dropbox integration
- Google Drive placeholder

**Private**
- Gallery, User Folder, Cross Device
- Desktop, Documents, Downloads, Pictures, Music, Videos
- Local vs OneDrive variants
- 3D Objects (if available)
- Libraries

**This PC**
- This PC folder visibility
- Hide specific drives (A: through Z:)
- Private folders under This PC
- Network location shortcuts

**System**
- Removable Drives, Network, Control Panel
- Device Center, Printers (hidden by default)
- Linux (WSL), Recycle Bin

**Custom**
- Nilesoft Shell directory entries
- 4 configurable custom path slots
- Individual drive letters (C:, D:, E:, F:)
- Special objects: God Mode, Applications, Quick access

**Panes**
- Navigation pane width reset
- Details and Preview pane toggles
- Width reset for right panes

**Settings**
- Open File Explorer to: Home/This PC/Downloads/Cloud/Custom
- Compact view toggle
- Folder options and Desktop icons

## Usage Notes

### Before Using

1. **Create Backup First**: Run the included PowerShell script to export current settings:
   ```powershell
   .\treeview.reg.export.namespace.ps1
   ```
   This creates `exported_registry.reg` for restoration if needed.

2. **Administrative Rights**: Some operations require admin privileges. When prompted:
   - Changes affect ALL users (system-wide)
   - Without admin: Changes affect current user only

### Testing Status

**Working Commands:**
- All visible menu items function correctly
- Object creation for custom paths (up to 4)
- Show/hide toggles for all system objects
- Position adjustments
- Desktop and This PC placement

**Not Yet Implemented:**
- Export command for custom objects
- Individual registry export (planned)

**Hidden Commands (Shift key):**
- Testing features only - use with caution
- May have incomplete functionality

### Attributes Menu

First 7 attributes control context menu options:
- **Can Copy**: Enable/disable Ctrl+C
- **Can Move/Cut**: Enable/disable Ctrl+X
- **Can Create Link**: Show/hide "Create shortcut"
- **Has Storage**: Required for folder functionality
- **Can Rename**: Enable/disable F2 rename
- **Can Delete**: Enable/disable Delete key
- **Has Property Sheet**: Show/hide Properties dialog

Other attributes affect visual appearance and behavior but are experimental.

### Windows Version Compatibility

- **Windows 11**: Fully tested on Win11
- **Windows 10**: Several commands tested, not all features verified
- Version-specific items automatically show/hide based on OS

### Custom Objects

To create a custom navigation pane entry:
1. Navigate to **Custom** menu
2. Select empty slot (custom path 1-4)
3. Click "create" option
4. Choose folder via dialog
5. Optionally select custom icon
6. Object appears after Explorer restart

## Dependencies

- **Nilesoft Shell**: Required for all functionality
- **PowerShell**: For registry export script
- **Administrator Rights**: Optional, but some features require elevation
- **Windows 10/11**: Designed for modern Windows versions

## Safety Recommendations

1. **Always backup first** using the export script
2. **Test on non-production system** initially
3. **One change at a time** to identify issues
4. **Note admin prompts** - these affect all users
5. **Keep exported_registry.reg** for emergency restoration

## Known Limitations

- Maximum 4 custom path objects
- Some Win10 features untested
- Export for custom objects incomplete
- Attributes beyond first 7 are experimental
- Registry changes require Explorer restart