# Nilesoft Shell: Context Menu Speed Optimization Guide

## 1. Theory

### Legacy vs Modern Context Menu Loading Behavior

**Legacy Context Menu (Windows 10 style):**
- **Synchronous Loading**: Waits for ALL menu items and extensions to load before displaying
- **Blocking Behavior**: The entire menu must be ready before it appears
- **Performance Impact**: Slow GUID keys delay the entire menu opening

**Modern Context Menu (Windows 11 default):**
- **Asynchronous Loading**: Opens immediately with basic items, loads additional items progressively  
- **Non-blocking**: Shows available items first, adds others as they become ready
- **Performance Impact**: Less noticeable delays from slow extensions

**Nilesoft Shell Behavior:**
- **Based on legacy context menu architecture**
- Loads sub-menu items **on sub-menu opening**
- Commands not in the main/first level don't affect opening speed at all
- Only processes items when their parent menu is accessed

### Understanding Windows Legacy Context Menu Structure

The Windows context menu commands are organized into three distinct groups, each with different performance characteristics:

#### Group 1 (G1) - Basic Commands
- **Position**: Bottom of context menu
- **Examples**: Cut, Copy, Paste, Delete, Properties
- **Behavior**: "Passive" commands that don't check object properties before displaying
- **Performance Impact**: Minimal - these commands determine the menu's foundation but don't affect opening speed

#### Group 2 (G2) - Registry-Based and Simple Shell Extensions
- **Position**: Top of context menu
- **Examples**: Open, Explore, Open in New Tab, Print, some system shell extensions
- **Behavior**: Check only file extension or object type (folder, drive, network location, etc.)
- **Performance Impact**: Negligible delay - simple extension/type detection

#### Group 3 (G3) - GUID-Based Commands (Dynamic)
- **Position**: Between G1 and G2
- **Examples**: 7-Zip menus, WinRAR options, Dropbox commands, "Open With", "Send To"
- **Behavior**: Handled via GUID keys that act as information agents
- **Performance Impact**: **Primary cause of slow context menu opening**

### The GUID Key Problem

GUID keys in G3 perform complex operations:
- Collect various object properties from Windows
- Perform custom checks on selected objects
- Determine whether commands/menus should be displayed
- Can check file extensions, file sizes, number of selected files
- May perform resource-intensive operations on graphics and video files

### Performance Bottlenecks

The delay increases with:
- Number of selected files
- File sizes (especially large files)
- Complex file types (graphics, video formats)
- Multiple third-party applications with context menu integrations
- Antivirus software scanning GUID key operations in real-time

## 2. Usage

### NS Speed Detection

#### GUID Keys Detection
1. Select the desired object(s) you want to analyze
2. Hold `Alt` and right-click
3. The context menu will blink but not open
4. Check `shell.log` for timing results

#### Total Loading Time Check
1. Press `F12` and right-click to measure overall context menu loading time
2. Check `shell.log` for the total elapsed time result (e.g., "1173 ms Elapsed time to load context menu")

### Reading shell.log Results

Example output format:
```
1ms {E61BF828-5E63-4287-BEF1-60B1A4FDE0E3} 
107ms {BAE3934B-8A6A-4BFB-81BD-3FC599A1BAF1}
111ms {B97E7965-F679-4A55-A272-78DDDC3C012F} UWP
```

**Understanding the format:**
- `Time` - Processing duration for the GUID key
- `{GUID}` - Unique identifier for the context menu handler  
- `UWP` - Indicates Universal Windows Platform application
- `0ms` - No checks performed or cached information from previous operations

**Important Notes:**
- Times can vary between runs due to caching, system load, and antivirus scanning
- Each Alt+Right-click reloads NS scripts and provides current timing
- Antivirus software may affect GUID key processing times in real-time

### Identifying GUID Keys

#### For Non-UWP Applications:
- Registry location: `HKCR\CLSID\{GUID}`
- Search web or check registry for GUID information

#### For UWP Applications:
- Registry location: `HKCR\PackagedCom\ClassIndex\`
- Often Windows Store applications

### Removing Problematic GUID Keys

#### Syntax for Non-UWP:
```
remove(clsid='{GUID-HERE}' where=!this.isuwp)
```

#### Syntax for UWP:
```
remove(clsid='{GUID-HERE}' where=this.isuwp)
```

#### Example Implementation:
```
remove(clsid='{b8cdcb65-b1bf-4b42-9428-1dfdb7ee92af}' where=!this.isuwp)
remove(clsid='{CB3B0003-8088-4EDE-8769-8B354AB2FF8C}' where=this.isuwp)
```

### Important Considerations

1. **Scope of Removal**: One GUID key typically controls an entire application's context menu presence
   - Removing 7-Zip's main GUID removes all 7-Zip menus (including drag-and-drop menus)

2. **Effect Timing**: Changes may not be immediate
   - Sometimes requires time to take effect
   - Restarting `explorer.exe` may help but doesn't guarantee immediate results

3. **Namespace Recognition**: Nilesoft Shell recognizes various namespace types:
   - Files and folders (local and network)
   - Drives (local, removable, network)  
   - Virtual folders (Control Panel, Recycle Bin)
   - Network locations and mapped drives
   - Special shell locations

## 3. Benefits

**Faster Context Menu Opening**  
   - Reduces delay, especially with large files or many selections.  
   - Noticeable improvement on image and video formats.

**Custom Control**  
  - Remove only unnecessary or slow third-party menu entries.  
  - Keep the essential ones.

**Cleaner Context Menu**  
  - Removes clutter from apps that add too many options.

**Safe Testing**  
  - You can test GUID removal without permanently editing Windows registry.  
  - Easily revert changes by editing/removing NS rules.