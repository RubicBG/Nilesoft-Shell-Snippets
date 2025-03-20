# Windows Environment Path Copy Tool

## Source Code & Screenshots

### Snippet:
[`all.copy.path.env.nss`](/ex3.multifunction/all.copy.path.env.nss)

### Screenshot:
![Screenshot 1](/ex3.multifunction/all.copy.path.env.1.png)
![Screenshot 2](/ex3.multifunction/all.copy.path.env.2.png)

## Overview
A Nilesoft Shell extension that converts file paths to use Windows environment variables and copies them to clipboard.

## Key Features
- Quick access to Environment Variables settings
- Converts paths to use environment variables
- Supports system and user environment paths
- Single folder/drive selection

## Menu Structure
- Environment Variables (SHIFT + Click for admin)
- User paths (%TMP%, %TEMP%, %LocalAppData%, etc.)
- Program paths (%ProgramFiles%, %CommonProgramFiles%, etc.)
- Windows paths (%WinDir%, %SystemRoot%)
- Drive paths (%HomeDrive%, %SystemDrive%)

## Usage Notes
- Works with directories, drives, and desktop
- Single selection only
- Only shows relevant variables for current path


## Dependencies
Required Components:
- Windows Operating System
- Nilesoft Shell framework

Optional Components:
- Administrative privileges for system-wide changes

No additional software installation is required beyond the Nilesoft Shell framework and standard Windows components.