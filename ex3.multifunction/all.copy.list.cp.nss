// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

menu(image=icon.copy_path title='Copy list' mode='single' type='dir|back.dir|drive|back.drive|desktop') {
	item(image=inherit keys='SHIFT paths recursive' title='Copy item names'
		tip='Copy the names of selected items to the clipboard, including hidden irems. Hold SHIFT to include full paths and subfolders.'
		window=hidden cmd-line='/c dir @sel(true) @if(keys.shift(), '/s') /b /o:gn | clip')
	item(image=inherit keys='SHIFT paths recursive' title='Copy item names with stats 'where=keys.shift()
		tip='Copy the names of selected items to the clipboard, including hidden irems. Hold SHIFT to include full paths, subfolders, and item details.'
		window=hidden cmd-line='/c dir @sel(true) @if(keys.shift(), '/s') /o:gn | clip')
	item(image=inherit keys='SHIFT paths recursive' title='Copy folder names'
		tip='Copy the names of selected folders to the clipboard, including hidden folders. Hold SHIFT to include full paths and subfolders.'
		window=hidden cmd-line='/c dir @sel(true) @if(keys.shift(), '/s') /b /a:d /o:n | clip')
	item(image=inherit keys='SHIFT paths recursive' title='Copy folder names with stats' where=keys.shift()
		tip='Copy the names of selected folders to the clipboard, including hidden folders. Hold SHIFT to include full paths, subfolders, and folder details.'
		window=hidden cmd-line='/c dir @sel(true) @if(keys.shift(), '/s') /a:d /o:n | clip')
	item(image=inherit keys='SHIFT paths recursive' title='Copy file names'
		tip='Copy the names of selected files to the clipboard, including hidden files. Hold SHIFT to include full paths and subfolders.'
		window=hidden cmd-line='/c dir @sel(true) @if(keys.shift(), '/s') /b /a:-d /o:n | clip')
	item(image=inherit keys='SHIFT paths recursive' title='Copy file names with stats' where=keys.shift()
		tip='Copy the names of selected files to the clipboard, including hidden files. Hold SHIFT to include full paths, subfolders, and file details.'
		window=hidden cmd-line='/c dir @sel(true) @if(keys.shift(), '/s') /a:-d /o:n | clip')
	separator()
	item(image=inherit title='Copy file names with size (in bytes)'
		tip='Copy the names and sizes (in bytes) of all files in the selected folder to the clipboard. Hidden files are not included.'
		cmd-ps=`$path = '@sel'; $list = Get-ChildItem -LiteralPath $path | Where-Object { $_.PSIsContainer -eq $false } | ForEach-Object { $fileName = $_.Name; $fileSize = $_.Length; \"$fileName - $($fileSize) bytes\"; }; $list | Out-String | Set-Clipboard;` window=hidden)
	item(image=inherit title='Copy file names with size (formated)'
		 tip='Copy the names and sizes of all files in the selected folder to the clipboard, formatted as GB, MB, or KB as appropriate. Hidden files are not included.'
		cmd-ps=`$path = '@sel'; $list = Get-ChildItem -LiteralPath $path | Where-Object { $_.PSIsContainer -eq $false } | ForEach-Object { $fileName = $_.Name; $fileSizeBytes = $_.Length; if ($fileSizeBytes -ge 1GB) { $fileSizeGB = $fileSizeBytes / 1GB; \"$fileName - $($fileSizeGB.ToString('N2')) GB\"; } elseif ($fileSizeBytes -ge 1MB) { $fileSizeMB = $fileSizeBytes / 1MB; \"$fileName - $($fileSizeMB.ToString('N2')) MB\"; } else { $fileSizeKB = $fileSizeBytes / 1KB; \"$fileName - $($fileSizeKB.ToString('N2')) KB\"; } }; $list | Out-String | Set-Clipboard;` window=hidden) }
