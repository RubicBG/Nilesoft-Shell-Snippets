// Author: Rubic / RubicBG
// Based on: Nilesoft Shell original snippet
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

menu(title=title.select mode='multiple' where=sel.count>0 image=\uE290) {
	item(title='All' tip='Select all items in current folder' keys='Ctrl+A' image=icon.select_all cmd=command.select_all)
	item(title='Invert' tip='Select unselected items and deselect selected ones' image=icon.invert_selection cmd=command.invert_selection)
	item(title='None' tip='Clear current selection' image=icon.select_none cmd=command.select_none)
	separator()
	$show_only2 = wnd.instance == 'explorerframe.dll' and (sel.raw != '::{F874310E-B6B7-47DC-BC84-B9E6B38F5903}' and sel.parent.raw != '::{F874310E-B6B7-47DC-BC84-B9E6B38F5903}')
	menu(expanded=1 where=show_only2) {
		// checks
		$detect_files	 = (sel.back and len(path.files(sel, "*", 3))>0) or (!sel.back and len(path.files(sel.parent, "*", 3))>0)
		$detect_nss 	 = (sel.back and len(path.files(sel, "*.nss", 3))>0) or (!sel.back and len(path.files(sel.parent, "*.nss", 3))>0)
		$detect_dirs	 = (sel.back and len(path.files(sel, "*", 2))>0) or (!sel.back and len(path.files(sel.parent, "*", 2))>0)
		$detect_ms_obj	 = (sel.back and regex.match(sel.raw, '^.*\..*-ms$')) or (!sel.back and regex.match(sel.parent.raw, '^.*\..*-ms$'))
		$detect_conflict = !sel.back and sel.parent.raw == path.parent(sel)
		// disable items
		$vis_for_files = if(not(detect_files or detect_ms_obj), 2)
		$vis_for_dirs  = if(not(detect_dirs or detect_ms_obj), 2)
		$vis_for_nss   = if(not(detect_nss or detect_ms_obj), 2)
		// keys info 
		$keys_deselect = 'SHIFT de~'
		// https://learn.microsoft.com/en-us/windows/win32/shell/shellfolderview-selectitem
		// Selection flags: 1=select, 8=focus, 0=deselect
		$select_flag=if(keys.shift(),0,1) + if(keys.rbutton(), 8)
		// Template for PowerShell selection commands - gets current window and applies filter
		$ps	= `$w = (New-Object -ComObject Shell.Application).Windows() | Where-Object { $_.HWND -eq @wnd.handle }; $w.Document.Folder.Items() | Where-Object { {0} } | ForEach-Object { $w.Document.SelectItem($_, @select_flag) }`
		// Template for checking file perceived type via registry (slower but accurate)
		$meta = `($e=[IO.Path]::GetExtension($_.Name).ToLower()) -and (Test-Path "Registry::HKEY_CLASSES_ROOT\$e") -and ((Get-ItemProperty -Path "Registry::HKEY_CLASSES_ROOT\$e" -ErrorAction SilentlyContinue).PerceivedType -eq '{1}')`
		item(image=\uE0E7 window=0 keys=keys_deselect title='All Folders' vis=vis_for_dirs
			cmd-ps=str.fmt(ps, `$_.Type -eq 'File folder'`))
		item(image=\uE108 window=0 keys=keys_deselect title='All Files'  tip='Select all files (excludes folders)' vis=vis_for_files
			cmd-ps=str.fmt(ps, `$_.Type -ne 'File folder'`))
		item(image=\uE109 window=0 keys=keys_deselect title='Nilesoft Shell Files' tip='Select .nss configuration files' vis=vis_for_nss
			cmd-ps=str.fmt(ps, `$_.Name -like '*.nss'`))
		item(image=\uE109 window=0 keys=keys_deselect title='Microsoft Office Files' tip='Select Word, Excel, PowerPoint files' vis=vis_for_files
			cmd-ps=str.fmt(ps, `$_.Type -like 'Microsoft*'`))
		separator()
		menu(image=\uE186 title='Search in Names' tip='Select items by name patterns') {
			item(image=inherit window=0 keys=keys_deselect title='Search Number' tip='Select items with number in name'
				cmd-ps=str.fmt(ps, `$_.Name -match '\d'`))
			separator()
			item(image=inherit window=0 keys=keys_deselect title='Search "a" in name'
				cmd-ps=str.fmt(ps, `$_.Name -like '*a*'`))
			item(image=inherit window=0 keys=keys_deselect title='Search "a" or "e" in name'
				cmd-ps=str.fmt(ps, `$_.Name -match '.*(e|a).*'`))
			item(image=inherit window=0 keys=keys_deselect title='Search "sys" in name'
				cmd-ps=str.fmt(ps, `$_.Name -like '*sys*'`))
			item(image=inherit window=0 keys=keys_deselect title='Search "disk" in name'
				cmd-ps=str.fmt(ps, `$_.Name -like '*disk*'`))
			separator()
			item(image=inherit window=0 keys=keys_deselect title='Search list #1'
				cmd-ps=str.fmt(ps, `$_.Name -match '\.(txt|doc|docx|pdf|rtf|csv|xml|json|md)$'`)) }			
		menu(image=\uE26E title='Development Files' tip='Select programming and development files') {
			item(window=0 keys=keys_deselect title='Source Code Files'
				cmd-ps=str.fmt(ps, `$_.Name -match '\.(nss|js|ts|py|java|cpp|c|cs|php|rb|go|rs)$'`))
			item(window=0 keys=keys_deselect title='Web Files'
				cmd-ps=str.fmt(ps, `$_.Name -match '\.(html|htm|css|scss|sass|less)$'`))
			item(window=0 keys=keys_deselect title='Config Files'
				cmd-ps=str.fmt(ps, `$_.Name -match '\.(json|xml|yml|yaml|ini|cfg|conf)$'`)) }
		menu(image=\uE142 title='Meta Types@"\t"slow' tip='Select by Windows perceived type' vis=vis_for_files) {
			item(image=\uE155 window=0 keys=keys_deselect title='Meta: audio'
				cmd-ps=str.fmt(ps, meta, 'audio'))
			item(image=\uE152 window=0 keys=keys_deselect title='Meta: video'
				cmd-ps=str.fmt(ps, meta, 'video'))
			item(image=\uE150 window=0 keys=keys_deselect title='Meta: image'
				cmd-ps=str.fmt(ps, meta, 'image'))
			item(image=\uE141 window=0 keys=keys_deselect title='Meta: document'
				cmd-ps=str.fmt(ps, meta, 'document'))
			item(image=\uE10E window=0 keys=keys_deselect title='Meta: text'
				cmd-ps=str.fmt(ps, meta, 'text'))
			item(image=icon.compressed window=0 keys=keys_deselect title='Meta: compressed'
				cmd-ps=str.fmt(ps, meta, 'compressed'))
			item(image=\uE142 window=0 keys=keys_deselect title='Meta: system'
				cmd-ps=str.fmt(ps, meta, 'system')) }
		menu(image=\uE1ED title='By File Size' tip='Select files by size ranges' vis=vis_for_files) {
			item(window=0 keys=keys_deselect title='Empty Files' tip='Select files with 0 bytes'
    			cmd-ps=str.fmt(ps, `$_.Type -ne 'File folder' -and $_.Size -eq 0`))
			separator()
			item(window=0 keys=keys_deselect title='Less 1KB'
				cmd-ps=str.fmt(ps, `$_.Type -ne 'File folder' -and $_.Size -lt 1024`))
			item(window=0 keys=keys_deselect title='Less 1MB'
				cmd-ps=str.fmt(ps, `$_.Type -ne 'File folder' -and $_.Size -lt (1024 * 1024)`))
			item(window=0 keys=keys_deselect title='Less 1GB'
				cmd-ps=str.fmt(ps, `$_.Type -ne 'File folder' -and $_.Size -lt (1024 * 1024 * 1024)`))
			item(window=0 keys=keys_deselect title='Greater 1KB'
				cmd-ps=str.fmt(ps, `$_.Type -ne 'File folder' -and $_.Size -gt 1024`))
			item(window=0 keys=keys_deselect title='Greater 1MB'
				cmd-ps=str.fmt(ps, `$_.Type -ne 'File folder' -and $_.Size -gt (1024 * 1024)`))
			item(window=0 keys=keys_deselect title='Greater 1GB'
				cmd-ps=str.fmt(ps, `$_.Type -ne 'File folder' -and $_.Size -gt (1024 * 1024 * 1024)`))
			separator()
			item(window=0 keys=keys_deselect title='200KB < ... < 900KB'
				cmd-ps=str.fmt(ps, `$_.Type -ne 'File folder' -and $_.Size -gt (200 * 1024) -and $_.Size -lt (900 * 1024)`)) }
		menu(image=\uE1F0 title='By Date' tip='Select files by modification date') {
			item(window=0 keys=keys_deselect title='Modified Today'
				cmd-ps=str.fmt(ps, `$_.ModifyDate.Date -eq (Get-Date).Date`))
			item(window=0 keys=keys_deselect title='Modified This Week'
				cmd-ps=str.fmt(ps, `$_.ModifyDate -gt (Get-Date).AddDays(-7)`))
			item(window=0 keys=keys_deselect title='Modified This Month'
				cmd-ps=str.fmt(ps, `$_.ModifyDate -gt (Get-Date).AddMonths(-1)`))
			item(window=0 keys=keys_deselect title='Older Than 6 Months'
				cmd-ps=str.fmt(ps, `$_.ModifyDate -lt (Get-Date).AddMonths(-6)`)) }} 
	separator()
	$regCheckSelect = 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
	$regCheckSelectShowed = reg.get(regCheckSelect,'AutoCheckSelect')==1
	item(title='Item Checkboxes' tip='Toggle selection checkboxes in File Explorer. Makes multi-selection easier' image=[[\uE137, if(regCheckSelectShowed, image.color2, image.color1)]] commands {
		cmd=reg.set(regCheckSelect, 'AutoCheckSelect', @if(regCheckSelectShowed,0,1), reg.dword) wait=1,
		//cmd='ie4uinit' args='-show' wait=1,
		//cmd=command.refresh wait=1,
		cmd=wnd.command(28931) wait=1,} )
}