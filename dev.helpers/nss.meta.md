# Nilesoft Shell Windows Properties Meta Copy Tool

## Source Code & Screenshots

### Snippet:
[`nss.meta.nss`](/dev.helpers/nss.meta.nss)

### Screenshot:
![Screenshot 1)](/dev.helpers/nss.meta.1.png)
![Screenshot 2)](/dev.helpers/nss.meta.2.png)

## Overview
A menu system for viewing and copying Windows file property metadata. The menu provides access to various Windows system property attributes organized into logical categories such as Core, Document, Image, Photo, Media, Audio, Music, Video...

## Key Features
- Mouse-click command integration (Left Click, Right Click, with Shift modifiers)
- Dynamic value retrieval from selected items
- Tooltip support with command information
- Extensive property list

## Usage Notes
- Supports multiple selection mode
- Command execution varies based on mouse button and shift key state
- Tooltips provide additional information about properties
- Properties are grouped logically for easier navigation

## Technical Details
- Command Structure:
  - Left Click: `@this.title`
  - Left Click + Shift: io.meta(sel, '@this.title')
  - Right Click: `'@io.meta(sel, this.title)'`
  - Right Click + Shift: `io.meta(sel, '@this.title')=='@io.meta(sel, this.title)'`

## Dependencies
Required Components:
- Windows Property System
- Nilesoft Shell framework

No additional software installation is required beyond the Nilesoft Shell framework and standard Windows components.