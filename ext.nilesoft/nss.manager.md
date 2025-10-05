# Shell Manager - Documentation

## Snippet:
[`nss.manager.nss`](/ext.nilesoft/nss.manager.nss)

## Screenshot:
![Screenshot 1](/ext.nilesoft/nss.manager.01.png)
![Screenshot 2](/ext.nilesoft/nss.manager.02.png)
![Screenshot 3](/ext.nilesoft/nss.manager.03.png)

## Current Status

The snippet is **not yet complete**, but all Nilesoft Shell settings can be edited from the menu and all visible commands are functional.

---

## Important Note

The description below is **not a menu guide**, but rather advice and explanations to help you understand how to use the menu effectively. I've structured it as an FAQ, and the explanations are intentionally simplified.

---

## FAQ

### 1. Why isn't there a GUI panel for editing NS syntax?

This question isn't directly about this snippet, but it explains a lot: The NS syntax itself is flexible—extremely flexible—but this makes "reading" and parsing the syntax very difficult.

- **Boolean example**: There are only two values: true and false. NS syntax allows true to be written as a keyword (`true`), as an integer (`1`), as a double (`1.0`), as a function (`@true`), as a function in a string (`'@true'`), as a mathematical expression (`(1+1)/2`), etc. There is no uniform syntax.

- **Multiple syntax variations for values**: For example, `.padding` can be an array of 4 values (`[1, 2, 3, 4]`), an array of 2 values (`[4, 2]`), an array of 1 value (`[4]`), or a single value (`4`). There is no uniform syntax.

- **Predefined variables**: Values can be predefined variables, but these variables can be defined locally (in a section), globally in the same file, or in a completely different file.

- **Multiple property syntax**: Properties can be written as sections `settings { tip = true }` or as single properties `settings.tip = true`.

- **Alternative property names**: Some properties can be defined with different words—`settings.tip` is the same as `theme.tip`.

- **Reload requirement**: After every change, the NS script must be reloaded to apply changes. This is easy with an NS function, but without it you have to restart Explorer (which is annoying).

These examples are at a "primitive level" — the NS syntax itself cannot be described in just a few points. A GUI panel would need to recognize all variations to edit freely, which in my view is impossible.

Even if someone creates logic that works, the probability of me providing multiple examples where that logic fails is very high. What can be done:

- **"Primitive solution"**: An editor that only works with a single standardized syntax type. The probability of manual changes confusing the GUI panel's logic is very high. If only the GUI panel is used, this won't be a problem, but it reduces flexibility to less than 20% of its real capabilities of NS syntax. NSTM was created on this ideology, and so is iMA-Menu.

