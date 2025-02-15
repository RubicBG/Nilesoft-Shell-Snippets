# Go To Menu for Nilesoft Shell

## Source Code & Screenshots

### Snippet:
[`goto.reg.nss`](/ex5.goto//goto.reg.nss)

### Screenshot:
![Screenshot 1](/ex5.goto/goto.reg.png)

## Overview
A Nilesoft Shell script that adds a "Go To" context menu to Windows Explorer, allowing users to save and quickly navigate to up to 5 frequently accessed locations.

## Key Features
- Store up to 5 directory paths in the Windows Registry
- Quick navigation to saved locations
- Path display shows simplified format for better readability
- Automatic path validation before displaying menu items
- Clear function to remove all saved paths

## Menu Structure
- "Add current path" option with counter (x/5)
- List of saved paths (up to 5 entries)
- Clear option to remove all saved paths

## Usage Notes
- Click normally to navigate in current window
- Hold Shift to open location in new window
- Duplicate paths are prevented from being added
- Invalid or non-existent paths are automatically hidden

## Technical Details
- **Registry Path**: `HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\TypedPaths`

## Dependencies
- Windows Operating System
- Nilesoft Shell framework

No additional software installation is required beyond the Nilesoft Shell framework and standard Windows components.