// 	Author: Rubic / RubicBG

// After replacing shell32 components with XAML resources, Windows Explorer's fullscreen does not work properly.
item(title=str.res('ieframe.dll', -17985) where=wnd.is_titlebar type='*' 
	tip=str.res('ieframe.dll', -9531)
	pos=indexof(str.replace(title.close, '&', '')) image=\uE1B1
	cmd=key.send(key.F11))

menu(title=title.windows where=wnd.is_titlebar type='*' pos=indexof(str.replace(title.close, '&', '')) sep='both' image=\uE1FB)
{
	item(title=title.cascade_windows cmd=command.cascade_windows)
	item(title=title.Show_windows_stacked cmd=command.Show_windows_stacked)
	item(title=title.Show_windows_side_by_side cmd=command.Show_windows_side_by_side)
	sep
	item(title=title.minimize_all_windows keys='Win+M' cmd=command.minimize_all_windows)
	item(title=title.restore_all_windows keys='Win+Shift+M' cmd=command.restore_all_windows)
}