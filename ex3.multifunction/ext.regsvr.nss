// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

menu(title='Register Server' mode='multiple' type='file' where=sel.file.ext=='.dll' or sel.file.ext=='.ocx' image=\uE0F1) {
	$isNS = io.meta(sel, 'System.Company') == 'Nilesoft'
	menu(expanded='true' where=!isNS) {
		item(title='Register' admin cmd='regsvr32.exe' args='@sel.path.quote' invoke='multiple')
		item(title='Unregister' admin cmd='regsvr32.exe' args='/u @sel.path.quote' invoke='multiple') }
	menu(expanded='true' where=isNS) {		
		item(title='Register' keys=io.meta(sel, 'System.FileVersion') vis=if(sel.path==app.dll,'disable') cmd={
			$go = true
			// backup shell.dll
			if(go and !io.rename(app.dll, '@app.dir/shell-@(sys.datetime("Ymd-HMS")).dll'), if(msg('Backup failed! Would you like to continue?', 'NileSoft Shell', msg.warning|msg.yesno|msg.defbutton2)==msg.idno, {go=false} ))
			// replace shell.dll
			if(go and !io.copy(sel.path, app.dll), msg('Copy of shell.dll was failed! Aborting!', 'NileSoft Shell', msg.error) & {go=false} )
			// check executable
			if(go and not(sel.parent().trim('\')==app.dir) and path.exists('@sel.parent/shell.exe') and msg('A copy of shell.exe was found in @sel.parent. Would you like to replace the main application with this version?' , 'NileSoft Shell', msg.warning|msg.yesno|msg.defbutton2)!=msg.idno, if(!io.copy('@sel.parent/shell.exe', app.exe), msg('Copy of shell.exe was failed!, msg.warning')))
			// reset shell.log
			if(go and path.exists('@app.dir/shell.log') and msg('Do you want to reset the log file?' , 'NileSoft Shell', msg.warning|msg.yesno|msg.defbutton2)!=msg.idno, io.delete('@sel.parent/shell.log'))
			// restart
			//cmd=app.exe args='-restart'
			if(go, command.restart_explorer) })
		item(title='Unregister' keys=io.meta(app.dll, 'System.FileVersion') vis=if(sel.path!=app.dll,'disable')
			cmd=app.exe args='-unregister')
	}}