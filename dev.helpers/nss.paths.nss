// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

menu(title='Copy NS path' mode='single' image=icon.copy_path tip='Copy Nilesoft Shell path' 
	vis=if(str.contains(sel.path, app.dir) or str.contains(sel.path, user.home) or str.contains(sel.path, sys.root) or str.contains(sel.raw, '::{031E4825-7B94-4DC3-B131-E946B44C8DD5}'), 'true', 'disabled')) {
	// https://nilesoft.org/docs/functions/app
	item(cmd=command.copy(this.title) where=str.contains(sel.path, app.directory) title='@@'+'app.directory'+str.sub(sel.path, len(app.directory)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, app.dir) title='@@'+'app.dir'+str.sub(sel.path, len(app.dir)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, app.exe) title='@@'+'app.exe'+str.sub(sel.path, len(app.exe)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, app.cfg) title='@@'+'app.cfg'+str.sub(sel.path, len(app.cfg)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, app.dll) title='@@'+'app.dll'+str.sub(sel.path, len(app.dll)))
	separator(where=str.contains(sel.path, app.dir))
	// https://nilesoft.org/docs/functions/user
	item(cmd=command.copy(this.title) where=str.contains(sel.path, user.home) title='@@'+'user.home'+str.sub(sel.path, len(user.home)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, user.appdata) title='@@'+'user.appdata'+str.sub(sel.path, len(user.appdata)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, user.contacts) title='@@'+'user.contacts'+str.sub(sel.path, len(user.contacts)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, user.desktop) title='@@'+'user.desktop'+str.sub(sel.path, len(user.desktop)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, user.directory) title='@@'+'user.directory'+str.sub(sel.path, len(user.directory)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, user.dir) title='@@'+'user.dir'+str.sub(sel.path, len(user.dir)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, user.documents) title='@@'+'user.documents'+str.sub(sel.path, len(user.documents)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, user.downloads) title='@@'+'user.downloads'+str.sub(sel.path, len(user.downloads)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, user.favorites) title='@@'+'user.favorites'+str.sub(sel.path, len(user.favorites)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, user.localappdata) title='@@'+'user.localappdata'+str.sub(sel.path, len(user.localappdata)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, user.music) title='@@'+'user.music'+str.sub(sel.path, len(user.music)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, user.personal) title='@@'+'user.personal'+str.sub(sel.path, len(user.personal)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, user.pictures) title='@@'+'user.pictures'+str.sub(sel.path, len(user.pictures)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, user.profile) title='@@'+'user.profile'+str.sub(sel.path, len(user.profile)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, user.quicklaunch) title='@@'+'user.quicklaunch'+str.sub(sel.path, len(user.quicklaunch)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, user.sendto) title='@@'+'user.sendto'+str.sub(sel.path, len(user.sendto)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, user.startmenu) title='@@'+'user.startmenu'+str.sub(sel.path, len(user.startmenu)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, user.temp) title='@@'+'user.temp'+str.sub(sel.path, len(user.temp)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, user.templates) title='@@'+'user.templates'+str.sub(sel.path, len(user.templates)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, user.videos) title='@@'+'user.videos'+str.sub(sel.path, len(user.videos)))
	separator(where=str.contains(sel.path, user.home))
	item(cmd=command.copy(this.title) where=str.contains(sel.raw, '::{031E4825-7B94-4DC3-B131-E946B44C8DD5}') title='@@'+'user.libraries'+str.sub(sel.raw, len('::{031E4825-7B94-4DC3-B131-E946B44C8DD5}')))
	item(cmd=command.copy(this.title) where=str.contains(sel.raw, '::{031E4825-7B94-4DC3-B131-E946B44C8DD5}\Documents.library-ms') title='@@'+'user.documentslibrary'+str.sub(sel.raw, len('::{031E4825-7B94-4DC3-B131-E946B44C8DD5}\Documents.library-ms')))
	separator(where=str.contains(sel.raw, '::{031E4825-7B94-4DC3-B131-E946B44C8DD5}'))
	// https://nilesoft.org/docs/functions/sys
	item(cmd=command.copy(this.title) where=str.contains(sel.path, sys.appdata) title='@@'+'sys.appdata'+str.sub(sel.path, len(sys.appdata)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, sys.bin) title='@@'+'sys.bin'+str.sub(sel.path, len(sys.bin)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, sys.bin32) title='@@'+'sys.bin32'+str.sub(sel.path, len(sys.bin32)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, sys.bin64) title='@@'+'sys.bin64'+str.sub(sel.path, len(sys.bin64)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, sys.directory) title='@@'+'sys.directory'+str.sub(sel.path, len(sys.directory)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, sys.dir) title='@@'+'sys.dir'+str.sub(sel.path, len(sys.dir)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, sys.path) title='@@'+'sys.path'+str.sub(sel.path, len(sys.path)))
	// check if path contains sys.prog, not sys.prog32
	item(cmd=command.copy(this.title) where=str.contains(sel.path, sys.prog) and !str.contains(sel.path, sys.prog32) title='@@'+'sys.prog'+str.sub(sel.path, len(sys.prog)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, sys.prog32) title='@@'+'sys.prog32'+str.sub(sel.path, len(sys.prog32)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, sys.programdata) title='@@'+'sys.programdata'+str.sub(sel.path, len(sys.programdata)))
	// remove extra backslash
	item(cmd=command.copy(this.title) where=str.contains(sel.path, sys.root) title='@@'+str.trim('sys.root'+str.sub(sel.path, len(sys.root)), "\\"))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, sys.temp) title='@@'+'sys.temp'+str.sub(sel.path, len(sys.temp)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, sys.templates) title='@@'+'sys.templates'+str.sub(sel.path, len(sys.templates)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, sys.users) title='@@'+'sys.users'+str.sub(sel.path, len(sys.users)))
	item(cmd=command.copy(this.title) where=str.contains(sel.path, sys.wow) title='@@'+'sys.wow'+str.sub(sel.path, len(sys.wow)))
}
