// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/
// To-Do: Currently i am using laptop that does not support hibernate - Hibernate, Hybrid Sleep and Fast Startup not tested

menu(title='Power' image=\uE14D image-sel=[\uE14D, #ff0000] tip='Power options for the computer and Windows session')
{	
	//> https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/shutdown
	item(title='Lock' keys='WIN+L' image=\uE100 tip='Secures your Windows session immediately. You will need your password, PIN, or biometric authentication to regain access.'
		// cmd-line='/c rundll32 user32.dll,LockWorkStation' window='hidden')
		cmd='rundll32.exe' args='user32.dll,LockWorkStation')
	item(title='Logoff' image=\uE102 tip='Signs out the current user, closing all programs but keeping Windows running. Other users can still sign in.'
		// cmd-line='/c shutdown -l' window='hidden')
		cmd='shutdown.exe' args='/l' window='hidden')
	item(title='Switch User' image=\uE101 tip='Switch to another user account while keeping your programs running in the background. Your session remains active.'
		// cmd-line='/c tsdiscon' window='hidden')
		cmd='tsdiscon.exe')

	separator()
	item(keys='SHIFT to force' title='Restart' image=\uE025 tip='Closes all programs and restarts Windows. Hold SHIFT to force close unresponsive applications.'
		// cmd-line='/c shutdown -r -f -t 00' window='hidden')
		cmd='shutdown.exe' args='/r @if(key.shift(),'/f','') /t 0' window='hidden')
	//> https://www.majorgeeks.com/content/page/how_to_add_restart_with_options_context_menu_in_windows_10.html
	item(keys='SHIFT to force' title='Restart Smart' image=\uE025 tip='Restarts Windows and automatically reopens your previously running applications after startup. Hold SHIFT to force close programs.'
		// cmd-line='/c shutdown -g -f -t 00' window='hidden')
		cmd='shutdown.exe' args='/g @if(key.shift(),'/f','') /t 0' window='hidden')
	item(keys='SHIFT to force' title='Shut Down' image=\uE12F tip='Closes all programs and turns off your computer. Hold SHIFT to force close unresponsive applications.'
		// cmd-line='/c shutdown -s -f -t 00' window='hidden')
		cmd='shutdown.exe' args='/s @if(key.shift(),'/f','') /t 0' window='hidden')
	//> https://www.tenforums.com/tutorials/96619-add-shut-down-context-menu-windows-10-a.html
	item(keys='SHIFT to force' title='Shut Down Smart' image=\uE12F tip='Shuts down your computer and saves your open applications to relaunch them on next startup. Hold SHIFT to force close programs.'
		// cmd-line='/c shutdown -sg -f -t 00' window='hidden')
		cmd='shutdown.exe' args='/sg @if(key.shift(),'/f','') /t 0' window='hidden')
	item(title='Shut Down Prompt' image=\uE12F tip='Immediately prompts to save any unsaved work, then shuts down your computer without waiting.'
		// cmd-line='/c shutdown -p' window='hidden')
		cmd='shutdown.exe' args='/p' window='hidden')
	item(title='Tablet Shut Down' image=image.fluent(\uEBFC) tip='Opens the tablet-style slide-to-shutdown screen, ideal for touch-enabled devices.'
		cmd='SlideToShutDown.exe')

	separator()
	item(title='Sleep' image=\uE11C tip='Saves your work in memory and puts your computer in a low-power state for quick wake-up. Maintains network connectivity.'
		cmd='rundll32.exe' args='powrprof.dll,SetSuspendState Sleep')
	/* HibernateEnabled or HibernateEnabledDefault
		https://www.elevenforum.com/t/enable-or-disable-hibernate-in-windows-11.1894/
		https://www.tenforums.com/tutorials/2859-enable-disable-hibernate-windows-10-a.html
		From version 1809 the registry setting “HibernateEnabled” was renamed “HibernateEnabledDefault”. If you use cmd (powercfg.exe /hibernate off), it is created in addition to the “HibernateEnabledDefault” parameter “HibernateEnabled” with all of the control circuits of the supply.
		ChatGPT:
		• HibernateEnabledDefault – This value defines the default “availability” of hibernation in the system’s power settings. In other words, it’s the default flag that tells Windows whether hibernation should be offered as an option in the power menu.
		• HibernateEnabled – This value reflects the current (active) state of hibernation on your machine. It’s the flag that actually tells the system to allow (or disallow) the hibernation process.
		*/
	$hibernate_enabled = reg('HKLM\SYSTEM\CurrentControlSet\Control\Power', 'HibernateEnabledDefault') and reg('HKLM\SYSTEM\CurrentControlSet\Control\Power', 'HibernateEnabled')
	item(title='Hibernate' image=\uE017 tip='Saves your work to disk and turns off your computer completely. Restores everything exactly as you left it on next startup.'
		vis=if(not(hibernate_enabled),'disabled')
		// cmd-line='/c shutdown -h' window='hidden')
		// cmd-line='/c rundll32 powrprof.dll,SetSuspendState 1,1,0' window='hidden')
		cmd='shutdown.exe' args='/h' window='hidden')
	//> https://www.elevenforum.com/t/turn-on-or-off-fast-startup-in-windows-11.1212/
	//+ https://www.tenforums.com/tutorials/4189-turn-off-fast-startup-windows-10-a.html
	$fast_startup_enabled = reg('HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power', 'HiberbootEnabled')
	item(title='Hybrid Sleep' image=\uE046 tip='Combines Sleep and Hibernate features - saves to both memory and disk for fast wake-up and protection against power loss.'
		vis=if(not(hibernate_enabled and fast_startup_enabled),'disabled')
		cmd-line='/c rundll32 powrprof.dll,SetSuspendState Sleep' window='hidden')
	item(keys='SHIFT to force' title='Hybrid Shut Down' image=\uE046 tip='Also known as Fast Startup. Combines a shut down and hibernation for faster startup.'
		vis=if(not(hibernate_enabled and fast_startup_enabled),'disabled')
		// cmd-line='/c shutdown -s -f -t 00 -hybrid' window='hidden')
		cmd='shutdown.exe' args='/s /hybrid @if(key.shift(),'/f','') /t 0' window='hidden')
	//> https://www.elevenforum.com/t/check-if-modern-standby-is-supported-in-windows-11.3262/
	item(title='Check Sleep and Hibernate States' image=\uE135 tip='Displays available power states of the computer.'
		cmd-line='/k powercfg /a & pause & exit')
	//> https://www.elevenforum.com/t/enable-or-disable-hibernate-in-windows-11.1894/
	item(title=if(hibernate_enabled,'Dis', 'En')+'able Hibernate' tip='Enables or disables the hibernation feature, which saves the current state of your session to disk and shuts down the computer. If hibernation is disabled, the hibernation file (hiberfil.sys) is removed'
		where=keys.shift()
		admin cmd-line='/c powercfg -h @if(hibernate_enabled, 'off', 'on') & pause & exit')
	//> https://www.elevenforum.com/t/turn-on-or-off-fast-startup-in-windows-11.1212/
	item(title=if(fast_startup_enabled,'Dis', 'En')+'able Fast Startup' tip='Enables or disables the fast startup feature, which combines a shut down and hibernation for faster startup.'
		vis=if(not(hibernate_enabled),'disabled') where=keys.shift()
		//cmd=reg.set('HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power', 'HiberbootEnabled', if(fast_startup_enabled, 0, 1)))
		admin cmd-line='/c reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d @if(fast_startup_enabled, 0, 1) /f' window=hidden)
	item(title='Power Options' image=icon.res('@sys.bin\powercpl.dll') tip='Opens the Power Options control panel, where you can adjust the power settings of your computer.'
		where=keys.shift()
		cmd-line='/c rundll32.exe shell32.dll,Control_RunDLL powercfg.cpl,,1' window='hidden')

	separator()	
	menu(title='Shut Down Schedule@"\t"SHIFT expand' image=\uE129) {
		menu(image=inherit expanded='true' where=!keys.shift()) {
			item(title='00 hour'  image=inherit vis='disable')	
			item(title='01 hour'  image=inherit cmd-line='/c shutdown -s -f -t @(01*60*60)' window='hidden')
			item(title='02 hours' image=inherit cmd-line='/c shutdown -s -f -t @(02*60*60)' window='hidden')
			item(title='03 hours' image=inherit cmd-line='/c shutdown -s -f -t @(03*60*60)' window='hidden')
			item(title='04 hours' image=inherit cmd-line='/c shutdown -s -f -t @(04*60*60)' window='hidden')
			item(title='05 hours' image=inherit cmd-line='/c shutdown -s -f -t @(05*60*60)' window='hidden')
			item(title='06 hours' image=inherit cmd-line='/c shutdown -s -f -t @(06*60*60)' window='hidden')
			item(title='07 hours' image=inherit cmd-line='/c shutdown -s -f -t @(07*60*60)' window='hidden')
			item(title='08 hours' image=inherit cmd-line='/c shutdown -s -f -t @(08*60*60)' window='hidden')
			item(title='09 hours' image=inherit cmd-line='/c shutdown -s -f -t @(09*60*60)' window='hidden')
			item(title='10 hours' image=inherit cmd-line='/c shutdown -s -f -t @(10*60*60)' window='hidden')
			item(title='11 hours' image=inherit cmd-line='/c shutdown -s -f -t @(11*60*60)' window='hidden')
			item(title='12 hours' image=inherit cmd-line='/c shutdown -s -f -t @(12*60*60)' window='hidden') }
		menu(image=inherit expanded='true' where=keys.shift()) {
			menu(title='00 hour'  image=inherit) {
				item(title='and 05 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((00*60+05)*60)' window='hidden')
				item(title='and 10 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((00*60+10)*60)' window='hidden')
				item(title='and 15 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((00*60+15)*60)' window='hidden')
				item(title='and 20 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((00*60+20)*60)' window='hidden')
				item(title='and 25 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((00*60+25)*60)' window='hidden')
				item(title='and 30 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((00*60+30)*60)' window='hidden')
				item(title='and 35 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((00*60+35)*60)' window='hidden')
				item(title='and 40 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((00*60+40)*60)' window='hidden')
				item(title='and 45 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((00*60+45)*60)' window='hidden')
				item(title='and 50 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((00*60+50)*60)' window='hidden')
				item(title='and 55 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((00*60+55)*60)' window='hidden') }
			menu(title='01 hour'  image=inherit) {
				item(title='and 00 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((01*60+00)*60)' window='hidden')
				item(title='and 10 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((01*60+10)*60)' window='hidden')
				item(title='and 20 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((01*60+20)*60)' window='hidden')
				item(title='and 30 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((01*60+30)*60)' window='hidden')
				item(title='and 40 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((01*60+40)*60)' window='hidden')
				item(title='and 50 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((01*60+50)*60)' window='hidden') }
			menu(title='02 hours' image=inherit) {
				item(title='and 00 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((02*60+00)*60)' window='hidden')
				item(title='and 10 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((02*60+10)*60)' window='hidden')
				item(title='and 20 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((02*60+20)*60)' window='hidden')
				item(title='and 30 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((02*60+30)*60)' window='hidden')
				item(title='and 40 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((02*60+40)*60)' window='hidden')
				item(title='and 50 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((02*60+50)*60)' window='hidden') }
			menu(title='03 hours' image=inherit) {
				item(title='and 00 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((03*60+00)*60)' window='hidden')
				item(title='and 10 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((03*60+10)*60)' window='hidden')
				item(title='and 20 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((03*60+20)*60)' window='hidden')
				item(title='and 30 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((03*60+30)*60)' window='hidden')
				item(title='and 40 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((03*60+40)*60)' window='hidden')
				item(title='and 50 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((03*60+50)*60)' window='hidden') }
			menu(title='04 hours' image=inherit) {
				item(title='and 00 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((04*60+00)*60)' window='hidden')
				item(title='and 10 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((04*60+10)*60)' window='hidden')
				item(title='and 20 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((04*60+20)*60)' window='hidden')
				item(title='and 30 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((04*60+30)*60)' window='hidden')
				item(title='and 40 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((04*60+40)*60)' window='hidden')
				item(title='and 50 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((04*60+50)*60)' window='hidden') }
			menu(title='05 hours' image=inherit) {
				item(title='and 00 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((05*60+00)*60)' window='hidden')
				item(title='and 10 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((05*60+10)*60)' window='hidden')
				item(title='and 20 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((05*60+20)*60)' window='hidden')
				item(title='and 30 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((05*60+30)*60)' window='hidden')
				item(title='and 40 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((05*60+40)*60)' window='hidden')
				item(title='and 50 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((05*60+50)*60)' window='hidden') }
			menu(title='06 hours' image=inherit) {
				item(title='and 00 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((06*60+00)*60)' window='hidden')
				item(title='and 10 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((06*60+10)*60)' window='hidden')
				item(title='and 20 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((06*60+20)*60)' window='hidden')
				item(title='and 30 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((06*60+30)*60)' window='hidden')
				item(title='and 40 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((06*60+40)*60)' window='hidden')
				item(title='and 50 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((06*60+50)*60)' window='hidden') }
			menu(title='07 hours' image=inherit) {
				item(title='and 00 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((07*60+00)*60)' window='hidden')
				item(title='and 10 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((07*60+10)*60)' window='hidden')
				item(title='and 20 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((07*60+20)*60)' window='hidden')
				item(title='and 30 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((07*60+30)*60)' window='hidden')
				item(title='and 40 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((07*60+40)*60)' window='hidden')
				item(title='and 50 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((07*60+50)*60)' window='hidden') }
			menu(title='08 hours' image=inherit) {
				item(title='and 00 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((08*60+00)*60)' window='hidden')
				item(title='and 10 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((08*60+10)*60)' window='hidden')
				item(title='and 20 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((08*60+20)*60)' window='hidden')
				item(title='and 30 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((08*60+30)*60)' window='hidden')
				item(title='and 40 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((08*60+40)*60)' window='hidden')
				item(title='and 50 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((08*60+50)*60)' window='hidden') }
			menu(title='09 hours' image=inherit) {
				item(title='and 00 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((09*60+00)*60)' window='hidden')
				item(title='and 10 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((09*60+10)*60)' window='hidden')
				item(title='and 20 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((09*60+20)*60)' window='hidden')
				item(title='and 30 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((09*60+30)*60)' window='hidden')
				item(title='and 40 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((09*60+40)*60)' window='hidden')
				item(title='and 50 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((09*60+50)*60)' window='hidden') }
			menu(title='10 hours' image=inherit) {
				item(title='and 00 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((10*60+00)*60)' window='hidden')
				item(title='and 10 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((10*60+10)*60)' window='hidden')
				item(title='and 20 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((10*60+20)*60)' window='hidden')
				item(title='and 30 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((10*60+30)*60)' window='hidden')
				item(title='and 40 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((10*60+40)*60)' window='hidden')
				item(title='and 50 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((10*60+50)*60)' window='hidden') }
			menu(title='11 hours' image=inherit) {
				item(title='and 00 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((11*60+00)*60)' window='hidden')
				item(title='and 10 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((11*60+10)*60)' window='hidden')
				item(title='and 20 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((11*60+20)*60)' window='hidden')
				item(title='and 30 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((11*60+30)*60)' window='hidden')
				item(title='and 40 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((11*60+40)*60)' window='hidden')
				item(title='and 50 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((11*60+50)*60)' window='hidden') }
			menu(title='12 hours' image=inherit) {
				item(title='and 00 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((12*60+00)*60)' window='hidden')
				item(title='and 10 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((12*60+10)*60)' window='hidden')
				item(title='and 20 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((12*60+20)*60)' window='hidden')
				item(title='and 30 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((12*60+30)*60)' window='hidden')
				item(title='and 40 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((12*60+40)*60)' window='hidden')
				item(title='and 50 minutes' image=inherit cmd-line='/c shutdown -s -f -t @((12*60+50)*60)' window='hidden') } }
		item(title='Abort' image=\uE139 cmd-line='/c shutdown -a' sep='before' window='hidden' ) }

	separator()
	item(keys='SHIFT to force' title='Recovery Mode' image=\uE12A tip='Restarts to Windows Recovery Environment for troubleshooting, repair options, and advanced startup settings.'
		// cmd-line='/c shutdown -r -o -f -t 00' window='hidden')
		cmd='shutdown.exe' args='/r /o @if(key.shift(),'/f','') /t 0' window='hidden')
	//> https://www.tenforums.com/tutorials/94290-add-boot-uefi-firmware-settings-context-menu-windows-10-a.html
	item(keys='SHIFT to force' title='Boot to BIOS/UEFI' image=\uE1A9 tip='Booting to your BIOS or UEFI firmware settings.'
		// admin cmd-line='/c shutdown -s -fw -f -t 00' window='hidden')
		admin cmd='shutdown.exe' args='/r /fw @if(key.shift(),'/f','') /t 0' window='hidden')
	//> https://winaero.com/safe-mode-context-menu-windows-10/
	menu(title='Boot Mode Restart' image=\uE0F6 tip='Set the boot mode of the computer and then restart the computer. It creates a shortcut on the desktop to manually change the boot mode, if needed.')
	{
		item(keys='SHIFT to force' title='Normal Mode' tip='Sets the default boot mode of the computer to Normal Mode, which starts Windows normally.'
			commands {
				cmd=io.delete('@user.desktop\MSConfig.lnk'),
				admin cmd-line='/c bcdedit /deletevalue {current} safeboot & shutdown /r @if(key.shift(),'/f','') /t 0' window='hidden', })
		item(keys='SHIFT to force' title='Save Mode' tip='Sets the default boot mode of the computer to Safe Mode, which starts Windows with minimal drivers and services.'
			commands {
				cmd=path.lnk.create('@user.desktop\MSConfig.lnk', 'MSConfig.exe'),
				admin cmd-line='/c bcdedit /set {current} safeboot minimal & shutdown /r @if(key.shift(),'/f','') /t 0' window='hidden', })
		item(keys='SHIFT to force' title='Safe Mode with Networking' tip='Sets the default boot mode of the computer to Safe Mode, which starts Windows with minimal drivers and services, but with networking enabled.'
			commands {
				cmd=path.lnk.create('@user.desktop\MSConfig.lnk', 'MSConfig.exe'),
				admin cmd-line='/c bcdedit /set {current} safeboot network & shutdown /r @if(key.shift(),'/f','') /t 0' window='hidden', })
		item(keys='SHIFT to force' title='Safe Mode with Command Prompt' tip='Sets the default boot mode of the computer to Safe Mode, which starts Windows with minimal drivers and services, but with a command prompt.'
			commands {
				cmd=path.lnk.create('@user.desktop\MSConfig.lnk', '@sys.bin\msconfig.exe'),
				admin cmd-line='/c bcdedit /set {current} safebootalternateshell yes & shutdown /r @if(key.shift(),'/f','') /t 0' window='hidden', })
	}
}


/* https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.application.setsuspendstate?view=windowsdesktop-8.0
	Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.Application]::SetSuspendState('Suspend', $false, $false)
 	cmd-line='/c rundll32 powrprof.dll,SetSuspendState 0,1,0' window='hidden')
	0 → Sleep mode (not Hibernate) 1 → Hibernation mode (saves session to disk, power off)
	0 → Do not force sleep 1 → Forces immediate sleep (even if an app tries to stop it)
	0 → Allow wake events (keyboard/mouse can wake) 1 → Prevents scheduled tasks or USB devices from waking the PC
		https://www.thewindowsclub.com/turn-off-hybrid-sleep-when-pc-is-on-battery-or-plugged-in
	https://www.elevenforum.com/t/sleep-computer-in-windows-11.5238/
	https://devblogs.microsoft.com/oldnewthing/20110510-00/?p=10703
*/


/* to check for S0
	https://www.reddit.com/r/Dell/comments/h0r56s/getting_back_s3_sleep_and_disabling_modern/
	CsEnabled - Up from Windows 10 2004 (2020 May update), MS also removed the CsEnabled option from registry. 
		1 → Modern Standby (S0 Low Power Idle) is enabled.
		0 → Modern Standby is not enabled (S3 is likely available).
	PlatformAoAcOverride
		https://www.elevenforum.com/t/disable-modern-standby-in-windows-10-and-windows-11.3929/
	EnableInputSuppression and EnforceDisconnectedStandby
		HybridSleep
*/