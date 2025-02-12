# PowerShell Archivator

## Source Code & Screenshots

### Snippet:
[`sys.compress.extract.nss`](/ex3.archiver/sys.compress.extract.nss)

### Screenshot:
![Screenshot 1)](/ex3.archiver/sys.compress.extract.1.png)
![Screenshot 2)](/ex3.archiver/sys.compress.extract.2.png)

## Overview
A shell extension menu that enhances Windows' built-in compression functionality by providing modernized compression commands in the legacy context menu.

## Key Features
- Integration of modern Windows compression commands
- Support for multiple compression formats (ZIP, 7z, TAR)
- Registry-based command management
- Administrator-level modifications
- Localized menu items using system resources

## Menu Structure
1. Main Menu ("Compress and Extract")
2. "Extract All" command (repositioned)
3. Submenu "NS Modern Commands":
   - Windows.CompressTo
   - Windows.CompressTo.Wizard
   - Windows.CompressTo.Zip
   - Windows.CompressTo.7z
   - Windows.CompressTo.Tar

## Usage Notes
- Requires administrative privileges for registry modifications

## Technical Details
- Registry paths:
  - HKEY_CLASSES_ROOT\*\shell
  - HKEY_CLASSES_ROOT\Folder\shell
  - HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore
- Uses Windows resource strings for localization
- Command state verification through registry queries
- Supports hidden window execution

## Dependencies
- Windows Operating System (Windows 11)
- Nilesoft Shell framework
- Windows Shell32.dll
- Windows.UI.FileExplorer.dll
- Zipfldr.dll
- Administrative privileges for registry modifications

No additional software installation is required beyond the Nilesoft Shell framework and standard Windows components.