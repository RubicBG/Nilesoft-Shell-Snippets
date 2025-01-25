// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

menu(title='Cleaning / Recycling' image=icon.empty_recycle_bin where=sel.raw=='::{645FF040-5081-101B-9F08-00AA002F954E}' pos=indexof(str.replace(title.empty_recycle_bin, '&', ''), 1)) {
	// https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/cleanmgr
	item(title=str.replace(str.res('cleanmgr.exe', -28), ' : ', '@"\t"') where=path.exists('@sys.bin\cleanmgr.exe') image
		cmd='cleanmgr.exe' keys=all)
	item(title=str.res('cleanmgr.exe', -19) keys=sys.root where=path.exists('@sys.bin\cleanmgr.exe') image
		cmd='cleanmgr.exe' args='/d @sys.root')
	item(title='Clean Temporary Files' tip='This command deletes temporary files from the system.' image=\uE0CE commands {
		/* Temp folders to clean
			“$env:windir\Temp\*” // Windows 8, 8.1, 10, 11 (Windows 7) - C:\Windows\Temp
			“$env:windir\Prefetch\*” // Windows 8, 8.1, 10, 11 (Windows 7) - C:\Windows\Prefetch
			“$env:systemdrive\Documents and Settings\*\Local Settings\temp\*” // Windows XP 
			“$env:systemdrive\Users\*\Appdata\Local\Temp\*” // Windows 8, 8.1, 10, 11 (Windows 7) */
		// The following command will delete all files in the Temp folder, the Windows Temp folder, the Prefetch folder, and the Temp folder of all users
		// admin cmd-ps=`Remove-Item -Path "$env:TEMP\*", "$env:windir\Temp\*", "$env:windir\Prefetch\*", "$env:systemdrive\Users\*\AppData\Local\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue`
		// The following command will delete all files in the Temp folder on windows 11 without admin rights
		cmd-ps=`Remove-Item -Path $env:TEMP\* -Recurse -Force -ErrorAction SilentlyContinue`
			window='hidden' wait=1, 
		cmd=msg.beep })

	separator()
	item(title=title.empty_recycle_bin keys='@sys.root' image=icon.empty_recycle_bin(auto, #ffff00) commands{
		admin cmd-line='/c rd /s /q %systemdrive%\$Recycle.bin' window='hidden' wait=1,
		cmd-ps=`Add-Type -TypeDefinition 'using System; using System.Runtime.InteropServices; public class shell32 { [DllImport(\"shell32.dll\")] public static extern int SHUpdateRecycleBinIcon(); }'; [shell32]::SHUpdateRecycleBinIcon(); Start-Sleep 1;` window='hidden' wait=1,
	})
	//> https://learn.microsoft.com/en-us/sysinternals/downloads/sdelete
	$isSDelete = str.contains(reg.get('HKCU\Environment', 'PATH'), 'sdelete') 
	item(title=title.empty_recycle_bin keys='Secure @sys.root' image=icon.empty_recycle_bin(auto, #ff0000) vis=isSDelete commands{
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

// Optional: Remove the following items from the Recycle Bin menu 
remove(where=sel.raw=='::{645FF040-5081-101B-9F08-00AA002F954E}' and this.title==title.rename)
remove(where=sel.raw=='::{645FF040-5081-101B-9F08-00AA002F954E}' and this.title==title.paste)