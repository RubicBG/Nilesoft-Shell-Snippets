# Run with Priority

## Source Code & Screenshots

### Snippet:
[`ext.priority.nss`](/ex3.multifunction/ext.priority.nss)

### Screenshot:
![Screenshot 1](/ex3.multifunction/ext.priority.1.png)

## Overview

This Nilesoft Shell script adds a context menu option for Windows executable files (.exe) and shortcuts (.lnk) that allows you to launch applications with different CPU priority levels. It provides both temporary (session-based) and permanent (registry-based) priority settings, giving you granular control over how Windows allocates CPU resources to your applications.

## Key Features

- **Dual Priority Modes**: Choose between temporary (one-time launch) or permanent (always applies) priority settings
- **Six Priority Levels**: Realtime, High, Above Normal, Normal, Below Normal, and Low
- **Smart Shortcut Handling**: Automatically resolves .lnk shortcuts to their target executables
- **Visual Indicators**: Shows current permanent priority setting with checkmarks
- **Safety Warnings**: Includes descriptive tooltips explaining each priority level's effects
- **Registry Management**: Creates and manages Windows Image File Execution Options for permanent priorities
- **Intelligent Cleanup**: Only shows "Normal" reset option when custom priorities exist

## Menu Structure

### Temporary Priority Settings
These options launch the application once with the specified priority:

1. **Realtime** - Highest priority; use with extreme caution as it can freeze the system if the process hangs
2. **High** - High priority; good for performance-critical applications
3. **Above normal** - Slightly higher priority; provides balanced performance boost
4. **Normal** (default) - Standard Windows priority behavior
5. **Below normal** - Lower priority; runs in background with less CPU usage
6. **Low** - Lowest priority; minimal CPU usage, runs only when system is idle

### Permanent Priority Settings
A submenu that configures registry entries to always launch the executable with the chosen priority:

- Uses Windows Image File Execution Options registry keys
- Stores settings at: `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\[executable]\PerfOptions`
- Displays checkmarks (✓) next to currently active permanent priority
- "Normal" option removes custom registry entries and returns to default behavior
- Requires administrator privileges to modify registry

## Usage Notes

**Temporary vs Permanent:**
- Temporary settings apply only to the current launch session
- Permanent settings persist across reboots and affect all future launches

**Priority Recommendations:**
- **Realtime**: Use only for critical system tasks; can cause system instability
- **High/Above Normal**: Games, video editing, real-time audio processing
- **Normal**: Default for most applications
- **Below Normal/Low**: Background services, system maintenance, non-urgent tasks

**Administrative Requirements:**
- Temporary priority changes: No admin rights needed
- Permanent priority changes: Requires administrator privileges

**Safety Considerations:**
- Setting too many applications to High/Realtime can cause system instability
- Realtime priority should be reserved for extremely critical processes only
- The script intelligently cleans up registry entries when resetting to Normal

## Dependencies

- **Nilesoft Shell**: This script requires Nilesoft Shell to be installed
- **Windows NT Registry Access**: Permanent settings modify system registry
- **Administrator Rights**: Required only for permanent priority modifications
- **Compatible File Types**: Works with .exe files and .lnk shortcuts pointing to executables