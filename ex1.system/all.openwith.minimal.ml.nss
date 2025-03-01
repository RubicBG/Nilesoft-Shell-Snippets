// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

remove(where=this.title==str.res('shell32.dll', -5376) or this.title==str.res('shell32.dll', -5377))

item(title=str.res('shell32.dll', -5377) type='file|dir' image=icon.open_with tip=str.res('shell32.dll', -5378)
		cmd='rundll32.exe' args='shell32.dll,OpenAs_RunDLL @sel')