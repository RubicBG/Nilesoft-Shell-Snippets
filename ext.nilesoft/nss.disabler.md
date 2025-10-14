# Nilesoft Shell: Context Menu Disabler

## Source Code & Screenshots

### Snippet:
[`nss.disabler.nss`](/ext.nilesoft/nss.disabler.nss)

### Screenshot:
![Screenshot 1](/ext.nilesoft/nss.disabler.1.png)
![Screenshot 2](/ext.nilesoft/nss.disabler.2.png)
![Screenshot 3](/ext.nilesoft/nss.disabler.3.png)
![Screenshot 4](/ext.nilesoft/nss.disabler.4.png)
![Screenshot 5](/ext.nilesoft/nss.disabler.5.png)

### Additional info:
See the detailed [Context Menu Speed Optimization Guide](/ext.nilesoft/nss.disabler.tut.md) for theory and advanced usage.

## Overview

A comprehensive Nilesoft Shell extension for managing and disabling Windows context menu items to improve performance and reduce clutter. This tool provides granular control over GUID-based context menu handlers from Windows built-in features, Microsoft applications, and third-party software.

**Primary Purpose:** Speed up context menu opening times by removing slow-loading GUID keys while maintaining essential functionality.

## Key Features

- **Quick Toggle System**: Temporarily or permanently disable all GUID-based context menu items with one click
- **Categorized Management**: Organized into Windows Built-in, Microsoft Applications, and Third-Party Applications
- **Safe Testing Mode**: "One session" option allows temporary testing without permanent changes
- **Advanced Registry Control**: Direct registry manipulation for items not handled by GUID keys
- **Visual Feedback**: Icons and color-coded tips indicate safety levels (success/warning/danger)

## Menu Structure

### 1. Quick Toggle (Top Level)
- **All Context Menu Items**: Master switch for all GUID-based entries
- **Standard Context Menu Items**: Controls non-UWP handlers (HKCR\CLSID)
- **UWP Context Menu Items**: Controls Universal Windows Platform handlers

**⚠️ CRITICAL WARNING**: The "Standard Context Menu Items" option is **hidden by default** (requires Shift key) because GUID `{9C07355E-C50A-45D2-B4A3-0A8235F8047F}` cannot be excluded. Disabling this can cause Explorer to terminate and restart repeatedly, potentially creating an infinite restart loop. Only use if you understand the risks.

### 2. Windows Built-in
Controls default Windows context menu items:
- Share
- Give access to
- Scan with Windows Defender
- Cast to Device
- Restore previous versions
- Rotate left/right
- Extract All
- Troubleshoot compatibility
- Next desktop background
- Install Fonts
- Add or edit stickers

### 3. Microsoft Applications
Manages Microsoft app integrations:
- **Cloud Services**: OneDrive, Skype
- **Editors**: Notepad (UWP), Paint (UWP), Photos (UWP), Clipchamp
- **AI Tools**: Copilot, Designer, Visual Search with Bing
- **Development**: Windows Terminal, Windows Terminal Preview
- **PowerToys**: PowerRename, File Locksmith, Image Resizer, NewPlus

### 4. Third-Party Applications
Controls third-party software entries:
- **Compression**: 7-Zip, NanaZip, WinRAR
- **Text Editors**: Notepad++, ABBYY FineReader
- **System Tools**: Start10/11, UnLockIT
- **Graphics Drivers**: NVIDIA Control Panel, AMD Radeon Software, Intel Graphics Settings

### 5. Settings
- **Reset all**: Removes all custom GUID configurations
- **Export settings**: Saves current configuration to registry file

### 6. Advanced Registry Control
Direct registry manipulation for items not handled by GUID keys:
- New, Send to, Open with
- Pin/Unpin options
- Copy as path, Copy/Move to folder
- Open file/folder location
- Always available offline

Tip: Always create a system restore point before making extensive changes. The Advanced Registry Control section requires Windows 11 for full compatibility.

## Usage Notes

### Speed Detection Workflow

1. **Identify Slow GUID Keys**:
   - Select files/folders to test
   - Hold `Alt` and right-click (menu blinks but doesn't open)
   - Check `shell.log` for timing results

2. **Measure Total Loading Time**:
   - Press `F12` and right-click
   - Check `shell.log` for total elapsed time

3. **Interpret Results**:
   ```
   1ms   {GUID} - Fast, no action needed
   50ms  {GUID} - Moderate, consider if bothering you
   200ms {GUID} - Slow, good candidate for removal
   ```

### Safety Levels

- **🟢 Success (Green)**: Safe to test, easily reversible
- **🟡 Warning (Yellow)**: Use with caution, test first
- **🔴 Danger (Red)**: Requires careful consideration, use Shift key to access

### Best Practices

1. **Always Test First**: Use "one session" options before making permanent changes
2. **Start Small**: Disable one category at a time to identify problems
3. **Keep Essentials**: Only remove items you don't use
4. **Document Changes**: Use export settings to save working configurations

### Important Considerations

- **Scope**: One GUID key typically controls an entire application's context menu presence
- **Timing**: Changes may not be immediate
- **Caching**: GUID processing times vary due to caching and system load
- **Antivirus**: Real-time scanning affects GUID key processing times

## Dependencies

### Required
- **Nilesoft Shell** (latest version recommended)
- Windows 10 or Windows 11

### Optional
- Administrator privileges (for Advanced Registry Control features)
- Applications listed in the configuration (for their respective menu items to appear)

### Technical Requirements
- File access: `shell.log` (created in Nilesoft Shell directory)
- Registry access: HKCR, HKCU, HKLM (varies by feature)
- PowerShell (for some advanced operations)

---

## Installation

1. Download the `nss.disabler.nss` file
2. Place it in your Nilesoft Shell installation directory (typically `C:\Program Files\Nilesoft Shell`)
3. Add the following line to your main `shell.nss` file:
   ```
   import 'nss.disabler.nss'
   ```
4. Restart Windows Explorer or reload Nilesoft Shell configuration with CTRL+SHIFT+RIGHT-CLICK
