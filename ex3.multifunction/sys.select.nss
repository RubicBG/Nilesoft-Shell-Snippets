// Author: Rubic / RubicBG
// Based on: Nilesoft Shell original snippet
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

menu(title=title.select mode='multiple' where=sel.count>0 image=\uE290) {
	item(title='All' keys='Ctrl+A' image=icon.select_all cmd=command.select_all)
	item(title='Invert' image=icon.invert_selection cmd=command.invert_selection)
	item(title='None' image=icon.select_none cmd=command.select_none)
	separator()
	$regCheckSelect = 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
	$regCheckSelectShowed = reg.get(regCheckSelect,'AutoCheckSelect')==1
	item(title='Checkboxes' tip='Selection Checkboxes' image=[[\uE137, if(regCheckSelectShowed, image.color2, image.color1)]] commands {
		cmd=reg.set(regCheckSelect, 'AutoCheckSelect', @if(regCheckSelectShowed,0,1), reg.dword) wait=1,
		//cmd='ie4uinit' args='-show' wait=1,
		//cmd=command.refresh wait=1,
		cmd=wnd.command(28931) wait=1,} )
}