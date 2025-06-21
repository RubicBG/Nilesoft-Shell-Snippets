// Author: Rubic / RubicBG
// Based on: Inasnum's idea (Discord)
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/
/* To-Do:
	Confirm how Windows prioritizes HKCU over HKLM when writing AppCompatFlags.
		Note: Currently treating them independently. Investigate if merge or sync is possible/needed.
	Research flag dependencies:
		Identify flags that must be used together.
	Investigate filtering flags based on system architecture (x86 vs x64).
		Note: Might not be feasible directly through registry alone.
	Research why a specific command only works on Windows Vista.
		Find a cross-version compatible method if possible.
*/

// Remove Troubleshoot Compatibility
// remove(clsid='{1d27f844-3a1f-4410-85ac-14651078412d}')

$flag_is_lm = key.shift()
$flag = null
$flags_m_reg = 'HKLM\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers'
$flags_u_reg = 'HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers'
$flags_m_str = null
$flags_u_str = null
$flag_file_path = if(sel.file.ext=='.lnk', sel.lnktarget, sel.path)

menu(title={ flags_m_str=reg.get(flags_m_reg, flag_file_path) flags_u_str=reg.get(flags_u_reg, flag_file_path) } + 'Windows Compatibility'
	mode='single' type='file' where=reg.exists('HKCR\@reg('HKCR\@path.file.ext(flag_file_path)')\shellex\ContextMenuHandlers\Compatibility') 
	image='<svg xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="100" height="100" viewBox="12 -12 48 48"><path fill="#03a9f4" d="M34.807,12.511l-3.488,12.077c-3.03-2.052-6.327-3.744-13.318-0.83l3.408-11.945l0.041-0.019C28.414,8.908,31.787,10.447,34.807,12.511z"></path><path fill="#ffc107" d="M36.633,13.68l-3.447,11.943c3.028,2.069,6.383,3.718,13.365,0.805l3.324-11.643C42.76,17.24,39.66,15.731,36.633,13.68z"></path><path fill="#ff5722" d="M35.387,10.337l3.441-11.964C35.8-3.688,32.442-5.344,25.454-2.424L22.011,9.59c2.775-1.153,4.969-1.682,6.806-1.666C31.604,7.942,33.563,9.102,35.387,10.337z"></path><path fill="#7cb342" d="M40.643-0.369l-3.44,12.033c3.018,2.063,6.669,3.752,13.359,0.738L54,0.415C47.021,3.317,43.665,1.688,40.643-0.369z"></path></svg>') {
	// https://www.nirsoft.net/utils/app_compatibility_view.html
	// https://www.tenforums.com/tutorials/15523-change-compatibility-mode-settings-apps-windows-10-a.html
	// https://ss64.com/nt/syntax-compatibility.html
	$flagging = {
		// get from registry
		flags_reg = if(flag_is_lm, flags_m_str, flags_u_str)
		flags_arr = str.split(flags_reg, ' ')
		// set to registry
		flags_new = ''
		flag_last = ''
		flag_test = flag
		// loop
		for(i=0, i<len(flags_arr)) {
			flag_curr = flags_arr[i]
			// ignore and fix
			if(flag_curr=='~', continue)
			if(flag_curr=='DPIUNAWARE' and str.contains(flags_reg, 'GDIDPISCALING'), continue)
			if(flag_curr=='GDIDPISCALING', flag_curr='GDIDPISCALING DPIUNAWARE')
			// remove
			$combination = '256COLOR|16BITCOLOR'
			if(str.contains(combination, flag_curr) and str.contains(combination, flag_test), continue)
			$combination = 'RUNASINVOKER|ELEVATECREATEPROCESS|RUNASADMIN'
			if(str.contains(combination, flag_curr) and str.contains(combination, flag_test), continue)
			$combination = 'PERPROCESSSYSTEMDPIFORCEOFF|PERPROCESSSYSTEMDPIFORCEON'
			if(str.contains(combination, flag_curr) and str.contains(combination, flag_test), continue)
			$combination = 'HIGHDPIAWARE|DPIUNAWARE|GDIDPISCALING DPIUNAWARE'
			if(str.contains(combination, flag_curr) and str.contains(combination, flag_test), continue)
			$combination = 'WIN95|WIN4SP5|WIN98|WIN2000|WINXPSP2|WINXPSP3|WINSRV03SP1|VISTARTM|VISTASP1|VISTASP2|WINSRV08SP1|WIN7RTM|WIN8RTM'
			if(str.contains(combination, flag_curr) and not(str.contains(combination, flag_test)), flag_last=' '+flag_curr)
			if(str.contains(combination, flag_curr) and str.contains(combination, flag_test), continue)	
			if(flag_test!=flag_curr, { flags_new+=' '+flag_curr })
		}
		// add new
		if(!str.contains(flags_reg, flag_test), { flags_new+=' '+flag_test })
		// reoerder and combine
		flags_new = '~'+str.replace(flags_new, flag_last, '')+flag_last
		// set new
		if(flag_is_lm, { flags_m_str = flags_new }, { flags_u_str = flags_new }) }
	$flag_cmd = if(flag_is_lm, if(len(flags_m_str)>2, `reg add "@flags_m_reg" /v "@flag_file_path" /t REG_SZ /d "@flags_m_str" /f`, `reg delete "@flags_m_reg" /v "@flag_file_path" /f`), if(len(flags_u_str)>2, `reg add "@flags_u_reg" /v "@flag_file_path" /t REG_SZ /d "@flags_u_str" /f`, `reg delete "@flags_u_reg" /v "@flag_file_path" /f`))
	menu(title='Compatibility mode' image=icon.res('shell32.dll', 94)) {
		$is64bit=sys.is64 and str.contains(sel.path, '%ProgramFiles%') and !str.contains(sel.path, '%ProgramFiles(x86)%')
		// Compatibility mode for a legacy Windows version (Windows 95)
		item(title='Windows 95' where=sys.ver.build>950 vis=if($is64bit, 'disabled')
			image=[[if(str.contains(flags_u_str, 'WIN95'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, 'WIN95'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='WIN95' flagging } @flag_cmd' window='hidden')
		// Enhanced compatibility mode for Windows 98, with improved USB and DirectX support
		item(title='Windows 98 / ME' where=sys.ver.build>2000 vis=if($is64bit, 'disabled')
			image=[[if(str.contains(flags_u_str, 'WIN98'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, 'WIN98'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='WIN98' flagging } @flag_cmd' window='hidden')
		// Windows 2000 compatibility mode for enterprise applications from early 2000s
		item(title='Windows 2000' where=sys.ver.build>2195 vis=if($is64bit, 'disabled')
			image=[[if(str.contains(flags_u_str, 'WIN2000'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, 'WIN2000'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='WIN2000' flagging } @flag_cmd' window='hidden')
		// Windows XP Service Pack 2 provides security enhancements and DirectX 9.0c compatibility
		item(title='Windows XP SP2' where=sys.ver.build>2600 vis=if($is64bit, 'disabled')
			image=[[if(str.contains(flags_u_str, 'WINXPSP2'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, 'WINXPSP2'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='WINXPSP2' flagging } @flag_cmd' window='hidden')
		// Windows XP Service Pack 3 compatibility - the final and most stable XP release
		item(title='Windows XP SP3' where=sys.ver.build>2600 vis=if($is64bit, 'disabled')
			image=[[if(str.contains(flags_u_str, 'WINXPSP3'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, 'WINXPSP3'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='WINXPSP3' flagging } @flag_cmd' window='hidden')
		// Compatibility setting for the initial release of Windows Vista (build 6000)
		item(title='Windows Vista RTM' where=sys.ver.build>6000
			image=[[if(str.contains(flags_u_str, 'VISTARTM'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, 'VISTARTM'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='VISTARTM' flagging } @flag_cmd' window='hidden')
		// Compatibility mode for Windows Vista Service Pack 1 - addresses many RTM issues
		item(title='Windows Vista SP1' where=sys.ver.build>6001
			image=[[if(str.contains(flags_u_str, 'VISTASP1'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, 'VISTASP1'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='VISTASP1' flagging } @flag_cmd' window='hidden')
		// Compatibility mode for Windows Vista Service Pack 2 - final Vista service pack
		item(title='Windows Vista SP2' where=sys.ver.build>6002
			image=[[if(str.contains(flags_u_str, 'VISTASP2'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, 'VISTASP2'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='VISTASP2' flagging } @flag_cmd' window='hidden')
		// Compatibility mode for the initial release of Windows 7 (build 7600)
		item(title='Windows 7 RTM' where=sys.ver.build>7601
			image=[[if(str.contains(flags_u_str, 'WIN7RTM'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, 'WIN7RTM'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='WIN7RTM' flagging } @flag_cmd' window='hidden')
		// Compatibility mode for the initial release of Windows 8 (build 9200)
		item(title='Windows 8 RTM' where=sys.ver.build>9200
			image=[[if(str.contains(flags_u_str, 'WIN8RTM'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, 'WIN8RTM'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='WIN8RTM' flagging } @flag_cmd' window='hidden')
		separator()
		// Windows NT 4.0 with Service Pack 5 - suitable for applications from 1999-2000 era
		item(title='Windows NT 4.0 SP5' where=sys.ver.build>1381 vis=if($is64bit, 'disabled')
			image=[[if(str.contains(flags_u_str, 'WIN4SP5'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, 'WIN4SP5'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='WIN4SP5' flagging } @flag_cmd' window='hidden')
		// Windows Server 2003 SP1 - enterprise server environment compatibility
		item(title='Windows Server 2003 SP1' where=sys.ver.build>3790 vis=if($is64bit, 'disabled')
			image=[[if(str.contains(flags_u_str, 'WINSRV03SP1'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, 'WINSRV03SP1'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='WINSRV03SP1' flagging } @flag_cmd' window='hidden')
		// Windows Server 2008 SP1 server environment compatibility
		item(title='Windows Server 2008 SP1' where=sys.ver.build>6003
			image=[[if(str.contains(flags_u_str, 'WINSRV08SP1'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, 'WINSRV08SP1'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='WINSRV08SP1' flagging } @flag_cmd' window='hidden') }
	separator()
	menu(title='User Access and Permissions' image=icon.res('imageres.dll', 73)) {
		// Option to run the application with administrative privileges
		item(title='Run as Administrator' tip='Execute with elevated privileges - required for legacy applications that need to modify system files or settings.'
			image=[[if(str.contains(flags_u_str, 'RUNASADMIN'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, 'RUNASADMIN'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='RUNASADMIN' flagging } @flag_cmd' window='hidden')
		// Vista-specific elevation method using child process creation
		item(title='Run as Administrator (Vista Method)' tip='Vista-specific: Launches a child process with administrative rights while maintaining parent context.' where=sys.ver.build>=6000
			image=[[if(str.contains(flags_u_str, 'ELEVATECREATEPROCESS'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, 'ELEVATECREATEPROCESS'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='ELEVATECREATEPROCESS' flagging } @flag_cmd' window='hidden')
		// Force standard user privileges even for administrator accounts
		item(title='Run as Standard User' tip='Forces application to run without administrative privileges, improving security for untrusted applications.' where=sys.ver.build>=6000
			image=[[if(str.contains(flags_u_str, 'RUNASINVOKER'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, 'RUNASINVOKER'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='RUNASINVOKER' flagging } @flag_cmd' window='hidden') }
	separator()
	menu(title='System Behavior and Stability' image=icon.res('imageres.dll', 109)) {
		// Enable application restart registration for crash recovery
		item(title='Enable Automatic Restart on Crash' tip='Registers application for automatic restart if it crashes unexpectedly - useful for mission-critical software.'
			image=[[if(str.contains(flags_u_str, 'REGISTERAPPRESTART'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, 'REGISTERAPPRESTART'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='REGISTERAPPRESTART' flagging } @flag_cmd' window='hidden')
		separator()
		// Disable Data Execution Prevention (DEP) notification for legacy applications
		item(title='Disable DEP Warning Dialog' tip='Prevents Windows from showing Data Execution Prevention warning when running incompatible applications.' where=sys.ver.build>=2600
			image=[[if(str.contains(flags_u_str, 'DisableNXShowUI'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, 'DisableNXShowUI'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='DisableNXShowUI' flagging } @flag_cmd' window='hidden')
		// Disable user callback exception dialog for applications with known exception issues
		item(title='Suppress Exception Dialogs' tip='Prevents Windows from showing error dialogs when application generates exceptions - helps with apps that have known harmless errors.' where=sys.ver.build>=2600
			image=[[if(str.contains(flags_u_str, 'DISABLEUSERCALLBACKEXCEPTION'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, 'DISABLEUSERCALLBACKEXCEPTION'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='DISABLEUSERCALLBACKEXCEPTION' flagging } @flag_cmd' window='hidden')
		separator()
		// Option to use legacy display ICC color management
		item(title='Legacy ICC Color Management' tip='Enables Windows XP-era color profile handling for graphics applications with specific color calibration requirements.'
			image=[[if(str.contains(flags_u_str, 'TRANSFORMLEGACYCOLORMANAGED'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, 'TRANSFORMLEGACYCOLORMANAGED'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='TRANSFORMLEGACYCOLORMANAGED' flagging } @flag_cmd' window='hidden') }
	menu(title='Display and Graphics Settings' image=icon.res('imageres.dll', 104)) {
		// Option to run in 256 color mode (8-bit) for extremely old applications
		item(title='256 Color Mode (8-bit)' tip='Reduce color depth to 256 colors for compatibility with legacy DOS and early Windows 95 applications.'
			image=[[if(str.contains(flags_u_str, '256COLOR'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, '256COLOR'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='256COLOR' flagging } @flag_cmd' window='hidden')
		// Option to run in 16-bit color mode (High Color - 65,536 colors)
		item(title='16-bit Color Mode (High Color)' tip='Set display to 65,536 colors - useful for games and applications from Windows 95/98 era.'
			image=[[if(str.contains(flags_u_str, '16BITCOLOR'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, '16BITCOLOR'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='16BITCOLOR' flagging } @flag_cmd' window='hidden')
		separator()
		// Resolution settings: Forcing low resolution (640x480) VGA display mode
		item(title='640 x 480 Resolution (VGA)' tip='Force application to run at standard VGA resolution - resolves scaling issues with older games and applications.'
			image=[[if(str.contains(flags_u_str, '640x480'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, '640x480'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='640x480' flagging } @flag_cmd' window='hidden')
		separator()
		// Option to disable fullscreen optimizations that affect legacy DirectX games
		item(title='Disable Fullscreen Optimizations' tip='Prevents Windows 10/11 from applying fullscreen optimizations that can cause input lag or rendering issues in older games.'
			image=[[if(str.contains(flags_u_str, 'DISABLEDXMAXIMIZEDWINDOWEDMODE'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, 'DISABLEDXMAXIMIZEDWINDOWEDMODE'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='DISABLEDXMAXIMIZEDWINDOWEDMODE' flagging } @flag_cmd' window='hidden')
		// Option to disable Desktop Window Manager (DWM) composition for legacy applications
		item(title='Disable Desktop Composition' tip='Turns off Aero/DWM visual effects that can interfere with older applications, especially fullscreen games.' where=sys.ver.build>=6000
			image=[[if(str.contains(flags_u_str, 'DISABLEDWM'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, 'DISABLEDWM'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='DISABLEDWM' flagging } @flag_cmd' window='hidden')
		// Option to disable visual themes/styling for applications with custom UI elements
		item(title='Disable Visual Themes' tip='Reverts to classic Windows appearance, fixing rendering issues in older applications that use custom controls.' where=sys.ver.build>=2600
			image=[[if(str.contains(flags_u_str, 'DISABLETHEMES'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, 'DISABLETHEMES'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='DISABLETHEMES' flagging } @flag_cmd' window='hidden') }
	menu(title='High DPI Settings' image=icon.res('imageres.dll', 186)) {
		// High DPI settings for Windows 10 Fall Creators Update and later (build 17063+)
		item(title='Override System DPI Scaling (Login)' tip='Controls per-process DPI awareness at Windows logon - use for applications that need consistent scaling across sessions.' where=sys.ver.build>=17063
			image=[[if(str.contains(flags_u_str, 'PERPROCESSSYSTEMDPIFORCEOFF'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, 'PERPROCESSSYSTEMDPIFORCEOFF'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='PERPROCESSSYSTEMDPIFORCEOFF' flagging } @flag_cmd' window='hidden')
		item(title='Override System DPI Scaling (Runtime)' tip='Controls per-process DPI awareness at application launch - more dynamic scaling that adapts to current display settings.' where=sys.ver.build>=17063
			image=[[if(str.contains(flags_u_str, 'PERPROCESSSYSTEMDPIFORCEON'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, 'PERPROCESSSYSTEMDPIFORCEON'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='PERPROCESSSYSTEMDPIFORCEON' flagging } @flag_cmd' window='hidden')
		separator()
		// Application-specific high DPI awareness: suitable for modern applications with built-in scaling
		item(title='Application-Managed DPI Scaling' tip='Tells Windows that the application handles its own high DPI scaling - prevents double-scaling artifacts.' where=sys.ver.build>=15002
			image=[[if(str.contains(flags_u_str, 'HIGHDPIAWARE'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, 'HIGHDPIAWARE'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='HIGHDPIAWARE' flagging } @flag_cmd' window='hidden')
		// Use system scaling via DPI unawareness - best for legacy applications
		item(title='Windows-Managed DPI Scaling' tip='Lets Windows handle all display scaling - best option for older applications with small UI elements on high-resolution displays.' where=sys.ver.build>=15002
			image=[[if(str.contains(flags_u_str, 'DPIUNAWARE') and !str.contains(flags_u_str, 'GDIDPISCALING'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, 'DPIUNAWARE') and !str.contains(flags_m_str, 'GDIDPISCALING'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='DPIUNAWARE' flagging } @flag_cmd' window='hidden')
		// Enhanced GDI scaling mode for GDI-heavy applications
		item(title='GDI-Optimized DPI Scaling' tip='Specialized scaling mode for applications that heavily use GDI drawing functions - improves text clarity on high DPI displays.' where=sys.ver.build>=15002
			image=[[if(str.contains(flags_u_str, 'GDIDPISCALING DPIUNAWARE'), \uE16E, \uE000), image.color2],[if(str.contains(flags_m_str, 'GDIDPISCALING DPIUNAWARE'), \uE170, \uE000), image.color2]]
			admin=flag_is_lm cmd-line='/c @{ flag='GDIDPISCALING DPIUNAWARE' flagging } @flag_cmd' window='hidden') }

	separator()
	item(title='Program Compatibility Troubleshooter' image cmd='msdt.exe' args='-id PCWDiagnostic')
	// Microsoft Defender Antivirus now includes signatures that detect and terminate any MSDT process launched with command‑line parameters
	item(title='Program Compatibility Troubleshooter' image cmd='msdt.exe' args='/id PCWDiagnostic /skip TRUE /param "IT_LaunchMethod=ContextMenu IT_BrowseForFile=@sel"' vis=0)
	// https://lolbas-project.github.io/lolbas/Binaries/Pcalua/
	// https://pentestlab.blog/tag/pcalua-exe/
	item(title='Program Compatibility Analyzer' image cmd='pcalua.exe' args='-a @sel(true)' vis=0)
}