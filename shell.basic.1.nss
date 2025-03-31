// Author: Rubic / RubicBG
// Based on: Nilesoft Shell original snippet
// https://web.archive.org/web/20240613020655/https://nilesoft.org/forum/viewtopic.php?t=23&sid=991564ba72bf76c8ef095e9d80b84f5f

settings
{
	priority=1
	exclude.where = !process.is_explorer
	showdelay = 200
	// Options to allow modification of system items
	modify.remove.duplicate=not(wnd.name=='SystemTray_Main')
	tip.enabled=true
}

import 'imports/theme.nss'
import 'imports/images.nss'

import 'imports/modify.nss'

import 'imports/terminal.nss'
$sys_object_recycle_bin	= sel.raw=='::{645FF040-5081-101B-9F08-00AA002F954E}' or sel.parent.raw=='::{645FF040-5081-101B-9F08-00AA002F954E}'
$sys_object_on_desktop	= wnd.is_desktop and sel.type==0 // "Windows Spotlight"
menu(mode='multiple' expanded='true' where=not(sys_object_on_desktop) and not(sys_object_recycle_bin))
{
	menu(mode="multiple" title="Pin/Unpin" image=icon.pin) { }
	menu(mode="multiple" title=title.more_options image=icon.more_options) { }

	import 'imports/file-manage.nss'
	import 'imports/develop.nss'
	import 'imports/goto.nss'
}

import 'imports/taskbar.nss'
