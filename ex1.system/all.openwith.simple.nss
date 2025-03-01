// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

remove(where=this.title==str.res('shell32.dll', -5376) or this.title==str.res('shell32.dll', -5377))

menu(title=str.res('shell32.dll', -5376) type='file|dir' image=icon.open_with) {
	item(title=str.res('shell32.dll', -5377) image=inherit tip=str.res('shell32.dll', -5378)
		cmd='rundll32.exe' args='shell32.dll,OpenAs_RunDLL @sel')
	separator()
	menu(expanded='true' mode='single' type='file') {
		item(image=\uE1B9 title=str.res('shell32.dll', -5382)
			cmd='ms-windows-store://search/?query=.@sel.file.ext')
		item(image=\uE120 title='What is this extension?'
			cmd='https://www.file-extensions.org/search/?searchstring='+sel.file.ext) } }