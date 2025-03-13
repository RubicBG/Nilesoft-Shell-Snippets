// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

// Hide default menu: NS can not recognize drag&drop paths, so use:
remove(find='Winrar')
//remove(clsid='{B41DB860-64E4-11D2-9906-E49FADC173CA}' where=!this.isuwp)

// Executables and Paths
$reg_winrar_exe		= reg.get('HKLM\Software\Microsoft\Windows\CurrentVersion\App Paths\WinRAR.exe') // path.combine(sys.prog, 'WinRar', 'WinRar.exe')
$reg_winrar_exe64	= reg.get('HKLM\Software\WinRAR', 'exe64')
$cmd_winrar 		= eval(if(sys.type == 64, reg_winrar_exe64, reg_winrar_exe))
$cmd_winrar_path	= eval(path.parent(cmd_winrar))
// Software Support Extension
$cmd_winrar_sse = str.join(reg.values('HKLM\Software\WinRAR\Capabilities\FileAssociations'), '|')
// Theme and Icons
$path_winrar_theme	= path.combine(sys.appdata, 'WinRAR\Themes', reg('HKCU\Software\WinRAR\Interface\Themes', 'ActivePath'))
$img_winrar			= If(path.exists(path_winrar_theme), path.combine(path_winrar_theme, 'rar.ico')					, cmd_winrar)
$img_winrar_extract = If(path.exists(path_winrar_theme), path.combine(path_winrar_theme, 'Toolbar', 'extract.png')	, cmd_winrar)
$img_winrar_add 	= If(path.exists(path_winrar_theme), path.combine(path_winrar_theme, 'Toolbar', 'add.png')		, cmd_winrar)
$img_winrar_delete	= If(path.exists(path_winrar_theme), path.combine(path_winrar_theme, 'Toolbar', 'delete.png')	, cmd_winrar)
$img_winrar_sfx 	= If(path.exists(path_winrar_theme), path.combine(path_winrar_theme, 'Toolbar', 'sfx.png')		, cmd_winrar)
$img_winrar_sfx_logo= If(path.exists(path_winrar_theme), path.combine(path_winrar_theme, 'Toolbar', 'sfxlogo.png')	, cmd_winrar)
$img_winrar_convert = If(path.exists(path_winrar_theme), path.combine(path_winrar_theme, 'Toolbar', 'convert.png')	, cmd_winrar)
$img_winrar_test	= If(path.exists(path_winrar_theme), path.combine(path_winrar_theme, 'Toolbar', 'test.png')		, cmd_winrar)
$img_winrar_repair 	= If(path.exists(path_winrar_theme), path.combine(path_winrar_theme, 'Toolbar', 'repair.png')	, cmd_winrar)
$img_winrar_info 	= If(path.exists(path_winrar_theme), path.combine(path_winrar_theme, 'Toolbar', 'info.png')		, cmd_winrar)

