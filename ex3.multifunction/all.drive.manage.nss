// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

menu(title='Drive Manage' where=sel.type==5 or io.meta(sel, 'System.ItemTypeText')=='CD Drive' image=\uE253) {
	separator()
	$isCDDrive = io.meta(sel, 'System.ItemTypeText')=='CD Drive'
	$isMFolder = path.exists(ini.get('@sel\desktop.ini', 'Nilesoft', 'subst'))
	menu(where=!(isCDDrive or isMFolder) expanded='true') {
		// https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/cleanmgr
		item(title=str.replace(str.res('cleanmgr.exe', -28), ' : ', '@"\t"') where=path.exists('@sys.bin\cleanmgr.exe') image
			tip='Launches Disk Cleanup to free up space'
			cmd='cleanmgr.exe' keys=all)
		item(title=str.res('cleanmgr.exe', -19) keys=sel.root where=path.exists('@sys.bin\cleanmgr.exe') image
			tip='Runs Disk Cleanup on the selected drive'
			cmd='cleanmgr.exe' args='/d @sel') 
		// https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/defrag
		item(title=str.res('dfrgui.exe', -106) where=path.exists('@sys.bin\dfrgui.exe') image
			tip='Opens the Defragment and Optimize Drives utility'
			cmd='dfrgui.exe' tip=str.res('dfrgui.exe', -103))
		// https://www.elevenforum.com/t/add-optimize-to-context-menu-of-drives-in-windows-11.3216/
		item(title=str.res('shell32.dll', -22027) where=path.exists('@sys.bin\dfrgui.exe') image='dfrgui.exe'
			tip='Runs disk optimization via command line'
			admin cmd-line='/k defrag @str.left(@sel, 2) /A & pause & exit')
		// https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/chkdsk?tabs=event-viewer
		item(title=str.res('shell32.dll', -28816) image=\uE0F6
			tip='Scans the drive for errors and attempts to fix them'
			admin cmd-line='/k chkdsk @str.left(@sel, 2) /r /f & pause & exit')
		item(title=str.res('shell32.dll', -28816) keys='dismounted' image=\uE0F6 vis=if(!path.isroot(sel) or str.contains(sel, sys.root), 'disable')
			tip='Performs a thorough disk check and attempts repairs (drive will be dismounted first)'
			admin cmd-line='/k chkdsk @str.left(@sel, 2) /r /f /x & pause & exit')
	separator()
	item(title='Disk Management' where=path.exists('@sys.bin\diskmgmt.msc') image=icon.settings
		tip='Opens the Disk Management utility to manage partitions'
		cmd='diskmgmt.msc')
	item(title='Disk and Volumes' where=sys.ver.major>=8 image=icon.settings
		tip='Opens Windows Settings for disk and volume management'
		cmd='ms-settings:disksandvolumes') }