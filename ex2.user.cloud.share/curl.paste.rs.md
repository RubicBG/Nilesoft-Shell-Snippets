# paste.rs Text File Upload - Nilesoft Shell Integration

## Source Code & Screenshots

### Snippet:
[`curl.paste.rs.nss`](/ex2.user.cloud.share/curl.paste.rs.nss)

### Screenshot:
![Screenshot](/ex2.user.cloud.share/curl.paste.rs.1.png)

## Overview

This Nilesoft Shell snippet provides seamless integration with paste.rs, a text and code sharing service similar to Pastebin. The integration adds context menu entries that allow users to quickly upload text-based files directly from Windows Explorer to paste.rs using cURL commands. The snippet intelligently filters files based on extensions and special filenames to only show the upload option for appropriate text and code files.

The service is particularly useful for sharing code snippets, configuration files, logs, and other text-based content with colleagues or the community. paste.rs provides a clean, ad-free interface for viewing shared content.

## Key Features

- **Smart File Filtering**: Automatically detects text and code files based on extensive extension list
- **Special Filename Recognition**: Supports common build and configuration files (Makefile, Dockerfile, etc.)
- **Quick Upload**: Simple one-click upload with automatic URL generation
- **Delete Functionality**: Built-in option to delete previously uploaded content
- **Manual Upload Option**: Direct browser access for manual uploads
- **Verbose Output**: SHIFT key modifier for detailed upload information
- **No Size Restrictions**: Service doesn't specify file size limitations

## Menu Structure

### Main Menu Options
- **Quick Upload**: Upload selected text/code file to paste.rs
- **Delete Upload**: Remove previously uploaded content using URL
- **Manual Upload**: Open paste.rs web interface in browser
- **Service Info**: Access paste.rs homepage for more information

### Supported File Types
The snippet supports an extensive list of programming languages and text formats including:
- **Programming Languages**: C/C++, Java, Python, JavaScript, PHP, Ruby, Go, Rust, etc.
- **Web Technologies**: HTML, CSS, XML, JSON, SVG
- **Configuration Files**: YAML, Properties, SQL, Makefiles
- **Documentation**: Markdown, reStructuredText, LaTeX
- **Scripts**: Bash, PowerShell, Batch files
- **Special Files**: Dockerfile, Gemfile, package.json equivalents

## Usage Notes

- **File Selection**: Only text-based and code files will show the upload option
- **Keyboard Modifiers**: Hold SHIFT during upload for verbose output and additional information
- **URL Management**: The service provides URLs for uploaded content that can be shared
- **Deletion**: Users can delete their uploads by providing the full URL
- **Browser Integration**: Manual upload option via the web interface, allowing users to copy and paste content directly for convenience.
- **Extension Handling**: The snippet includes special handling for .nss files, applying custom syntax highlighting by treating them as JavaScript for improved readability.

## Dependencies

- **cURL**: Must be installed and accessible from command line
- **Command Prompt**: All operations use Windows cmd.exe
- **Internet Connection**: Required for uploading to paste.rs service

## Important Warnings

⚠️ **Service Availability**: If paste.rs is down or experiencing issues, the upload functionality will not work properly. Users may experience timeouts or connection errors.

⚠️ **Service Changes**: If paste.rs modifies their API, endpoints, or upload methods, some functions may stop working until the snippet is updated accordingly.

⚠️ **File Content**: Only upload text-based files. Binary files are not supported and may cause errors.

⚠️ **Privacy**: Uploaded content may be publicly accessible. Do not upload sensitive or confidential information.

⚠️ **Retention Policy**: Check paste.rs terms of service for file retention periods and deletion policies.