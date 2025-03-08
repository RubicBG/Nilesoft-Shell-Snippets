# Dropbox Integration for Nilesoft Shell

## Source Code & Screenshots

### Snippets:
- [`cloud.dropbox.remove.nss`](/ex2.user.cloud.share/cloud.dropbox.remove.nss) - Removes default Dropbox context menu
- [`cloud.dropbox.basic.nss`](/ex2.user.cloud.share/cloud.dropbox.basic.ml.nss) - Basic Dropbox menu integration
- [`cloud.dropbox.enhanced.nss`](/ex2.user.cloud.share/cloud.dropbox.enhanced.nss) - Enhanced Dropbox menu with custom icons

### Screenshot:
![Screenshot 1](/ex2.user.cloud.share/cloud.dropbox.basic.png)
![Screenshot 2](/ex2.user.cloud.share/cloud.dropbox.enhanced.png)

## Overview
These Nilesoft Shell snippets enhance Windows context menu integration with Dropbox. The files provide different levels of customization, from completely removing the default Dropbox menu to creating enhanced menus with custom icons and tooltips.

## Key Features
- Remove default Dropbox context menu items (remove snippet)
- Create a custom Dropbox menu with localized text (basic snippet)
- Add enhanced visual elements with custom SVG icons (enhanced snippet)
- Contextual menu items based on file location (Dropbox folder vs. local)
- Helpful tooltips explaining each action (enhanced snippet)
- Special handling for Dropbox-specific features like ignoring files (enhanced snippet)

## Menu Structure
The snippets modify or create a dedicated Dropbox menu with the following context-aware items:

- Move to Dropbox
- Copy Dropbox link
- Share
- View in Dropbox/Dropbox.com
- Version history
- Make available offline/online-only
- Send for signature
- Request files
- Manage access
- Ignore/Un-ignore from Dropbox

## Usage Notes
- The menu title can be customized by changing the `$menu_db_name` variable
- Three different snippets are available depending on your needs:
  - Use `remove` to disable the default Dropbox context menu
  - Use `basic` for a basic replacement with native icons
  - Use `enhanced` for an enhanced menu with custom SVG icons and tooltips
- The helper menu in the simple snippet displays all available command strings (disabled by default)
- Custom ignore/un-ignore commands create/modify the special `com.dropbox.ignored` file

## Dependencies
- Windows Operating System
- Nilesoft Shell framework
- Dropbox desktop client
  - Dropbox DLL for localized strings and icons
  - Dropbox user account configured on the system

The snippets automatically retrieve necessary paths from the Windows Registry:
- Dropbox DLL path
- Dropbox folder location
