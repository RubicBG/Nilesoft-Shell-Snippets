# Windows Namespace Extensions - Complete Guide

## Table of Contents
1. [Introduction](#introduction)
2. [Registry Structure Overview](#registry-structure-overview)
3. [Key Components Explained](#key-components-explained)
4. [CLSID Types Comparison](#clsid-types-comparison)
5. [Attributes Deep Dive](#attributes-deep-dive)
6. [Target Properties](#target-properties)
7. [Working Examples](#working-examples)
8. [Resources](#resources)

---

## Introduction

Windows Namespace Extensions allow you to integrate custom folders, drives, and virtual locations into Windows Explorer's navigation tree. This creates seamless integration that makes your custom locations appear as native Windows folders.

### What Can You Do With Namespace Extensions?

- Add custom folders to "This PC"
- Create quick access to drives (C:\, D:\, etc.)
- Add virtual folders (shell:::guid)
- Integrate application folders into Explorer
- Add network locations (UNC paths, WSL)
- Create shortcuts to shell locations

### How It Works

Namespace extensions use the Windows Registry to register COM objects (Component Object Model) that tell Windows Explorer how to display and interact with your custom locations. When Explorer encounters your CLSID, it uses the registered COM handler to render the folder.

---

## Registry Structure Overview

Every namespace extension requires these main registry keys:

```
HKEY_CURRENT_USER\Software\Classes\CLSID\{YOUR-GUID-HERE}
├── (Default)                    # Display name
├── InfoTip                      # Tooltip text
├── SortOrderIndex               # Position in list
├── System.IsPinnedtoNameSpaceTree  # Pin to nav pane
├── DefaultIcon\                 # Icon configuration
├── InProcServer32\              # COM DLL handler
├── Instance\                    # Implementation details
│   └── InitPropertyBag\         # Initialization parameters
└── ShellFolder\                 # Folder behavior attributes
```

### Registration Locations

**For Current User Only:**
```
HKEY_CURRENT_USER\Software\Classes\CLSID\{GUID}
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{GUID}
```

**For All Users (requires admin):**
```
HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{GUID}
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{GUID}
```

**For Network Neighborhood:**
```
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\NetworkNeighborhood\NameSpace\{GUID}
```

**Note:** You can also use `HKEY_CLASSES_ROOT\CLSID\{GUID}` which merges HKLM and HKCU settings.

---

## Key Components Explained

### 1. CLSID (Class Identifier)

A CLSID is a globally unique identifier (GUID) that identifies your namespace extension. Each extension needs a unique CLSID.

**Format:** `{00000000-0000-0000-0000-000000000000}`

**Generating a GUID:**
- PowerShell: `[guid]::NewGuid()`
- Online: Use a [`GUID generator`](https://www.guidgen.com/)
- Visual Studio: Tools → Create GUID

**Important:** 
- Never reuse CLSIDs from other applications
- Each namespace extension needs its own unique CLSID
- Keep the CLSID consistent once deployed

### 2. Display Properties

```reg
[HKEY_CURRENT_USER\Software\Classes\CLSID\{YOUR-GUID}]
@="Display Name"                                 # Name shown in Explorer
"CreatedBy"="Your Application Name"              # Optional metadata
"InfoTip"="Tooltip description"                  # Hover text
"SortOrderIndex"=dword:00000050                  # Sort position (0x50 = 80)
"System.IsPinnedtoNameSpaceTree"=dword:00000001  # Pin to nav pane
```

**SortOrderIndex Values:**
- Lower numbers appear first
- `0x00000042` (66) - Network, OneDrive
- `0x00000050` (80) - Common position
- `0x00000054` (84) - User folders
- Use values between 0x40-0x60 for best placement

### 3. DefaultIcon

Specifies which icon to display for your namespace extension.

```reg
[HKEY_CURRENT_USER\Software\Classes\CLSID\{YOUR-GUID}\DefaultIcon]
@="path\\to\\icon.ico"                    # .ico file
@="path\\to\\file.exe,0"                  # Icon from executable (index 0)
@="imageres.dll,-36"                      # System icon (negative = resource ID)
@="%systemroot%\\system32\\shell32.dll,4" # Environment variable + index
```

**Common System Icons:**
- `imageres.dll,-36` - Hard drive
- `imageres.dll,-27` - Settings/Control Panel
- `shell32.dll,4` - Folder

### 4. InProcServer32

Specifies the COM DLL that implements the namespace extension handler.

```reg
[HKEY_CURRENT_USER\Software\Classes\CLSID\{YOUR-GUID}\InProcServer32]
@="shell32.dll"                           # Recommended for most cases
"ThreadingModel"="Both"                   # Threading model
```

**Available Options:**

| DLL | Status | When to Use |
|-----|--------|-------------|
| `shell32.dll` | ✅ **Recommended** | Modern, maintained, works for all types |
| `shdocvw.dll` | ⚠️ Legacy | Deprecated, but still works for compatibility |

**Threading Models:**

| Model | Description | Use Case |
|-------|-------------|----------|
| `Both` | Works in STA or MTA | **Recommended** - Most flexible, best performance |
| `Apartment` (STA) | Single-threaded apartment | Legacy code, not thread-safe |

**Why "Both" is Better:**
- Modern Windows Explorer uses multi-threading
- Better performance with concurrent operations
- Windows-provided COM objects are already thread-safe

**[Official Documentation](https://learn.microsoft.com/en-us/windows/win32/cossdk/threading-model-attribute)**

### 5. Instance

Defines which COM class implementation to use.

```reg
[HKEY_CURRENT_USER\Software\Classes\CLSID\{YOUR-GUID}\Instance]
"CLSID"="{IMPLEMENTATION-CLSID}"          # Which handler to use
```

**Common Implementation CLSIDs:**

| CLSID | Name | Purpose |
|-------|------|---------|
| `{0afaced1-e828-11d1-9187-b532f1e9575d}` | Folder Shortcut | Simple folder pointer - fast, lightweight |
| `{0E5AAE11-A475-4c5b-AB00-C66DE400274E}` | Explorer Browser | Advanced folder browser - more features |

[CLSID Types Comparison](#clsid-types-comparison)

### 6. InitPropertyBag

Initialization parameters that tell Windows where/what to display.

```reg
[HKEY_CURRENT_USER\Software\Classes\CLSID\{YOUR-GUID}\Instance\InitPropertyBag]
"Attributes"=dword:00000011               # File attributes (FILE_ATTRIBUTE flags)
"Target"="C:\\Path\\To\\Folder"           # Universal property - works for most targets
```

**Attributes (FILE_ATTRIBUTE flags):**

| Value | Flag | Meaning |
|-------|------|---------|
| `0x01` | READONLY | Cannot modify |
| `0x02` | HIDDEN | Hidden by default |
| `0x04` | SYSTEM | System folder |
| `0x10` | DIRECTORY | Is a directory |
| `0x20` | ARCHIVE | Archive bit set |

**Common Combinations:**
- `0x11` (17) - READONLY + DIRECTORY - Read-only folder
- `0x15` (21) - READONLY + SYSTEM + DIRECTORY - Protected system folder
- `0x10` (16) - DIRECTORY only - Normal folder

[Official Documentation](https://learn.microsoft.com/en-us/windows/win32/fileio/file-attribute-constants)

**Target Property Names:**

| Property | Use For | Example |
|----------|---------|---------|
| `Target` | Physical folders | `C:\Program Files\MyApp` |
| `TargetFolderPath` | Drive roots | `C:\` or `D:\` |
| `TargetKnownFolder` | Shell GUIDs | `{ED7BA470-8E54-465E-825C-99712043E01C}` |

[Target Properties](#target-properties)

### 7. ShellFolder

Defines the behavior and capabilities of the folder in Windows Explorer.

```reg
[HKEY_CURRENT_USER\Software\Classes\CLSID\{YOUR-GUID}\ShellFolder]
"Attributes"=dword:f080004d               # SFGAO flags (Shell Folder Get Attributes)
"FolderValueFlags"=dword:00000028         # Additional flags (usually 0x28)
```

**Attributes:**

[Attributes Deep Dive](#attributes-deep-dive)

[Official Documentation](https://learn.microsoft.com/en-us/windows/win32/shell/sfgao)

**FolderValueFlags:**
- `0x00000028` (40) - Standard value for most folders
- `0x00000228` (552) - Alternative value (seen in some configurations)
- Can usually be omitted for simple cases

---

## CLSID Types Comparison

### Folder Shortcut: `{0afaced1-e828-11d1-9187-b532f1e9575d}`

**What It Is:**
A lightweight handler that creates a simple pointer to a file system location or network path.

**Pros:**
- ✅ **Fast and lightweight** - minimal resource usage
- ✅ **Simple behavior** - works like a normal folder
- ✅ **Best performance** - especially for large folders
- ✅ **Works with UNC paths** - network locations supported

**Cons:**
- ❌ **Limited to physical/network paths** - no virtual folders
- ❌ **No shell::: support** - cannot point to shell GUIDs

**Best For:**
- Program installation folders (`C:\Program Files\MyApp`)
- Network paths (`\\server\share`, `\\wsl$\Ubuntu`)
- Quick access to real folders
- Performance-critical scenarios

---

### Explorer Browser: `{0E5AAE11-A475-4c5b-AB00-C66DE400274E}`

**What It Is:**
A full-featured Explorer browser control that provides advanced folder browsing capabilities.

**Pros:**
- ✅ **Supports shell::: paths** - can point to virtual folders
- ✅ **Supports TargetKnownFolder** - can use known folder GUIDs
- ✅ **Dynamic content** - can update/refresh automatically
- ✅ **Full Explorer features** - advanced capabilities

**Cons:**
- ❌ **More overhead** - uses more resources
- ❌ **Slightly slower** - initialization takes longer

**Best For:**
- Virtual folders (God Mode, Control Panel)
- Shell locations (`shell:::{GUID}`)
- Known folder GUIDs
- When you need advanced features

### Side-by-Side Comparison

| Feature | Folder Shortcut | Explorer Browser |
|---------|----------------|------------------|
| **Performance** | ⚡ Excellent | 🐌 Good |
| **Resource Usage** | 💾 Minimal | 💾💾 Moderate |
| **Load Time** | ⚡ Instant | 🕐 Slower |
| **Physical Folders** | ✅ Perfect | ✅ Good |
| **Drive Roots** | ⚠️ Works but limited | ✅ Excellent |
| **Virtual Folders** | ❌ Not supported | ✅ Perfect |
| **Shell Locations** | ❌ Not supported | ✅ Perfect |
| **CLSID Shortcuts** | ❌ Broken | ✅ Works |
| **Properties Dialog** | ⚠️ May fail | ✅ Full support |
| **Dynamic Content** | ❌ No | ✅ Yes |
| **Custom Views** | ❌ No | ✅ Yes |
| **Simplicity** | ✅ Very simple | ⚠️ More complex |
| **Maintenance** | ✅ Easy | ⚠️ Moderate |

---

## Attributes Deep Dive

### ShellFolder Attributes (SFGAO Flags)

These are bitwise flags that define what operations are allowed on the folder and how it appears in Explorer.

**[Official Documentation](https://learn.microsoft.com/en-us/windows/win32/shell/sfgao)** 

**Common Flag Values:**

```
0x00000001 - SFGAO_CANCOPY          Can copy items
0x00000002 - SFGAO_CANMOVE          Can move items
0x00000004 - SFGAO_CANLINK          Can create shortcuts
0x00000008 - SFGAO_STORAGE          Supports IStorage
0x00000010 - SFGAO_CANRENAME        Can rename
0x00000020 - SFGAO_CANDELETE        Can delete
0x00000040 - SFGAO_HASPROPSHEET     Has property sheet
0x00000080 - SFGAO_DROPTARGET       Can receive drops
0x00000100 - SFGAO_LINK             Is a shortcut (MOVED from 0x10000!)
0x00000200 - SFGAO_SHARE            Can be shared
0x00000400 - SFGAO_READONLY         Read-only
0x00000800 - SFGAO_GHOSTED          Ghosted (dimmed)
0x00001000 - SFGAO_SYSTEM           System object
0x00002000 - SFGAO_ENCRYPTED        Encrypted
0x00004000 - SFGAO_ISSLOW           Slow to access
0x00008000 - SFGAO_GHOSTED          Ghosted (dimmed)
0x00010000 - SFGAO_LINK             Is a link/shortcut
0x00020000 - SFGAO_SHARE            Is shared
0x00040000 - SFGAO_READONLY         Read-only
0x00080000 - SFGAO_HIDDEN           Hidden
0x02000000 - SFGAO_REMOVABLE        Removable media
0x08000000 - SFGAO_BROWSABLE        Can browse in place
0x10000000 - SFGAO_FILESYSANCESTOR  Contains file system folders
0x20000000 - SFGAO_FOLDER           Is a folder
0x40000000 - SFGAO_FILESYSTEM       Is filesystem object
0x80000000 - SFGAO_HASSUBFOLDER     May have subfolders
```

### Common Attribute Combinations

**Standard Folder/Drive (0xf080004d = 4034920525):**
```
Flags set:
0x00000001 - CANCOPY
0x00000004 - CANLINK  
0x00000008 - STORAGE
0x00000040 - HASPROPSHEET
0x10000000 - FILESYSANCESTOR
0x20000000 - FOLDER
0x40000000 - FILESYSTEM
0x80000000 - HASSUBFOLDER
```
**Use for:** Regular folders, drive roots, full access

**Virtual/Read-Only (0xb080010d = 2962293005):**
```
Flags set:
0x00000004 - CANLINK (shortcuts allowed)
0x00000008 - STORAGE
0x00000100 - LINK (is a special folder)
0x10000000 - FILESYSANCESTOR
0x20000000 - FOLDER
0x80000000 - HASSUBFOLDER
Missing: CANCOPY, CANMOVE, CANDELETE, CANRENAME, FILESYSTEM
```
**Use for:** God Mode, virtual folders, browse-only

**Protected Folder (0xb0800048 = 2962292808):**
```
Flags set:
0x00000008 - STORAGE
0x00000040 - HASPROPSHEET
0x10000000 - FILESYSANCESTOR
0x20000000 - FOLDER
0x80000000 - HASSUBFOLDER
Missing: CANCOPY, CANMOVE, CANDELETE, CANRENAME, CANLINK
```
**Use for:** Read-only application folders, protected content

**No Copy/Cut (0xf080004c = 4034920524):**
```
Same as standard but remove:
0x00000001 - CANCOPY (prevents copying)
```
**Use for:** Prevent file copying while allowing other operations

### Recommended Values by Type

| Type | Hex Value | Decimal | Usage |
|------|-----------|---------|-------|
| **Physical Folder** | `0xf080004d` | 4034920525 | Full access, all operations |
| **Application Folder (Protected)** | `0xb0800048` | 2962292808 | Browse only, no modifications |
| **Drive Root** | `0xf080004d` | 4034920525 | Standard drive access |
| **Network Path** | `0xf080004d` | 4034920525 | UNC paths, WSL |
| **Shell Path (God Mode)** | `0xb080010d` | 2962293005 | Virtual folders, browse-only |
| **Known Folder GUID** | `0xf080004d` | 4034920525 | Standard access |

---

## Target Properties

### How Target Properties Actually Work

Through testing, here's what actually works:

**Folder Shortcut CLSID `{0afaced1...}`:**
- Only reads: `Target` property
- Accepts: Physical folder paths, UNC network paths
- Format: `"Target"="C:\\Path"` or `"Target"="\\\\server\\share"`

**Explorer Browser CLSID `{0E5AAE11...}`:**
- Reads multiple properties in order: `TargetKnownFolder`, `Target`, `TargetFolderPath`
- `TargetKnownFolder`: For known folder GUIDs (documented but works)
- `Target`: Universal - works for everything (physical, network, shell paths)
- Format examples:
  - Physical: `"Target"="C:\\Folder"`
  - Network: `"Target"="\\\\server\\share"`
  - Shell: `"Target"="shell:::{GUID}"` (does NOT work - use TargetKnownFolder)
  - Known Folder: `"TargetKnownFolder"="{GUID}"`

### Working Configurations

| Target Type | CLSID | Property | Example |
|-------------|-------|----------|---------|
| Physical Folder | Folder Shortcut | `Target` | `C:\Program Files\MyApp` |
| Network UNC | Folder Shortcut | `Target` | `\\wsl$\Ubuntu` |
| Drive Root | Folder Shortcut or Browser | `Target` | `C:\` |
| Known Folder | Explorer Browser | `TargetKnownFolder` | `{a52bba46-e9e1-435f-b3d9-28daa648c0f6}` |
| Shell Path | ❌ Not supported | - | Use TargetKnownFolder instead |

**Important:** Despite documentation suggesting `shell:::{GUID}` works with `Target`, testing shows you must use `TargetKnownFolder` with the GUID (without shell::: prefix) for virtual folders.

---

## Working Examples

### Example 1: Application Folder (Nilesoft Shell)

**Purpose:** Add program folder to navigation for quick access.

```reg
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Software\Classes\CLSID\{00000000-0000-0000-4231-123456748808}]
@="Nilesoft Shell"
"InfoTip"="Nilesoft Shell Application Folder"
"SortOrderIndex"=dword:00000050
"System.IsPinnedtoNameSpaceTree"=dword:00000001

[HKEY_CURRENT_USER\Software\Classes\CLSID\{00000000-0000-0000-4231-123456748808}\DefaultIcon]
@="C:\\Program Files\\Nilesoft Shell\\shell.exe,0"

[HKEY_CURRENT_USER\Software\Classes\CLSID\{00000000-0000-0000-4231-123456748808}\InProcServer32]
@="shell32.dll"
"ThreadingModel"="Both"

[HKEY_CURRENT_USER\Software\Classes\CLSID\{00000000-0000-0000-4231-123456748808}\Instance]
"CLSID"="{0afaced1-e828-11d1-9187-b532f1e9575d}"

[HKEY_CURRENT_USER\Software\Classes\CLSID\{00000000-0000-0000-4231-123456748808}\Instance\InitPropertyBag]
"Attributes"=dword:00000011
"Target"="C:\\Program Files\\Nilesoft Shell"

[HKEY_CURRENT_USER\Software\Classes\CLSID\{00000000-0000-0000-4231-123456748808}\ShellFolder]
"Attributes"=dword:f080004d
"FolderValueFlags"=dword:00000028

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{00000000-0000-0000-4231-123456748808}]
@="Nilesoft Shell"
```

---

### Example 2: Drive Root (C: Drive)

**Purpose:** Quick access to C: drive root.

```reg
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Software\Classes\CLSID\{445a2e0d-9142-4458-a84a-66dee0196d3c}]
@="C: Drive"
"InfoTip"="Local Disk (C:)"
"SortOrderIndex"=dword:00000050
"System.IsPinnedtoNameSpaceTree"=dword:00000001

[HKEY_CURRENT_USER\Software\Classes\CLSID\{445a2e0d-9142-4458-a84a-66dee0196d3c}\DefaultIcon]
@="imageres.dll,-36"

[HKEY_CURRENT_USER\Software\Classes\CLSID\{445a2e0d-9142-4458-a84a-66dee0196d3c}\InProcServer32]
@="shell32.dll"
"ThreadingModel"="Both"

[HKEY_CURRENT_USER\Software\Classes\CLSID\{445a2e0d-9142-4458-a84a-66dee0196d3c}\Instance]
"CLSID"="{0afaced1-e828-11d1-9187-b532f1e9575d}"

[HKEY_CURRENT_USER\Software\Classes\CLSID\{445a2e0d-9142-4458-a84a-66dee0196d3c}\Instance\InitPropertyBag]
"Attributes"=dword:00000011
"Target"="C:\\"

[HKEY_CURRENT_USER\Software\Classes\CLSID\{445a2e0d-9142-4458-a84a-66dee0196d3c}\ShellFolder]
"Attributes"=dword:f080004d
"FolderValueFlags"=dword:00000028

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{445a2e0d-9142-4458-a84a-66dee0196d3c}]
@="C: Drive"
```

---

### Example 3: OneDrive (Known Folder GUID)

**Purpose:** Add OneDrive folder using its known folder GUID.

**Source:** Working example from OneDrive installation.

```reg
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}]
@="OneDrive - Personal"
"System.IsPinnedToNameSpaceTree"=dword:00000001
"SortOrderIndex"=dword:00000042

[HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\DefaultIcon]
@="C:\\Users\\YourName\\AppData\\Local\\Microsoft\\OneDrive\\OneDrive.exe,5"

[HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\InProcServer32]
@=hex(2):25,00,73,00,79,00,73,00,74,00,65,00,6d,00,72,00,6f,00,6f,00,74,00,25,\
  00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,73,00,68,00,\
  65,00,6c,00,6c,00,33,00,32,00,2e,00,64,00,6c,00,6c,00,00,00
; Decodes to: %systemroot%\system32\shell32.dll

[HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\Instance]
"CLSID"="{0E5AAE11-A475-4c5b-AB00-C66DE400274E}"

[HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\Instance\InitPropertyBag]
"Attributes"=dword:00000011
"TargetKnownFolder"="{a52bba46-e9e1-435f-b3d9-28daa648c0f6}"

[HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder]
"FolderValueFlags"=dword:00000028
"Attributes"=dword:f080004d
```

**Simplified version (without hex encoding):**
```reg
[HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\InProcServer32]
@="%systemroot%\\system32\\shell32.dll"
```

**Note:** This example uses:
- Explorer Browser CLSID (required for TargetKnownFolder)
- `TargetKnownFolder` property (not Target)
- Known folder GUID: `{a52bba46-e9e1-435f-b3d9-28daa648c0f6}` (OneDrive)

---

### Example 4: Network Location (WSL Ubuntu)

**Purpose:** Add WSL Ubuntu to Network neighborhood.

**Source:** https://gist.github.com/rikka0w0/f4fdedb1c6a39a484f6ac982c4a4dedd

```reg
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\CLSID\{90818ab5-0f00-487c-8570-a16feb94cd61}]
@="Ubuntu WSL"
"InfoTip"="\\\\wsl$\\Ubuntu"
"DescriptionID"=dword:00000001
"System.IsPinnedtoNameSpaceTree"=dword:00000001

[HKEY_CLASSES_ROOT\CLSID\{90818ab5-0f00-487c-8570-a16feb94cd61}\DefaultIcon]
@="%systemroot%\\system32\\wsl.exe,0"

[HKEY_CLASSES_ROOT\CLSID\{90818ab5-0f00-487c-8570-a16feb94cd61}\InProcServer32]
@="shdocvw.dll"
"ThreadingModel"="Both"

[HKEY_CLASSES_ROOT\CLSID\{90818ab5-0f00-487c-8570-a16feb94cd61}\Instance]
"CLSID"="{0afaced1-e828-11d1-9187-b532f1e9575d}"

[HKEY_CLASSES_ROOT\