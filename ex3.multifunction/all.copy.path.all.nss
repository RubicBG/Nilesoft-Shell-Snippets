// Author: Rubic / RubicBG
// Based on: Nilesoft Shell original snippet
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

menu(image=icon.copy_path title=title.copy_path	mode='single') {
	item(title='Open File Location' image cmd='explorer.exe' args='/select, @sel')
	separator()

	// Section: Full Path Variants
	item(image=inherit cmd=command.copy(this.title) title=sel.path)
	item(image=inherit cmd=command.copy(this.title) title=sel.raw where=(sel.raw != sel.path))
	item(image=inherit cmd=command.copy(this.title) title=sel.short where=(sel.short != sel.path) and len(sel.short)>0 tip='Short Path: Uses DOS 8.3 names for compatibility with older systems')
	menu(expanded='true' where=keys.shift() and str.contains(sel.path, ':')) {
		item(cmd=command.copy(this.title) title='\\localhost\' + str.replace(sel.path, ':', '$')  tip='Network Path: For accessing via a mapped drive or UNC path')
		item(cmd=command.copy(this.title) title=path.wsl(sel.path) tip='Unix-style Path: Use for WSL or similar environments')
		item(cmd=command.copy(this.title) title=str.replace(path.wsl(sel.path), '/mnt/', '/cygdrive/')  tip='Cygwin Path: For use in Cygwin environments')
		item(cmd=command.copy(this.title) title=str.right(path.wsl(sel.path), len(path.wsl(sel.path))-len('/mnt/c')) tip='Pure Unix Path: For Linux systems (with root /home structure)')
		item(cmd=command.copy(this.title) title='file://' + path.separator(sel.path)  tip='Internet Path: Use as a file URL for browsers or network links')	}
	separator()

	// Section: Parent Path Variants
	item(image=inherit cmd=command.copy(this.title) where=(sel.parent.len>3 and !str.start(sel.raw, '::')) title=@sel.parent)
	item(image=inherit cmd=command.copy(this.title) title=@sel.parent.raw where=(sel.parent.raw != sel.parent))
	separator()

	// Section: File Name and Extension
	item(cmd=command.copy(this.title) type='file|dir|back.dir' title=@sel.file.name)
	item(cmd=command.copy(this.title) type='file' where=sel.file.len != sel.file.title.len title=@sel.file.title)
	item(cmd=command.copy(this.title) type='file' where=sel.file.ext.len>0 title=@sel.file.ext)

	// Section: Special Folder Names (UUID-based or System)
	$ext_dir = regex.matches(sel, '\.\{[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}\}$')
	item(cmd=command.copy(this.title) type='dir|back.dir' where=len(ext_dir[0])>0 title=str.replace(sel.file.name, ext_dir[0], ""))
	item(cmd=command.copy(this.title) type='dir|back.dir' where=len(ext_dir[0])>0 title=ext_dir[0])
	
	// Section: Namespace (e.g., libraries or virtual folders)
	item(cmd=command.copy(this.title) type='namespace' where=str.end(sel.raw, '.library-ms') title=sel.path.title+'.library-ms')
	item(cmd=command.copy(this.title) type='namespace' where=str.end(sel.raw, '.library-ms') title=sel.path.title)
	item(cmd=command.copy(this.title) type='namespace' where=str.end(sel.raw, '.library-ms') title='.library-ms')
}
