# Windows Spotlight Enhancement

## Source Code & Screenshots

### Snippet
[`sys.spotlight.nss`](/ext.desktop/sys.spotlight.nss)

### Screenshots
![Screenshot 1)](/ext.desktop/sys.spotlight.1.png)
![Screenshot 2)](/ext.desktop/sys.spotlight.2.png)
![Screenshot 3)](/ext.desktop/sys.spotlight.3.png)

## Overview
This script enhances Windows Spotlight functionality by adding a context menu to manage desktop wallpapers and related content. It was developed in response to Microsoft's changes to the Windows Spotlight context menu, where traditional options like "Switch to next picture," "I like this picture," and "Not a fan of this picture" were removed in favor of a modern menu interface.

### Important Note
This NS script generates commands based on the information provided by the modern context menu. Future updates from Microsoft to Windows Spotlight might affect the script's functionality. Users should be aware that changes in Windows Spotlight's core functionality could impact the script's performance.

## Key Features
- Context menu integration for Windows Spotlight
- Wallpaper management capabilities
- Related content display
- Developer tools and settings
- Current wallpaper information display with photographer credits
- Quick navigation through Spotlight wallpaper collection (4 images per session)
- Direct access to wallpaper information and related web content
- Wallpaper saving functionality

## Menu Structure

### Main Menu Items
1. Current wallpaper information with photographer credits (shown as tooltip)
2. "Learn more" link to detailed web content about the image
3. Next wallpaper option (cycles through four available images)
4. Individual wallpaper submenus (one for each available image)

### Per-Wallpaper Submenu
Each wallpaper has a dedicated submenu containing:
- Landscape information
- Copyright details (displayed as tooltip)
- Description (available offline, no internet connection required)
- View/Set wallpaper options
- Related links (if enabled by feature flags)

### Management Options
- Save wallpaper to custom location
- Change icon
  * Can be set with "invisible" icon
  * "Cancel" restores default icon
- Rename functionality
  * Supports empty names
  * "Cancel" restores default name
- Delete option
  * Protected by Shift-key requirement
  * Automatically creates .reg file for restoring the icon
- Settings management

### Settings Submenu
- Related content toggles
  * Default values can be configured in code
  * Separate toggles for content and hotspots
- Quick access to Windows settings:
  * Background customization
  * Color schemes
  * Lock screen options

### Developer Menu (Shift-key activated)
- Image path information
- Current image folder access
- Registry information
- Additional resources
- Links to Windows Spotlight documentation

## Technical Components

### Data Processing
The script processes multiple data arrays from Windows Registry:
- Image paths and metadata
- Text content (titles, descriptions, copyright)
- Related URLs and links
- System identifiers

### Registry Integration
Primary registry key: `HKCU\Software\Microsoft\Windows\CurrentVersion\DesktopSpotlight\Creatives`

Data extracted includes:
- Asset paths (both full and cropped versions)
- Icon hover text
- Icon labels
- Titles
- Descriptions
- Copyright information
- CTA (Call-to-Action) text and URLs
- System IDs

### Feature Flags
- `use_relatedContent`: Toggle for related content display
- `use_relatedHotspots`: Toggle for related hotspots
- Validation checks for content availability
- Flags can be preset in code for default behavior

## Usage Notes

### Keyboard Shortcuts
- Shift + Click: Opens cropped wallpaper version instead of full version
- Shift: Enables developer menu with additional options
- Shift: Required for delete operation (safety measure)

### Related Content
Content availability depends on:
- System language settings
- Feature flag configuration
- Content presence in registry
- Internet connectivity (for web links only)

### User Interface
- Top section: Current wallpaper name and photographer credits
- Navigation: Simple "Next" option for cycling through images
- Information: Detailed metadata for each wallpaper
- Quick actions: Save, view, and set wallpaper options
- Safety: Protected delete operation with recovery option

## Dependencies
- Windows Registry access
- PowerShell execution capabilities
- Windows Spotlight service
- System icon resources
- Windows modern context menu system
