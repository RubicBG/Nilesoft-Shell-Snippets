// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

// Executables and Paths
$cmd_winrar 		= eval(path.combine(sys.prog, 'WinRar', 'WinRar.exe'))
$cmd_winrar_path	= eval(path.parent(cmd_winrar))
// Software Support Extension
$cmd_winrar_sse = '.rar|.zip|.cab|.arj|.lz|.tlz|.lzh|.lha|.7z|.tar|.gz|.tgz|.uue|.xxe|.uu|.bz2|.tbz2|.bz|.tbz|.jar|.iso|.z|.taz|.xz|.txz|.zipx|.zst|.tzst|.001'

menu(title='WinRar' mode='multiple' type='file|drive|dir|back.drive|back.dir|Desktop' image=cmd_winrar vis=if(!path.exists(cmd_winrar_path), 'disable'))
{
	item(title='Extract to...' keys='with manager' sep='before'
		mode='multiple' type='file' find=cmd_winrar_sse image=inherit
		cmd=cmd_winrar args='x -iext -ver -imon1 @sel(true," -an=")' + ' "?\"')
	item(title='Extract to "@sel.path.title\"'
		mode='multiple' type='file' find=cmd_winrar_sse image=inherit
		cmd=cmd_winrar args='x -iext -ver -imon1 @sel(true," -an=")' + ' * "@sel.path.title \"')
	item(title='Extract to "@sel.path.title\" and Delete It' vis=keys.shift()
		mode='single' type='file' find=cmd_winrar_sse image=inherit commands {
		cmd=cmd_winrar args='x -iext -ver -imon1 @sel(true)' + ' * "@sel.path.title \"' wait = 1,
		cmd=if(msg('Are you sure you want to delete the archive file?', 'NileSoft Shell', msg.warning | msg.yesno)==msg.idyes, io.delete(sel)) wait = 1,
    	cmd=command.refresh wait = 1, })
	item(title='Extract each archive to separate folder'
		mode='multiple' type='file' where=sel.count>1 find=cmd_winrar_sse image=inherit
		cmd=cmd_winrar args='x -iext -ver -imon1 -ad1 @sel(true," -an=")' + ' * \')
	item(title='Extract Here'
		mode='multiple' type='file' find=cmd_winrar_sse sep=sep.after image=inherit
		cmd=cmd_winrar args='x -iext -ver -imon1 @sel(true," -an=")' + ' * \')

	// known issue: can not add archive to itself
	item(title='Add to...' keys='with manager' tip='Archive file(s) with WinRAR Manager...'
		mode='multiple' type='file|dir' image=inherit sep='before'
		cmd=cmd_winrar args='a -ep1 -scul -r0 -iext -imon1 . @sel(true)')
	item(title='Add to "@sel.title'+'.rar"' keys='SHIFT to .zip' tip='Press SHIFT key to add to "@sel.title'+'.zip"'
		mode='multiple' type='file|dir' image=inherit
		cmd=cmd_winrar args='a -ep1 -scul -r0 -iext -imon1 "@sel.title@if(key.shift(),".zip",".rar")" @sel(true)')
	item(title='Add to "@sel.parent.name'+'.rar"' keys='SHIFT to .zip' tip='Press SHIFT key to add to "@sel.parent.name'+'.zip"'
		mode='multiple' type='file|dir' where=('@sel.file.title'!='@sel.parent.name') image=inherit
		cmd=cmd_winrar args='a -ep1 -scul -r0 -iext -imon1 "@sel.parent.name@if(key.shift(),".zip",".rar")" @sel(true)')
	menu(title='Add to unique archives...' type='file|dir|back.dir' image=inherit sep=sep.after) {
		item(title='Convert Folder to "@sel.path.title'+'.rar"' keys='SHIFT to .zip' tip='Press SHIFT key to add to "@sel.path'+'.zip"'
			mode='single' type='dir' where=len(path.files(sel.dir))>0 image=inherit
			cmd=cmd_winrar args='a -ep1 -scul -r0 -iext -imon1 -dr "@sel.path@if(key.shift(),".zip",".rar")" "@sel.path.title\*"')
		item(title='Move all to "@sel.title'+'.rar"' keys='SHIFT to .zip' tip='Press SHIFT key to add to "@sel.title'+'zip"'
			mode='single' type='back.dir' image=inherit
			cmd=cmd_winrar args='a -ep1 -scul -r0 -iext -imon1 -dr ".\@sel.title@if(key.shift(),".zip",".rar")" *')
		item(title='Create a SFX "@sel.title'+'.sfx.exe"'
			mode='multiple' type='file|dir' sep='before' image=inherit
			cmd=cmd_winrar args='a -ep1 -scul -r0 -iext -imon1 -sfx "@sel.parent\@sel.title'+'.sfx.exe" @sel(true)') }

	item(title='Convert archive(s)...'
		mode='multiple' type='file' find=cmd_winrar_sse image=inherit
		cmd=cmd_winrar args='cv -iext -imon1 @sel(true," -an=")')
	item(title='Test archive(s)...'
		mode='multiple' type='file' find=cmd_winrar_sse image=inherit
		cmd=cmd_winrar args='t -iext -idv -imon1 @sel(true," -an=")')
	item(title='Repair archive...'
		mode='single' type='file' find=cmd_winrar_sse sep=sep.after image=inherit
		cmd=cmd_winrar args='r -iext @sel.path(true)')

	// known issue: can not recognize sfx from exe
	item(title='Open with WinRAR...'
		mode='single' type='file' find=cmd_winrar_sse image=inherit
		cmd=cmd_winrar args='-iext @sel.path(true)')
	item(title='Browse with WinRAR...'
		mode='single' type='drive|dir|back.drive|back.dir|Desktop' sep=sep.after image=inherit
		cmd=cmd_winrar args='-iext @sel.path(true)')

	menu(title='WinRAR Help' mode='multiple' where=key.shift() sep=sep.top image=inherit)
	{
		item(title='Documentation...'
			mode='multiple'
			cmd='@cmd_winrar_path\WinRAR.chm')
		item(title='Web support...'
			mode='multiple'
			cmd='https://www.win-rar.com/support.html')
		// If you have a license key, open rarreg.key with text editor and copy the license information to the following variables (it won't work with this example)
		$EULA_user		= 'Shell'
		$EULA_license	= 'Unlimited Company License'
		$EULA_key		= '4ae132ea6ff589ae3e17@"\n"64122122503e17f4ed244955149fd14d9dcc0b423cb56ad4b5009d@"\n"a9cdf27113a976d04d0d60fce6cb5ffde62890079861be57638717@"\n"7131ced835ed65cc743d9777f2ea71a8e32c7e593cf66794343565@"\n"b41bcf56929486b8bcdac33d50ecf7739960d2d3ae1e72adee2b40@"\n"97b1f3ba9d57e81ea3224b06dadeef1f6c5f544a489986e6102d8e@"\n"f770005bb7cd8058d56fa5aa3fe4e828e196feb99c8fd48e6021aa@"\n"cb5350dbc77a49be7f004ffc705a52cc7f7195d26ca42546815861'
		// $EULA_full		= 'RAR registration data' + "\n" + EULA_user + "\n" + EULA_license + "\n" + 'UID=' + EULA_key
		item(title='Registration'
			mode='multiple' admin=@key.shift()
			admin cmd-line='/c del "@cmd_winrar_path\rarreg.key" & (echo RAR registration data&& echo ' + EULA_user + '&& echo ' + EULA_license + '&& echo ' + str.replace(EULA_key, '@"\n"', '&& echo ') + ') > "@cmd_winrar_path\rarreg.key"' window='hidden')
	}
}