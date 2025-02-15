// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/
// To-Do: make exceptions for system folders

menu(image=icon.copy_path title='Environment Path' mode='single' type='dir|back.dir|drive|back.drive|desktop') {
	//+ https://learn.microsoft.com/en-us/windows/deployment/usmt/usmt-recognized-environment-variables
	item(title='ENV GUI' keys='SHIFT edit sys env' tip='Edit Environment Variables' image='@sys.bin\imageres.dll,156' sep='both'
		 admin=keys.shift() cmd='rundll32.exe' args='sysdm.cpl,EditEnvironmentVariables')

	$reg_cu = reg.get('HKCU\Environment', 'PATH')
	$reg_lm = reg.get('HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'PATH')
	// does not work for drives
	$is_in_path			= str.contains(reg_cu, sel+';') or str.contains(reg_cu, sel+'\;') or str.end(reg_cu, sel)
	$add_to_path		= str.replace('@reg_cu;@sel', ';;', ';').trimstart(';')
	$remove_from_path	= str.replace(reg_cu, sel, '').replace('\;', ';').replace(';;', ';')
	
	/* need explorer restart to take effect
	item(title=if(is_in_path, 'Remove from ', 'Add to ')+"%PATH%" type='dir' 
		admin cmd-line='/c @if(is_in_path, if(msg('Are you sure you want to remove this path?', 'NileSoft Shell', msg.yesno | msg.warning)==msg.idyes, 'setx PATH "@remove_from_path" & pause & exit'), 'setx PATH "@add_to_path" & pause & exit')')
	*/
	item(title=if(is_in_path, 'Remove path from ', 'Add path to ')+"%PATH%" type='dir|dir.back' image=if(is_in_path, \uE171, \uE172)
		admin cmd=if(is_in_path, if(msg('Are you sure you want to remove this path?', 'NileSoft Shell', msg.yesno | msg.warning)==msg.idyes, reg.set('HKCU\Environment', 'PATH', remove_from_path)), reg.set('HKCU\Environment', 'PATH', add_to_path)))

	separator()
	item(title='Check '+"%PATH%" keys='default'	where=keys.shift()	image=\uE187 cmd=msg(str.join(str.split('%path%', ';'), "\n"))) 
	item(title='Check '+"%PATH%" keys='CU'		where=keys.shift()	image=\uE187 cmd=msg(str.join(str.split(reg_cu, ';'), "\n")))
	item(title='Check '+"%PATH%" keys='LM'		where=keys.shift()	image=\uE187 cmd=msg(str.join(str.split(reg_lm, ';'), "\n")))
	item(title='Check '+"%PATH%" keys='LM+CU'	where=keys.shift()	image=\uE187 cmd=msg(str.join(str.split(reg_lm, ';'), "\n") + "\n\n" + str.join(str.split(reg_cu, ';'), "\n")))
}