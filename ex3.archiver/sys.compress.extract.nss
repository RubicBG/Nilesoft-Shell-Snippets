// Author: Rubic / RubicBG

//> https://www.tenforums.com/tutorials/3233-add-remove-extract-all-context-menu-windows.html
// modify(find='Extract All*' menu=title.more_options sep pos=0)
// remove(clsid='{b8cdcb65-b1bf-4b42-9428-1dfdb7ee92af}' where=!this.isuwp)

$menu_archiver = ''
menu(title='Compress and Extract' type='file|dir' image=icon.res('zipfldr.dll,-101')) {
	modify(find='Extract All*' pos='middle' menu=menu_archiver+'/Compress and Extract')
	menu(title='NS Modern Commands' image=icon.settings sep pos=bottom tip='Clone commands from modern to legacy context menu') {
		// $reg_path	= 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell'
		$rk	= null // registry keyword name
		$rt	= null // registry target name
		$re	= null // registry extension name
		$reg_modify = 'reg query "HKEY_CLASSES_ROOT\@re\shell\@rk" >nul 2>&1 && reg delete "HKEY_CLASSES_ROOT\@re\shell\@rk" /f || reg copy "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\@rk" "HKEY_CLASSES_ROOT\@re\shell\@rk" /f'
		
		// Windows.CompressTo
		item(title=str.res('windows.UI.FileExplorer.dll,-51797') checked=reg.exists('HKCR\*\shell\Windows.CompressTo') and reg.exists('HKCR\Folder\shell\Windows.CompressTo') keys='menu'
			admin cmd-line='/c @{rk = 'Windows.CompressTo' rt = rk } @{re = '*'} @reg_modify & @{re = 'Folder'} @reg_modify' window='hidden')
		modify(where=this.title==str.res('windows.UI.FileExplorer.dll,-51797') image=icon.res('zipfldr.dll,-101') pos='middle' menu=menu_archiver+'/Compress and Extract')
		// Windows.CompressTo.Wizard
		item(title=str.res('zipfldr.dll,-10610') checked=reg.exists('HKCR\*\shell\Windows.CompressTo.Wizard') and reg.exists('HKCR\Folder\shell\Windows.CompressTo.Wizard') keys='wizard'
			admin cmd-line='/c @{rk = 'Windows.CompressTo.Wizard' rt = rk } @{re = '*'} @reg_modify & @{re = 'Folder'} @reg_modify' window='hidden')
		modify(where=this.title==str.res('zipfldr.dll,-10536') image=icon.res('zipfldr.dll,-101') title=str.res('zipfldr.dll,-10610') tip=str.res('zipfldr.dll,-10537') pos='middle' menu=menu_archiver+'/Compress and Extract')
		// Windows.CompressTo.Zip
		item(title=str.res('Windows.UI.FileExplorer.dll,-51793') checked=reg.exists('HKCR\*\shell\Windows.CompressTo.Zip') and reg.exists('HKCR\Folder\shell\Windows.CompressTo.Zip')
			admin cmd-line='/c @{rk = 'Windows.CompressTo.Zip' rt = rk } @{re = '*'} @reg_modify & @{re = 'Folder'} @reg_modify' window='hidden')
		modify(where=this.title==str.res('zipfldr.dll,-10530') image=icon.res('zipfldr.dll,-101') title=str.replace(str.res('windows.UI.FileExplorer.dll,-51797'), '...', ' ' + str.res('Windows.UI.FileExplorer.dll,-51798')) tip=str.res('zipfldr.dll,-10531') pos='middle' menu=menu_archiver+'/Compress and Extract')
		// Windows.CompressTo.7z
		item(title=str.replace(str.res('windows.UI.FileExplorer.dll,-51797'), '...', ' ' + str.res('Windows.UI.FileExplorer.dll,-51799')) checked=reg.exists('HKCR\*\shell\Windows.CompressTo.7z') and reg.exists('HKCR\Folder\shell\Windows.CompressTo.7z')
			admin cmd-line='/c @{rk = 'Windows.CompressTo.7z' rt = rk } @{re = '*'} @reg_modify & @{re = 'Folder'} @reg_modify' window='hidden')
		modify(where=this.title==str.res('zipfldr.dll,-10532') image=icon.res('zipfldr.dll,-101') title=str.replace(str.res('windows.UI.FileExplorer.dll,-51797'), '...', ' ' + str.res('Windows.UI.FileExplorer.dll,-51799')) pos='middle' menu=menu_archiver+'/Compress and Extract')
		// Windows.CompressTo.Tar
		item(title=str.replace(str.res('windows.UI.FileExplorer.dll,-51797'), '...', ' ' + str.res('Windows.UI.FileExplorer.dll,-51800')) checked=reg.exists('HKCR\*\shell\Windows.CompressTo.Tar')
			admin cmd-line='/c @{rk = 'Windows.CompressTo.Tar' rt = rk } @{re = '*'} @reg_modify & @{re = 'Folder'} @reg_modify' window='hidden')
		modify(where=this.title==str.res('zipfldr.dll,-10534') image=icon.res('zipfldr.dll,-101') title=str.replace(str.res('windows.UI.FileExplorer.dll,-51797'), '...', ' ' + str.res('Windows.UI.FileExplorer.dll,-51800')) pos='middle' menu=menu_archiver+'/Compress and Extract')
	}
}