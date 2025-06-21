# File Upload Services - Nilesoft Shell Integration

## Source Code & Screenshots

### Snippet:
[`curl.transfer.sh.nss`](/ex2.user.cloud.share/curl.transfer.sh.nss)
[`curl.bashupload.com.nss`](/ex2.user.cloud.share/curl.bashupload.com.nss)
[`curl.temp.sh.nss`](/ex2.user.cloud.share/curl.temp.sh.nss)
[`curl.uguu.se.nss`](/ex2.user.cloud.share/curl.uguu.se.nss)

### Screenshot:
![Screenshot 1](/ex2.user.cloud.share/curl.transfer.sh.1.png)
![Screenshot 2](/ex2.user.cloud.share/curl.bashupload.com.1.png)
![Screenshot 3](/ex2.user.cloud.share/curl.temp.sh.1.png)
![Screenshot 4](/ex2.user.cloud.share/curl.uguu.se.1.png)

## Overview

This collection of Nilesoft Shell snippets provides seamless integration with popular temporary file upload services through cURL commands. The snippets add context menu entries that allow users to quickly upload files directly from Windows Explorer to various cloud services including uguu.se, bashupload.com, temp.sh, and transfer.sh.

Each service offers different features such as varying storage durations, file size limits, and upload methods. The integration provides both basic upload functionality and advanced options like custom naming, verbose output, and clipboard integration.

## Key Features

- **Multiple Upload Services**: Support for uguu.se, bashupload.com, temp.sh, and transfer.sh
- **Flexible Upload Options**: Various methods including form data, binary data, and multipart uploads
- **Storage Duration Control**: Options for different retention periods (3 hours to 14 days)
- **File Size Support**: Ranges from 128MB to 50GB depending on the service
- **Advanced Features**: 
  - Custom file naming
  - Clipboard integration for direct URL copying
  - Virus scanning capabilities (transfer.sh)
  - Single-use download links
  - Verbose output options
- **User-Friendly Interface**: Clean context menu integration with tooltips

## Menu Structure

### transfer.sh Menu
- Upload for 1 day
- Upload for 14 days (default)
- Upload for 1 download only
- Clipboard variants for silent uploads
- Upload with virus scanning
- Service and GitHub info links

### bashupload.com Menu
- Quick Upload (original filename)
- Upload with custom name
- Upload as Form Data (multiple files)
- Service Info link

### temp.sh Menu
- Quick Upload for 3 days (4GB limit)
- Service Info link

### uguu.se Menu
- Quick Upload for 3 hours (128MB limit)
- Service Info link


## Usage Notes

- **Keyboard Modifiers**: Hold SHIFT for verbose output and additional information
- **File Selection**: Most services work with single file selection, bashupload.com supports multiple files
- **Progress Indication**: Commands include pause statements to view upload results
- **Custom Naming**: bashupload.com allows custom server-side filenames through input dialogs
- **Clipboard Integration**: transfer.sh includes options to automatically copy URLs to clipboard

## Dependencies

- **cURL**: Must be installed and accessible from command line
- **Command Prompt**: All operations use Windows cmd.exe
- **Internet Connection**: Required for uploading to remote services

## Important Warnings

⚠️ **Service Availability**: If any of the upload servers are down or experiencing issues, the corresponding menu options will not work properly. Users may experience timeouts or connection errors.

⚠️ **Service Changes**: If the upload services modify their APIs, endpoints, or upload methods, some functions may stop working until the snippets are updated accordingly.

⚠️ **File Size Limits**: Each service has different file size restrictions. Attempting to upload files exceeding these limits will result in errors.

⚠️ **Temporary Storage**: All services provide temporary file hosting. Files will be automatically deleted after the specified retention period.