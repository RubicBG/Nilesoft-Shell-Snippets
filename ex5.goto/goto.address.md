# Go To Address Bar Menu for Nilesoft Shell

## Source Code & Screenshots

### Snippet:
[`goto.address.nss`](/ex5.goto/goto.address.nss)

### Screenshot:
![Screenshot 1](/ex5.goto/goto.address.png)

## Overview
The Go To Address Bar Menu is a Nilesoft Shell extension that provides quick access to your File Explorer address bar history. This implementation offers an efficient way to access previously visited locations through a convenient context menu, enhancing Windows File Explorer navigation capabilities.

## Key Features
- Access to up to 26 recently typed paths in File Explorer
- Intelligent path display with simplified formatting
- Full path tooltips on hover
- Smart navigation within existing or new windows
- Context-aware behavior in File Explorer
- One-click history clearing option
- Path existence verification before display

## Menu Structure
1. **History Entries**
   - Shows up to 26 most recent typed paths (url1 through url26)
   - Each entry displays in simplified format:
     - Root drives shown in full (e.g., "C:\")
     - Other paths shown as "...\ParentFolder\CurrentFolder"
   - Full paths available as tooltips

2. **Management Options**
   - "Clear Address Bar history" option at the bottom

## Usage Notes
- Menu appears only when address bar history exists
- Click normally to navigate in current window
- Hold Shift to open location in new window
- Tooltips show full paths on hover
- Entries only appear if paths still exist
- History can be cleared through the menu interface

## Technical Details
- **Registry Path**: `HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\TypedPaths`

## Dependencies
- Windows Operating System
- Nilesoft Shell framework
- Windows history tracking enabled

No additional software installation is required beyond the Nilesoft Shell framework and standard Windows components.