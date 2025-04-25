// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/
// To-Do: Verify if PowerShell commands require escape characters.
// To-Do: Ensure compatibility with .lnk files.
// To-Do: Find the correct netsh commands to open and close ports.

$svg_firewall=image.svg('<svg fill="#D75A4A" width="100" height="100" viewBox="0 0 36 36">
	<path d="M32 6H4a2 2 0 0 0-2 2v20a2 2 0 0 0 2 2h28a2 2 0 0 0 2-2V8a2 2 0 0 0-2-2ZM4 8h28v5.08h-8.2v-4H22v4h-8v-4h-2v4H4Zm0 7h28v6.08h-3.08v-4.81H27v4.81h-8.08v-4.81H17v4.81H8.9v-4.81H7v4.81H4Zm19.8 13v-3.73h-1.6V28H14v-3.73h-1.6V28H4v-5h28v5Z"/></svg>')
menu(title='Firewall' type='file' find='.exe|.cmd|.bat|.msi|.ps1|.vbs' image=svg_firewall) {
	//> https://learn.microsoft.com/en-us/windows-server/networking/technologies/netsh/netsh-contexts
	//> https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/netsh-advfirewall-firewall-control-firewall-behavior
	$name_allow='Allow @sel.name'
	$name_block='Block @sel.name'
	item(image=image.res('@sys.bin\comres.dll, 8') title='Allow in Windows Firewall'
		admin cmd-ps='New-NetFirewallRule -DisplayName \"@name_allow\" -Program @sel(true) -Direction Outbound -Action Allow; New-NetFirewallRule -DisplayName \"@name_allow\" -Program @sel(true) -Direction Inbound -Action Allow' window='hidden')
	item(image=image.res('@sys.bin\comres.dll,10') title='Block in Windows Firewall'
		admin cmd-ps='New-NetFirewallRule -DisplayName \"@name_block\" -Program @sel(true) -Direction Outbound -Action Block; New-NetFirewallRule -DisplayName \"@name_block\" -Program @sel(true) -Direction Inbound -Action Block' window='hidden')
	item(image=image.res('@sys.bin\comres.dll,13') title='Remove From Windows Firewall'
		admin cmd-ps='Get-NetFirewallRule -DisplayName \"@name_allow\" | Remove-NetFirewallRule; Get-NetFirewallRule -DisplayName \"@name_block\" | Remove-NetFirewallRule' window='hidden')
	separator()
	item(image=image.res('@sys.bin\imageres.dll, 101') title='Allow in Windows Firewall' keys='netsh'
		admin cmd-line='/c netsh advfirewall firewall add rule name="@name_allow" program=sel(true) dir=in action=allow && netsh advfirewall firewall add rule name="@name_allow" program=sel(true) dir=out action=allow' window='hidden')
	item(image=image.res('@sys.bin\imageres.dll, 100') title='Block in Windows Firewall' keys='netsh'
		admin cmd-line='/c netsh advfirewall firewall add rule name="@name_block" program=sel(true) dir=in action=block && netsh advfirewall firewall add rule name="@name_block" program=sel(true) dir=out action=block' window='hidden')
	item(image=image.res('@sys.bin\imageres.dll, 102') title='Remove From Windows Firewall' keys='netsh'
		admin cmd-line='/k netsh advfirewall firewall delete rule name="@name_allow" & netsh advfirewall firewall delete rule name="@name_block"' window='hidden')
	item(image=image.res('@sys.bin\imageres.dll, 099') title='Check the Rule in Windows Firewall' keys='netsh'
		admin cmd-line='/k netsh advfirewall firewall show rule name="@name_allow" & netsh advfirewall firewall show rule name="@name_block" & pause & exit')
	separator()
	item(image=inherit title='Windows Firewall' where=path.exists('@sys.bin\wf.msc')
		cmd='wf.msc')
	item(image=inherit title='Windows Defender Firewall' where=path.exists('@sys.bin\firewall.cpl')
		cmd='control' args='firewall.cpl') }