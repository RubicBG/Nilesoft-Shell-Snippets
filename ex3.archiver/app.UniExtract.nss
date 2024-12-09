//  Author: Rubic / RubicBG

$cmd_UniExtract = eval(sys.prog32+'\UniExtract\UniExtract.exe')
menu(title='UniExtract' type='file' image=cmd_UniExtract)
{
	$vis_UE = if(!path.exists(cmd_UniExtract), 'disable')
	$tip_UE = if(!path.exists(cmd_UniExtract), 'requires UniExtract to be installed')
	
	item(vis=vis_UE tip=tip_UE title ='Extract Files...'		image cmd=cmd_UniExtract args='@sel.path(true)')
	item(vis=vis_UE tip=tip_UE title ='Extract to Subdir...'	image cmd=cmd_UniExtract args='@sel.path(true) "/sub"')
	item(vis=vis_UE tip=tip_UE title ='Extract Here'			image cmd=cmd_UniExtract args='@sel.path(true) "."')
	separator()
	item(vis=vis_UE tip=tip_UE title ='Scan Files'				image cmd=cmd_UniExtract args='@sel.path(true) "/scan"')
	item(vis=vis_UE tip=tip_UE title ='Check for Updates'		image cmd=path.parent(cmd_UniExtract) + if(key.shift(),'/UniExtractUpdater_NoAdmin.exe','/UniExtractUpdater.exe'))
	item(vis=!path.exists(cmd_UniExtract) title ='Download UniExtract' image=icon.res(path.combine(sys.bin, 'shell32.dll'), 122) commands {
		// admin cmd-ps=`$DownloadURL = 'https://github.com/Bioruebe/UniExtract2/releases/download/v2.0.0-rc.3/UniExtractRC3.zip'; $TempZipPath = '@sys.temp\UniExtractRC3.zip'; $ExtractPath = '@path.parent(path.parent(cmd_UniExtract))'; if (!(Test-Path -Path $ExtractPath)) { New-Item -ItemType Directory -Path $ExtractPath -Force }; Invoke-WebRequest -Uri $DownloadURL -OutFile $TempZipPath; Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::ExtractToDirectory($TempZipPath, $ExtractPath); Remove-Item -Path $TempZipPath -Force` wait=1,
		admin cmd-ps=`$DownloadURL = 'https://github.com/Bioruebe/UniExtract2/releases/download/v2.0.0-rc.3/UniExtractRC3.zip'; $TempZipPath = '@sys.temp\UniExtractRC3.zip'; $ExtractPath = '@path.parent(path.parent(cmd_UniExtract))'; if (!(Test-Path -LiteralPath $ExtractPath)) { New-Item -ItemType Directory -Path $ExtractPath -Force }; Invoke-WebRequest -Uri $DownloadURL -OutFile $TempZipPath; Expand-Archive -LiteralPath $TempZipPath -DestinationPath $ExtractPath -Force; Remove-Item -LiteralPath $TempZipPath -Force` wait=1,
		cmd=path.parent(cmd_UniExtract) + if(key.shift(),'/UniExtractUpdater_NoAdmin.exe','/UniExtractUpdater.exe') wait=1,
	})
}


/*
	https://github.com/Bioruebe/UniExtract2/blob/master/UniExtract.au3
	
	; Define context menu commands
	; On top to make remove via command line parameter possible
	; Shell	| Commandline Parameter | Translation | MultiSelectModel
	Global $CM_Shells[5][4] = [ _
		["uniextract_files", "", "EXTRACT_FILES", "Single"], _
		["uniextract_here", " .", "EXTRACT_HERE", "Player"], _
		["uniextract_sub", " /sub", "EXTRACT_SUB", "Player"], _
		["uniextract_last", " /last", "EXTRACT_LAST", "Player"], _
		["uniextract_scan", " /scan", "SCAN_FILE", "Player"] _
	]
*/