menu(title='WinRar' mode='multiple' type='file|drive|dir|back.drive|back.dir|Desktop' image=img_winrar vis=if(!path.exists(cmd_winrar_path), 'disable') tip=if(!path.exists(cmd_winrar_path), 'Requires WinRar to be installed'))
{
	item(title='Extract to...' keys='with manager' sep='before'
		mode='multiple' type='file' find=cmd_winrar_sse image=image.res(img_winrar_extract)
		cmd=cmd_winrar args='x -iext -ver -imon1 @sel(true," -an=")' + ' "?\"')
	item(title='Extract to "@sel.path.title\"'
		mode='multiple' type='file' find=cmd_winrar_sse image=image.res(img_winrar_extract)
		cmd=cmd_winrar args='x -iext -ver -imon1 @sel(true," -an=")' + ' * "@sel.path.title \"')
	item(title='Extract to "@sel.path.title\" and Delete It' vis=keys.shift()
		mode='single' type='file' find=cmd_winrar_sse image=image.res(img_winrar_delete) commands {
		cmd=cmd_winrar args='x -iext -ver -imon1 @sel(true)' + ' * "@sel.path.title \"' wait = 1,
		cmd=if(msg('Are you sure you want to delete the archive file?', 'NileSoft Shell', msg.warning | msg.yesno)==msg.idyes, io.delete(sel)) wait = 1,
    	cmd=command.refresh wait = 1, })
	item(title='Extract each archive to separate folder'
		mode='multiple' type='file' where=sel.count>1 find=cmd_winrar_sse image=image(img_winrar_extract)
		cmd=cmd_winrar args='x -iext -ver -imon1 -ad1 @sel(true," -an=")' + ' * \')
	item(title='Extract Here'
		mode='multiple' type='file' find=cmd_winrar_sse sep=sep.after image=image.res(img_winrar_extract)
		cmd=cmd_winrar args='x -iext -ver -imon1 @sel(true," -an=")' + ' * \')

	// known issue: can not add archive to itself
	item(title='Add to...' keys='with manager' tip='Archive file(s) with WinRAR Manager...'
		mode='multiple' type='file|dir' image=image.res(img_winrar_add) sep='before'
		cmd=cmd_winrar args='a -ep1 -scul -r0 -iext -imon1 . @sel(true)')
	menu(title='Add to ...' mode='multiple' type='file|dir' image=image.res(img_winrar_add))
	{
		$reg_Prof0 = reg('HKCU\Software\WinRAR\Profiles\0', 'Name')
		$reg_Prof1 = reg('HKCU\Software\WinRAR\Profiles\1', 'Name')
		$reg_Prof2 = reg('HKCU\Software\WinRAR\Profiles\2', 'Name')
		$reg_Prof3 = reg('HKCU\Software\WinRAR\Profiles\3', 'Name')
		$reg_Prof4 = reg('HKCU\Software\WinRAR\Profiles\4', 'Name')
		$reg_Prof5 = reg('HKCU\Software\WinRAR\Profiles\5', 'Name')
		$reg_Prof6 = reg('HKCU\Software\WinRAR\Profiles\6', 'Name')
		$reg_Prof7 = reg('HKCU\Software\WinRAR\Profiles\7', 'Name')
		$reg_Prof8 = reg('HKCU\Software\WinRAR\Profiles\8', 'Name')
		$reg_Prof9 = reg('HKCU\Software\WinRAR\Profiles\9', 'Name')
		item(title=reg_Prof0 where=str.len(reg_Prof0)>0
			cmd=cmd_winrar args='a -cp"@reg_Prof0" -ep1 -scul -r0 -iext -imon1 "@sel.title" @sel(true)')
		item(title=reg_Prof1 where=str.len(reg_Prof1)>0
			cmd=cmd_winrar args='a -cp"@reg_Prof1" -ep1 -scul -r0 -iext -imon1 "@sel.title" @sel(true)')
		item(title=reg_Prof2 where=str.len(reg_Prof2)>0
			cmd=cmd_winrar args='a -cp"@reg_Prof2" -ep1 -scul -r0 -iext -imon1 "@sel.title" @sel(true)')
		item(title=reg_Prof3 where=str.len(reg_Prof3)>0
			cmd=cmd_winrar args='a -cp"@reg_Prof3" -ep1 -scul -r0 -iext -imon1 "@sel.title" @sel(true)')
		item(title=reg_Prof4 where=str.len(reg_Prof4)>0
			cmd=cmd_winrar args='a -cp"@reg_Prof4" -ep1 -scul -r0 -iext -imon1 "@sel.title" @sel(true)')
		item(title=reg_Prof5 where=str.len(reg_Prof5)>0
			cmd=cmd_winrar args='a -cp"@reg_Prof5" -ep1 -scul -r0 -iext -imon1 "@sel.title" @sel(true)')
		item(title=reg_Prof6 where=str.len(reg_Prof6)>0
			cmd=cmd_winrar args='a -cp"@reg_Prof6" -ep1 -scul -r0 -iext -imon1 "@sel.title" @sel(true)')
		item(title=reg_Prof7 where=str.len(reg_Prof7)>0
			cmd=cmd_winrar args='a -cp"@reg_Prof7" -ep1 -scul -r0 -iext -imon1 "@sel.title" @sel(true)')
		item(title=reg_Prof8 where=str.len(reg_Prof8)>0
			cmd=cmd_winrar args='a -cp"@reg_Prof8" -ep1 -scul -r0 -iext -imon1 "@sel.title" @sel(true)')
		item(title=reg_Prof9 where=str.len(reg_Prof9)>0
			cmd=cmd_winrar args='a -cp"@reg_Prof9" -ep1 -scul -r0 -iext -imon1 "@sel.title" @sel(true)')
	}

	item(title='Add to "@sel.title'+'.rar"' keys='SHIFT to .zip' tip='Press SHIFT key to add to "@sel.title'+'.zip"'
		mode='multiple' type='file|dir' image=image.res(img_winrar_add)
		cmd=cmd_winrar args='a -ep1 -scul -r0 -iext -imon1 "@sel.title@if(key.shift(),".zip",".rar")" @sel(true)')
	item(title='Add to "@sel.parent.name'+'.rar"' keys='SHIFT to .zip' tip='Press SHIFT key to add to "@sel.parent.name'+'.zip"'
		mode='multiple' type='file|dir' where=('@sel.file.title'!='@sel.parent.name') image=image.res(img_winrar_add)
		cmd=cmd_winrar args='a -ep1 -scul -r0 -iext -imon1 "@sel.parent.name@if(key.shift(),".zip",".rar")" @sel(true)')

	menu(title='Add to unique archives...' type='file|dir|back.dir' image=image.res(img_winrar_add) sep=sep.after)
	{
		item(title='Convert Folder to "@sel.path.title'+'.rar"' keys='SHIFT to .zip' tip='Press SHIFT key to add to "@sel.path'+'.zip"'
			mode='single' type='dir' where=len(path.files(sel.dir))>0 image=image.res(img_winrar_delete)
			cmd=cmd_winrar args='a -ep1 -scul -r0 -iext -imon1 -dr "@sel.path@if(key.shift(),".zip",".rar")" "@sel.path.title\*"')
		item(title='Move all to "@sel.title'+'.rar"' keys='SHIFT to .zip' tip='Press SHIFT key to add to "@sel.title'+'zip"'
			mode='single' type='back.dir' image=image.res(img_winrar_delete)
			cmd=cmd_winrar args='a -ep1 -scul -r0 -iext -imon1 -dr ".\@sel.title@if(key.shift(),".zip",".rar")" *')

		item(title='Create a SFX "@sel.title'+'.sfx.exe"'
			mode='multiple' type='file|dir' sep='before' image=image.res(img_winrar_sfx)
			cmd=cmd_winrar args='a -ep1 -scul -r0 -iext -imon1 -sfx "@sel.parent\@sel.title'+'.sfx.exe" @sel(true)')
	}

	item(title='Convert archive(s)...'
		mode='multiple' type='file' find=cmd_winrar_sse image=image.res(img_winrar_convert)
		cmd=cmd_winrar args='cv -iext -imon1 @sel(true," -an=")')
	item(title='Test archive(s)...'
		mode='multiple' type='file' find=cmd_winrar_sse image=image.res(img_winrar_test)
		cmd=cmd_winrar args='t -iext -idv -imon1 @sel(true," -an=")')
	item(title='Repair archive...'
		mode='single' type='file' find=cmd_winrar_sse sep=sep.after image=image.res(img_winrar_repair)
		cmd=cmd_winrar args='r -iext @sel.path(true)')

	// known issue: can not recognize sfx from exe
	item(title='Open with WinRAR...'
		mode='single' type='file' find=cmd_winrar_sse image=image.res(img_winrar)
		cmd=cmd_winrar args='-iext @sel.path(true)')
	item(title='Browse with WinRAR...'
		mode='single' type='drive|dir|back.drive|back.dir|Desktop' sep=sep.after image=image.res(img_winrar)
		cmd=cmd_winrar args='-iext @sel.path(true)')

	menu(title='WinRAR Help' mode='multiple' where=key.shift() sep=sep.top image=image.res(img_winrar_info))
	{
		item(title='Documentation...'
			mode='multiple' image=image.res(img_winrar_info)
			cmd='@cmd_winrar_path\WinRAR.chm')
		item(title='Web support...'
			mode='multiple' image=image.res(img_winrar_info)
			cmd='https://www.win-rar.com/support.html')
		// If you have a license key, open rarreg.key with text editor and copy the license information to the following variables (it won't work with this example)
		$EULA_user		= 'Shell'
		$EULA_license	= 'Unlimited Company License'
		$EULA_key		= '4ae132ea6ff589ae3e17@"\n"64122122503e17f4ed244955149fd14d9dcc0b423cb56ad4b5009d@"\n"a9cdf27113a976d04d0d60fce6cb5ffde62890079861be57638717@"\n"7131ced835ed65cc743d9777f2ea71a8e32c7e593cf66794343565@"\n"b41bcf56929486b8bcdac33d50ecf7739960d2d3ae1e72adee2b40@"\n"97b1f3ba9d57e81ea3224b06dadeef1f6c5f544a489986e6102d8e@"\n"f770005bb7cd8058d56fa5aa3fe4e828e196feb99c8fd48e6021aa@"\n"cb5350dbc77a49be7f004ffc705a52cc7f7195d26ca42546815861'
		// $EULA_full		= 'RAR registration data' + "\n" + EULA_user + "\n" + EULA_license + "\n" + 'UID=' + EULA_key
		item(title='Registration'
			mode='multiple' admin=@key.shift() image=image.res(img_winrar_info)
			admin cmd-line='/c del "@cmd_winrar_path\rarreg.key" & (echo RAR registration data&& echo ' + EULA_user + '&& echo ' + EULA_license + '&& echo ' + str.replace(EULA_key, '@"\n"', '&& echo ') + ') > "@cmd_winrar_path\rarreg.key"' window='hidden')
		item(title='Istall Popcol Theme'
			image=icon.res(path.combine(sys.bin, 'shell32.dll'), 122) commands {
			cmd-ps=`$DownloadURL = 'https://www.rarlab.com/themes/POPCOL_96x96.theme.rar'; $TempRarPath = '@sys.temp\POPCOL_96x96.theme.rar'; Invoke-WebRequest -Uri $DownloadURL -OutFile $TempRarPath; Start-Process -FilePath '@cmd_winrar' -ArgumentList $TempRarPath;` window='hidden' wait='true',
			cmd=reg.set('HKCU\Software\WinRAR\Interface\Themes', 'ActivePath', 'POPCOL_96x96', reg.sz) wait='true',
			cmd-ps=`$TempRarPath = '@sys.temp\POPCOL_96x96.theme.rar'; Remove-Item -Path $TempRarPath -Force;` window='hidden' wait='true', })
		item(title='update WinRAR ...'
			image=icon.res(path.combine(sys.bin, 'shell32.dll'), 122)
			cmd-ps='winget install --id=RARLab.WinRAR -e')
	}
}

// menu(title=menu_archiver mode='multiple' type='*' where=window.name=="static" image=[[\uE019],[\uE01A]] position=top) { item(title='Test' type='*' where=window.name=="static" tip=sel) }

