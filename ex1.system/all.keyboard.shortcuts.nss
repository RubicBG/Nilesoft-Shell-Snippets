// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

// remove keyboard shortcut info of the only command that has one
// modify(find='Undo*|Redo*' keys='')
// modify(where=str.start(this.title, title.Undo) or str.start(this.title, title.Redo) keys='')

//> https://support.microsoft.com/en-us/windows/keyboard-shortcuts-in-windows-dcc61a57-8ff0-cffe-9796-cb9706c75eec
//> https://www.elevenforum.com/t/keyboard-shortcuts-in-windows-11.2253/
modify(where=this.title==title.open							keys='Enter')
modify(where=this.title==title.cut				type='*'	keys='Ctrl+X')
modify(where=this.title==title.copy				type='*'	keys='Ctrl+C')
modify(where=this.title==title.paste			type='*'	keys='Ctrl+V') // tip='Open the clipboard history (Win+V)'
modify(where=this.title==title.delete			type='*'	keys='Ctrl+D' tip=["\xE1A7 Press SHIFT key to permanently delete selected file"+if(sel.count>1, 's'), tip.danger, 1.0])
modify(where=this.title==title.rename						keys='F2')
modify(where=str.start(this.title, title.undo)	type='*'	keys='Ctrl+Z')
modify(where=str.start(this.title, title.redo)	type='*'	keys='Ctrl+Y')
modify(where=this.title==title.select_all 		type='*'	keys='Ctrl+A')
modify(where=this.title==title.copy_as_path					keys='Ctrl+Shift+C')
modify(where=this.title==title.refresh						keys='Ctrl+R')
modify(where=this.title==title.properties & sel.count>0		keys='Alt+Enter')

//> https://www.elevenforum.com/t/change-size-of-desktop-icons-in-windows-11.4820/
modify(where=this.title==title.extra_large_icons	in=str.replace(title.view, '&', '') keys='Ctrl+Shift+1')
modify(where=this.title==title.large_icons			in=str.replace(title.view, '&', '') keys='Ctrl+Shift+2')
modify(where=this.title==title.medium_icons			in=str.replace(title.view, '&', '') keys='Ctrl+Shift+3')
modify(where=this.title==title.small_icons			in=str.replace(title.view, '&', '') keys='Ctrl+Shift+4')
modify(where=this.title==title.list					in=str.replace(title.view, '&', '') keys='Ctrl+Shift+5')
modify(where=this.title==title.details				in=str.replace(title.view, '&', '') keys='Ctrl+Shift+6')
modify(where=this.title==title.tiles				in=str.replace(title.view, '&', '') keys='Ctrl+Shift+7')
modify(where=this.title==title.content				in=str.replace(title.view, '&', '') keys='Ctrl+Shift+8')

// Add keyboard shortcut info to "&Folder" in "Ne&w" menu
modify(where=this.title==eval(str.res('shell32.dll', -30317)) in=str.replace(title.new, '&', '') keys='Ctrl+Shift+N')

// Add new commands for "Select &all"
item(title='Select &all' keys='Ctrl+A' image=icon.select_all cmd=command.select_all)

// Add keyboard shortcut info to "Size &All Columns to Fit"
modify(type='*' keys='Ctrl+"Num Pad +"'
	where=(this.title==eval(str.res('shell32.dll', -37201)) or this.title==eval(str.res('shell32.dll', -37466))) and (wnd.parent.name=="SHELLDLL_DefView"))

// Add new commands in "View" menu
item(title='Column Arrange' keys='Ctrl+"Num Pad +"'
	where=window.name=='CabinetWClass' menu=title.view image=icon.details sep='top'
	commands{cmd=keys.send(key.ctrl, key.shift, 54) wait=1, cmd=keys.send(key.ctrl, 107)})
item(title='Expand Navigation Pane' keys='Ctrl+Shift+E'
	where=window.name=='CabinetWClass' menu=title.view image=icon.expand sep='bottom'
	tip='Expands all folders from the tree in the navigation pane.' cmd=keys.send(key.ctrl, key.shift, 69))
item(title='Up' keys='Alt+Up'
	where=window.name=='CabinetWClass' menu=title.view image=\uE214 cmd=keys.send(key.alt, key.up))
item(title='Back' keys='Alt+Left'
	where=window.name=='CabinetWClass' menu=title.view image=\uE216 cmd=keys.send(key.alt, key.left))
item(title='Forward' keys='Alt+Right'
	where=window.name=='CabinetWClass' menu=title.view image=\uE215 cmd=keys.send(key.alt, key.right))

item(title='Desktop icon settings' where=wnd.is_desktop menu=title.view pos=indexof(quote(str.replace(title.show_desktop_icons, '&', ''))) image=image.res('@sys.bin\desk.cpl', 0)
	cmd='rundll32.exe' args='shell32.dll,Control_RunDLL desk.cpl,,0')

/* this snippet is not working well
item(title='&Hide file names' where=wnd.is_desktop menu=title.view pos=indexof(quote(str.replace(title.show_desktop_icons, '&', ''))) tip='hides file names on desctop icons temporarly'
	cmd=wnd.command(28727)) */