// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/


menu(expanded='true' where=sel.raw=='::{645FF040-5081-101B-9F08-00AA002F954E}' pos=indexof(str.replace(title.empty_recycle_bin, '&', null), 1)) {
	menu(title='Cleaning / Recycling' image=icon.empty_recycle_bin ) {
		// https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/cleanmgr
		item(title=str.replace(str.res('cleanmgr.exe', -28), ' : ', '@"\t"') where=path.exists('@sys.bin\cleanmgr.exe') image
			cmd='cleanmgr.exe' keys=all)
		item(title=str.res('cleanmgr.exe', -19) keys=sys.root where=path.exists('@sys.bin\cleanmgr.exe') image
			cmd='cleanmgr.exe' args='/d @sys.root')
		item(title='Clean Temporary Files' keys='SHIFT all' tip='This command deletes all files in the Temp folder, Press SHIFT to clean all files in the Temp folder, the Windows Temp folder and the Temp folder of all users.' image=\uE0CE commands {
			// https://github.com/Myraas/Remote-Disk-Cleanup/blob/master/Remote-Disk-Cleanup.ps1
			/* Description of Temp Folders
				$env:TEMP\*
					Path:				%TEMP%
					Description:		Contains temporary files created by applications and the system during runtime. Commonly includes logs, caches, and incomplete file downloads.
					Good to Delete:		Yes, usually safe to delete these files to free up space.
					OS:					Windows (all versions).
					Admin Privileges:	No, unless accessing system-level temporary files.
				$env:windir\Temp\*
					Path:				C:\Windows\Temp
					Description:		System-wide temporary folder. Used by Windows services and applications for temporary data storage.
					Good to Delete:		Yes, but avoid deleting files in use.
					OS:					Windows (all versions).
					Admin Privileges:	Yes, required for access and deletion.
				$env:windir\Prefetch\*
					Path:				C:\Windows\Prefetch
					Description:		Stores prefetch data to speed up application launches by caching commonly used files.
					Good to Delete:		Yes, but it may slightly slow down app startups initially.
					OS:					Windows XP and later.
					Admin Privileges:	Yes, required for access and deletion.
				$env:systemdrive\Documents and Settings\*\Local Settings\Temp\*
					Path:				%USERPROFILE%\Local Settings\Temp
					Description:		Legacy user-specific temporary files (used in Windows XP and earlier).
					Good to Delete:		Yes, if on older systems still using this path.
					OS:					Windows XP or earlier.
					Admin Privileges:	Yes, for accessing another user’s folder.
				$env:systemdrive\Users\*\Appdata\Local\Temp\*
					Path:				%USERPROFILE%\AppData\Local\Temp
					Description:		Current user’s temporary files, including logs, caches, and installer remnants.
					Good to Delete:		Yes, safe to clear this folder.
					OS:					Windows Vista and later.
					Admin Privileges:	No, unless accessing another user’s folder. */
			admin=keys.shift() cmd-ps=`Remove-Item -Path "$env:TEMP\*" @if(key.shift(), '"$env:windir\Temp\*", "$env:systemdrive\Users\*\AppData\Local\Temp\*"') -Recurse -Force -ErrorAction SilentlyContinue` window='hidden' wait=1,
			cmd=msg.beep })
		separator()
		item(title='Reset Recycle Bin' keys='@sys.root' image=icon.empty_recycle_bin(auto, #ffff00) commands{
			admin cmd-line='/c rd /s /q %systemdrive%\$Recycle.bin' window='hidden' wait=1,
			cmd-ps=`Add-Type -TypeDefinition 'using System; using System.Runtime.InteropServices; public class shell32 { [DllImport(\"shell32.dll\")] public static extern int SHUpdateRecycleBinIcon(); }'; [shell32]::SHUpdateRecycleBinIcon(); Start-Sleep 1;` window='hidden' wait=1,
		})
		//> https://learn.microsoft.com/en-us/sysinternals/downloads/sdelete
		$isSDelete = str.contains(reg.get('HKCU\Environment', 'PATH'), 'sdelete')
		item(title='Reset Recycle Bin' keys='Secure @sys.root' image=icon.empty_recycle_bin(auto, #ff0000) vis=isSDelete commands{
			cmd-line='/c sdelete64 -p 3 -s %systemdrive%\$Recycle.bin & pause & exit'  wait=1, //window='hidden'
			cmd-ps=`Add-Type -TypeDefinition 'using System; using System.Runtime.InteropServices; public class shell32 { [DllImport(\"shell32.dll\")] public static extern int SHUpdateRecycleBinIcon(); }'; [shell32]::SHUpdateRecycleBinIcon(); Start-Sleep 1;` window='hidden' wait=1,
		})

		separator()
		menu(title='Component Store' expanded='true' where=sys.is10orgreater) {
			//> https://www.elevenforum.com/t/analyze-and-clean-up-component-store-winsxs-folder-in-windows-11.7597/
			item(title='Analyze Component Store' image=\uE187 tip='This command analyzes the Windows component store (WinSxS folder) to determine whether cleanup is recommended.'
				admin cmd-ps=`-NoExit -NoLogo DISM /Online /Cleanup-Image /AnalyzeComponentStore`)
			item(title='Clean Up Component Store' image=\uE0CE tip='This command cleans up the Windows component store (WinSxS folder) by removing outdated or unused components to free up disk space.'
				admin cmd-ps=`-NoExit -NoLogo  DISM /Online /Cleanup-Image /StartComponentCleanup`)
			item(title='Check and Clean Up Component Store' image=\uE0CE tip='This command analyzes the Windows component store (WinSxS folder), and if cleanup is recommended, it automatically runs the cleanup process to free up disk space.' vis=keys.shift()
				admin cmd-ps=`-command if ((DISM /Online /Cleanup-Image /AnalyzeComponentStore | Select-String 'Component Store Cleanup Recommended : Yes')) { DISM /Online /Cleanup-Image /StartComponentCleanup }` window='minimized')
		}
	}
	menu(title='Clean up recently deleted' image=icon.empty_recycle_bin pos=indexof(str.replace(title.empty_recycle_bin, '&', null), 1)) {
		item(title='Clean up items deleted 2 days ago' commands{
			cmd-ps=`(New-Object -ComObject Shell.Application).NameSpace(10).Items() | Where-Object { $_.ExtendedProperty('System.Recycle.DateDeleted') -lt (Get-Date).AddDays(-2) } | ForEach-Object { Remove-Item $_.Path -Recurse -Force }` window='hidden',
			cmd=msg.beep })
		item(title='Clean up items deleted 7 days ago' commands{
			cmd-ps=`(New-Object -ComObject Shell.Application).NameSpace(10).Items() | Where-Object { $_.ExtendedProperty('System.Recycle.DateDeleted') -lt (Get-Date).AddDays(-7) } | ForEach-Object { Remove-Item $_.Path -Recurse -Force }` window='hidden',
			cmd=msg.beep })
		item(title='Clean up items deleted 15 days ago' commands{
			cmd-ps=`(New-Object -ComObject Shell.Application).NameSpace(10).Items() | Where-Object { $_.ExtendedProperty('System.Recycle.DateDeleted') -lt (Get-Date).AddDays(-15) } | ForEach-Object { Remove-Item $_.Path -Recurse -Force }` window='hidden',
			cmd=msg.beep })
		item(title='Clean up items deleted 1 month ago' commands{
			cmd-ps=`(New-Object -ComObject Shell.Application).NameSpace(10).Items() | Where-Object { $_.ExtendedProperty('System.Recycle.DateDeleted') -lt (Get-Date).AddMonths(-1) } | ForEach-Object { Remove-Item $_.Path -Recurse -Force }` window='hidden',
			cmd=msg.beep })
		item(title='Clean up items deleted 2 months ago' commands{
			cmd-ps=`(New-Object -ComObject Shell.Application).NameSpace(10).Items() | Where-Object { $_.ExtendedProperty('System.Recycle.DateDeleted') -lt (Get-Date).AddMonths(-2) } | ForEach-Object { Remove-Item $_.Path -Recurse -Force }` window='hidden',
			cmd=msg.beep })
		item(title='Clean up items deleted 3 months ago' commands{
			cmd-ps=`(New-Object -ComObject Shell.Application).NameSpace(10).Items() | Where-Object { $_.ExtendedProperty('System.Recycle.DateDeleted') -lt (Get-Date).AddMonths(-3) } | ForEach-Object { Remove-Item $_.Path -Recurse -Force }` window='hidden',
			cmd=msg.beep })
		separator()
		item(title='Clean up items larger than 200MB' commands{
			cmd-ps=`(New-Object -ComObject Shell.Application).NameSpace(10).Items() | Where-Object { $_.Size -gt 200MB } | ForEach-Object { Remove-Item $_.Path -Recurse -Force }` window='hidden',
			cmd=msg.beep })
		item(title='Clean up items larger than 1GB' commands{
			cmd-ps=`(New-Object -ComObject Shell.Application).NameSpace(10).Items() | Where-Object { $_.Size -gt 1GB } | ForEach-Object { Remove-Item $_.Path -Recurse -Force }` window='hidden',
			cmd=msg.beep })
		separator()
		item(title='Clean up all items' commands{
			cmd-ps=`(New-Object -ComObject Shell.Application).NameSpace(10).Items() | ForEach-Object { Remove-Item $_.Path -Recurse -Force }` window='hidden',
			cmd=msg.beep })
	}
}

// Optional: Remove the following items from the Recycle Bin menu
remove(where=sel.raw=='::{645FF040-5081-101B-9F08-00AA002F954E}' and this.title==title.rename)
remove(where=sel.raw=='::{645FF040-5081-101B-9F08-00AA002F954E}' and this.title==title.paste)