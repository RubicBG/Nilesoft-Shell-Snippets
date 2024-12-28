// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

menu(image=icon.copy_path title='Copy &env path' mode='single' type='dir|back.dir|drive|back.drive|desktop') {
	item(title='Environment Variables' keys='SHIFT admin' image='@sys.bin\imageres.dll,156'
		 admin=keys.shift() cmd='rundll32.exe' args='sysdm.cpl,EditEnvironmentVariables')
	separator()
	// AppData / User
	item(image=inherit cmd=command.copy(this.title) where=str.contains(sel.path, '%TMP%') title="%TMP%"+str.sub(sel.path, len(sys.expand('%TMP%'))))
	item(image=inherit cmd=command.copy(this.title) where=str.contains(sel.path, '%TEMP%') title="%TEMP%"+str.sub(sel.path, len(sys.expand('%TEMP%'))))
	item(image=inherit cmd=command.copy(this.title) where=str.contains(sel.path, '%LocalAppData%') title="%LocalAppData%"+str.sub(sel.path, len(sys.expand('%LocalAppData%'))))
	item(image=inherit cmd=command.copy(this.title) where=str.contains(sel.path, '%UserProfile%') title="%UserProfile%"+str.sub(sel.path, len(sys.expand('%UserProfile%'))))
	item(image=inherit cmd=command.copy(this.title) where=str.contains(sel.path, '%AppData%') title="%AppData%"+str.sub(sel.path, len(sys.expand('%AppData%'))))
	item(image=inherit cmd=command.copy(this.title) where=str.contains(sel.path, '%Public%') title="%Public%"+str.sub(sel.path, len(sys.expand('%Public%'))))
	// ProgramData
	item(image=inherit cmd=command.copy(this.title) where=str.contains(sel.path, '%ProgramData%') title="%ProgramData%"+str.sub(sel.path, len(sys.expand('%ProgramData%'))))
	item(image=inherit cmd=command.copy(this.title) where=str.contains(sel.path, '%AllUsersProfile%') title="%AllUsersProfile%"+str.sub(sel.path, len(sys.expand('%AllUsersProfile%'))))
	// Program
	item(image=inherit cmd=command.copy(this.title) where=str.contains(sel.path, '%CommonProgramFiles%') and !str.contains(sel.path, '%CommonProgramFiles(x86)%') title="%CommonProgramFiles%"+str.sub(sel.path, len(sys.expand('%CommonProgramFiles%'))))
	item(image=inherit cmd=command.copy(this.title) where=str.contains(sel.path, '%ProgramFiles%') and !str.contains(sel.path, '%ProgramFiles(x86)%') title="%ProgramFiles%"+str.sub(sel.path, len(sys.expand('%ProgramFiles%'))))
	item(image=inherit cmd=command.copy(this.title) where=str.contains(sel.path, '%CommonProgramFiles(x86)%') title="%CommonProgramFiles(x86)%"+str.sub(sel.path, len(sys.expand('%CommonProgramFiles(x86)%'))))
	item(image=inherit cmd=command.copy(this.title) where=str.contains(sel.path, '%ProgramFiles(X86)%') title="%ProgramFiles(X86)%"+str.sub(sel.path, len(sys.expand('%ProgramFiles(X86)%'))))
	// Windows
	item(image=inherit cmd=command.copy(this.title) where=str.contains(sel.path, '%WinDir%') title="%WinDir%"+str.sub(sel.path, len(sys.expand('%WinDir%'))))
	item(image=inherit cmd=command.copy(this.title) where=str.contains(sel.path, '%SystemRoot%') title="%SystemRoot%"+str.sub(sel.path, len(sys.expand('%SystemRoot%'))))
	// drive letter
	item(image=inherit cmd=command.copy(this.title) where=str.contains(sel.path, '%HomeDrive%') title="%HomeDrive%"+str.sub(sel.path, len(sys.expand('%HomeDrive%'))))
	item(image=inherit cmd=command.copy(this.title) where=str.contains(sel.path, '%SystemDrive%') title="%SystemDrive%"+str.sub(sel.path, len(sys.expand('%SystemDrive%')))) }