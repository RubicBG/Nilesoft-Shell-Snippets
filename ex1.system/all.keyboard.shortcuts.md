# Windows Keyboard Shortcuts Menu Enhancement

## Source Code & Screenshots

### Snippet:
[`all.keyboard.shortcuts.nss`](/ex1.system/all.keyboard.shortcuts.nss)

### Screenshot:
![Screenshot 1](/ex1.system/all.keyboard.shortcuts.1.png)
![Screenshot 2](/ex1.system/all.keyboard.shortcuts.2.png)
![Screenshot 3](/ex1.system/all.keyboard.shortcuts.3.png)
![Screenshot 5](/ex1.system/all.keyboard.shortcuts.4.png)
![Screenshot 5](/ex1.system/all.keyboard.shortcuts.5.png)

## Overview
A Nilesoft Shell extension that enhances the Windows context menu by adding keyboard shortcut information to standard menu items and introducing additional commands with keyboard shortcuts for improved productivity.

## Key Features
- Displays keyboard shortcuts for common Windows operations
- Adds tooltips with additional information for certain actions
- Introduces new commands with keyboard shortcuts in the View menu
- Modifies standard menu items with enhanced shortcut information
- Customizes contextual behavior based on selection and window type

## Menu Structure
- Common Operations
  - Open, Cut, Copy, Paste, Delete with keyboard shortcuts
  - Rename, Undo, Redo, Select All with shortcuts
  - Copy as Path, Refresh, Properties with shortcuts
- View Menu Enhancements
  - Icon size shortcuts (Extra Large to Content)
  - Column Arrange (Ctrl+Shift+C)
  - Expand Navigation Pane (Ctrl+Shift+E)
  - Navigation shortcuts (Up, Back, Forward)
  - Desktop icon settings command

## Usage Notes
- Displays keyboard shortcuts alongside menu items for quick reference
- Window-specific commands appear only in appropriate contexts
- Custom tooltips provide additional information
- Introduces consistent keyboard shortcuts across Windows Explorer

## Dependencies
Required Components:
- Windows Operating System
  - System resources (shell32.dll)
  - String resources for localization support 
- Nilesoft Shell framework

No additional software installation is required beyond the Nilesoft Shell framework and standard Windows components.
