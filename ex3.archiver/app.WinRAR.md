## WinRAR Context Menu Enhancement
**Description**:  
A comprehensive context menu replacement for WinRAR that extends and customizes archiving functionality in Windows File Explorer. Designed to provide advanced options and seamless integration with WinRAR's features.

**Key Features**:
* **Extract**
  - Extract with WinRAR GUI Manager
  - Extract files to current folder
  - Extract to specific destination
  - Extract with full path preservation
  - Extract selected files from multi-volume archives
  - Extract with automatic folder creation

* **Compress**
  - Create archives with multiple compression levels
  - Support for various archive formats (ZIP, RAR, 7Z)
  - Compress multiple files and folders
  - Create self-extracting archives
  - Set compression method and algorithm

* **Compress to Profile**
  - Utilize predefined WinRAR compression profiles
  - Quick access to custom archive configurations
  - Dynamic profile management
  - Create and save new compression profiles
  - Instant application of saved profiles

* **Convert / Test / Repair**
  - Convert between different archive formats
  - Test archive integrity
  - Verify archive structure
  - Attempt to repair damaged or corrupted archives
  - Compare archive contents

* **Install Theme / Update / Registration**
  - Download and install WinRAR themes
  - Automatic WinRAR version updates
  - Trial version registration support
  - Customize WinRAR interface
  - Manage WinRAR installation settings

* **Others**
  - Password protection for archives
  - Multi-language support
  - Context menu customization
  - Support for large file and multi-volume archives
  - Minimal performance overhead
  - Seamless File Explorer integration

**Language Support**:
- **Primary Language**: English
- **Localization**:
  - UI elements support WinRAR's language settings
  - Menu commands compatible with multiple language installations
  - Recommended: Match WinRAR's language settings for best experience

**Level of Understanding**:
- **NSS Code**: Intermediate  
  Requires understanding of more complex Nilesoft Shell Script syntax, including registry reading and command switches.
- **External Knowledge**: Level 2  
  Familiarity with WinRAR installation, profiles, and archiving concepts is beneficial.

**Compatibility**:
- Verified on 64-bit WinRAR installations
- May require manual configuration for specific features
- Some theme installations might have limited graphic compatibility

**Snippet**:  
[`app.WinRAR.nss`](/ex3.archiver/app.WinRAR.nss)

**Screenshot**:  
![WinRAR Context Menu](/ex3.archiver/app.WinRAR.png)