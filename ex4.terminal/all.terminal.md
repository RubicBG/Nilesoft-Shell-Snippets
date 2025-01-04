# Terminal Menu

## Source Code & Screenshots
### Snippet:
[`all.terminal.nss`](/ex4.terminal/all.terminal.nss)

### Screenshot:
![Screenshot 1](/ex4.terminal/all.terminal.png)

## Overview
Provides quick access to various command-line interfaces and terminal emulators from the Windows context menu.

## Key Features
- Multiple terminal options including Command Prompt, PowerShell, and Windows Terminal
- Administrator mode access via SHIFT key or right-click
- Custom color schemes for Command Prompt
- Support for multiple PowerShell versions
- Git CMD integration
- Path handling with escape character support

## Menu Structure
1. Command Prompt Options
   - Standard Command Prompt
   - Green-Black color scheme
   - Black-Blue color scheme
2. PowerShell Options
   - Windows PowerShell
   - PowerShell 7
   - PowerShell 7 Preview
3. Windows Terminal Options
   - Windows Terminal
   - Windows Terminal Preview
4. Git Integration
   - Git CMD

## Usage Notes
- Press SHIFT or use right-click to run terminals with administrator privileges
- Special handling for paths containing square brackets
- Automatic working directory setting to selected folder
- Visual feedback through disabled states for incompatible options

## Dependencies
Required Components:
- Windows Operating System
- Nilesoft Shell framework
- Windows Terminal (optional)
- Windows Terminal Preview (optional)
- PowerShell 7 (optional)
- PowerShell 7 Preview (optional)
- Git installation (optional)