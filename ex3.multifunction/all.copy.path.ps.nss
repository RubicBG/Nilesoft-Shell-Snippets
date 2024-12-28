// Author: Rubic / RubicBG
// Based on: jorn's idea (Discord)
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

menu(image=icon.copy_path title=title.copy_path mode='multiple' type='file|dir|back.dir|drive|back.drive|desktop') {
	item(image=inherit title='Copy item@if(sel.count>1, 's') full path' tip='Copies the full path of the selected item(s) to the clipboard'
		window='hidden' cmd-ps=`-Command @sel(2, ',') | % { [System.IO.Path]::GetFullPath($_) } | Set-Clipboard`)
	item(image=inherit title='Copy parent@if(sel.count>1, 's') full path' where=!path.isdrive(sel) tip='Copies the full path of the parent directory of the selected item(s) to the clipboard'
		window='hidden' cmd-ps=`-Command @sel(2, ',') | % { [System.IO.Path]::GetDirectoryName($_) } | Set-Clipboard`)
	separator()
	item(title='Copy item@if(sel.count>1, 's') name' tip='Copies the name (with extension) of the selected item(s) to the clipboard'
		window='hidden' cmd-ps=`-Command @sel(2, ',') | % { [System.IO.Path]::GetFileName($_) } | Set-Clipboard`)
	item(title='Copy item@if(sel.count>1, 's') title' tip='Copies the title (name without extension) of the selected item(s) to the clipboard'
		window='hidden' cmd-ps=`-Command @sel(2, ',') | % { [System.IO.Path]::GetFileNameWithoutExtension($_) } | Set-Clipboard`)
	separator()
	item(title='Copy Content@if(sel.count>1, 's')' type='file' mode='multi_unique' tip='Copies the content of the selected file(s) to the clipboard'
		window='hidden' cmd-ps=`-Command  @sel(2, ',') | % { Get-Content $_ -Raw } | Set-Clipboard`)
	item(image=inherit title='Copy Content@if(sel.count>1, 's')' type='dir|back.dir|drive|back.drive|desktop' tip='Copies the full paths of all items inside the selected directory/drive to the clipboard'
		window='hidden' cmd-ps=`-Command Set-Clipboard -LiteralPath (@sel(2, ',') | % { Get-ChildItem $_ -Force | % { $_.FullName } })`) }

		