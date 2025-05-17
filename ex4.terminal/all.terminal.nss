// Author: Rubic / RubicBG
// Based on: Nilesoft Shell original snippet
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

menu(type='*' where=(sel.count or wnd.is_taskbar or wnd.is_edit) and !str.end(sel.raw, '.library-ms') title=title.terminal image=icon.run_with_powershell vis=if(this.level!=1, 'disabled'))
	{
		$tip_run_admin=["\xE1A7 Press SHIFT key or right mouse button to run " + this.title + " as administrator", tip.warning, 1.0]
		$has_admin=key.shift() or key.rbutton()

		item(admin=has_admin tip=tip_run_admin title=title.command_prompt
			image cmd='cmd.exe' args='/k TITLE Command Prompt &ver& PUSHD "@sel.dir"')
		item(admin=has_admin tip=tip_run_admin title=title.command_prompt +' (Green-Black)'
			image cmd='cmd.exe' args='/k TITLE Command Prompt &color 20&ver& CLS & PUSHD "@sel.dir"')
		item(admin=has_admin tip=tip_run_admin title=title.command_prompt +' (Black-Blue)'
			image cmd='cmd.exe' args='/k TITLE Command Prompt &color 09&ver& CLS & PUSHD "@sel.dir"')
		separator()
		item(admin=has_admin tip=tip_run_admin title=title.windows_powershell
			image cmd-ps=`-noexit -command "Set-Location -LiteralPath '@sel.dir\.'"`)
		item(admin=has_admin tip=tip_run_admin title='Windows PowerShell 7' where=package.exists("Microsoft.PowerShell_7")
			image cmd-pwsh=`-noexit -command "Set-Location -LiteralPath '@sel.dir\.'"`)
		/* Example for Windows PowerShell 7 - Old Syntax
		item(admin=has_admin tip=tip_run_admin title='Windows PowerShell 7' where=path.exists(path.combine(sys.prog, '\PowerShell\7\pwsh.exe'))
			image cmd=path.combine(sys.prog, '\PowerShell\7\pwsh.exe') args=`-noexit -command "Set-Location -LiteralPath '@sel.dir\.'"`)  */
		item(admin=has_admin tip=tip_run_admin title='Windows PowerShell 7 Preview' where=path.exists(path.combine(sys.prog, '\PowerShell\7-preview\pwsh.exe'))
			image cmd=path.combine(sys.prog, 'PowerShell\7-preview\pwsh.exe') args=`-noexit -command "Set-Location -LiteralPath '@sel.dir\.'"`)
		separator()

		$wt_escape_have=str.contains(sel.path, '[') or str.contains(sel.path, ']')
		item(admin=has_admin tip=tip_run_admin title=title.Windows_Terminal where=package.exists("Microsoft.WindowsTerminal_")
			image cmd='@package.path("Microsoft.WindowsTerminal_")\WindowsTerminal.exe' arg='-d "@sel.path\."' vis=if(wt_escape_have, 'disabled'))
		item(admin=has_admin tip=tip_run_admin title='Windows Terminal Preview' where=package.exists("Microsoft.WindowsTerminalPreview_")
			image cmd='@package.path("Microsoft.WindowsTerminalPreview_")\WindowsTerminal.exe' arg='-d "@sel.path\."' vis=if(wt_escape_have, 'disabled'))

		separator()
		$exe_wsl = path.combine(sys.bin, 'wsl.exe')
		$reg_wsl = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Lxss'
		$distro_names = null
		$distro_guids = null
		menu(title={ distro_guids = reg.keys(reg_wsl) } where=path.exists(exe_wsl) expanded='true') {
			item(admin=has_admin tip=tip_run_admin title=str.res(exe_wsl, 2) keys='default WSL shell' vis=if(len(distro_guids)==0, 'disabled')
				image cmd=exe_wsl args='--cd "@sel.dir"')
			item(admin=has_admin tip=tip_run_admin title=str.res(exe_wsl, 2) keys='clean bash shell' vis=if(len(distro_guids)==0, 'disabled')
				image cmd=exe_wsl args='--cd "@sel.dir" -e bash --noprofile --norc')
		}
		menu(title=for(i=0, i<len(distro_guids)) { distro += reg.get(reg_wsl+ '\' + distro_guids[i], 'DistributionName') + "\n" { distro_names = str.split(distro, "\n") } } expanded='true') {
			item(title='Open in ' + distro_names[0] where=len(distro_guids)>1
				image cmd=exe_wsl args='-d "@distro_guids[0]" --cd "@sel.dir"')
			item(title='Open in ' + distro_names[1] where=len(distro_guids)>1
				image cmd=exe_wsl args='-d "@distro_guids[1]" --cd "@sel.dir"')
			item(title='Open in ' + distro_names[2] where=len(distro_guids)>2
				image cmd=exe_wsl args='-d "@distro_guids[2]" --cd "@sel.dir"')
			item(title='Open in ' + distro_names[3] where=len(distro_guids)>3
				image cmd=exe_wsl args='-d "@distro_guids[3]" --cd "@sel.dir"')
			item(title='Open in ' + distro_names[4] where=len(distro_guids)>4
				image cmd=exe_wsl args='-d "@distro_guids[4]" --cd "@sel.dir"')
			item(title='Open in ' + distro_names[5] where=len(distro_guids)>5
				image cmd=exe_wsl args='-d "@distro_guids[5]" --cd "@sel.dir"')
		}

		separator()
		item(title='Git CMD' where=path.exists(path.combine(sys.prog, 'Git', 'git-cmd.exe'))
			image cmd=path.combine(sys.prog, 'Git', 'git-cmd.exe') args='--cd-to-home & title Git CMD')

		separator()
	}

modify(where=this.id==id.open_powershell_window_here pos='bottom' menu='Terminal' vis=keys.shift())
modify(where=this.name=='open linux shell here' image='wsl.exe' pos='bottom' menu='Terminal' vis=keys.shift())
remove(clsid='{9F156763-7844-4DC4-B2B1-901F640F5155}|{02DB545A-3E20-46DE-83A5-1329B1E88B6B}') // Open in Windows Terminal; Open in Terminal
modify(where=this.name=='open in terminal' || this.name=='open in terminal preview' pos='bottom' menu='Terminal' vis=if(str.contains(sel.path, '[') or str.contains(sel.path, ']'), 'disabled') vis=keys.shift())
