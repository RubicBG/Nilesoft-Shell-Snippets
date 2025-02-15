# Go To Run Menu for Nilesoft Shell

## Source Code & Screenshots

### Snippet:
[`goto.run.nss`](/ex5.goto/goto.run.nss)

### Screenshot:
![Screenshot 1](/ex5.goto/goto.run.png)


## Overview
The Go To Run Menu is a specialized Nilesoft Shell extension that provides quick access to your Run dialog history. This implementation offers an efficient way to access and manage your previously executed Run commands, enhancing the Windows Run functionality with a convenient history feature.

## Key Features
- Access to the last 16 Run command entries
- Ability to clear Run command history
- Clean command display with stripped formatting

## Menu Structure
1. **History Entries**
   - Displays up to 16 most recent Run commands
   - Entries are automatically populated from the Windows Registry
   - Each entry is clickable and will re-execute the command

2. **Management Options**
   - "Clear Run history" option at the bottom

## Usage Notes
- Menu appears only when Run history exists in the registry
- Requires Windows Run command tracking to be enabled
- History can be cleared through the menu interface
- Settings can be adjusted through Windows Privacy settings

## Dependencies
- Windows Operating System
- Nilesoft Shell framework
- Windows history tracking enabled

No additional software installation is required beyond the Nilesoft Shell framework and standard Windows components.