- **"Good solution"**: An editor that works through AI prompts. This would work in 90% of cases (AI recognizes syntax but can't always modify it), but working with AI has its own peculiarities.

This snippet is not a "primitive solution" but far from a "good solution" — somewhere in the middle.

---

### 2. What are the snippet's advantages?

- **New undocumented properties**: I've checked the source code and found all undocumented properties. There aren't many, but the snippet works with all of them so far.

- **Works with all theme files found online**: Over 100 themes tested (Catppuccin - 4×14, iMA-Menu - 15, GitHub - 10, Discord - 13, mine - 7, others - 14). Can extract what's needed even from mixed syntax (as some prefer to make changes in `shell.nss`). Recognizes even the old NS syntax from before v1.8.1 (`shell { set { theme{...} } }`).

- **Standardizes syntax**: Manual changes are allowed. Before each change via the snippet, it extracts only properties for `theme.` and `settings.` and fits them to a uniform syntax.

- **Handles alternative property names**: For properties with more than one name, it edits the existing property or chooses the primary one I've set if none exists.

- **Recognizes all common values**: Recognizes and edits each one. (If not a common valie the icon of 'manual' changes to `!`)

- **Moves all settings**: All settings (`settings { }`) from `shell.nss` are moved to `/themes/default.nss` so they can be edited by the snippet. Creates a backup of the original file as `shell.old`.

- **Converts arrays to singles**: Values written as arrays that can be written separately are converted to singles.

- **Auto-generates arrays**: Properties that only work with arrays generate a full array when entering a single component.

- **Creates backups**: Before each change to `/themes/default.nss`, a copy is created as `/themes/default.old`. If the snippet creates an NS syntax error for any reason, use the backup to restore the last working syntax.

- **Removes old NSTM settings**: Removes all settings added by NSTM (old version) if anyone used it — the two versions are incompatible.

- **Customizable menu location**: The menu can be edited to show in the desktop context menu and/or taskbar (edit the main menu properties as you like).

---

### 3. What are the snippet's disadvantages?

- **Property duplication handling**: When a property is duplicated (a technical error), NS accepts the last one entered, but the snippet reads the first one — which creates a discrepancy. However, when editing through the snippet, all duplicates are removed.

---

### 4. How to add other configurations?

- **Simple import**: Just import it (for example, in `shell.nss` with `import "/imports/nss.manager.nss"`) — no other settings needed.

- **Compact mode**: `expand_theme=1` and/or `expand_sttg=1` — if you set them to 0, the menu will be more compact.

- **Debug messages**: `debug_msg=`—this option is currently enabled. Right-clicking a command will show messages for main steps or detected errors during command execution.

- **Modern mode**: `mode_modern=1`—don't change this. This determines whether the menu works like the old version (NSTM). At 0, it will only work with a single theme and should not be manually edited.

---

### 5. Practical tips

- **Theme files**: Any theme copied to `/themes` will work. However, use the "import" command — this way the file will still end up in `/themes`, but processed and viewable.

- **Reset indicator**: (Almost) every menu has a 'reset' command. If it's not active, it means there are no settings in the file. You can use this as an indicator that something has been changed.

- **Manual command**: (Almost) every menu has a 'manual' command. The command tip shows the value (if there is one in the file). The command recognizes a wide range of values for the given property and changes its icon to `!` if something is unfamiliar. Check the tip to see what you have before changing it.

- **Hidden menu**: If you add [`iMA-Menu themes`](https://github.com/iMAboud/iMA-Menu/tree/main/iMA%20Menu/theme) to `/themes/iMA-Menu/`, a hidden menu will appear.

---

### 6. Why isn't the snippet finished?

- **Gradient menus**: "linear angle" and "linear stops" still work with the old syntax (from NSTM). Can change values, but doesn't recognize them afterwards. I've adjusted it enough to have it for now.

- **Opasity menus**: "opacity" is measured in percentages (0%-100%), all "opacity" menus show values ​​from 0 to 40, where 40 corresponds to 100% - I will replace them with a better once.

- **Hidden incomplete commands**: All commands created only as empty items or that don't work for some reason are hidden for the time being.

- **Conditional values**: The snippet is prepared for this too. Few people know that NS settings can be different in different situations: with two monitors, text size can be different — and not just that. The menu can be one way for taskbar (or desktop) and different for everything else. A specific parameter can be active when selecthing folders, another for files, a third for no selection. Certain settings can be active on even days, others on odd days — this can be interpreted for seasons or by hour, or whatever comes to mind. I can list more than 10,000 scenarios. I will add only a few practical ones.

- **Additional properties**: I have ideas for `setting.exclude.` properties that would be good to add. It will take time to come up with a logic that there are some peculiarities.

---

### 7. Problems with the snippet?

- **Syntax recognition**: The snippet recognizes foreign theme syntax very well, but it's not perfect. The fact that it works with all 100+ themes I've tested is not a guarantee.

- **Execution speed**: With each command, settings are reloaded. It works quite well for me, but I haven't tested it on slower computers. (I've reduced many secondary menus — from over 15,000 items I've reduced them to under 9,000.)

- **Backup files**: If editing creates an NS syntax error, there's a backup copy in `/themes/default.old` (and `/shell.old`).

- **Debug messages**: I left debug messages when clicking a command with the right mouse button. You can see what it read from the files before it started editing. (This will only work in this version.)

---

## Summary

This context menu manager for Nilesoft Shell settings bridges the gap between manual editing and full automation, handling the complexities of NS syntax while maintaining flexibility for advanced users.