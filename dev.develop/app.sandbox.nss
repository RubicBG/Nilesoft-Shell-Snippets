// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

menu(title='Windows Sandbox' mode='single' type='file|dir|back.dir|drive|back.drive|desktop' where=sys.ver.build>=1903 and user.name!='WDAGUtilityAccount'
	image='@appx('WindowsSandbox')\Assets\Logo-256.ico'
	vis=if(process.is_started("WindowsSandboxRemoteSession.exe") or !appx.exists('WindowsSandbox'), 'disable') 
	tip=if(process.is_started("WindowsSandboxRemoteSession.exe"), 'Windows Sandbox is running. Close it to use this feature.', if(!appx.exists('WindowsSandbox'), 'Requires Windows Sandbox to be installed', 'The profile remains preserved even after restarting the Windows Sandbox.'))) {
	//> https://learn.microsoft.com/en-us/windows/security/application-security/application-isolation/windows-sandbox/windows-sandbox-configure-using-wsb-file
	// $special_char 'é|è|à|â|ê|û|î|ä|ë|ü|ï|ö|ù|ò|~|!|@|#|$|%|^|&|+|=|}|{|||<|>|;' // Windows Sandbox does not support these characters in the path
	$template_b = '<Configuration><VGPU>Disable</VGPU><Networking>Enable</Networking><MappedFolders><MappedFolder><HostFolder>SOURCE</HostFolder><SandboxFolder>TARGET</SandboxFolder><ReadOnly>@if(keys.shift(), 'false', 'true')</ReadOnly></MappedFolder></MappedFolders><LogonCommand><Command>CMD</Command></LogonCommand></Configuration>'
	$template_m = '<Configuration><VGPU>Disable</VGPU><Networking>Enable</Networking><MappedFolders><MappedFolder><HostFolder>SOURCE</HostFolder><SandboxFolder>TARGET</SandboxFolder><ReadOnly>@if(keys.shift(), 'false', 'true')</ReadOnly></MappedFolder></MappedFolders></Configuration>'
	$template_r = '<Configuration><VGPU>Disable</VGPU><Networking>Enable</Networking><LogonCommand><Command>CMD</Command></LogonCommand></Configuration>'
	$ps_command = `$tempFile = [System.IO.Path]::GetTempFileName() -replace '\.tmp$', '.wsb'; Set-Content -Path $tempFile -Value $wsbConfig; Start-Process -FilePath "WindowsSandbox.exe" -ArgumentList $tempFile; Start-Sleep -Seconds 25; Remove-Item -Path $tempFile -Force`

	item(image=\uE249 keys='SHIFT writable' title='Run Sandbox with NS Shell and Windows Context Menu'
		tip='Synchronizes the Nilesoft Shell directory with Windows Sandbox. Both the Nilesoft Shell and Windows "Modern" context menus are enabled. Hold SHIFT to enable writable access.'
		cmd-ps=`$wsbConfig='@str.replace(template_b, 'SOURCE', app.dir).replace('TARGET', app.dir).replace('CMD', '@app.exe -s -r')'; @ps_command` window='hidden')
	item(image=\uE249 keys='SHIFT writable' title='Run Sandbox with NS Shell only'
		tip='Synchronizes the Nilesoft Shell directory with Windows Sandbox. Only the Nilesoft Shell context menu is enabled. Hold SHIFT to enable writable access.'
		cmd-ps=`$wsbConfig='@str.replace(template_b, 'SOURCE', app.dir).replace('TARGET', app.dir).replace('CMD', '@app.exe -s -r -t')'; @ps_command` window='hidden')
	item(image=\uE0E9 keys='SHIFT writable' title='Sync Desktop with Sandbox'
		tip='Maps your desktop folder into the Windows Sandbox. Hold SHIFT to enable writable access.' 
		cmd-ps=`$wsbConfig='@str.replace(template_m, 'SOURCE', user.desktop).replace('TARGET', 'C:\Users\WDAGUtilityAccount\Desktop')'; @ps_command` window='hidden')
	separator()

	/* Example: $dir_map
		= 'C:\Sandbox@if(keys.shift(), 'Writable', 'ReadOnly')Folder'
		= 'C:\SandboxMappedFolder'
		= 'C:\@sel.dir.name'
		= 'C:\Users\WDAGUtilityAccount\Desktop\Sandbox@if(keys.shift(), 'Writable', 'ReadOnly')Folder'
		= 'C:\Users\WDAGUtilityAccount\Desktop\SandboxMappedFolder'
		= 'C:\Users\WDAGUtilityAccount\Desktop\@sel.dir.name' */
	$dir_map = 'C:\Sandbox@if(keys.shift(), 'Writable', 'ReadOnly')Folder'
	item(image=\uE0E7 keys='SHIFT writable' title='Share Selected Folder in Sandbox' type='dir|back.dir|drive|back.drive|desktop'
		tip='Maps the selected folder into the Windows Sandbox at @dir_map. Hold SHIFT for writable access.' 
		cmd-ps=`$wsbConfig='@str.replace(template_m, 'SOURCE', sel.dir).replace('TARGET', dir_map)'; @ps_command` window='hidden')
	item(image=\uE0E7 keys='SHIFT writable' title='Share Selected Folder in Sandbox, Show in Explorer' type='dir|back.dir|drive|back.drive|desktop'
		tip='Maps the selected folder into the Windows Sandbox at @dir_map and shows it in Explorer. Hold SHIFT for writable access.' 
		cmd-ps=`$wsbConfig='@str.replace(template_b, 'SOURCE', sel.dir).replace('TARGET', dir_map).replace('CMD', 'explorer.exe /select, "@dir_map"')'; @ps_command` window='hidden')
	item(image=\uE0E7 keys='SHIFT writable' title='Share Selected Folder in Sandbox, Open in Explorer' type='dir|back.dir|drive|back.drive|desktop'
		tip='Maps the selected folder into the Windows Sandbox at @dir_map and opens it in Explorer. Hold SHIFT for writable access.' 
		cmd-ps=`$wsbConfig='@str.replace(template_b, 'SOURCE', sel.dir).replace('TARGET', dir_map).replace('CMD', 'explorer.exe "@dir_map"')'; @ps_command` window='hidden')
	separator()

	item(image=\uE11F title='Open URL in Sandbox with Edge' type='file' where=sel.file.ext=='.url'
		tip='Launches a .url file in Windows Sandbox using Microsoft Edge.'
		cmd-ps=`$wsbConfig='@str.replace(template_r, 'CMD', 'cmd /c start msedge @ini.get(sel, "InternetShortcut", "URL")')'; @ps_command` window='hidden')
	separator()

	/* Example: $dir_app
		= 'C:\Sandbox@if(keys.shift(), 'Writable', 'ReadOnly')Folder'
		= 'C:\SandboxTmpFolder'
		= 'C:\Users\WDAGUtilityAccount\Desktop\SandboxTmpFolder' */
	$dir_app = 'C:\Sandbox@if(keys.shift(), 'Writable', 'ReadOnly')Folder'
	$se = sel.file.ext
	$fl = path.combine(dir_app, sel.name)
	$ps_run = 'powershell -ExecutionPolicy Bypass -Command'
	item(image=\uE10E keys='SHIFT writable' title=if(!str.contains('.reg|.zip|.iso|', sel.file.ext+'|'), 'Try to ')+'Open File in Sandbox' type='file'
		tip='Launches the selected file in Windows Sandbox. Hold SHIFT for writable access.'
		cmd-ps=`$wsbConfig='@str.replace(template_b, 'SOURCE', sel.parent).replace('TARGET', dir_app).replace('CMD', '@ps_run \"rundll32.exe "shell32.dll,OpenAs_RunDLL @fl\"')'; @ps_command` window='hidden')
	item(image=\uE10E keys='SHIFT writable' title='Open Selected File in Sandbox with Edge' type='file' where=str.contains(eval(str.join(reg.values('HKLM\SOFTWARE\Clients\StartMenuInternet\Microsoft Edge\Capabilities\FileAssociations'), '|')+'|'), sel.file.ext+'|')
		tip='Launches the selected file in Windows Sandbox using Microsoft Edge. Hold SHIFT for writable access.'
		cmd-ps=`$wsbConfig='@str.replace(template_b, 'SOURCE', sel.parent).replace('TARGET', dir_app).replace('CMD', 'cmd /c start msedge "@path.combine(dir_app, sel.name)"')'; @ps_command` window='hidden')
	$cmd_exec = if(se=='.exe', '"@fl"', if(se=='.msi', 'msiexec /i "@fl"', if(se=='.bat' or se=='.cmd', '@ps_run \"Start-Process @fl\"', if(se=='.ps1', '@ps_run \"Start-Process powershell.exe -ArgumentList \\\"-nologo\\\",\\\"-File  @fl\\\"\"', 'powershell.exe'))))
	item(image=\uE258 keys='SHIFT writable' title='Run Executable File in Sandbox' type='file' where=str.contains('.exe|.msi|.bat|.cmd|.ps1|', sel.file.ext+'|')
		tip='Runs the selected executable file in Windows Sandbox. Hold SHIFT for writable access.'
		cmd-ps=`$wsbConfig='@str.replace(template_b, 'SOURCE', sel.parent).replace('TARGET', dir_app).replace('CMD', cmd_exec)'; @ps_command` window='hidden')
	item(image=\uE258 keys='SHIFT writable' title='Run Executable File with Argument in Sandbox' type='file' where=str.contains('.exe|.msi|.bat|.cmd|', sel.file.ext+'|')
		tip='Tries to run the selected executable file in Windows Sandbox with the argument(s). Hold SHIFT for writable access.'
		cmd-ps=if(!input('Nilesoft Shell', 'Add argument(s)') , msg('Operation cancelled'), `$wsbConfig='@str.replace(template_b, 'SOURCE', sel.parent).replace('TARGET', dir_app).replace('CMD', '@cmd_exec @input.result')'; @ps_command`) window='hidden')
	item(image=\uE258 keys='SHIFT writable' title='Silent Run PowerShell Script in Sandbox' type='file' where=sel.file.ext=='.ps1'
		tip='Runs the selected PowerShell script in Windows Sandbox. No user interaction possible. Hold SHIFT for writable access.'
		cmd-ps=`$wsbConfig='@str.replace(template_b, 'SOURCE', sel.parent).replace('TARGET', dir_app).replace('CMD', 'powershell.exe -ExecutionPolicy Bypass -File  @fl')'; @ps_command` window='hidden')
}