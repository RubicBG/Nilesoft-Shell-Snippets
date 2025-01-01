Nilesoft Shell is an amazing program, and I use it as a hobby to create new menus with commands (at last review there were more than 100 nss files with more than 1000 menus and more than 10000 commands in them. Now the commands are probably more than 20000 - a complete arsenal)

The idea is to start uploading my nss files one by one, making a description and screenshot. The truth is that I prefer to create new menus with commands than to make descriptions, so it won't happen soon. (I don't think anyone wants to do this "paperwork" anyway)

However
- If anyone has an idea for a menu with commands, I am ready to participate in its creation
- If anyone has a working cmd or ps code that needs to be adapted to NS commands, I will help
- If anyone has questions about the NS code itself (not about the program) you can ask - I will answer

## New
- [`File Hash Tool (CMD)`](/ex3.multifunction/all.copy.hash.cmd.md)
- [`File Hash Tool (Powershell)`](/ex3.multifunction/all.copy.hash.ps.md)

- [`Windows Path Copy Tool`](/ex3.multifunction/all.copy.path.all.md)
- [`Windows Environment Path Copy Tool`](/ex3.multifunction/all.copy.path.env.md)
- [`Shortcut Path Copy Tool`](/ex3.multifunction/all.copy.path.lnk.md)
- [`URL Path Copy Tool`](/ex3.multifunction/all.copy.path.url.md)
- [`Copy Tool (Powershell)`](/ex3.multifunction/all.copy.path.ps.md)
- [`Nilesoft Shell Path Copy Tool`](/dev.helpers/nss.paths.md)
- [`Copy List Tool (Nilesoft Shell)`](/ex3.multifunction/all.copy.list.ns.md)
- [`Copy List Tool (CMD and Powershell)`](/ex3.multifunction/all.copy.list.cp.md)

- [`Windows Spotlight Enhancement`](/ext.desktop/sys.spotlight.md)

- [`Windows Sandbox`](/dev.develop/app.sandbox.md)


## More
| Screenshot | File Name | Lang | Remarks |
|------------|-----------|----------|---------|
| ![screenshot1](/ex3.archiver/app.WinRAR.png) | [app.WinRAR](/ex3.archiver/app.WinRAR.nss) | EN | This menu replace the original WinRar menu. It only works with an installed version of WinRAR (reads the registry) Never tested for 32bit installation.<br><br>- command to register the trial version (manual filling of the information in the source code is required, it won't work with the example I left.)<br>- command to download and install a theme (not all themes work because of the graphic files, only some look good)<br>- WinRar auto update command<br>- The archive profiles are created in the Winrar program, the menu uses them. Reordering the profiles is also reflected dynamically.<br>- ... and more<br><br>Тhe menu was created much earlier than the one for 7-zip. The menu commands used command switches that were not documented anywhere during the creation of the menu. |
| ![screenshot1](/ex3.archiver/app.SevenZip.png) | [app.SevenZip](/ex3.archiver/app.SevenZip.nss) | EN | This menu replace the original 7-Zip menu.<br><br>In theory the menu should also work with NanaZip (if someone modifies the code, please share)<br><br>The presentation of the menu and other user versions of it on [discord](https://discord.com/channels/1106387012707168318/1142552812740423770) |
| ![screenshot1](/ex3.archiver/app.UniExtract.png) | [app.SevenZip](/ex3.archiver/app.UniExtract.nss) | EN | "Universal Extractor 2 is a tool designed to extract files from any type of extractable file." [formats](https://github.com/Bioruebe/UniExtract2/blob/master/docs/FORMATS.md) |
| ![screenshot1](/ex3.archiver/sys.compress.extract.png) | [FILE](/ex3.archiver/sys.compress.extract.nss) | ML<br>80% | The menu checks and clones commands from windows modern context menu into a legacy one, modifying the names and icons.<br>-Explanation of commands on [ElevenForum](https://www.elevenforum.com/t/zip-compress-files-and-folders-in-windows-11.8235/)<br>-It is highly recommended not to edit it if you are not sure what you are doing - it changes the registry!|
| ![screenshot1](/ext.others/bar.scroll.ud.png) ![screenshot2](/ext.others/bar.scroll.lr.png) | [bar.scroll](/ext.others/bar.scroll.nss) | EN | adds icons to already existing commands |
| ![screenshot1](/ext.others/bar.title.png) | [bar.title](/ext.others/bar.title.nss) | ML | F11 does not work good on win 11 24H2 |
| ![screenshot1](/ext.others/bar.address.png) | [bar.address](/ext.others/bar.address.nss) | EN | does not work on win 11 anymore |
| | [theme-manager](/theme-manager.nss) | EN | still alpha version<br>more info on [discord](https://discord.com/channels/1106387012707168318/1139275510506082336)<br>Preview on [github](https://github.com/moudey/Shell/issues/462#issuecomment-2094207347) |
