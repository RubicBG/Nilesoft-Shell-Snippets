// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

menu(title='MSI Commands' where=sel.file.ext=='.msi' image=\uE0F8 pos=1) {
	item(title='Open' 
		cmd='msiexec' args='/i @sel.path(true)')
	separator()
	item(title='&Install' keys='SHIFT no restart'
		cmd='msiexec' args='/i @sel.path(true) @if(key.shift(), '/norestart')')
	item(title='install quietly' keys='SHIFT no restart'
		cmd='msiexec' args='/i @sel.path(true) /qn @if(key.shift(), '/norestart')')
	item(title='&Uninstall' keys='SHIFT no restart'
		cmd='msiexec' args='/x @sel.path(true) @if(key.shift(), '/norestart')')
	item(title='Uninstall quietly' keys='SHIFT no restart'
		cmd='msiexec' args='/x @sel.path(true) /qn @if(key.shift(), '/norestart')')
	item(title='Re&pair'
		cmd='msiexec' args='/f @sel.path(true)')
	separator()
	item(title='Extract'
		cmd='msiexec' args='/a @sel.path(true) /qb TARGETDIR="@sel.parent\@sel.file.title"')
	separator()
	item(title='View MSI Options' tip='Microsoft Standard Installer command-line options'
		cmd='msiexec' args='/?')
}

remove(where=sel.file.ext=='.msi' and this.title=='&Uninstall')
remove(where=sel.file.ext=='.msi' and this.title=='Re&pair')