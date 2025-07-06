# Advanced Selection Menu for Nilesoft Shell

## Source Code & Screenshots

### Snippet: [`sys.select.mega.nss`](/ex3.multifunction/sys.select.mega.nss)

### Screenshot:
![Screenshot 1](/ex3.multifunction/sys.select.mega.1.png)
![Screenshot 2](/ex3.multifunction/sys.select.mega.2.png)
![Screenshot 3](/ex3.multifunction/sys.select.mega.3.png)
![Screenshot 4](/ex3.multifunction/sys.select.mega.4.png)
![Screenshot 5](/ex3.multifunction/sys.select.mega.5.png)


## Overview

This advanced selection menu snippet for Nilesoft Shell provides comprehensive file and folder selection capabilities beyond the standard Windows Explorer selection options. it offers intelligent filtering, pattern matching, and metadata-based selection through PowerShell integration with Windows Shell APIs.

The menu appears everywhere, but the advanced selection options are available only in Windows Explorer and provides both quick selection shortcuts and advanced filtering options for power users who need to manage large numbers of files efficiently.

## Key Features

- **Smart Context Detection**: Automatically detects file types, folders, and special locations to show relevant options
- **PowerShell Integration**: Uses Windows Shell COM objects for precise file selection control
- **Metadata-Based Selection**: Selects files by Windows perceived types (audio, video, image, document, etc.)
- **Pattern Matching**: Advanced search capabilities including regex patterns and wildcard matching
- **Size-Based Filtering**: Select files by size ranges from empty files to multi-gigabyte files
- **Date-Based Selection**: Filter by modification dates (today, this week, this month, older files)
- **Development-Friendly**: Special categories for source code, web files, and configuration files
- **Toggle Functionality**: Hold Shift to deselect instead of select items
- **Checkbox Integration**: Built-in toggle for Windows Explorer item checkboxes

## Menu Structure

**Main Menu Items:**
- All (Ctrl+A) - Select all items in current folder
- Invert - Toggle selection state of all items
- None - Clear current selection
- Item Checkboxes - Toggle Windows Explorer selection checkboxes

**Advanced Selection Submenus:**
- **Basic Types**: All Folders, All Files, Nilesoft Shell Files, Microsoft Office Files
- **Search in Names**: Pattern matching including numbers, specific letters, and keyword searches
- **Development Files**: Source code, web files, and configuration files by extension
- **Meta Types**: Selection by Windows perceived file types (slower but accurate)
- **By File Size**: Empty files, size ranges from KB to GB, and custom size ranges
- **By Date**: Modified today, this week, this month, or older than 6 months

## Usage Notes

**Selection Behavior:**
- Default behavior selects matching items
- Hold **Shift** while clicking to deselect matching items instead
- Right-click selections include focus behavior for better navigation

**Performance Considerations:**
- Meta Types menu is marked as "slow" due to registry lookups for accurate type detection
- Basic file extension matching is faster than perceived type detection
- Large folders with thousands of files may experience noticeable delays

**Context Sensitivity:**
- Menu automatically hides irrelevant options (e.g., file size options when only folders are present)
- Detects special Windows locations and adjusts available options accordingly
- Prevents conflicts when selecting items that don't match the current context

## Dependencies

**System Requirements:**
- Windows 10/11 with PowerShell 5.1 or later
- Nilesoft Shell installed and configured
- Windows Shell COM objects (standard Windows installation)

**Performance Notes:**
- **PowerShell Loading Lag**: Initial PowerShell command execution may have 1-2 second delay on first use per session
- **Windows API Calls**: Selection operations use Shell COM objects which can be slower than native Windows operations
- **OS Speed Dependency**: Performance scales with system specifications - faster CPUs and SSDs significantly improve response times
- **Memory Usage**: Large folder operations may temporarily increase memory usage during PowerShell execution
- **Registry Access**: Meta Types functionality requires registry reads which add latency but provide accurate file type detection

**Optimization Tips:**
- Use basic file extension matching when possible instead of Meta Types for better performance
- Consider folder size when using advanced selection options
- PowerShell execution speed improves after initial load within the same Windows session