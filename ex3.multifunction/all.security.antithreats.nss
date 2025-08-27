// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

menu(type='file|dir|back' mode='single' title='Antithreats' image='@sys.prog\Windows Defender\MpDlpCmd.exe') {
	// https://learn.microsoft.com/en-us/powershell/module/defender/set-mppreference?view=windowsserver2025-ps
	// https://www.pdq.com/powershell/set-mppreference/
	menu(title='Microsoft Defender@"\t"cmd' type='file|dir|back' expanded=1 image='@sys.prog\Windows Defender\MpDlpCmd.exe') {
		//> https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/command-line-arguments-microsoft-defender-antivirus?view=o365-worldwide
		//+ https://www.elevenforum.com/t/manually-scan-with-microsoft-defender-antivirus-in-windows-11.4349/
		//- https://www.windowscentral.com/software-apps/windows-11/how-to-manage-microsoft-defender-antivirus-from-command-prompt-on-windows-11
		//- https://www.windowscentral.com/how-use-windows-defender-command-prompt-windows-10
		//- https://winbuzzer.com/2021/05/12/how-to-use-windows-defender-from-the-command-line-cmd-in-windows-10-xcxwbt/
		//+ https://www.maketecheasier.com/use-windows-defender-from-command-prompt/
		$exe_defender = '@sys.prog\Windows Defender\MpCmdRun.exe'
		item(title='Microsoft Defender (Quick Scan)' image=exe_defender
			cmd-line='/c "@exe_defender" -Scan -ScanType 1 & pause & exit')
		item(title='Microsoft Defender (Full Scan)'  image=exe_defender keys='SHIFT to enable' vis=if(!keys.shift(), 'disable') tip='It takes a lot of time'
			cmd-line='/c "@exe_defender" -Scan -ScanType 2 & pause & exit')
		item(title='Microsoft Defender (Custom Scan)' image=exe_defender type='file|dir'
			cmd-line='/c call "@exe_defender" -Scan -ScanType 3 -File @sel(true) & pause & exit')
		item(title='Microsoft Defender (Boot Sector Malware Scan)' image=exe_defender
			cmd-line='/c call "@exe_defender" -Scan -ScanType -BootSectorScan & pause & exit') }
	separator()
	menu(title='Microsoft Defender@"\t"ps' type='file|dir|back' expanded=1 image=inherit) {
		item(title='Microsoft Defender (Quick Scan)' image=inherit
			cmd-ps=`Start-MpScan -ScanType QuickScan` window='minimized')
		item(title='Microsoft Defender (Full Scan)' image=inherit keys='SHIFT to enable' vis=if(!keys.shift(), 'disable') tip='It takes a lot of time'
			cmd-ps=`Start-MpScan -ScanType FullScan` window='minimized')
		item(title='Microsoft Defender (Custom Scan)' image=inherit type='file|dir'
			cmd-ps=`Start-MpScan -ScanType CustomScan -ScanPath '@sel(true)'` window='minimized')
		item(title='Microsoft Defender (Boot Sector Malware Scan)' image=inherit keys='SHIFT to enable' vis=if(!keys.shift(), 'disable') tip='It requires a restart of your PC and takes around 15 minutes.'
			cmd-ps=`Start-MpWDOScan` window='hidden')
		separator()
		// $reg_wd_exclusions = 'HKLM\SOFTWARE\Microsoft\Windows Defender\Exclusions' // can't be read
		item(title='Microsoft Defender Exclusion (Path)' type='file|dir' image=\uE1D7
			admin cmd-ps=`$Path = Get-Item -LiteralPath '@sel(true)'; $Exclusions=(Get-MpPreference).ExclusionPath; if ($Exclusions -contains $Path) { Read-Host -Prompt 'Path exists. Press [Enter] to remove'; Remove-MpPreference -ExclusionPath $Path; Write-Host "Removed $Path"; } else { Read-Host -Prompt 'Path not found. Press [Enter] to add'; Add-MpPreference -ExclusionPath $Path; Write-Host "Added $Path"; }`)
		item(title='Microsoft Defender Exclusion (Extension)' type='file' image=\uE1D7
			admin cmd-ps=`$Ext = '@str.trim(sel.file.ext, '.')'; $Exclusions=(Get-MpPreference).ExclusionExtension; if ($Exclusions -contains $Ext) { Read-Host -Prompt 'Extension exists. Press [Enter] to remove'; Remove-MpPreference -ExclusionExtension $Ext; } else { Read-Host -Prompt 'Extension not found. Press [Enter] to add'; Add-MpPreference -ExclusionExtension $Ext; }`)
		item(title='Microsoft Defender Exclusion (Process)' type='file' where=sel.file.ext=='.exe' image=\uE1D7
			admin cmd-ps=`$Process = '@sel.file.name'; $Exclusions=(Get-MpPreference).ExclusionProcess; if ($Exclusions -contains $Process) { Read-Host -Prompt 'Process name exists. Press [Enter] to remove'; Remove-MpPreference -ExclusionProcess $Process; } else { Read-Host -Prompt 'Process name not found. Press [Enter] to add'; Add-MpPreference -ExclusionProcess $Process; }`) }
	separator()
	menu(title='Malicious Software Removal Tool' type='file|dir|back' expanded=1 where=path.exists('@sys.bin\MRT.exe') vis=keys.shift()) {
		item(title='Malicious Software Removal Tool' image
			cmd='mrt.exe') // mrt /?
		item(title='Malicious Software Removal Tool (Full Scan)' image
			cmd='mrt.exe' args='/F:Y') }
	separator()
	$svg_vt=image.svg('<svg width="100" height="100" viewBox="0 0 24 24" fill="@image.color2">
		<path d="M10.87 12 0 22.68h24V1.32H0zm10.73 8.52H5.28l8.637-8.448L5.28 3.48H21.6z"/></svg>')
	menu(title='VirusTotal' type='file' image=svg_vt expanded=1) {
		//+ https://www.tines.com/blog/virustotal-api-security-automation
		item(title='Hash Report on VirusTotal.com' image=inherit tip='Check File Report (No API Key required)'
			cmd-line='/k for /f "delims=" %i in (@"'"certutil -hashfile @sel(true) SHA256 ^| findstr /r "^[0-9a-fA-F]*$"@"'") do set SHA256=%i && cmd /c start https://www.virustotal.com/gui/file/%SHA256% && exit' window='minimized')
		// if vtAIP is empty it will ask to set it temporary
		$vtAIP='57affd7226dbb8bd92fa6e683b8546f8c9780a50d19da612b7d58e4135c754e0'
		item(title='Set API fot VirusTotal' where=vtAIP=='' commands {
			cmd="https://www.virustotal.com",
			cmd={vtAIP=input('VirusTotal', 'Set API fot VirusTotal')}, })
		item(title='Check Hash with VirusTotal API' where=vtAIP!='' image=inherit tip='result is not formatted'
			cmd-ps=`-Command "(Invoke-RestMethod -Uri 'https://www.virustotal.com/vtapi/v2/file/report' -Method POST -Body @@{apikey='@vtAIP'; resource=(Get-FileHash -Algorithm SHA1 -Path '@sel').Hash}).scans; Read-Host -Prompt '[Enter] to close'"`)
		item(title='Check Hash with VirusTotal API' where=vtAIP!='' image=inherit tip='if the hash exists, it produces a result, elese - a blank screen'
			cmd-ps=`-Command "foreach ($elem in (Invoke-RestMethod -Uri 'https://www.virustotal.com/vtapi/v2/file/report' -Method POST -Body @@{ apikey='@vtAIP'; resource=(Get-FileHash -Algorithm SHA1 -Path '@sel').Hash}).scans.PsObject.Properties) { $elem.Name.PadRight(25) + $elem.Value.detected }; Read-Host -Prompt '[Enter] to close'"`)
		item(title='Check Hash with VirusTotal API' where=vtAIP!='' image=inherit tip='if there is no result, it is not clear whether the hash does not exist in the virustotal.com or the file is clean'
			cmd-ps=`-Command "foreach ($elem in (Invoke-RestMethod -Uri 'https://www.virustotal.com/vtapi/v2/file/report' -Method POST -Body @@{ apikey='@vtAIP'; resource=(Get-FileHash -Algorithm SHA1 -Path '@sel').Hash}).scans.PsObject.Properties) { if($elem.Value.detected) { $elem.Name } }; Read-Host -Prompt '[Enter] to close'"`) }
}