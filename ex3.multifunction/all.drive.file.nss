// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/
// To-Do: Check which is better to use: isCDFS or isCDDrive

menu(title='File Drive' type='file' where=sel.file.ext=='.iso' or sel.file.ext=='.img' image=icon.mount) {
	// https://www.elevenforum.com/t/mount-or-unmount-iso-and-img-file-in-windows-11.1201/
	item(title='Mount' image=icon.mount
		cmd-ps=`$file = Get-Item -LiteralPath '@sel(true)'; Mount-DiskImage -ImagePath $file` window='hidden')
	item(title='UnMount' image=icon.mount
		cmd-ps=`$file = Get-Item -LiteralPath '@sel(true)'; Dismount-DiskImage -ImagePath $file` window='hidden')
	item(title='Info' tip='Info about an ISO file'
		cmd-ps=`$file = Get-Item -LiteralPath '@sel(true)'; Get-DiskImage -ImagePath $file; Read-Host -Prompt '[Enter] to close'`)
	item(title='Verify' tip='Verify if an ISO file is mounted'
		cmd-ps=`$file = Get-Item -LiteralPath '@sel(true)'; (Get-DiskImage -ImagePath $file).Attached; Read-Host -Prompt '[Enter] to close'`) }

// https://www.geeksforgeeks.org/what-is-cdfs-compact-disc-file-system/
$isCDFS = io.meta(sel,'System.Volume.FileSystem')=='CDFS' // Compact Disc File System
$isCDDrive = io.meta(sel, 'System.ItemTypeText')=='CD Drive'
menu(title='File Drive' where=isCDDrive image=icon.mount) {
	// https://www.elevenforum.com/t/find-file-path-location-of-mounted-iso-and-img-in-windows-11.23231/
	item(title='View Source File #1'
		cmd-ps=`$imagePath = (Get-Volume @str.left(sel.root, 1) | Get-DiskImage).ImagePath; Write-Host $imagePath; Read-Host -Prompt '[Enter] to close'`)
	item(title='View Source File #2'
		cmd-ps=`(Get-DiskImage -DevicePath \\.\@str.trim(sel.root, '\')).ImagePath; Read-Host -Prompt '[Enter] to close'`)
	item(title='Eject' image=icon.eject cmd-ps=`$imagePath = (Get-Volume @str.left(sel.root, 1) | Get-DiskImage).ImagePath; Dismount-DiskImage -ImagePath $imagePath` window='hidden')
	
	item(title='Eject' image=icon.eject keys='Smart' commands {
		// not working good; navigate to "This PC" not possible
		cmd=command.navigate('C:\') && sleep(500) && keys.send(key.alt, key.up) wait=1,
		cmd-ps=`$imagePath = (Get-Volume @str.left(sel.root, 1) | Get-DiskImage).ImagePath; Dismount-DiskImage -ImagePath $imagePath` window='hidden' wait=1,
	}) }
