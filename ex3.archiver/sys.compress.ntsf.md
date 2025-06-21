# NTFS Compression System - Nilesoft Shell Integration

## Source Code & Screenshots

### Snippet:
[`sys.compress.ntsf.nss`](/ex3.archiver/sys.compress.ntsf.nss)

### Screenshot:
![Screenshot](/ex3.archiver/sys.compress.ntsf.png)

## What is NTFS Compression?

NTFS compression is a built-in Windows feature that automatically reduces file sizes on your hard drive **without creating archive files**. Unlike traditional compression tools (WinRAR, 7-Zip) that create separate compressed archives, NTFS compression works transparently at the filesystem level.

### How It Works
- **Transparent Operation**: Files appear and behave normally - you can open, edit, and save them just like uncompressed files
- **Automatic Process**: Windows automatically compresses data when writing to disk and decompresses when reading
- **No Manual Extraction**: No need to "extract" files - they work exactly like normal files
- **Space Savings**: Typically saves 30-80% disk space depending on file types and compression algorithm used
- **Visual Indication**: Compressed files show a blue double-arrow overlay icon in Windows Explorer

### When Is It Useful?
- **Low Disk Space**: Free up storage space without deleting files
- **SSD Storage**: Maximize limited SSD capacity while maintaining performance
- **Archival Storage**: Compress rarely-accessed files to save space
- **Text/Code Files**: Excellent compression ratios on documents, source code, and logs
- **System Optimization**: Reduce storage footprint of large applications or game installations

### What Files Benefit Most?
- **Text Files**: Documents, source code, configuration files (50-80% space savings)
- **Log Files**: System logs, application logs (60-90% space savings)
- **Uncompressed Data**: Raw data files, databases, large text-based files
- **Office Documents**: Older Office formats (.doc, .xls) compress well
- **Large Applications**: Executables and program files (20-50% savings)

### What Files Don't Benefit?
- **Already Compressed**: Images (JPEG, PNG), videos (MP4, AVI), music (MP3), archives (ZIP, RAR)
- **Modern Office Files**: .docx, .xlsx already use internal compression
- **Encrypted Files**: May not compress effectively

## Overview

This comprehensive Nilesoft Shell snippet provides full integration with Windows NTFS compression capabilities, offering both traditional LZNT1 compression and modern Windows Overlay Filter (WOF) compression algorithms. The integration adds intelligent context menu entries that allow users to compress and decompress files and folders directly from Windows Explorer with various compression algorithms and advanced features.

The snippet automatically detects NTFS volumes and disables compression options on non-NTFS filesystems. It supports both legacy compression methods for maximum compatibility and modern high-efficiency algorithms for better space savings on newer Windows systems (Windows 10 build 15063+).

## Key Features

- **Automatic NTFS Detection**: Only enables compression on NTFS volumes
- **Multiple Compression Algorithms**: 
  - LZNT1 (traditional NTFS compression)
  - XPRESS 4K/8K/16K (modern WOF compression)
  - LZX (maximum compression ratio)
- **Smart Recursive Compression**: Automatically skips already-compressed file types
- **Compression Status Analysis**: Detailed reporting of compression states and algorithms
- **Windows Version Compatibility**: Adapts features based on Windows build version
- **Progress Monitoring**: Optional verbose output with SHIFT key modifier
- **File Type Intelligence**: Excludes media files, archives, and compressed documents from smart compression
- **PowerShell Integration**: Advanced compression analysis using Windows APIs

## Menu Structure

### Main Compression Options
- **Standard Compression (LZNT1)**: Traditional NTFS compression with moderate space savings (30-50%)
- **Standard Recursive Compression**: Recursively compress entire folder structures
- **Modern Compression Menu** (Windows 10+):
  - XPRESS 4K: Balanced speed and compression
  - XPRESS 8K: Better compression with minimal performance impact
  - XPRESS 16K: Highest XPRESS compression ratio
  - LZX: Maximum compression (70-80% space savings)

### Smart Compression Features
- **Modern Smart Recursive Compression**: Intelligently skips pre-compressed formats
- **File Type Exclusions**: Automatically excludes executables, archives, images, videos, audio, and Office documents
- **PowerShell-Based Processing**: Uses advanced filtering for selective compression

### Analysis and Management
- **Status Reporting**: Shows compression ratios and space savings
- **Compression Type Detection**: Identifies exact algorithms used (WOF API)
- **Recursive Analysis**: Analyzes compression types throughout folder structures
- **Decompression Options**: Standard and modern decompression methods

## Usage Notes

- **NTFS Requirement**: Only works on NTFS-formatted drives
- **Windows Version**: Modern compression requires Windows 10 build 15063 or later
- **Keyboard Modifiers**: Hold SHIFT for verbose output and progress monitoring
- **File Attributes**: Compressed files show blue overlay icons in Windows Explorer
- **Performance Impact**: 
  - LZNT1: Minimal CPU overhead
  - XPRESS: Moderate CPU usage, better compression
  - LZX: Highest CPU usage, maximum compression
- **Smart Compression**: Automatically excludes file types that don't benefit from compression
- **Space Requirements**: Ensure adequate free space before decompression operations

### Excluded File Types (Smart Compression)
- **Executables**: .dl_, .xap, .cab, .dmg, .onepkg, .lzx
- **Archives**: .zip, .rar, .7z, .tar, .gz, .bz2, .tgz, .lz, .xz, .txz
- **Images**: .gif, .jpg, .jpeg, .png, .wmf
- **Videos**: .mkv, .mp4, .wmv, .avi, .bk2, .flv, .ogg, .mpg, .m2v, .m4v, .vob
- **Audio**: .mp3, .aac, .wma, .flac
- **Office Documents**: .docx, .xlsx, .pptx, .vssx, .vstx

## Dependencies

- **Windows NTFS**: Required filesystem for compression functionality
- **Windows 10 Build 15063+**: Required for modern compression algorithms
- **PowerShell**: Used for advanced compression analysis and smart filtering
- **Command Prompt**: Used for compact.exe operations
- **Administrative Rights**: May be required for some compression operations on system files
- **Sufficient Disk Space**: Required for decompression operations

## Important Warnings

⚠️ **NTFS Only**: Compression features are automatically disabled on non-NTFS volumes (FAT32, exFAT, etc.).

⚠️ **Performance Impact**: Higher compression ratios (especially LZX) increase CPU usage during file access.

⚠️ **Space Requirements**: Decompression requires adequate free space as files expand to original size.

⚠️ **System Files**: Be cautious when compressing system directories as it may affect system performance.

⚠️ **Large Operations**: Recursive compression of large directory structures may take considerable time.

⚠️ **Backup Recommendation**: Consider backing up important data before applying compression, especially with new algorithms.

⚠️ **Mixed Algorithms**: Different compression algorithms may be used within the same folder structure - use the analysis tools to understand current states.