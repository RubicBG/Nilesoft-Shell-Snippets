# File Hash Tool (Powershell)

A powerful context menu extension for Windows that allows you to calculate, verify, copy, and save various hash checksums of files directly from the right-click menu.

## Features

### Hash Types Supported
- MD5
- SHA1
- SHA256
- SHA384 (Shift required)
- SHA512 (Shift required)
- MACTripleDES (Shift required)
- RIPEMD160 (Shift required)

### Operations Available

#### Verify Checksum (single file)
- Automatically verifies checksums using `.md5`, `.sha1`, `.sha256`, `.SHA384`, and `.SHA512` files
- Displays whether the hash matches or not
- Color-coded output (red for non-matching hashes)

#### Copy Hash (single file)
- Copy of any supported hash to clipboard
- Beep confirmation when hash is copied

#### View Hash (single file)
- View detailed hash information in terminal
- Displays file path and hash value

#### Hash Multi Verifier (single file)
- Compare file against any hash value
- Automatically detects hash type by length
- Supports MD5, SHA1, SHA256, SHA384, and SHA512

#### Hash Verifier (single file)
- Compare file against specific hash type
- Input validation for hash format
- Clear match/no match output

#### Compare Two Files
- Compare two selected files using any supported hash
- Instant match/no match results

#### Create Checksums File (single or multiple)
- Create checksum files for multiple files
- Optional recursive mode for folders (hold SHIFT)
- Supports all hash types
- Creates a single checksums file in source directory

## Technical Details

- Uses PowerShell's `Get-FileHash` cmdlet
- Supports both single and multiple file selections
- Supports directories (for checksums creation)

## Notes
- All hash calculations are performed locally using PowerShell
- Operations are designed to be fast and efficient
- Verification follows standard checksum file formats
- Compatible with Windows PowerShell environment

## Requirements
- Windows PowerShell 5.1 or later
- Windows 10/11 recommended

## Snippet:
[`all.copy.hash.ps.nss`](/ex3.multifunction/all.copy.hash.ps.nss)

## Screenshot:
![Screenshot 1)](/ex3.multifunction/all.copy.hash.ps.png)