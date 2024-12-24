// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/


menu(image=icon.copy_path title='Copy list' mode='multiple' type='file|dir|back.dir|drive|back.drive|desktop') {
	item(mode='multiple' where=sel.count>1 image=inherit title='Copy (@sel.count) item@if(sel.count>1, 's') selected'
		tip='Copy the names of all selected items to the clipboard.'
		cmd=command.copy(sel(false, "\n")))
	menu(expanded='true' mode='single' type='dir|back.dir|drive|back.drive|desktop' image=inherit) {
		item(title='Copy (@len(path.files(sel.dir))) item name@if(len(path.files(sel.dir))>1, 's')' keys='SHIFT with path@if(len(path.files(sel.dir))>1, 's')'
			image=inherit 
			tip='Copy the names of all items in the selected folder to the clipboard, including hidden items. Hold SHIFT to include full paths.'
			cmd=command.copy(str.join(path.files(sel.dir, '*', if(keys.shift(), 5|16, 5)),"\n")))
		separator()
		item(title='Copy (@len(path.files(sel.dir, '*', 3))) file name@if(len(path.files(sel.dir, '*', 3))>1, 's')' keys='SHIFT with path@if(len(path.files(sel.dir, '*', 3))>1, 's')'
			image=inherit where=len(path.files(sel.dir, '*', 3))>0
			tip='Copy the names of all files in the selected folder to the clipboard, including hidden files. Hold SHIFT to include full paths.'
			cmd=command.copy(str.join(path.files(sel.dir, '*', if(keys.shift(), 3|16, 3)),"\n")))
		item(title='Copy (@len(path.files(sel.dir, '*', 2))) folder name@if(len(path.files(sel.dir, '*', 2))>1, 's')' keys='SHIFT with path@if(len(path.files(sel.dir, '*', 2))>1, 's')'
			image=inherit where=len(path.files(sel.dir, '*', 2))>0
			tip='Copy the names of all folders in the selected folder to the clipboard, including hidden folders. Hold SHIFT to include full paths.'
			cmd=command.copy(str.join(path.files(sel.dir, '*', if(keys.shift(), 2|16, 2)),"\n"))) }