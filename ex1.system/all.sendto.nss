// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

// These code snippet move down the 'Send to' menu.
modify(where=this.title==title.send_to pos=indexof(quote(str.replace(title.copy, '&', '')), 1))

// These code snippets add new menu items to the 'Send to' menu.
item(menu=title.send_to title='Send to Executable'
	image=icon.send_to pos='top' sep='both'
	cmd=path.file.box('.exe|*.exe') args=sel.path(true))
item(menu=title.send_to title='Open "Send To" folder'
	image=icon.open_folder sep='top'
	cmd=user.sendto)
item(menu=title.send_to title='Add Here ...' type='namespace|drive|dir'
	image=icon.new_folder
	cmd=path.lnk.create(user.sendto+'\'+sel.path.title+'.lnk', sel.path))
item(menu=title.send_to title='Add Here ...' where=sel.file.ext=='.exe'
	image=icon.new_folder
	cmd=path.lnk.create(user.sendto+'\'+sel.path.title+'.lnk', sel.path))

// These code snippets reorder the 'Send to' menu.
modify(where=this.title==str.res('sendmail.dll',-4)
	in=str.replace(title.send_to,'&','') pos='top' sep='after')
modify(where=this.title==str.res('shell32.dll',-34575)
	in=str.replace(title.send_to,'&','') pos='top')
modify(where=this.title==str.res('sendmail.dll',-21)
	in=str.replace(title.send_to,'&','') pos='top')
modify(where=this.title==str.res('zipfldr.dll',-10148)
	in=str.replace(title.send_to,'&','') pos='top')
modify(where=this.title==str.res('fsquirt.exe',-2343)
	in=str.replace(title.send_to,'&','') pos='top')

/*
// In Windows 11, the "Send to" menu generally copies files to a folder regardless of whether the source and destination are on the same drive. This change means that files are not moved when sending to a folder, which can be different from previous versions of Windows. 
$sendto_sc_path='@(user.sendto)\@(this.title).lnk'
modify(where=path.lnk.type(sendto_sc_path)==2 or path.lnk.type(sendto_sc_path)==3 find='*' in=str.replace(title.send_to,'&','')
	keys=if(path.root(sel)==path.root(path.lnk(sendto_sc_path)), 'Move', 'Copy' ))
*/
