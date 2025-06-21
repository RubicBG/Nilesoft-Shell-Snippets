// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

$path_viber = eval(str.trim(path.remove_args(reg.get('HKCU\Software\Classes\viber\shell\open\command')), '"'))
item(title='Viber' type='file'			mode='multiple' where=path.exists(path_viber)
	image cmd=path_viber arg='ShareFiles @sel(true)')
item(title='Viber' type='dir|back.dir'	mode='multiple' where=path.exists(path_viber)
	image cmd=path_viber arg='ShareFiles @str.join(path.files(sel.dir, '*', 3|8|16), " ")')