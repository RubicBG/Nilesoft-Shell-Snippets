# File Hash Tool (CMD)

A powerful context menu extension for Windows that allows you to calculate, verify, copy, and save various hash checksums of files directly from the right-click menu.

## Features

### Hash Types Supported
- MD2 (Shift required)
- MD4 (Shift required)
- MD5
- SHA1
- SHA256
- SHA384 (Shift required)
- SHA512 (Shift required)

### Operations Available

#### Verify Checksum (single file)
- Automatically verifies checksums using `.md2`, `.md4`, `.md5`, `.sha1`, `.sha256`, `.SHA384`, and `.SHA512` files
- Displays whether the hash matches or not

#### Copy Hash (single file)
- Copy of any supported hash to clipboard
- Beep confirmation when hash is copied

#### Copy or Create (single file)
- Copy of any supported hash to clipboard
- Hold SHIFT to create a checksum file (e.g., `.md5`, `.sha1`) with the hash value
- Beep confirmation

#### View or Save (single file)
- View hash in terminal
- Hold SHIFT to save hash report to a `.txt` file

#### View (multiple file)
- View hash in terminal

## Technical Details

- Uses Windows `certutil` for hash calculations
- Supports both single and multiple file selections

## Notes
- All hash calculations are performed locally using Windows built-in tools
- Operations are designed to be fast and efficient
- Verification follows standard checksum file formats
- Compatible with Windows command prompt environment

## Snippet: 
[`all.copy.hash.cmd.nss`](/ex3.multifunction/all.copy.hash.cmd.nss)

## Screenshot:
![Screenshot 1)](/ex3.multifunction/all.copy.hash.cmd.png)