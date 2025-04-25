# Encrypt, Decrypt - Nilesoft Shell Snippet

## Source Code & Screenshots

### Snippet:
[`all.security.encrypt.nss`](/ex3.multifunction/all.security.encrypt.nss)

### Screenshot:
![Screenshot 1](/ex3.multifunction/all.security.encrypt.1.png)
![Screenshot 1](/ex3.multifunction/all.security.encrypt.2.png)

## Overview
This Nilesoft Shell snippet adds an "Encrypt, Decrypt" context menu for files and folders, providing easy access to Windows' built-in Encrypted File System (EFS) functionality. It allows users to quickly encrypt or decrypt files and folders directly from the right-click menu without using command line tools.

## Key Features
- One-click file and folder encryption using Windows EFS
- One-click decryption of EFS-encrypted items
- Recursive encryption/decryption options for folders
- Smart menu that adapts based on the current encryption status
- EFS certificate management options
- Support for multiple file selection

## Menu Structure
- Main entry: "Encrypt, Decrypt" with a lock icon
- For unencrypted items:
  - Encrypt (for files and folders)
  - Encrypt recursive (for folders only)
- For encrypted items:
  - Decrypt (for files and folders)
  - Decrypt recursive (for folders only)
- Certificate management:
  - View EFS cert (displays encryption certificate details)
  - Copy EFS cert (copies certificate thumbprint to clipboard)

## Usage Notes
- Right-click on files or folders to access this menu
- The menu dynamically shows only relevant options based on encryption status
- Encrypted files are identified by checking for the "E" attribute
- All operations use the Windows built-in cipher.exe command
- The Explorer view is automatically refreshed after encryption/decryption
- Command windows display progress and require confirmation before closing
- Certificate operations work with the current user's EFS certificate
- Multiple files can be selected for batch encryption/decryption

## Dependencies
- Windows Operating System
  - Windows Pro or Enterprise edition required (EFS is not available in Home editions)
- Nilesoft Shell framework
- Uses Windows built-in cipher.exe command for EFS operations
- Requires NTFS file system (EFS is not available on FAT/exFAT)

No additional software installation is required beyond the Nilesoft Shell framework and standard Windows components.