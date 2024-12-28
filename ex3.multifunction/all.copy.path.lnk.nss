// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

menu(image=icon.copy_path title='Copy &lnk path' mode='single' type='file' where=len(path.lnktarget(sel))>0) {
	item(title='Open File Location' image cmd='explorer.exe' args='/select, @path.lnktarget(sel)')
	separator()
	// check if both path.lnktarget and path.lnk.target are the same
	item(image=inherit cmd=command.copy(this.title) title=path.lnk.target(sel))
	item(image=inherit cmd=command.copy(this.title) title=path.lnktarget(sel) where=path.lnktarget(sel) != path.lnk.target(sel))
	separator()
	item(image=inherit cmd=command.copy(this.title) title=path.location(path.lnk.target(sel)) where=len(path.location(path.lnk.target(sel)))>3)
	item(image=inherit cmd=command.copy(this.title) title=path.lnk.dir(sel) where=(path.location(path.lnk.target(sel)) != path.lnk.dir(sel)) and len(path.lnk.dir(sel))>0 tip='Start in folder')	
	separator()
	item(cmd=command.copy(this.title) title=path.name(path.lnk.target(sel)))
	item(cmd=command.copy(this.title) title=path.title(path.lnk.target(sel)) where=path.name(path.lnk.target(sel)) != path.title(path.lnk.target(sel)))
	item(cmd=command.copy(this.title) title=path.file.ext(path.lnk.target(sel)) where=len(path.file.ext(path.lnk.target(sel)))>1) }