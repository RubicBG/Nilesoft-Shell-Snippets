// system: definition (can be changed)
	// general
	$cpl_name	= 'Control Panel'
	$cpl_in		= '' // 'Go to'
	$classic 	= keys.shift() // keys.shift(), 0, 1

	// info
	$i_NAME = '@"\t"NAME'
	$i_guid = '@"\t"GUID'
	$i_gmix = '@"\t"MIX'
	$i_ctrl = '@"\t"control'
	$i_rdll = '@"\t"rundll32'
	$i_dcpl = '@"\t".cpl'
	$i_dexe = '@"\t".exe'
	$i_dmsc = '@"\t".msc'

// system: OS version
	// https://en.wikipedia.org/wiki/List_of_Microsoft_Windows_versions
	$WinXP		=  '5.1.2600.0'
	$WinV		=  '6.0.6000.0'
	$Win7		=  '6.1.7600.0'			
	$Win8		=  '6.2.9200.0'			$Lwin8 = '@"\t"@if(sys.version>=Win8, 'legacy', 'supported')'
	$Win81		=  '6.3.9600.0'
	$win10_1507	= '10.0.10240.0'		$L1507 = '@"\t"@if(sys.version>=win10_1507, 'legacy', 'supported')'
	$win10_1607	= '10.0.14393.0'
	$win10_1709	= '10.0.16299.0'
	$win10_1803	= '10.0.17134.0'
	$win10_1909	= '10.0.18363.0'
	$win10_2004	= '10.0.19041.0'
	$win10_20h2	= '10.0.19042.0'
	$win11_21H2	= '10.0.22000.0'		$Lsupp = '@"\t"supported'

// system: menu names 
	// https://learn.microsoft.com/en-us/previous-versions/windows/desktop/legacy/cc144183(v=vs.85)
	$cpl_name_0='Control Panel'
	$cpl_name_1=if(sys.version>=Win7, 'System and Security', if(sys.version>=WinV, 'System and Maintenance + Security', 'Performance and Maintenance + Security Center'))
	$cpl_name_2=if(sys.version>=WinV, 'Network and Internet', 'Network and Internet Connections')
	$cpl_name_3=if(sys.version>=WinV, 'Hardware and Sound', 'Printers and Other Hardware, Sounds + Speech, and Audio Devices') // Printers and Other Hardware (winXP)
	$cpl_name_4=if(sys.version>=WinV, 'Programs', 'Add or Remove Programs')
	$cpl_name_5='User Accounts' // User Accounts and Family Safety
	$cpl_name_6=if(sys.version>=WinV, 'Appearance and Personalization', 'Appearance and Themes')
	$cpl_name_7=if(sys.version>=win10_1803, 'Clock and Region', if(sys.version>=WinV, 'Clock, Language, and Region', 'Date, Time, Language, and Regional Options'))
	$cpl_name_8=if(sys.version>=WinV, 'Ease of Access', 'Accessibility Options')
	$cpl_name_9='Others'

	$is_m0 = '@if(str.len(cpl_in)>0, '@cpl_in/')@cpl_name'
	$is_m1 = '@if(str.len(cpl_in)>0, '@cpl_in/')@cpl_name@if(!classic, '/@cpl_name_1')'
	$is_m2 = '@if(str.len(cpl_in)>0, '@cpl_in/')@cpl_name@if(!classic, '/@cpl_name_2')'
	$is_m3 = '@if(str.len(cpl_in)>0, '@cpl_in/')@cpl_name@if(!classic, '/@cpl_name_3')'
	$is_m4 = '@if(str.len(cpl_in)>0, '@cpl_in/')@cpl_name@if(!classic, '/@cpl_name_4')'
	$is_m5 = '@if(str.len(cpl_in)>0, '@cpl_in/')@cpl_name@if(!classic, '/@cpl_name_5')'
	$is_m6 = '@if(str.len(cpl_in)>0, '@cpl_in/')@cpl_name@if(!classic, '/@cpl_name_6')'
	$is_m7 = '@if(str.len(cpl_in)>0, '@cpl_in/')@cpl_name@if(!classic, '/@cpl_name_7')'
	$is_m8 = '@if(str.len(cpl_in)>0, '@cpl_in/')@cpl_name@if(!classic, '/@cpl_name_8')'
	$is_m9 = '@if(str.len(cpl_in)>0, '@cpl_in/')@cpl_name@if(!classic, '/@cpl_name_9')'

// system: shell commands
	$cpl_co = [ 'shell:',
				'shell:::' ]
	$cpl_cm = [ 'shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\0\::',	// Control Panel\All Control Panel Items\...
				'shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\5\::',	// Control Panel\System and Security\...
				'shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\3\::',	// Control Panel\Network and Internet\...
				'shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\2\::',	// Control Panel\Hardware and Sound\...
				'shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\8\::',	// Control Panel\Programs\...
				'shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\9\::',	// Control Panel\User Accounts\...
				'shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\1\::',	// Control Panel\Appearance and Personalization\...
				'shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\6\::',	// Control Panel\Clock and Region\...
				'shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\7\::',	// Control Panel\Ease of Access\...
				'shell:::{21EC2020-3AEA-1069-A2DD-08002B30309D}\::',	// All Control Panel Items\...
				'shell:ControlPanelFolder\::' ]							// Control Panel\All Control Panel Items\...	
// menus
menu(title=cpl_name	menu=cpl_in where=sys.version>=WinXP image=icon.res('@sys.bin\shell32.dll', 21)) {
	menu(image=inherit		title=cpl_name_1 vis=classic==0) { item(vis=vis.hidden) }
	menu(image=inherit		title=cpl_name_2 vis=classic==0) { item(vis=vis.hidden) }
	menu(image=inherit		title=cpl_name_3 vis=classic==0) { item(vis=vis.hidden) }
	menu(image=inherit		title=cpl_name_4 vis=classic==0) { item(vis=vis.hidden) }
	menu(image=inherit		title=cpl_name_5 vis=classic==0) { item(vis=vis.hidden) }
	menu(image=inherit		title=cpl_name_6 vis=classic==0) { item(vis=vis.hidden) }
	menu(image=inherit		title=cpl_name_7 vis=classic==0) { item(vis=vis.hidden) }
	menu(image=inherit		title=cpl_name_8 vis=classic==0) { item(vis=vis.hidden) }
	menu(image=inherit	sep	title=cpl_name_9 vis=classic==0) { item(vis=vis.hidden) }}
//> https://learn.microsoft.com/en-us/windows/win32/shell/controlpanel-canonical-names
//+ https://voyager.deanza.edu/~hso/cis170f/lecture/ch03/win01/index.html
//- https://renenyffenegger.ch/notes/Windows/control-panel/index
//- https://wikileaks.org/ciav7p1/cms/page_13762780.html
menu(title='Control Panel@if(classic, L1507)'		image=icon.res('@sys.bin\shell32.dll', 21)					menu=is_m0 pos='top' sep) {
	item(image=inherit
		title='Control Panel (Category view)@i_guid'
		tip='Control Panel'
		cmd=cpl_co[1]  + '{26EE0668-A00A-44D7-9371-BEB064C98683}')
	item(image=inherit
		title='Control Panel@i_guid'
		tip='Control Panel\All Control Panel Items'
		cmd=cpl_co[1]  + '{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}')
	item(image=inherit
		title='Control Panel (Icons view)@i_guid'
		tip='All Control Panel Items'
		cmd=cpl_co[1]  + '{21EC2020-3AEA-1069-A2DD-08002B30309D}')
	item(image=inherit
		title='Control Panel@i_name'
		tip='Control Panel\All Control Panel Items'
		cmd=cpl_co[0]  + 'ControlPanelFolder')
	separator()
	item(image=inherit
		title='Control Panel (Icons view)@i_name'
		tip='Control Panel\All Control Panel Items'
		cmd=cpl_co[1]  + '{26EE0668-A00A-44D7-9371-BEB064C98683}\@if(!keys.shift(), 0, 11)')
	separator() }
menu(title='Action Center@L1507'					image=icon.res('@sys.bin\ActionCenterCPL.dll')				menu=is_m1 where=sys.version>=Win7 and path.exists('@sys.bin\ActionCenterCPL.dll')) {
	// https://learn.microsoft.com/en-us/windows/win32/shell/controlpanel-canonical-names#action-center
	item(vis=vis.hidden) }
menu(title='Administrative Tools@L1507'				image=icon.res('@sys.bin\imageres.dll', 109) /*-114*/		menu=is_m1 where=sys.version>=WinV) {
	// https://learn.microsoft.com/en-us/windows/win32/shell/controlpanel-canonical-names#administrative-tools
	// https://learn.microsoft.com/en-us/windows/client-management/client-tools/administrative-tools-in-windows
	item(vis=vis.hidden) }
menu(title='AutoPlay@L1507'							image=icon.res('@sys.bin\autoplay.dll')						menu=is_m3 where=sys.version>=WinV and path.exists('@sys.bin\autoplay.dll')) {
	item(image=inherit
		title='AutoPlay@i_guid'
		tip='AutoPlay'
		cmd=cpl_co[1]  + '{9C60DE1E-E5FC-40F4-A487-460851A8D915}')
	item(image=inherit
		title='AutoPlay (Category view)@i_guid'
		tip='Control Panel\Hardware and Sound\AutoPlay@"\n"Control Panel\All Control Panel Items\AutoPlay'
		cmd=if(!keys.shift(), cpl_cm[3], cpl_cm[0])+'{9C60DE1E-E5FC-40F4-A487-460851A8D915}')
	item(image=inherit
		title='AutoPlay (Icons view)@i_guid'
		tip='All Control Panel Items\AutoPlay'
		cmd=cpl_cm[9]  + '{9C60DE1E-E5FC-40F4-A487-460851A8D915}')
	item(image=inherit
		title='AutoPlay@i_gmix'
		tip='Control Panel\All Control Panel Items\AutoPlay'
		cmd=cpl_cm[10] + '{9C60DE1E-E5FC-40F4-A487-460851A8D915}')
	separator()
	item(image=inherit
		title='AutoPlay@i_ctrl'
		cmd='control' args='/name Microsoft.AutoPlay') }
menu(title='Biometric Devices@L1507'				image=icon.res('@sys.bin\biocpl.dll')						menu=is_m3 where=sys.version>=Win7 and path.exists('@sys.bin\biocpl.dll')) {
	// https://www.bayometric.com/windows-biometric-framework/
	item(image=inherit
		title='Biometric Devices@i_guid'
		cmd=cpl_co[1]  + '{0142e4d0-fb7a-11dc-ba4a-000ffe7ab428}') }
menu(title='Backup and Restore@Lwin8'				image=icon.res('@sys.bin\sdcpl.dll')						menu=is_m1 where=sys.version>=Win7 and path.exists('@sys.bin\sdcpl.dll')) {
	item(image=inherit
		title='Backup and Restore@i_guid'
		tip='Backup and Restore (Windows 7)'
		cmd=cpl_co[1]  + '{B98A2BEA-7D42-4558-8BD1-832F41BAC6FD}')
	item(image=inherit
		title='Backup and Restore (Category view)@i_guid'
		tip='Control Panel\System and Security\Backup and Restore (Windows 7)@"\n"Control Panel\All Control Panel Items\Backup and Restore (Windows 7)'
		cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{B98A2BEA-7D42-4558-8BD1-832F41BAC6FD}')
	item(image=inherit
		title='Backup and Restore (Icons view)@i_guid'
		tip='All Control Panel Items\Backup and Restore (Windows 7)'
		cmd=cpl_cm[9]  + '{B98A2BEA-7D42-4558-8BD1-832F41BAC6FD}')
	item(image=inherit
		title='Backup and Restore@i_gmix'
		tip='Control Panel\All Control Panel Items\Backup and Restore (Windows 7)'
		cmd=cpl_cm[10] + '{B98A2BEA-7D42-4558-8BD1-832F41BAC6FD}') }
menu(title='BitLocker Drive Encryption@L1507'		image=icon.res('@sys.bin\fvecpl.dll')						menu=is_m1 where=sys.version>=WinV and path.exists('@sys.bin\fvecpl.dll')) {
	item(image=inherit
		title='BitLocker Drive Encryption@i_guid'
		tip='BitLocker Drive Encryption'
		cmd=cpl_co[1]  + '{D9EF8727-CAC2-4E60-809E-86F80A666C91}')
	item(image=inherit
		title='BitLocker Drive Encryption (Category view)@i_guid'
		tip='Control Panel\System and Security\BitLocker Drive Encryption@"\n"Control Panel\All Control Panel Items\BitLocker Drive Encryption'
		cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{D9EF8727-CAC2-4E60-809E-86F80A666C91}')
	item(image=inherit
		title='BitLocker Drive Encryption (Icons view)@i_guid'
		tip='All Control Panel Items\BitLocker Drive Encryption'
		cmd=cpl_cm[9]  + '{D9EF8727-CAC2-4E60-809E-86F80A666C91}')
	item(image=inherit
		title='BitLocker Drive Encryption@i_gmix'
		tip='Control Panel\All Control Panel Items\BitLocker Drive Encryption'
		cmd=cpl_cm[10] + '{D9EF8727-CAC2-4E60-809E-86F80A666C91}') }
menu(title='Color Management@L1507'					image=icon.res('@sys.bin\colorcpl.exe')						menu=is_m6 where=sys.version>=WinV and path.exists('@sys.bin\colorcpl.exe')) {
	item(image=inherit
		title='Color Management@i_guid'
		tip='(Panel) Color Management'
		cmd=cpl_co[1]  + '{B2C761C6-29BC-4F19-9251-E6195265BAF1}')
	item(image=inherit
		title='Color Management (Category view)@i_guid'
		tip='(Panel) Color Management'
		cmd=if(!keys.shift(), cpl_cm[7], cpl_cm[0])+'{B2C761C6-29BC-4F19-9251-E6195265BAF1}')
	item(image=inherit
		title='Color Management (Icons view)@i_guid'
		tip='(Panel) Color Management'
		cmd=cpl_cm[9]  + '{B2C761C6-29BC-4F19-9251-E6195265BAF1}')
	item(image=inherit
		title='Color Management@i_gmix'
		tip='(Panel) Color Management'
		cmd=cpl_cm[10] + '{B2C761C6-29BC-4F19-9251-E6195265BAF1}')
	separator()
	item(image=inherit
		title='Color Management@i_dexe'
		cmd='@sys.bin\colorcpl.exe') }
menu(title='Credential Manager@L1507'				image=icon.res('@sys.bin\Vault.dll')						menu=is_m5 where=sys.version>=Win7 and path.exists('@sys.bin\Vault.dll')) {
	item(image=inherit
		title='Credential Manager@i_guid'
		tip='Credential Manager'
		cmd=cpl_co[1]  + '{1206F5F1-0569-412C-8FEC-3204630DFB70}')
	item(image=inherit
		title='Credential Manager (Category view)@i_guid'
		tip='Control Panel\System and Security\Credential Manager@"\n"Control Panel\All Control Panel Items\Credential Manager'
		cmd=if(!keys.shift(), cpl_cm[5], cpl_cm[0])+'{1206F5F1-0569-412C-8FEC-3204630DFB70}')
	item(image=inherit
		title='Credential Manager (Icons view)@i_guid'
		tip='All Control Panel Items\Credential Manager'
		cmd=cpl_cm[9]  + '{1206F5F1-0569-412C-8FEC-3204630DFB70}')
	item(image=inherit
		title='Credential Manager@i_gmix'
		tip='Control Panel\All Control Panel Items\Credential Manager'
		cmd=cpl_cm[10] + '{1206F5F1-0569-412C-8FEC-3204630DFB70}') }
menu(title='Date and Time@L1507'					image=icon.res('@sys.bin\timedate.cpl')						menu=is_m7 where=sys.version>=WinV and path.exists('@sys.bin\timedate.cpl')) {
	item(image=inherit
		title='Date and Time@i_guid'
		tip='(Panel) Date and Time'
		cmd=cpl_co[1]  + '{E2E7934B-DCE5-43C4-9576-7FE4F75E7480}')
	item(image=inherit
		title='Date and Time (Category view)@i_guid'
		tip='(Panel) Date and Time'
		cmd=if(!keys.shift(), cpl_cm[7], cpl_cm[0])+'{E2E7934B-DCE5-43C4-9576-7FE4F75E7480}')
	item(image=inherit
		title='Date and Time (Icons view)@i_guid'
		tip='(Panel) Date and Time'
		cmd=cpl_cm[9]  + '{E2E7934B-DCE5-43C4-9576-7FE4F75E7480}')
	item(image=inherit
		title='Date and Time@i_gmix'
		tip='(Panel) Date and Time'
		cmd=cpl_cm[10] + '{E2E7934B-DCE5-43C4-9576-7FE4F75E7480}')
	separator()
	item(image=inherit
		title='Date and Time (Date and Time)@i_rdll'
		cmd='rundll32.exe' args='shell32.dll,Control_RunDLL timedate.cpl,,0')
	item(image=inherit
		title='Date and Time (Additional Clocks)@i_rdll'
		cmd='rundll32.exe' args='shell32.dll,Control_RunDLL timedate.cpl,,1') }
menu(title='Default Programs [R]@L1507'				image=icon.res('@sys.bin\imageres.dll', 19)	/*-24*/			menu=is_m4 where=sys.version>=WinV) {
	item(image=inherit
		title='Default Programs@i_guid'
		tip='Default Programs'
		cmd=cpl_co[1]  + '{17CD9488-1228-4B2F-88CE-4298E93E0966}')
	item(image=inherit
		title='Default Programs (Category view)@i_guid'
		tip='Control Panel\System and Security\Default Programs@"\n"Control Panel\All Control Panel Items\Default Programs'
		cmd=if(!keys.shift(), cpl_cm[4], cpl_cm[0])+'{17CD9488-1228-4B2F-88CE-4298E93E0966}')
	item(image=inherit
		title='Default Programs (Icons view)@i_guid'
		tip='All Control Panel Items\Default Programs'
		cmd=cpl_cm[9]  + '{17CD9488-1228-4B2F-88CE-4298E93E0966}')
	item(image=inherit
		title='Default Programs@i_gmix'
		tip='Control Panel\All Control Panel Items\Default Programs'
		cmd=cpl_cm[10] + '{17CD9488-1228-4B2F-88CE-4298E93E0966}')
	separator()
	item(image=inherit
		title='Default Programs@i_guid'
		cmd=cpl_cm[1] + '{E44E5D18-0652-4508-A4E2-8A090067BCB0}')
	item(image=inherit
		title='Default Programs@i_ctrl'
		cmd='control' args='/name Microsoft.DefaultPrograms')
	separator()
	menu(image=inherit title='Set Default Programs') {
		item(image=inherit
			title='Set Default Programs@i_guid'
			cmd=cpl_co[1]  + '{17CD9488-1228-4B2F-88CE-4298E93E0966}\pageDefaultProgram')
		item(image=inherit
			title='Set Default Programs (Category view)@i_guid'
			cmd=if(!keys.shift(), cpl_cm[4], cpl_cm[0])+'{17CD9488-1228-4B2F-88CE-4298E93E0966}\pageDefaultProgram')
		item(image=inherit
			title='Set Default Programs (Icons view)@i_guid'
			cmd=cpl_cm[9]  + '{17CD9488-1228-4B2F-88CE-4298E93E0966}\pageDefaultProgram')
		item(image=inherit
			title='Set Default Programs@i_gmix'
			cmd=cpl_cm[10] + '{17CD9488-1228-4B2F-88CE-4298E93E0966}\pageDefaultProgram')
		separator()
		item(image=inherit
			title='Set Default Programs@i_ctrl'
			cmd='control' args='/name Microsoft.DefaultPrograms /page pageDefaultProgram') }
	menu(image=inherit title='Set Associations') {
		item(image=inherit
			title='Set Associations@i_guid'
			cmd=cpl_co[1]  + '{17CD9488-1228-4B2F-88CE-4298E93E0966}\pageFileAssoc')
		item(image=inherit
			title='Set Default Programs (Category view)@i_guid'
			cmd=if(!keys.shift(), cpl_cm[4], cpl_cm[0])+'{17CD9488-1228-4B2F-88CE-4298E93E0966}\pageFileAssoc')
		item(image=inherit
			title='Set Associations (Icons view)@i_guid'
			cmd=cpl_cm[9]  + '{17CD9488-1228-4B2F-88CE-4298E93E0966}\pageFileAssoc')
		item(image=inherit
			title='Set Associations@i_gmix'
			cmd=cpl_cm[10] + '{17CD9488-1228-4B2F-88CE-4298E93E0966}\pageFileAssoc')
		separator()
		item(image=inherit
			title='Set Associations@i_ctrl'
			cmd='control' args='/name Microsoft.DefaultPrograms /page pageFileAssoc') }
	menu(image=inherit title='Set Program Access and Computer Defaults') {
		item(image=inherit
			title='Set Program Access and Computer Defaults@i_guid'
			cmd=cpl_co[1]  + '{2559a1f7-21d7-11d4-bdaf-00c04f60b9f0}')
		item(image=inherit
			title='Set Program Access and Computer Defaults (Category view)@i_guid'
			cmd=if(!keys.shift(), cpl_cm[4], cpl_cm[0])+'{2559a1f7-21d7-11d4-bdaf-00c04f60b9f0}')
		item(image=inherit
			title='Set Program Access and Computer Defaults (Icons view)@i_guid'
			cmd=cpl_cm[9]  + '{2559a1f7-21d7-11d4-bdaf-00c04f60b9f0}')
		item(image=inherit vis='disable'
			title='Set Program Access and Computer Defaults@i_gmix'
			cmd=cpl_cm[10] + '{2559a1f7-21d7-11d4-bdaf-00c04f60b9f0}') }}
menu(title='Desktop Gadgets@L1507'					image=icon.res('@sys.prog\Windows Sidebar\sbdrop.dll')		menu=is_m6 where=sys.version>=Win7 and path.exists('@sys.prog\Windows Sidebar\sbdrop.dll')) {
	// %ProgramFiles%\Windows Sidebar\Sidebar.exe,-100
	item(image=inherit
		title='Desktop Gadgets@i_guid'
		tip='(Panel) Desktop Gadgets'
		cmd=cpl_co[1]  + '{6B9228DA-9C15-419e-856C-19E768A13BDC}')
	item(image=inherit
		title='Desktop Gadgets (Category view)@i_guid'
		tip='(Panel) Desktop Gadgets@"\n"(Panel) Desktop Gadgets'
		cmd=if(!keys.shift(), cpl_cm[6], cpl_cm[0])+'{6B9228DA-9C15-419e-856C-19E768A13BDC}')
	item(image=inherit
		title='Desktop Gadgets (Icons view)@i_guid'
		tip='(Panel) Desktop Gadgets'
		cmd=cpl_cm[9]  + '{6B9228DA-9C15-419e-856C-19E768A13BDC}')
	item(image=inherit
		title='Desktop Gadgets@i_gmix'
		tip='(Panel) Desktop Gadgets'
		cmd=cpl_cm[10] + '{6B9228DA-9C15-419e-856C-19E768A13BDC}') }
menu(title='Device Manager@L1507'					image=icon.res('@sys.bin\devmgr.dll', 5)					menu=is_m3 where=sys.version>=WinV and path.exists('@sys.bin\devmgr.dll')) {
	item(image=inherit
		title='Device Manager@i_guid'
		tip='(Panel) Device Manager'
		cmd=cpl_co[1]  + '{74246BFC-4C96-11D0-ABEF-0020AF6B0B7A}')
	item(image=inherit
		title='Device Manager (Category view)@i_guid'
		tip='(Panel) Device Manager'
		cmd=if(!keys.shift(), cpl_cm[3], cpl_cm[0])+'{74246BFC-4C96-11D0-ABEF-0020AF6B0B7A}')
	item(image=inherit
		title='Device Manager (Icons view)@i_guid'
		tip='(Panel) Device Manager'
		cmd=cpl_cm[9]  + '{74246BFC-4C96-11D0-ABEF-0020AF6B0B7A}')
	item(image=inherit
		title='Device Manager@i_gmix'
		tip='(Panel) Device Manager'
		cmd=cpl_cm[10] + '{74246BFC-4C96-11D0-ABEF-0020AF6B0B7A}')
	separator()
	item(image=inherit
		title='Device Manager@i_dmsc'
		// cmd='mmc.exe' args='/s devmgmt.msc'
		cmd='devmgmt.msc') }
menu(title='Devices and Printers@L1507'				image=icon.res('@sys.bin\DeviceCenter.dll')					menu=is_m3 where=sys.version>=Win7 and path.exists('@sys.bin\DeviceCenter.dll')) {
	item(image=inherit
		title='Devices and Printers@i_guid'
		tip='Devices and Printers'
		cmd=cpl_co[1]  + '{A8A91A66-3A7D-4424-8D24-04E180695C7A}')
	item(image=inherit
		title='Devices and Printers (Category view)@i_guid'
		tip='Control Panel\System and Security\Devices and Printers@"\n"Control Panel\All Control Panel Items\Devices and Printers'
		cmd=if(!keys.shift(), cpl_cm[3], cpl_cm[0])+'{A8A91A66-3A7D-4424-8D24-04E180695C7A}')
	item(image=inherit
		title='Devices and Printers (Icons view)@i_guid'
		tip='All Control Panel Items\Devices and Printers'
		cmd=cpl_cm[9]  + '{A8A91A66-3A7D-4424-8D24-04E180695C7A}')
	item(image=inherit
		title='Devices and Printers@i_gmix'
		tip='Control Panel\All Control Panel Items\Devices and Printers'
		cmd=cpl_cm[10] + '{A8A91A66-3A7D-4424-8D24-04E180695C7A}') }
menu(title='Display [!]@L1507'						image=icon.res('@sys.bin\Display.dll')						menu=is_m3 where=sys.version>=WinV and path.exists('@sys.bin\Display.dll')) {
	// up to Win10 1607
	item(image=inherit
		title='Display@i_guid'
		tip='Display'
		cmd=cpl_co[1]  + '{C555438B-3C23-4769-A71F-B6D3D9B6053A}')
	item(image=inherit
		title='Display (Category view)@i_guid'
		tip='Control Panel\System and Security\Display@"\n"Control Panel\All Control Panel Items\Display'
		cmd=if(!keys.shift(), cpl_cm[3], cpl_cm[0])+'{C555438B-3C23-4769-A71F-B6D3D9B6053A}')
	item(image=inherit
		title='Display (Icons view)@i_guid'
		tip='All Control Panel Items\Display'
		cmd=cpl_cm[9]  + '{C555438B-3C23-4769-A71F-B6D3D9B6053A}')
	item(image=inherit
		title='Display@i_gmix'
		tip='Control Panel\All Control Panel Items\Display'
		cmd=cpl_cm[10] + '{C555438B-3C23-4769-A71F-B6D3D9B6053A}') }
menu(title='Get Programs [!]@L1507'					image=''													menu=is_m4 where=sys.version>=WinV and path.exists('@sys.bin\Display.dll')) {
	item(image=inherit
		title='Get Programs@i_name'
		tip='Control Panel\All Control Panel Items\Get Programs'
		cmd=cpl_co[0]  + 'AddNewProgramsFolder') }
menu(title='Ease of Access Center@L1507'			image=icon.res('@sys.bin\accessibilitycpl.dll')				menu=is_m8 where=sys.version>=WinV and path.exists('@sys.bin\accessibilitycpl.dll')) {
	item(image=inherit
		title='Ease of Access Center@i_guid'
		tip='Ease of Access Center'
		cmd=cpl_co[1]  + '{D555645E-D4F8-4C29-A827-D93C859C4F2A}')
	item(image=inherit
		title='Ease of Access Center (Category view)@i_guid'
		tip='Control Panel\Ease of Access\Ease of Access Center@"\n"Control Panel\All Control Panel Items\Ease of Access Center'
		cmd=if(!keys.shift(), cpl_cm[8], cpl_cm[0])+'{D555645E-D4F8-4C29-A827-D93C859C4F2A}')
	item(image=inherit
		title='Ease of Access Center (Icons view)@i_guid'
		tip='All Control Panel Items\Ease of Access Center'
		cmd=cpl_cm[9]  + '{D555645E-D4F8-4C29-A827-D93C859C4F2A}')
	item(image=inherit
		title='Ease of Access Center@i_gmix'
		tip='Control Panel\All Control Panel Items\Ease of Access Center'
		cmd=cpl_cm[10] + '{D555645E-D4F8-4C29-A827-D93C859C4F2A}')
	separator()
	item(image=inherit
		title='Ease of Access Center@i_ctrl'
		tip='Control Panel\All Control Panel Items\Ease of Access Center'
		cmd='control.exe' args='/name Microsoft.EaseOfAccessCenter')
	item(image=inherit
		title='Ease of Access Center@i_dcpl'
		tip='Control Panel\All Control Panel Items\Ease of Access Center'
		cmd='control.exe' args='access.cpl')
	separator()
	menu(image=inherit title='Get recommendations to make your computer easier to use (cognitive)') {
		item(image=inherit
			title='Get recommendations to make your computer easier to use (cognitive)@i_guid'
			cmd=cpl_co[1]  + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageQuestionsCognitive')
		item(image=inherit
			title='Get recommendations to make your computer easier to use (cognitive) (Category view)@i_guid'
			cmd=if(!keys.shift(), cpl_cm[8], cpl_cm[0])+'{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageQuestionsCognitive')
		item(image=inherit
			title='Get recommendations to make your computer easier to use (cognitive) (Icons view)@i_guid'
			cmd=cpl_cm[9]  + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageQuestionsCognitive')
		item(image=inherit
			title='Get recommendations to make your computer easier to use (cognitive)@i_gmix'
			cmd=cpl_cm[10] + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageQuestionsCognitive') }
	menu(image=inherit title='Get recommendations to make your computer easier to use (eyesight)') {
		item(image=inherit
			title='Get recommendations to make your computer easier to use (eyesight)@i_guid'
			cmd=cpl_co[1]  + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageQuestionsEyesight')
		item(image=inherit
			title='Get recommendations to make your computer easier to use (eyesight) (Category view)@i_guid'
			cmd=if(!keys.shift(), cpl_cm[8], cpl_cm[0])+'{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageQuestionsEyesight')
		item(image=inherit
			title='Get recommendations to make your computer easier to use (eyesight) (Icons view)@i_guid'
			cmd=cpl_cm[9]  + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageQuestionsEyesight')
		item(image=inherit
			title='Get recommendations to make your computer easier to use (eyesight)@i_gmix'
			cmd=cpl_cm[10] + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageQuestionsEyesight') }
	menu(image=inherit title='Use the computer without a display') {
		item(image=inherit
			title='Use the computer without a display@i_guid'
			cmd=cpl_co[1]  + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageNoVisual')
		item(image=inherit
			title='Use the computer without a display (Category view)@i_guid'
			cmd=if(!keys.shift(), cpl_cm[8], cpl_cm[0])+'{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageNoVisual')
		item(image=inherit
			title='Use the computer without a display (Icons view)@i_guid'
			cmd=cpl_cm[9]  + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageNoVisual')
		item(image=inherit
			title='Use the computer without a display@i_gmix'
			cmd=cpl_cm[10] + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageNoVisual') }
	menu(image=inherit title='Make the computer easier to see') {
		item(image=inherit
			title='Make the computer easier to see@i_guid'
			cmd=cpl_co[1]  + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageEasierToSee')
		item(image=inherit
			title='Make the computer easier to see (Category view)@i_guid'
			cmd=if(!keys.shift(), cpl_cm[8], cpl_cm[0])+'{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageEasierToSee')
		item(image=inherit
			title='Make the computer easier to see (Icons view)@i_guid'
			cmd=cpl_cm[9]  + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageEasierToSee')
		item(image=inherit
			title='Make the computer easier to see@i_gmix'
			cmd=cpl_cm[10] + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageEasierToSee') }
	menu(image=inherit title='Use the computer without a mouse or keyboard') {
		item(image=inherit
			title='Use the computer without a mouse or keyboard@i_guid'
			cmd=cpl_co[1]  + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageNoMouseOrKeyboard')
		item(image=inherit
			title='Use the computer without a mouse or keyboard (Category view)@i_guid'
			cmd=if(!keys.shift(), cpl_cm[8], cpl_cm[0])+'{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageNoMouseOrKeyboard')
		item(image=inherit
			title='Use the computer without a mouse or keyboard (Icons view)@i_guid'
			cmd=cpl_cm[9]  + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageNoMouseOrKeyboard')
		item(image=inherit
			title='Use the computer without a mouse or keyboard@i_gmix'
			cmd=cpl_cm[10] + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageNoMouseOrKeyboard') }
	menu(image=inherit title='Make the mouse easier to use') {
		item(image=inherit
			title='Make the mouse easier to use@i_guid'
			cmd=cpl_co[1]  + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageEasierToClick')
		item(image=inherit
			title='Make the mouse easier to use (Category view)@i_guid'
			cmd=if(!keys.shift(), cpl_cm[8], cpl_cm[0])+'{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageEasierToClick')
		item(image=inherit
			title='Make the mouse easier to use (Icons view)@i_guid'
			cmd=cpl_cm[9]  + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageEasierToClick')
		item(image=inherit
			title='Make the mouse easier to use@i_gmix'
			cmd=cpl_cm[10] + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageEasierToClick') }
	menu(image=inherit title='Make the keyboard easier to use') {
		item(image=inherit
			title='Make the keyboard easier to use@i_guid'
			cmd=cpl_co[1]  + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageKeyboardEasierToUse')
		item(image=inherit
			title='Make the keyboard easier to use (Category view)@i_guid'
			cmd=if(!keys.shift(), cpl_cm[8], cpl_cm[0])+'{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageKeyboardEasierToUse')
		item(image=inherit
			title='Make the keyboard easier to use (Icons view)@i_guid'
			cmd=cpl_cm[9]  + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageKeyboardEasierToUse')
		item(image=inherit
			title='Make the keyboard easier to use@i_gmix'
			cmd=cpl_cm[10] + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageKeyboardEasierToUse') }
	menu(image=inherit title='Set up Mouse Keys') {
			item(image=inherit
		title='Set up Mouse Keys@i_guid'
			cmd=cpl_co[1]  + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageMouseKeysSettings')
			item(image=inherit
		title='Set up Mouse Keys (Category view)@i_guid'
			cmd=if(!keys.shift(), cpl_cm[8], cpl_cm[0])+'{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageMouseKeysSettings')
			item(image=inherit
		title='Set up Mouse Keys (Icons view)@i_guid'
			cmd=cpl_cm[9]  + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageMouseKeysSettings')
			item(image=inherit
		title='Set up Mouse Keys@i_gmix'
			cmd=cpl_cm[10] + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageMouseKeysSettings') }
	menu(image=inherit title='Set up Sticky Keys') {
		item(image=inherit
			title='Set up Sticky Keys@i_guid'
			cmd=cpl_co[1]  + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageStickyKeysSettings')
		item(image=inherit
			title='Set up Sticky Keys (Category view)@i_guid'
			cmd=if(!keys.shift(), cpl_cm[8], cpl_cm[0])+'{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageStickyKeysSettings')
		item(image=inherit
			title='Set up Sticky Keys (Icons view)@i_guid'
			cmd=cpl_cm[9]  + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageStickyKeysSettings')
		item(image=inherit
			title='Set up Sticky Keys@i_gmix'
			cmd=cpl_cm[10] + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageStickyKeysSettings') }
	menu(image=inherit title='Set up Filter Keys') {
			item(image=inherit
		title='Set up Filter Keys@i_guid'
			cmd=cpl_co[1]  + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageFilterKeysSettings')
			item(image=inherit
		title='Set up Filter Keys (Category view)@i_guid'
			cmd=if(!keys.shift(), cpl_cm[8], cpl_cm[0])+'{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageFilterKeysSettings')
			item(image=inherit
		title='Set up Filter Keys (Icons view)@i_guid'
			cmd=cpl_cm[9]  + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageFilterKeysSettings')
			item(image=inherit
		title='Set up Filter Keys@i_gmix'
			cmd=cpl_cm[10] + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageFilterKeysSettings') }
	menu(image=inherit title='Set up Repeat and Slow Keys') {
		item(image=inherit
			title='Set up Repeat and Slow Keys@i_guid'
			cmd=cpl_co[1]  + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageRepeatRateSlowKeysSettings')
		item(image=inherit
			title='Set up Repeat and Slow Keys (Category view)@i_guid'
			cmd=if(!keys.shift(), cpl_cm[8], cpl_cm[0])+'{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageRepeatRateSlowKeysSettings')
		item(image=inherit
			title='Set up Repeat and Slow Keys (Icons view)@i_guid'
			cmd=cpl_cm[9]  + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageRepeatRateSlowKeysSettings')
		item(image=inherit
			title='Set up Repeat and Slow Keys@i_gmix'
			cmd=cpl_cm[10] + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageRepeatRateSlowKeysSettings') }
	menu(image=inherit title='Use text or visual alternatives for sounds') {
		item(image=inherit
			title='Use text or visual alternatives for sounds@i_guid'
			cmd=cpl_co[1]  + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageEasierWithSounds')
		item(image=inherit
			title='Use text or visual alternatives for sounds (Category view)@i_guid'
			cmd=if(!keys.shift(), cpl_cm[8], cpl_cm[0])+'{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageEasierWithSounds')
		item(image=inherit
			title='Use text or visual alternatives for sounds (Icons view)@i_guid'
			cmd=cpl_cm[9]  + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageEasierWithSounds')
		item(image=inherit
			title='Use text or visual alternatives for sounds@i_gmix'
			cmd=cpl_cm[10] + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageEasierWithSounds') }
	menu(image=inherit title='Make it easier to focus on tasks') {
		item(image=inherit
		title='Make it easier to focus on tasks@i_guid'
			cmd=cpl_co[1]  + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageEasierToReadAndWrite')
		item(image=inherit
		title='Make it easier to focus on tasks (Category view)@i_guid'
			cmd=if(!keys.shift(), cpl_cm[8], cpl_cm[0])+'{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageEasierToReadAndWrite')
		item(image=inherit
		title='Make it easier to focus on tasks (Icons view)@i_guid'
			cmd=cpl_cm[9]  + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageEasierToReadAndWrite')
		item(image=inherit
		title='Make it easier to focus on tasks@i_gmix'
			cmd=cpl_cm[10] + '{D555645E-D4F8-4c29-A827-D93C859C4F2A}\pageEasierToReadAndWrite') }}
menu(title='Family Safety@L1507'					image=icon.res('@sys.bin\wpccpl.dll', -100)					menu=is_m5 where=sys.version>=WinV and path.exists('@sys.bin\wpccpl.dll')) {
	// https://learn.microsoft.com/en-us/windows/win32/shell/controlpanel-canonical-names#family-safety
	item(image=inherit
		title='Family Safety@i_guid'
		tip='Family Safety'
		cmd=cpl_co[1]  + '{96AE8D84-A250-4520-95A5-A47A7E3C548B}') }
menu(title='File Explorer Options@Lsupp'			image=icon.res('@sys.bin\shell32.dll', 110)					menu=is_m6 where=sys.version>=WinV) {
	// Folder Options
	item(image=inherit
		title='File Explorer Options@i_guid'
		tip='(Panel) File Explorer Options'
		cmd=cpl_co[1]  + '{6DFD7C5C-2451-11D3-A299-00C04F8EF6AF}')
	item(image=inherit
		title='File Explorer Options (Category view)@i_guid'
		tip='(Panel) File Explorer Options@"\n"(Panel) File Explorer Options'
		cmd=if(!keys.shift(), cpl_cm[6], cpl_cm[0])+'{6DFD7C5C-2451-11D3-A299-00C04F8EF6AF}')
	item(image=inherit
		title='File Explorer Options (Icons view)@i_guid'
		tip='(Panel) File Explorer Options'
		cmd=cpl_cm[9]  + '{6DFD7C5C-2451-11D3-A299-00C04F8EF6AF}')
	item(image=inherit
		title='File Explorer Options@i_gmix'
		tip='(Panel) File Explorer Options'
		cmd=cpl_cm[10] + '{6DFD7C5C-2451-11D3-A299-00C04F8EF6AF}') 
	separator()
	item(image=inherit
		title='File Explorer Options (General tab)@i_rdll'
		cmd='rundll32' args='shell32.dll,Options_RunDLL 0')
	item(image=inherit
		title='File Explorer Options (View tab)@i_rdll'
		cmd='rundll32' args='shell32.dll,Options_RunDLL 7')
	item(image=inherit
		title='File Explorer Options (Search tab)@i_rdll'
		cmd='rundll32' args='shell32.dll,Options_RunDLL 2') }
menu(title='File History@L1507'						image=icon.res('@sys.bin\FileHistory.exe')					menu=is_m1 where=sys.version>=Win8 and path.exists('@sys.bin\fhcpl.dll')) {
	item(image=inherit
		title='File History@i_guid'
		tip='File History'
		cmd=cpl_co[1]  + '{F6B6E965-E9B2-444B-9286-10C9152EDBC5}')
	item(image=inherit
		title='File History (Category view)@i_guid'
		tip='Control Panel\Hardware and Sound\File History@"\n"Control Panel\All Control Panel Items\File History'
		cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{F6B6E965-E9B2-444B-9286-10C9152EDBC5}')
	item(image=inherit
		title='File History (Icons view)@i_guid'
		tip='All Control Panel Items\File History'
		cmd=cpl_cm[9]  + '{F6B6E965-E9B2-444B-9286-10C9152EDBC5}')
	item(image=inherit
		title='File History@i_gmix'
		tip='Control Panel\All Control Panel Items\File History'
		cmd=cpl_cm[10] + '{F6B6E965-E9B2-444B-9286-10C9152EDBC5}') }
menu(title='Fonts@L1507'							image=icon.res('@sys.bin\fontext.dll')						menu=is_m6 where=sys.version>=WinV and path.exists('@sys.bin\fontext.dll')) {
	item(image=inherit vis='disable'
		title='Fonts@i_guid'
		tip='Fonts'
		cmd=cpl_co[1]  + '{BD84B380-8CA2-1069-AB1D-08000948F534}')
	item(image=inherit
		title='Fonts (Category view)@i_guid'
		tip='Control Panel\Hardware and Sound\Fonts@"\n"Control Panel\All Control Panel Items\Fonts'
		cmd=if(!keys.shift(), cpl_cm[6], cpl_cm[0])+'{BD84B380-8CA2-1069-AB1D-08000948F534}')
	item(image=inherit
		title='Fonts (Icons view)@i_guid'
		tip='All Control Panel Items\Fonts'
		cmd=cpl_cm[9]  + '{BD84B380-8CA2-1069-AB1D-08000948F534}')
	item(image=inherit
		title='Fonts@i_gmix'
		tip='Control Panel\All Control Panel Items\Fonts'
		cmd=cpl_cm[10] + '{BD84B380-8CA2-1069-AB1D-08000948F534}')
	separator()
	menu(image=inherit title='Fonts settings') {
		item(image=inherit
			title='Fonts settings@i_guid'
			tip='Fonts settings'
			cmd=cpl_co[1]  + '{93412589-74D4-4E4E-AD0E-E0CB621440FD}')
		item(image=inherit
			title='Fonts settings (Category view)@i_guid'
			tip='Control Panel\Hardware and Sound\Fonts settings@"\n"Control Panel\All Control Panel Items\Fonts settings'
			cmd=if(!keys.shift(), cpl_cm[6], cpl_cm[0])+'{93412589-74D4-4E4E-AD0E-E0CB621440FD}')
		item(image=inherit
			title='Fonts settings (Icons view)@i_guid'
			tip='All Control Panel Items\Fonts settings'
			cmd=cpl_cm[9]  + '{93412589-74D4-4E4E-AD0E-E0CB621440FD}')
		item(image=inherit
			title='Fonts settings@i_gmix'
			tip='Control Panel\All Control Panel Items\Fonts settings'
			cmd=cpl_cm[10] + '{93412589-74D4-4E4E-AD0E-E0CB621440FD}') }}

menu(title='Getting Started [!]@L1507'				image=icon.res('@sys.bin\OobeFldr.dll')						menu=is_m9 where=sys.version>=Win7 and path.exists('@sys.bin\OobeFldr.dll')) {
	// %SystemRoot%\branding\shellbrd\shellbrd.dll
	item(image=inherit
		title='Getting Started@i_guid'
		tip='Getting Started'
		cmd=cpl_co[1]  + '{CB1B7F8C-C50A-4176-B604-9E24DEE8D4D1}')
	item(image=inherit
		title='Getting Started (Category view)@i_guid'
		tip='Control Panel\All Control Panel Items\Getting Started'
		cmd=cpl_cm[0] + '{CB1B7F8C-C50A-4176-B604-9E24DEE8D4D1}')
	item(image=inherit
		title='Getting Started (Icons view)@i_guid'
		tip='All Control Panel Items\Getting Started'
		cmd=cpl_cm[9]  + '{CB1B7F8C-C50A-4176-B604-9E24DEE8D4D1}')
	item(image=inherit
		title='Getting Started@i_gmix'
		tip='Control Panel\All Control Panel Items\Getting Started'
		cmd=cpl_cm[10] + '{CB1B7F8C-C50A-4176-B604-9E24DEE8D4D1}') }
menu(title='HomeGroup [!]@L1507'					image=icon.res('@sys.bin\imageres.dll', -1013)				menu=is_m2 where=sys.version>=WinV and path.exists('@sys.bin\hgcpl.dll')) {
	// up to Win10 1709
	// https://winaero.com/add-homegroup-desktop-icon-windows-10/
	item(image=inherit
		title='HomeGroup@i_guid'
		tip='HomeGroup'
	 	cmd=cpl_co[1]  + '{67CA7650-96E6-4FDD-BB43-A8E774F73A57}')
	item(image=inherit
		title='HomeGroup (Category view)@i_guid'
		tip='Control Panel\Hardware and Sound\HomeGroup@"\n"Control Panel\All Control Panel Items\HomeGroup'
		cmd=if(!keys.shift(), cpl_cm[2], cpl_cm[0])+'{67CA7650-96E6-4FDD-BB43-A8E774F73A57}')
	item(image=inherit
		title='HomeGroup (Icons view)@i_guid'
		tip='All Control Panel Items\HomeGroup'
		cmd=cpl_cm[9]  + '{67CA7650-96E6-4FDD-BB43-A8E774F73A57}')
	item(image=inherit vis='disable'
		title='HomeGroup@i_gmix'
		tip='Control Panel\All Control Panel Items\HomeGroup'
		cmd=cpl_cm[10] + '{67CA7650-96E6-4FDD-BB43-A8E774F73A57}') }
menu(title='Indexing Options@Lsupp'					image=icon.res('@sys.bin\srchadmin.dll')					menu=is_m1 where=sys.version>=WinV and path.exists('@sys.bin\srchadmin.dll')) {
	item(image=inherit
		title='Indexing Options@i_guid'
		tip='(Panel) Indexing Options'
		cmd=cpl_co[1]  + '{87D66A43-7B11-4A28-9811-C86EE395ACF7}')
	item(image=inherit
		title='Indexing Options (Category view)@i_guid'
		tip='(Panel) Indexing Options@"\n"(Panel) Indexing Options'
		cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{87D66A43-7B11-4A28-9811-C86EE395ACF7}')
	item(image=inherit
		title='Indexing Options (Icons view)@i_guid'
		tip='(Panel) Indexing Options'
		cmd=cpl_cm[9]  + '{87D66A43-7B11-4A28-9811-C86EE395ACF7}')
	item(image=inherit
		title='Indexing Options@i_gmix'
		tip='(Panel) Indexing Options'
		cmd=cpl_cm[10] + '{87D66A43-7B11-4A28-9811-C86EE395ACF7}')
	separator()
	item(image=inherit
		title='Indexing Options@i_ctrl'
		cmd='control' args='srchadmin.dll') }
menu(title='Infrared [!]@L1507'						image=''													menu=is_m2 where=sys.version>=Win7 and path.exists('@sys.bin\irprops.cpl')) {
	// Win10 from 1607 to 1809
	item(image=inherit
		title='Infrared@i_guid'
		tip='Infrared'
		cmd=cpl_co[1]  + '{A0275511-0E86-4ECA-97C2-ECD8F1221D08}')
	item(image=inherit
		title='Infrared (Category view)@i_guid'
		tip='Control Panel\Hardware and Sound\Infrared@"\n"Control Panel\All Control Panel Items\Infrared'
		cmd=if(!keys.shift(), cpl_cm[2], cpl_cm[0])+'{A0275511-0E86-4ECA-97C2-ECD8F1221D08}')
	item(image=inherit
		title='Infrared (Icons view)@i_guid'
		tip='All Control Panel Items\Infrared'
		cmd=cpl_cm[9]  + '{A0275511-0E86-4ECA-97C2-ECD8F1221D08}')
	item(image=inherit
		title='Infrared@i_gmix'
		tip='Control Panel\All Control Panel Items\Infrared'
		cmd=cpl_cm[10] + '{A0275511-0E86-4ECA-97C2-ECD8F1221D08}') 
	separator()
	item(image=inherit
		title='Infrared@i_ctrl'
		cmd='control' args='/name Microsoft.Infrared') }
menu(title='Internet Options@L1507'					image=icon.res('@sys.bin\inetcpl.cpl', 26)					menu=is_m2 where=sys.version>=Win8 and path.exists('@sys.bin\inetcpl.cpl')) {
	item(image=inherit
		title='Internet Options@i_guid'
		tip='(Panel) Internet Options'
		cmd=cpl_co[1]  + '{A3DD4F92-658A-410F-84FD-6FBBBEF2FFFE}')
	item(image=inherit
		title='Internet Options (Category view)@i_guid'
		tip='(Panel) Internet Options@"\n"(Panel) Internet Options'
		cmd=if(!keys.shift(), cpl_cm[2], cpl_cm[0])+'{A3DD4F92-658A-410F-84FD-6FBBBEF2FFFE}')
	item(image=inherit
		title='Internet Options (Icons view)@i_guid'
		tip='(Panel) Internet Options'
		cmd=cpl_cm[9]  + '{A3DD4F92-658A-410F-84FD-6FBBBEF2FFFE}')
	item(image=inherit
		title='Internet Options@i_gmix'
		tip='(Panel) Internet Options'
		cmd=cpl_cm[10] + '{A3DD4F92-658A-410F-84FD-6FBBBEF2FFFE}') }
menu(title='Keyboard@L1507'							image=icon.res('@sys.bin\main.cpl', 5)						menu=is_m3 where=sys.version>=Win8 and path.exists('@sys.bin\main.cpl')) {
	item(image=inherit
		title='Keyboard@i_guid'
		tip='(Panel) Keyboard'
		cmd=cpl_co[1]  + '{725BE8F7-668E-4C7B-8F90-46BDB0936430}')
	item(image=inherit
		title='Keyboard (Category view)@i_guid'
		tip='(Panel) Keyboard@"\n"(Panel) Keyboard'
		cmd=if(!keys.shift(), cpl_cm[3], cpl_cm[0])+'{725BE8F7-668E-4C7B-8F90-46BDB0936430}')
	item(image=inherit
		title='Keyboard (Icons view)@i_guid'
		tip='(Panel) Keyboard'
		cmd=cpl_cm[9]  + '{725BE8F7-668E-4C7B-8F90-46BDB0936430}')
	item(image=inherit
		title='Keyboard@i_gmix'
		tip='(Panel) Keyboard'
		cmd=cpl_cm[10] + '{725BE8F7-668E-4C7B-8F90-46BDB0936430}') }
menu(title='Language [!]@L1507'						image=''													menu=is_m6 where=sys.version>=WinV) {
	/* shell:::{BF782CC9-5A52-4A17-806C-2A894FFEEAC5} */ }
menu(title='Location Settings [!]@L1507'			image=icon.res('@sys.bin\SensorsCpl.dll')					menu=is_m3 where=sys.version>=WinV and path.exists('@sys.bin\SensorsCpl.dll')) {
	// Sensors | Location and Other Sensors
	item(image=inherit
		title='Location Settings@i_guid'
		tip='Location Settings'
		cmd=cpl_co[1]  + '{E9950154-C418-419E-A90A-20C5287AE24B}')
	item(image=inherit
		title='Location Settings (Category view)@i_guid'
		tip='Control Panel\Hardware and Sound\Location Settings@"\n"Control Panel\All Control Panel Items\Location Settings'
		cmd=if(!keys.shift(), cpl_cm[3], cpl_cm[0])+'{E9950154-C418-419E-A90A-20C5287AE24B}')
	item(image=inherit
		title='Location Settings (Icons view)@i_guid'
		tip='All Control Panel Items\Location Settings'
		cmd=cpl_cm[9]  + '{E9950154-C418-419E-A90A-20C5287AE24B}')
	item(image=inherit
		title='Location Settings@i_gmix'
		tip='Control Panel\All Control Panel Items\Location Settings'
		cmd=cpl_cm[10] + '{E9950154-C418-419E-A90A-20C5287AE24B}') }
menu(title='Mouse@L1507'							image=icon.res('@sys.bin\main.cpl', 0)						menu=is_m3 where=sys.version>=WinV and path.exists('@sys.bin\main.cpl')) { 
	item(image=inherit
		title='Mouse@i_guid'
		tip='Mouse'
		cmd=cpl_co[1]  + '{6C8EEC18-8D75-41B2-A177-8831D59D2D50}')
	item(image=inherit
		title='Mouse (Category view)@i_guid'
		tip='Control Panel\System and Security\Mouse@"\n"Control Panel\All Control Panel Items\Mouse'
		cmd=if(!keys.shift(), cpl_cm[3], cpl_cm[0])+'{6C8EEC18-8D75-41B2-A177-8831D59D2D50}')
	item(image=inherit
		title='Mouse (Icons view)@i_guid'
		tip='All Control Panel Items\Mouse'
		cmd=cpl_cm[9]  + '{6C8EEC18-8D75-41B2-A177-8831D59D2D50}')
	item(image=inherit
		title='Mouse@i_gmix'
		tip='Control Panel\All Control Panel Items\Mouse'
		cmd=cpl_cm[10] + '{6C8EEC18-8D75-41B2-A177-8831D59D2D50}') }
menu(title='Network@Lsupp'							image=''													menu=is_m2 where=sys.version>=Win7) {
	item(image=inherit
		title='Network@i_guid'
		tip='Network'
		cmd=cpl_co[1]  + '{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}')
	item(image=inherit
		title='Network (Category view)@i_guid'
		tip='Control Panel\Network and Internet\Network@"\n"Control Panel\Network'
		cmd=if(!keys.shift(), cpl_cm[2], cpl_cm[0])+'{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}')
	item(image=inherit
		title='Network (Icons view)@i_guid'
		tip='All Control Panel Items\Network and Sharing Center\Network'
		cmd=cpl_cm[9]  + '{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}')
	item(image=inherit
		title='Network@i_gmix' vis='disable'
		tip='Control Panel\All Control Panel Items\Network and Sharing Center\Network'
		cmd=cpl_cm[10] + '{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}')
	separator()
		item(image=inherit
		title='Network@i_name'
		tip='Network'
		cmd=cpl_co[0]  + 'NetworkPlacesFolder') }
menu(title='Network Connections@Lsupp'				image=icon.res('@sys.bin\ncpa.cpl', 0)						menu=is_m2 where=sys.version>=Win7 and path.exists('@sys.bin\ncpa.cpl')) {
	item(image=inherit
		title='Network Connections@i_guid'
		tip='All Control Panel Items\Network Connections'
		cmd=cpl_co[1]  + '{7007ACC7-3202-11D1-AAD2-00805FC1270E}')
	item(image=inherit
		title='Network Connections (Category view)@i_guid'
		tip='Control Panel\Network and Internet\Network Connections@"\n"Control Panel\All Control Panel Items\Network Connections'
		cmd=if(!keys.shift(), cpl_cm[2], cpl_cm[0])+'{7007ACC7-3202-11D1-AAD2-00805FC1270E}')
	item(image=inherit
		title='Network Connections (Icons view)@i_guid'
		tip='All Control Panel Items\Network Connections'
		cmd=cpl_cm[9]  + '{7007ACC7-3202-11D1-AAD2-00805FC1270E}')
	item(image=inherit
		title='Network Connections@i_gmix'
		tip='Control Panel\All Control Panel Items\Network Connections'
		cmd=cpl_cm[10] + '{7007ACC7-3202-11D1-AAD2-00805FC1270E}')
	separator()
	item(image=inherit
		title='Network Connections@i_dcpl'
		tip='Control Panel\All Control Panel Items\Network Connections'
		cmd='control.exe' args='ncpa.cpl')
	separator()
	item(image=inherit
		title='Network Connections@i_guid'
		tip='All Control Panel Items\Network Connections'
		cmd=cpl_co[1]  + '{992CFFA0-F557-101A-88EC-00DD010CCC48}')
	item(image=inherit
		title='Network Connections (Category view)@i_guid'
		tip='Control Panel\Network and Internet\Network Connections@"\n"Control Panel\All Control Panel Items\Network Connections'
		cmd=if(!keys.shift(), cpl_cm[2], cpl_cm[0])+'{992CFFA0-F557-101A-88EC-00DD010CCC48}')
	item(image=inherit
		title='Network Connections (Icons view)@i_guid'
		tip='All Control Panel Items\Network Connections'
		cmd=cpl_cm[9]  + '{992CFFA0-F557-101A-88EC-00DD010CCC48}')
	item(image=inherit vis='disable'
		title='Network Connections@i_gmix'
		tip='Control Panel\All Control Panel Items\Network Connections'
		cmd=cpl_cm[10] + '{992CFFA0-F557-101A-88EC-00DD010CCC48}') }
item(												col	sep='after'												menu=cpl_name where=classic) 
menu(title='Network and Sharing Center@L1507'		image=icon.res('@sys.bin\netcenter.dll')					menu=is_m2 where=sys.version>=WinV and path.exists('@sys.bin\netcenter.dll')) {
	item(image=inherit
		title='Network and Sharing Center@i_guid'
		tip='Network and Sharing Center'
		cmd=cpl_co[1]  + '{8E908FC9-BECC-40F6-915B-F4CA0E70D03D}')
	item(image=inherit
		title='Network and Sharing Center (Category view)@i_guid'
		tip='Control Panel\Network and Internet\Network and Sharing Center@"\n"Control Panel\All Control Panel Items\Network and Sharing Center'
		cmd=if(!keys.shift(), cpl_cm[2], cpl_cm[0])+'{8E908FC9-BECC-40F6-915B-F4CA0E70D03D}')
	item(image=inherit
		title='Network and Sharing Center (Icons view)@i_guid'
		tip='All Control Panel Items\Network and Sharing Center'
		cmd=cpl_cm[9]  + '{8E908FC9-BECC-40F6-915B-F4CA0E70D03D}')
	item(image=inherit
		title='Network and Sharing Center@i_gmix'
		tip='Control Panel\All Control Panel Items\Network and Sharing Center'
		cmd=cpl_cm[10] + '{8E908FC9-BECC-40F6-915B-F4CA0E70D03D}')
	menu(image=inherit title='Advanced sharing settings [R]') {
		item(image=inherit
			title='Advanced sharing settings@i_guid'
			tip='Network and Sharing Center\Advanced sharing settings'
			cmd=cpl_co[1]  + '{8E908FC9-BECC-40F6-915B-F4CA0E70D03D}\Advanced')
		item(image=inherit
			title='Advanced sharing settings (Category view)@i_guid'
			tip='Control Panel\Network and Internet\Network and Sharing Center\Advanced sharing settings@"\n"Control Panel\All Control Panel Items\Network and Sharing Center\Advanced sharing settings'
			cmd=if(!keys.shift(), cpl_cm[2], cpl_cm[0])+'{8E908FC9-BECC-40F6-915B-F4CA0E70D03D}\Advanced')
		item(image=inherit
			title='Advanced sharing settings (Icons view)@i_guid'
			tip='All Control Panel Items\Network and Sharing Center\Advanced sharing settings'
			cmd=cpl_cm[9]  + '{8E908FC9-BECC-40F6-915B-F4CA0E70D03D}\Advanced')
		item(image=inherit
			title='Advanced sharing settings@i_gmix'
			tip='Control Panel\All Control Panel Items\Network and Sharing Center\Advanced sharing settings'
			cmd=cpl_cm[10] + '{8E908FC9-BECC-40F6-915B-F4CA0E70D03D}\Advanced') }
	menu(image='' title='Media streaming options') {
		item(image=inherit
			title='Media streaming options@i_guid'
			tip='Network and Sharing Center\Media streaming options'
			cmd=cpl_co[1]  + '{8E908FC9-BECC-40F6-915B-F4CA0E70D03D}\ShareMedia')
		item(image=inherit
			title='Media streaming options (Category view)@i_guid'
			tip='Control Panel\Network and Internet\Network and Sharing Center\Media streaming options@"\n"Control Panel\All Control Panel Items\Network and Sharing Center\Media streaming options'
			cmd=if(!keys.shift(), cpl_cm[2], cpl_cm[0])+'{8E908FC9-BECC-40F6-915B-F4CA0E70D03D}\ShareMedia')
		item(image=inherit
			title='Media streaming options (Icons view)@i_guid'
			tip='All Control Panel Items\Network and Sharing Center\Media streaming options'
			cmd=cpl_cm[9]  + '{8E908FC9-BECC-40F6-915B-F4CA0E70D03D}\ShareMedia')
		item(image=inherit
			title='Media streaming options@i_gmix'
			tip='Control Panel\All Control Panel Items\Network and Sharing Center\Media streaming options'
			cmd=cpl_cm[10] + '{8E908FC9-BECC-40F6-915B-F4CA0E70D03D}\ShareMedia') }}
menu(title='Notification Area Icons@L1507'			image=icon.res('@sys.bin\taskbarcpl.dll')					menu=is_m6 where=sys.version>=Win7 and path.exists('@sys.bin\taskbarcpl.dll')) {
	item(image=inherit
		title='Notification Area Icons@i_guid'
		tip='Notification Area Icons'
		cmd=cpl_co[1]  + '{05d7b0f4-2121-4eff-bf6b-ed3f69b894d9}')
	item(image=inherit
		title='Notification Area Icons (Category view)@i_guid'
		tip='Control Panel\Appearance and Personalization\Notification Area Icons@"\n"Control Panel\All Control Panel Items\Notification Area Icons'
		cmd=if(!keys.shift(), cpl_cm[6], cpl_cm[0])+'{05d7b0f4-2121-4eff-bf6b-ed3f69b894d9}')
	item(image=inherit
		title='Notification Area Icons (Icons view)@i_guid'
		tip='All Control Panel Items\Notification Area Icons'
		cmd=cpl_cm[9]  + '{05d7b0f4-2121-4eff-bf6b-ed3f69b894d9}')
	item(image=inherit vis='disable'
		title='Notification Area Icons@i_gmix'
		tip='Control Panel\All Control Panel Items\Notification Area Icons'
		cmd=cpl_cm[10] + '{05d7b0f4-2121-4eff-bf6b-ed3f69b894d9}')
	separator()
	menu(image=inherit title='System Icons') {
		item(image=inherit
			title='System Icons@i_guid'
			tip='Notification Area Icons\System Icons'
			cmd=cpl_co[1]  + '{05d7b0f4-2121-4eff-bf6b-ed3f69b894d9}\SystemIcons')
		item(image=inherit
			title='System Icons (Category view)@i_guid'
			tip='Control Panel\Appearance and Personalization\Notification Area Icons\System Icons@"\n"Control Panel\All Control Panel Items\Notification Area Icons\System Icons'
			cmd=if(!keys.shift(), cpl_cm[6], cpl_cm[0])+'{05d7b0f4-2121-4eff-bf6b-ed3f69b894d9}\SystemIcons')
		item(image=inherit
			title='System Icons (Icons view)@i_guid'
			tip='All Control Panel Items\Notification Area Icons\System Icons'
			cmd=cpl_cm[9]  + '{05d7b0f4-2121-4eff-bf6b-ed3f69b894d9}\SystemIcons')
		item(image=inherit vis='disable'
			title='System Icons@i_gmix'
			tip='Control Panel\All Control Panel Items\Notification Area Icons\System Icons'
			cmd=cpl_cm[10] + '{05d7b0f4-2121-4eff-bf6b-ed3f69b894d9}\SystemIcons') }}
menu(title='Pen and Touch [!]@L1507'				image=icon.res('@sys.bin\tabletpc.cpl', 0)					menu=is_m3 where=sys.version>=Win7 and path.exists('@sys.bin\tabletpc.cpl')) {
	item(image=inherit
		title='Pen and Touch@i_guid'
		tip='Pen and Touch'
		cmd=cpl_co[1]  + '{F82DF8F7-8B9F-442E-A48C-818EA735FF9B}')
	item(image=inherit
		title='Pen and Touch (Category view)@i_guid'
		tip='Control Panel\Hardware and Sound\Pen and Touch@"\n"Control Panel\All Control Panel Items\Pen and Touch'
		cmd=if(!keys.shift(), cpl_cm[3], cpl_cm[0])+'{F82DF8F7-8B9F-442E-A48C-818EA735FF9B}')
	item(image=inherit
		title='Pen and Touch (Icons view)@i_guid'
		tip='All Control Panel Items\Pen and Touch'
		cmd=cpl_cm[9]  + '{F82DF8F7-8B9F-442E-A48C-818EA735FF9B}')
	item(image=inherit
		title='Pen and Touch@i_gmix'
		tip='Control Panel\All Control Panel Items\Pen and Touch'
		cmd=cpl_cm[10] + '{F82DF8F7-8B9F-442E-A48C-818EA735FF9B}') }
menu(title='Parental Controls [!]@L1507'			image=''													menu=is_m5 where=sys.version>=Win7) {
	// https://www.bt.com/content/dam/bt/help/legacy/Microsoft%20Windows%20Parental%20Controls.pdf
	// %SystemRoot%\System32\wpccpl.dll,-1
	item(image=inherit
		title='Parental Controls@i_guid'
		tip='Parental Controls'
		cmd=cpl_co[1]  + '{96AE8D84-A250-4520-95A5-A47A7E3C548B}')
	item(image=inherit
		title='Parental Controls (Category view)@i_guid'
		tip='Control Panel\User Accounts\Parental Controls@"\n"Control Panel\All Control Panel Items\Parental Controls'
		cmd=if(!keys.shift(), cpl_cm[5], cpl_cm[0])+'{96AE8D84-A250-4520-95A5-A47A7E3C548B}')
	item(image=inherit
		title='Parental Controls (Icons view)@i_guid'
		tip='All Control Panel Items\Parental Controls'
		cmd=cpl_cm[9]  + '{96AE8D84-A250-4520-95A5-A47A7E3C548B}')
	item(image=inherit
		title='Parental Controls@i_gmix'
		tip='Control Panel\All Control Panel Items\Parental Controls'
		cmd=cpl_cm[10] + '{96AE8D84-A250-4520-95A5-A47A7E3C548B}') }
menu(title='Performance Information and Tools [!]'	image=icon.res('@sys.bin\wpccpl.dll')						menu=is_m1 where=sys.version>=Win7 and path.exists('@sys.bin\wpccpl.dll')) {
	// %SystemRoot%\System32\PerfCenterCPL.dll,-1
	item(image=inherit
		title='Performance Information and Tools@i_guid'
		tip='Performance Information and Tools'
		cmd=cpl_co[1]  + '{A6F1684D-AED6-401b-9786-A3E3B53C6641}')
	item(image=inherit
		title='Performance Information and Tools (Category view)@i_guid'
		tip='Control Panel\System and Security\Performance Information and Tools@"\n"Control Panel\All Control Panel Items\Performance Information and Tools'
		cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{A6F1684D-AED6-401b-9786-A3E3B53C6641}')
	item(image=inherit
		title='Performance Information and Tools (Icons view)@i_guid'
		tip='All Control Panel Items\Performance Information and Tools'
		cmd=cpl_cm[9]  + '{A6F1684D-AED6-401b-9786-A3E3B53C6641}')
	item(image=inherit
		title='Performance Information and Tools@i_gmix'
		tip='Control Panel\All Control Panel Items\Performance Information and Tools'
		cmd=cpl_cm[10] + '{A6F1684D-AED6-401b-9786-A3E3B53C6641}') }
menu(title='Personalization@L1507'					image=icon.res('@sys.bin\themecpl.dll')						menu=is_m6 where=sys.version>=WinV and path.exists('@sys.bin\themecpl.dll')) {
	item(image=inherit
		title='Personalization@i_guid'
		tip='Personalization'
		cmd=cpl_co[1]  + '{ED834ED6-4B5A-4BFE-8F11-A626DCB6A921}')
	item(image=inherit
		title='Personalization (Category view)@i_guid'
		tip='Control Panel\Appearance and Personalization\Personalization@"\n"Control Panel\All Control Panel Items\Personalization'
		cmd=if(!keys.shift(), cpl_cm[6], cpl_cm[0])+'{ED834ED6-4B5A-4BFE-8F11-A626DCB6A921}')
	item(image=inherit
		title='Personalization (Icons view)@i_guid'
		tip='All Control Panel Items\Personalization'
		cmd=cpl_cm[9]  + '{ED834ED6-4B5A-4BFE-8F11-A626DCB6A921}')
	item(image=inherit
		title='Personalization@i_gmix'
		tip='Control Panel\All Control Panel Items\Personalization'
		cmd=cpl_cm[10] + '{ED834ED6-4B5A-4BFE-8F11-A626DCB6A921}')
	separator()
	menu(image=inherit title='Color and Appearance') {
		item(image=inherit
			title='Color and Appearance@i_guid'
			tip='Personalization\Color and Appearance'
			cmd=cpl_co[1]  + '{ED834ED6-4B5A-4BFE-8F11-A626DCB6A921}\pageColorization')
		item(image=inherit
			title='Color and Appearance (Category view)@i_guid'
			tip='Control Panel\Appearance and Personalization\Personalization\Color and Appearance@"\n"Control Panel\All Control Panel Items\Personalization\Color and Appearance'
			cmd=if(!keys.shift(), cpl_cm[6], cpl_cm[0])+'{ED834ED6-4B5A-4BFE-8F11-A626DCB6A921}\pageColorization')
		item(image=inherit
			title='Color and Appearance (Icons view)@i_guid'
			tip='All Control Panel Items\Personalization\Color and Appearance'
			cmd=cpl_cm[9]  + '{ED834ED6-4B5A-4BFE-8F11-A626DCB6A921}\pageColorization')
		item(image=inherit
			title='Color and Appearance@i_gmix'
			tip='Control Panel\All Control Panel Items\Personalization\Color and Appearance'
			cmd=cpl_cm[10] + '{ED834ED6-4B5A-4BFE-8F11-A626DCB6A921}\pageColorization') }
	menu(image=inherit title='Desktop Background') {
		item(image=inherit
			title='Desktop Background@i_guid'
			tip='Desktop Background'
			cmd=cpl_co[1]  + '{ED834ED6-4B5A-4BFE-8F11-A626DCB6A921}\pageWallpaper')
		item(image=inherit
			title='Desktop Background (Category view)@i_guid'
			tip='Control Panel\Appearance and Personalization\Desktop Background@"\n"Control Panel\All Control Panel Items\Desktop Background'
			cmd=if(!keys.shift(), cpl_cm[6], cpl_cm[0])+'{ED834ED6-4B5A-4BFE-8F11-A626DCB6A921}\pageWallpaper')
		item(image=inherit
			title='Desktop Background (Icons view)@i_guid'
			tip='All Control Panel Items\Desktop Background'
			cmd=cpl_cm[9]  + '{ED834ED6-4B5A-4BFE-8F11-A626DCB6A921}\pageWallpaper')
		item(image=inherit
			title='Desktop Background@i_gmix'
			tip='Control Panel\All Control Panel Items\Desktop Background'
			cmd=cpl_cm[10] + '{ED834ED6-4B5A-4BFE-8F11-A626DCB6A921}\pageWallpaper') } }
menu(title='Phone and Modem@L1507'					image=icon.res('@sys.bin\telephon.cpl', 0)					menu=is_m3 where=sys.version>=Win7 and path.exists('@sys.bin\telephon.cpl')) {
	item(image=inherit
		title='Phone and Modem@i_guid'
		tip='(Panel) Location Information'
		cmd=cpl_co[1]  + '{40419485-C444-4567-851A-2DD7BFA1684D}')
	item(image=inherit
		title='Phone and Modem (Category view)@i_guid'
		tip='(Panel) Location Information@"\n"(Panel) Location Information'
		cmd=if(!keys.shift(), cpl_cm[3], cpl_cm[0])+'{40419485-C444-4567-851A-2DD7BFA1684D}')
	item(image=inherit
		title='Phone and Modem (Icons view)@i_guid'
		tip='(Panel) Location Information'
		cmd=cpl_cm[9]  + '{40419485-C444-4567-851A-2DD7BFA1684D}')
	item(image=inherit
		title='Phone and Modem@i_gmix'
		tip='(Panel) Location Information'
		cmd=cpl_cm[10] + '{40419485-C444-4567-851A-2DD7BFA1684D}') }
menu(title='Power Options@L1507'					image=icon.res('@sys.bin\powercpl.dll')						menu=is_m3 where=sys.version>=WinV and path.exists('@sys.bin\powercpl.dll')) {
	item(image=inherit
		title='Power Options@i_guid'
		tip='Power Options'
		cmd=cpl_co[1]  + '{025A5937-A6BE-4686-A844-36FE4BEC8B6D}')
	item(image=inherit
		title='Power Options (Category view)@i_guid'
		tip='Control Panel\Hardware and Sound\Power Options@"\n"Control Panel\All Control Panel Items\Power Options'
		cmd=if(!keys.shift(), cpl_cm[3], cpl_cm[0])+'{025A5937-A6BE-4686-A844-36FE4BEC8B6D}')
	item(image=inherit
		title='Power Options (Icons view)@i_guid'
		tip='All Control Panel Items\Power Options'
		cmd=cpl_cm[9]  + '{025A5937-A6BE-4686-A844-36FE4BEC8B6D}')
	item(image=inherit
		title='Power Options@i_gmix'
		tip='Control Panel\All Control Panel Items\Power Options'
		cmd=cpl_cm[10] + '{025A5937-A6BE-4686-A844-36FE4BEC8B6D}')
	separator()
	menu(image=inherit title='Power Options System Settings') {
		item(image=inherit
			title='System Settings@i_guid'
			tip='Power Options\System Settings'
			cmd=cpl_co[1]  + '{025A5937-A6BE-4686-A844-36FE4BEC8B6D}\pageGlobalSettings')
		item(image=inherit
			title='System Settings (Category view)@i_guid'
			tip='Control Panel\Hardware and Sound\Power Options\System Settings@"\n"Control Panel\All Control Panel Items\Power Options\System Settings'
			cmd=if(!keys.shift(), cpl_cm[3], cpl_cm[0])+'{025A5937-A6BE-4686-A844-36FE4BEC8B6D}\pageGlobalSettings')
		item(image=inherit
			title='System Settings (Icons view)@i_guid'
			tip='All Control Panel Items\Power Options\System Settings'
			cmd=cpl_cm[9]  + '{025A5937-A6BE-4686-A844-36FE4BEC8B6D}\pageGlobalSettings')
		item(image=inherit
			title='System Settings@i_gmix'
			tip='Control Panel\All Control Panel Items\Power Options\System Settings'
			cmd=cpl_cm[10] + '{025A5937-A6BE-4686-A844-36FE4BEC8B6D}\pageGlobalSettings') }
	menu(image=inherit title='Create a Power Plan') {
		item(image=inherit
			title='Create a Power Plan@i_guid'
			tip='Power Options\Create a Power Plan'
			cmd=cpl_co[1]  + '{025A5937-A6BE-4686-A844-36FE4BEC8B6D}\pageCreateNewPlan')
		item(image=inherit
			title='Create a Power Plan (Category view)@i_guid'
			tip='Control Panel\Hardware and Sound\Power Options\Create a Power Plan@"\n"Control Panel\All Control Panel Items\Power Options\Create a Power Plan'
			cmd=if(!keys.shift(), cpl_cm[3], cpl_cm[0])+'{025A5937-A6BE-4686-A844-36FE4BEC8B6D}\pageCreateNewPlan')
		item(image=inherit
			title='Create a Power Plan (Icons view)@i_guid'
			tip='All Control Panel Items\Power Options\Create a Power Plan'
			cmd=cpl_cm[9]  + '{025A5937-A6BE-4686-A844-36FE4BEC8B6D}\pageCreateNewPlan')
		item(image=inherit
			title='Create a Power Plan@i_gmix'
			tip='Control Panel\All Control Panel Items\Power Options\Create a Power Plan'
			cmd=cpl_cm[10] + '{025A5937-A6BE-4686-A844-36FE4BEC8B6D}\pageCreateNewPlan') }
	menu(image=inherit title='Edit Plan Settings') {
		item(image=inherit
			title='Edit Plan Settings@i_guid'
			tip='Edit Plan Settings'
			cmd=cpl_co[1]  + '{025A5937-A6BE-4686-A844-36FE4BEC8B6D}\pagePlanSettings')
		item(image=inherit
			title='Edit Plan Settings (Category view)@i_guid'
			tip='Control Panel\Hardware and Sound\Power Options\Edit Plan Settings@"\n"Control Panel\All Control Panel Items\Power Options\Edit Plan Settings'
			cmd=if(!keys.shift(), cpl_cm[3], cpl_cm[0])+'{025A5937-A6BE-4686-A844-36FE4BEC8B6D}\pagePlanSettings')
		item(image=inherit
			title='Edit Plan Settings (Icons view)@i_guid'
			tip='All Control Panel Items\Power Options\Edit Plan Settings'
			cmd=cpl_cm[9]  + '{025A5937-A6BE-4686-A844-36FE4BEC8B6D}\pagePlanSettings')
		item(image=inherit
			title='Edit Plan Settings@i_gmix'
			tip='Control Panel\All Control Panel Items\Power Options\Edit Plan Settings'
			cmd=cpl_cm[10] + '{025A5937-A6BE-4686-A844-36FE4BEC8B6D}\pagePlanSettings')
		item(image=inherit
			title='Edit Plan Settings@i_ctrl'
			tip='Control Panel\All Control Panel Items\Power Options\Edit Plan Settings'
			cmd='control.exe' args='/name Microsoft.PowerOptions /page pagePlanSettings') }
	separator()
	menu(title='Power Schemes' image=image.glyph(\uE271, #00FF00)) {
		$ps_default = reg.get('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes', 'ActivePowerScheme')
		item(title='Balanced'			tip='Automatically balances performance with energy consumption on capable hardware.' sep='after'
			image=image.mdl(\uF5F7)		vis=if(ps_default== '381b4222-f694-41f0-9685-ff5bb260df2e', 'disable') cmd-line='/c powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e' window=hidden)
		item(title='Power Saver'		tip='Saves energy by reducing your computer performance where possible.'
			image=image.mdl(\uF5F2)		vis=if(ps_default== 'a1841308-3541-4fab-bc81-f71556f20b4a', 'disable') cmd-line='/c powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a' window=hidden)
		item(title='High Performance'	tip='Favors performance, but may use more energy.'
			image=image.mdl(\uF5FB)		vis=if(ps_default== '8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c', 'disable') cmd-line='/c powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c' window=hidden)
		item(title='Ultimate Performance'	tip='Provides ultimate performance on higher end PCs.'
			image=image.mdl(\uF5FB)		vis=if(ps_default== 'e9a42b02-d5df-448d-aa00-03f14749eb61', 'disable') cmd-line='/c powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61' window=hidden) }
	menu(title='Power Schemes ML' image=image.glyph(\uE271, #00FF00)) {
		$Power_Schemes=reg.values('HKEY_LOCAL_MACHINE\SOFTWARE\@if(sys.is64, 'WOW6432Node\')Microsoft\Windows\CurrentVersion\Applets\SysTray\BattMeter\Flyout')
		$ps_default = reg.get('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes', 'ActivePowerScheme')
		$title_vis=0 // info from .dll (1) or from reg (0)
		$descr_vis=1 // info from .dll (1) or from reg (0)

		$ps0_title_r = reg.get('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes\@Power_Schemes[0]', 'FriendlyName')
		$ps0_title_s = regex.matches(ps0_title_r, '^([^,]*,[^,]*)')
		$ps0_title_a = if(len(ps0_title_s[0])>0 and title_vis, str.res(sys.expand(ps0_title_s[0])), str.trim(str.remove(ps0_title_r, 0, len(ps0_title_s[0])), ','))
		$ps0_descr_r = reg.get('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes\@Power_Schemes[0]', 'Description')
		$ps0_descr_s = regex.matches(ps0_descr_r, '^([^,]*,[^,]*)')
		$ps0_descr_a = if(len(ps0_descr_s[0])>0 and descr_vis, str.res(sys.expand(ps0_descr_s[0])), str.trim(str.remove(ps0_descr_r, 0, len(ps0_descr_s[0])), ','))
		item(title=ps0_title_a tip=ps0_descr_a vis=if(ps_default==Power_Schemes[0], 'disable') cmd-line='/c powercfg /setactive @Power_Schemes[0]' window=hidden)

		$ps1_title_r = reg.get('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes\@Power_Schemes[1]', 'FriendlyName')
		$ps1_title_s = regex.matches(ps1_title_r, '^([^,]*,[^,]*)')
		$ps1_title_a = if(len(ps1_title_s[0])>0 and title_vis, str.res(sys.expand(ps1_title_s[0])), str.trim(str.remove(ps1_title_r, 0, len(ps1_title_s[0])), ','))
		$ps1_descr_r = reg.get('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes\@Power_Schemes[1]', 'Description')
		$ps1_descr_s = regex.matches(ps1_descr_r, '^([^,]*,[^,]*)')
		$ps1_descr_a = if(len(ps1_descr_s[0])>0 and descr_vis, str.res(sys.expand(ps1_descr_s[0])), str.trim(str.remove(ps1_descr_r, 0, len(ps1_descr_s[0])), ','))
		item(title=ps1_title_a tip=ps1_descr_a vis=if(ps_default==Power_Schemes[1], 'disable') cmd-line='/c powercfg /setactive @Power_Schemes[1]' window=hidden)

		$ps2_title_r = reg.get('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes\@Power_Schemes[2]', 'FriendlyName')
		$ps2_title_s = regex.matches(ps2_title_r, '^([^,]*,[^,]*)')
		$ps2_title_a = if(len(ps2_title_s[0])>0 and title_vis, str.res(sys.expand(ps2_title_s[0])), str.trim(str.remove(ps2_title_r, 0, len(ps2_title_s[0])), ','))
		$ps2_descr_r = reg.get('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes\@Power_Schemes[2]', 'Description')
		$ps2_descr_s = regex.matches(ps2_descr_r, '^([^,]*,[^,]*)')
		$ps2_descr_a = if(len(ps2_descr_s[0])>0 and descr_vis, str.res(sys.expand(ps2_descr_s[0])), str.trim(str.remove(ps2_descr_r, 0, len(ps2_descr_s[0])), ','))
		item(title=ps2_title_a tip=ps2_descr_a vis=if(ps_default==Power_Schemes[2], 'disable') cmd-line='/c powercfg /setactive @Power_Schemes[2]' window=hidden) }	}
menu(title='Programs and Features@L1507'			image=icon.res('@sys.bin\appwiz.cpl', 0)					menu=is_m4 where=sys.version>=WinV and path.exists('@sys.bin\appwiz.cpl')) {
	// imageres.dll,-87
	item(image=inherit
		title='Programs and Features@i_guid'
		tip='Programs and Features'
		cmd=cpl_co[1]  + '{7B81BE6A-CE2B-4676-A29E-EB907A5126C5}')
	item(image=inherit
		title='Programs and Features (Category view)@i_guid'
		tip='Control Panel\Programs\Programs and Features@"\n"Control Panel\All Control Panel Items\Programs and Features'
		cmd=if(!keys.shift(), cpl_cm[4], cpl_cm[0])+'{7B81BE6A-CE2B-4676-A29E-EB907A5126C5}')
	item(image=inherit
		title='Programs and Features (Icons view)@i_guid'
		tip='All Control Panel Items\Programs and Features'
		cmd=cpl_cm[9]  + '{7B81BE6A-CE2B-4676-A29E-EB907A5126C5}')
	item(image=inherit
		title='Programs and Features@i_gmix'
		tip='Control Panel\All Control Panel Items\Programs and Features'
		cmd=cpl_cm[10] + '{7B81BE6A-CE2B-4676-A29E-EB907A5126C5}')
	separator()
	item(image=inherit
		title='Programs and Features@i_name'
		tip='Control Panel\All Control Panel Items\Programs and Features'
		cmd=cpl_co[0]  + 'ChangeRemoveProgramsFolder')
	separator()
	menu(image=inherit title='Installed Updates [R]') {
		item(image=inherit
			title='Installed Updates@i_guid'
			tip='Programs and Features\Installed Updates'
			cmd=cpl_co[1]  + '{7B81BE6A-CE2B-4676-A29E-EB907A5126C5}\::{D450A8A1-9568-45C7-9C0E-B4F9FB4537BD}')
		item(image=inherit
			title='Installed Updates (Category view)@i_guid'
			tip='Control Panel\Hardware and Sound\Programs and Features\Installed Updates@"\n"Control Panel\All Control Panel Items\Programs and Features\Installed Updates'
			cmd=if(!keys.shift(), cpl_cm[4], cpl_cm[0])+'{7B81BE6A-CE2B-4676-A29E-EB907A5126C5}\::{D450A8A1-9568-45C7-9C0E-B4F9FB4537BD}')
		item(image=inherit
			title='Installed Updates (Icons view)@i_guid'
			tip='All Control Panel Items\Programs and Features\Installed Updates'
			cmd=cpl_cm[9]  + '{7B81BE6A-CE2B-4676-A29E-EB907A5126C5}\::{D450A8A1-9568-45C7-9C0E-B4F9FB4537BD}')
		item(image=inherit
			title='Installed Updates@i_gmix'
			tip='Control Panel\All Control Panel Items\Programs and Features\Installed Updates'
			cmd=cpl_cm[10] + '{7B81BE6A-CE2B-4676-A29E-EB907A5126C5}\::{D450A8A1-9568-45C7-9C0E-B4F9FB4537BD}') }
	menu(image=icon.res('@sys.bin\appwiz.cpl', 2) title='Windows Feature' ) {
		item(image=inherit
			title='Windows Feature@i_guid'
			tip='(Panel) Windows Feature'
			cmd=cpl_co[1]  + '{67718415-c450-4f3c-bf8a-b487642dc39b}')
		item(image=inherit
			title='Windows Feature (Category view)@i_guid'
			tip='(Panel) Windows Feature@"\n"(Panel) Windows Feature'
			cmd=if(!keys.shift(), cpl_cm[4], cpl_cm[0])+'{67718415-c450-4f3c-bf8a-b487642dc39b}')
		item(image=inherit
			title='Windows Feature (Icons view)@i_guid'
			tip='(Panel) Windows Feature'
			cmd=cpl_cm[9]  + '{67718415-c450-4f3c-bf8a-b487642dc39b}')
		item(image=inherit vis='disable'
			title='Windows Feature@i_gmix'
			tip='(Panel) Windows Feature'
			cmd=cpl_cm[10] + '{67718415-c450-4f3c-bf8a-b487642dc39b}')
			separator()
		item(image=inherit
			title='Windows Feature@i_rdll'
			cmd='rundll32.exe' args='shell32.dll,Control_RunDLL appwiz.cpl,,2') }}
menu(title='Recovery@L1507'							image=icon.res('@sys.bin\imageres.dll', -1022)				menu=is_m1 where=sys.version>=Win7 and path.exists('@sys.bin\recovery.dll')) {
	item(image=inherit
		title='Recovery@i_guid'
		tip='Recovery'
		cmd=cpl_co[1]  + '{9FE63AFD-59CF-4419-9775-ABCC3849F861}')
	item(image=inherit
		title='Recovery (Category view)@i_guid'
		tip='Control Panel\System and Security\Recovery@"\n"Control Panel\All Control Panel Items\Recovery'
		cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{9FE63AFD-59CF-4419-9775-ABCC3849F861}')
	item(image=inherit
		title='Recovery (Icons view)@i_guid'
		tip='All Control Panel Items\Recovery'
		cmd=cpl_cm[9]  + '{9FE63AFD-59CF-4419-9775-ABCC3849F861}')
	item(image=inherit
		title='Recovery@i_gmix'
		tip='Control Panel\All Control Panel Items\Recovery'
		cmd=cpl_cm[10] + '{9FE63AFD-59CF-4419-9775-ABCC3849F861}') }
menu(title='Region@L1507'							image=icon.res('@sys.bin\intl.cpl', 0)						menu=is_m7 where=sys.version>=Win7 and path.exists('@sys.bin\intl.cpl')) {
	item(image=inherit
		title='Region@i_guid'
		tip='(Panel) Region'
		cmd=cpl_co[1]  + '{62D8ED13-C9D0-4CE8-A914-47DD628FB1B0}')
	item(image=inherit
		title='Region (Category view)@i_guid'
		tip='(Panel) Region@"\n"(Panel) Region'
		cmd=if(!keys.shift(), cpl_cm[7], cpl_cm[0])+'{62D8ED13-C9D0-4CE8-A914-47DD628FB1B0}')
	item(image=inherit
		title='Region (Icons view)@i_guid'
		tip='(Panel) Region'
		cmd=cpl_cm[9]  + '{62D8ED13-C9D0-4CE8-A914-47DD628FB1B0}')
	item(image=inherit
		title='Region@i_gmix'
		tip='(Panel) Region'
		cmd=cpl_cm[10] + '{62D8ED13-C9D0-4CE8-A914-47DD628FB1B0}') }
menu(title='RemoteApp and Desktop Connections@L1507'image=icon.res('@sys.bin\tsworkspace.dll')					menu=is_m1 where=sys.version>=Win7 and path.exists('@sys.bin\tsworkspace.dll')) {
	item(image=inherit
		title='RemoteApp and Desktop Connections@i_guid'
		tip='RemoteApp and Desktop Connections'
		cmd=cpl_co[1]  + '{241D7C96-F8BF-4F85-B01F-E2B043341A4B}')
	item(image=inherit
		title='RemoteApp and Desktop Connections (Category view)@i_guid'
		tip='Control Panel\System and Security\RemoteApp and Desktop Connections@"\n"Control Panel\All Control Panel Items\RemoteApp and Desktop Connections'
		cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{241D7C96-F8BF-4F85-B01F-E2B043341A4B}')
	item(image=inherit
		title='RemoteApp and Desktop Connections (Icons view)@i_guid'
		tip='All Control Panel Items\RemoteApp and Desktop Connections'
		cmd=cpl_cm[9]  + '{241D7C96-F8BF-4F85-B01F-E2B043341A4B}')
	item(image=inherit
		title='RemoteApp and Desktop Connections@i_gmix'
		tip='Control Panel\All Control Panel Items\RemoteApp and Desktop Connections'
		cmd=cpl_cm[10] + '{241D7C96-F8BF-4F85-B01F-E2B043341A4B}')
	separator()
	menu(image=inherit title='Connection Properties [!]') {
		item(image=inherit
			title='Connection Properties@i_guid'
			tip='RemoteApp and Desktop Connections\Properties'
			cmd=cpl_co[1]  + '{241D7C96-F8BF-4F85-B01F-E2B043341A4B}\PropertiesPage')
		item(image=inherit
			title='Connection Properties (Category view)@i_guid'
			tip='Control Panel\System and Security\RemoteApp and Desktop Connections\Properties@"\n"Control Panel\All Control Panel Items\RemoteApp and Desktop Connections\Properties'
			cmd=if(!keys.shift(), cpl_cm[3], cpl_cm[0])+'{241D7C96-F8BF-4F85-B01F-E2B043341A4B}\PropertiesPage')
		item(image=inherit
			title='Connection Properties (Icons view)@i_guid'
			tip='All Control Panel Items\RemoteApp and Desktop Connections\Properties'
			cmd=cpl_cm[9]  + '{241D7C96-F8BF-4F85-B01F-E2B043341A4B}\PropertiesPage')
		item(image=inherit
			title='Connection Properties@i_gmix'
			tip='Control Panel\All Control Panel Items\RemoteApp and Desktop Connections\Properties'
			cmd=cpl_cm[10] + '{241D7C96-F8BF-4F85-B01F-E2B043341A4B}\PropertiesPage') }}
menu(title='Security and Maintenance@L1507'			image=icon.res('@sys.bin\ActionCenterCPL.dll')				menu=is_m1 where=sys.version>=Win7 and path.exists('@sys.bin\ActionCenterCPL.dll')) {
	// https://learn.microsoft.com/en-us/windows/win32/shell/controlpanel-canonical-names#action-center
	// Security and Maintenance (From Win10 1507)| Action Center (up to Win8.1)
	// if(sys.version>=win10_1507, 'Security and Maintenance', 'Action Center')
	item(image=inherit
		title='Security and Maintenance@i_guid'
		tip='Security and Maintenance'
		cmd=cpl_co[1]  + '{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}')
	item(image=inherit
		title='Security and Maintenance (Category view)@i_guid'
		tip='Control Panel\System and Security\Security and Maintenance@"\n"Control Panel\All Control Panel Items\Security and Maintenance'
		cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}')
	item(image=inherit
		title='Security and Maintenance (Icons view)@i_guid'
		tip='All Control Panel Items\Security and Maintenance'
		cmd=cpl_cm[9]  + '{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}')
	item(image=inherit
		title='Security and Maintenance@i_gmix'
		tip='Control Panel\All Control Panel Items\Security and Maintenance'
		cmd=cpl_cm[10] + '{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}')
	separator()
	menu(image=inherit title='Automatic Maintenance') {
		item(image=inherit
			title='Automatic Maintenance@i_guid'
			tip='Security and Maintenance\Automatic Maintenance'
			cmd=cpl_co[1]  + '{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}\MaintenanceSettings')
		item(image=inherit
			title='Automatic Maintenance (Category view)@i_guid'
			tip='Control Panel\System and Security\Security and Maintenance\Automatic Maintenance@"\n"Control Panel\All Control Panel Items\Security and Maintenance\Automatic Maintenance'
			cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}\MaintenanceSettings')
		item(image=inherit
			title='Automatic Maintenance (Icons view)@i_guid'
			tip='All Control Panel Items\Security and Maintenance\Automatic Maintenance'
			cmd=cpl_cm[9]  + '{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}\MaintenanceSettings')
		item(image=inherit
			title='Automatic Maintenance@i_gmix'
			tip='Control Panel\All Control Panel Items\Security and Maintenance\Automatic Maintenance'
			cmd=cpl_cm[10] + '{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}\MaintenanceSettings') }
	menu(image=inherit title='Advanced Problem Reporting Settings [!]') {
		item(image=inherit
			title='Advanced Problem Reporting Settings@i_guid'
			tip='Security and Maintenance\Advanced Problem Reporting Settings'
			cmd=cpl_co[1]  + '{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}\pageAdvSettings')
		item(image=inherit
			title='Advanced Problem Reporting Settings (Category view)@i_guid'
			tip='Control Panel\System and Security\Security and Maintenance\Advanced Problem Reporting Settings@"\n"Control Panel\All Control Panel Items\Security and Maintenance\Advanced Problem Reporting Settings'
			cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}\pageAdvSettings')
		item(image=inherit
			title='Advanced Problem Reporting Settings (Icons view)@i_guid'
			tip='All Control Panel Items\Security and Maintenance\Advanced Problem Reporting Settings'
			cmd=cpl_cm[9]  + '{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}\pageAdvSettings')
		item(image=inherit
			title='Advanced Problem Reporting Settings@i_gmix'
			tip='Control Panel\All Control Panel Items\Security and Maintenance\Advanced Problem Reporting Settings'
			cmd=cpl_cm[10] + '{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}\pageAdvSettings') }
	menu(image=inherit title='Problem Reports') {
		item(image=inherit
			title='Problem Reports@i_guid'
			tip='Security and Maintenance\Problem Reports'
			cmd=cpl_co[1]  + '{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}\pageProblems')
		item(image=inherit
			title='Problem Reports (Category view)@i_guid'
			tip='Control Panel\System and Security\Security and Maintenance\Problem Reports@"\n"Control Panel\All Control Panel Items\Security and Maintenance\Problem Reports'
			cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}\pageProblems')
		item(image=inherit
			title='Problem Reports (Icons view)@i_guid'
			tip='All Control Panel Items\Security and Maintenance\Problem Reports'
			cmd=cpl_cm[9]  + '{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}\pageProblems')
		item(image=inherit
			title='Problem Reports@i_gmix'
			tip='Control Panel\All Control Panel Items\Security and Maintenance\Problem Reports'
			cmd=cpl_cm[10] + '{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}\pageProblems') }
	menu(image=inherit title='Reliability Monitor') {
		item(image=inherit
			title='Reliability Monitor@i_guid'
			tip='Security and Maintenance\Reliability Monitor'
			cmd=cpl_co[1]  + '{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}\pageReliabilityView')
		item(image=inherit
			title='Reliability Monitor (Category view)@i_guid'
			tip='Control Panel\System and Security\Security and Maintenance\Reliability Monitor@"\n"Control Panel\All Control Panel Items\Security and Maintenance\Reliability Monitor'
			cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}\pageReliabilityView')
		item(image=inherit
			title='Reliability Monitor (Icons view)@i_guid'
			tip='All Control Panel Items\Security and Maintenance\Reliability Monitor'
			cmd=cpl_cm[9]  + '{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}\pageReliabilityView')
		item(image=inherit
			title='Reliability Monitor@i_gmix'
			tip='Control Panel\All Control Panel Items\Security and Maintenance\Reliability Monitor'
			cmd=cpl_cm[10] + '{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}\pageReliabilityView') }
	menu(image=inherit title='Problem Details') {
		item(image=inherit
			title='Problem Details@i_guid'
			tip='Security and Maintenance\Problem Details'
			cmd=cpl_co[1]  + '{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}\pageReportDetails')
		item(image=inherit
			title='Problem Details (Category view)@i_guid'
			tip='Control Panel\System and Security\Security and Maintenance\Problem Details@"\n"Control Panel\All Control Panel Items\Security and Maintenance\Problem Details'
			cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}\pageReportDetails')
		item(image=inherit
			title='Problem Details (Icons view)@i_guid'
			tip='All Control Panel Items\Security and Maintenance\Problem Details'
			cmd=cpl_cm[9]  + '{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}\pageReportDetails')
		item(image=inherit
			title='Problem Details@i_gmix'
			tip='Control Panel\All Control Panel Items\Security and Maintenance\Problem Details'
			cmd=cpl_cm[10] + '{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}\pageReportDetails') }
	menu(image=inherit title='Problem Reporting Settings') {
		item(image=inherit
			title='Problem Reporting Settings@i_guid'
			tip='Security and Maintenance\Problem Reporting Settings'
			cmd=cpl_co[1]  + '{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}\pageSettings')
		item(image=inherit
			title='Problem Reporting Settings (Category view)@i_guid'
			tip='Control Panel\System and Security\Security and Maintenance\Problem Reporting Settings@"\n"Control Panel\All Control Panel Items\Security and Maintenance\Problem Reporting Settings'
			cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}\pageSettings')
		item(image=inherit
			title='Problem Reporting Settings (Icons view)@i_guid'
			tip='All Control Panel Items\Security and Maintenance\Problem Reporting Settings'
			cmd=cpl_cm[9]  + '{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}\pageSettings')
		item(image=inherit
			title='Problem Reporting Settings@i_gmix'
			tip='Control Panel\All Control Panel Items\Security and Maintenance\Problem Reporting Settings'
			cmd=cpl_cm[10] + '{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}\pageSettings') }
	menu(image=inherit title='Change Security and Maintenance settings') {
		item(image=inherit
			title='Change Security and Maintenance settings@i_guid'
			tip='Security and Maintenance\Change Security and Maintenance settings'
			cmd=cpl_co[1]  + '{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}\Settings')
		item(image=inherit
			title='Change Security and Maintenance settings (Category view)@i_guid'
			tip='Control Panel\System and Security\Security and Maintenance\Change Security and Maintenance settings@"\n"Control Panel\All Control Panel Items\Security and Maintenance\Change Security and Maintenance settings'
			cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}\Settings')
		item(image=inherit
			title='Change Security and Maintenance settings (Icons view)@i_guid'
			tip='All Control Panel Items\Security and Maintenance\Change Security and Maintenance settings'
			cmd=cpl_cm[9]  + '{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}\Settings')
		item(image=inherit
			title='Change Security and Maintenance settings@i_gmix'
			tip='Control Panel\All Control Panel Items\Security and Maintenance\Change Security and Maintenance settings'
			cmd=cpl_cm[10] + '{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}\Settings') }}

menu(title='Sound@L1507'							image=icon.res('@sys.bin\mmsys.cpl', 0)						menu=is_m3 where=sys.version>=Win7 and path.exists('@sys.bin\mmsys.cpl')) {
	item(image=inherit
		title='Sound@i_guid'
		tip='(Panel) Sound'
		cmd=cpl_co[1]  + '{F2DDFC82-8F12-4CDD-B7DC-D4FE1425AA4D}')
	item(image=inherit
		title='Sound (Category view)@i_guid'
		tip='(Panel) Sound@"\n"(Panel) Sound'
		cmd=if(!keys.shift(), cpl_cm[3], cpl_cm[0])+'{F2DDFC82-8F12-4CDD-B7DC-D4FE1425AA4D}')
	item(image=inherit
		title='Sound (Icons view)@i_guid'
		tip='(Panel) Sound'
		cmd=cpl_cm[9]  + '{F2DDFC82-8F12-4CDD-B7DC-D4FE1425AA4D}')
	item(image=inherit
		title='Sound@i_gmix'
		tip='(Panel) Sound'
		cmd=cpl_cm[10] + '{F2DDFC82-8F12-4CDD-B7DC-D4FE1425AA4D}')
		separator()
	item(title='Sound Volume' image=image.fluent(\uE992) image-sel=image.fluent(\uE995) cmd='sndvol')
	item(title='Sound Output' keys='Win+Ctrl+V' where=sys.is11 image=image.fluent(\uE994) cmd=keys.send(key.win, key.ctrl, "V")) }
menu(title='Speech Recognition@L1507'				image=icon.res('@sys.bin\Speech\SpeechUX\speechuxcpl.dll')	menu=is_m8 where=sys.version>=Win7 and path.exists('@sys.bin\Speech\SpeechUX\speechuxcpl.dll')) {
	item(image=inherit
		title='Speech Recognition@i_guid'
		tip='Speech Recognition'
		cmd=cpl_co[1]  + '{58E3C745-D971-4081-9034-86E34B30836A}')
	item(image=inherit
		title='Speech Recognition (Category view)@i_guid'
		tip='Control Panel\Ease of Access\Speech Recognition@"\n"Control Panel\All Control Panel Items\Speech Recognition'
		cmd=if(!keys.shift(), cpl_cm[8], cpl_cm[0])+'{58E3C745-D971-4081-9034-86E34B30836A}')
	item(image=inherit
		title='Speech Recognition (Icons view)@i_guid'
		tip='All Control Panel Items\Speech Recognition'
		cmd=cpl_cm[9]  + '{58E3C745-D971-4081-9034-86E34B30836A}')
	item(image=inherit
		title='Speech Recognition@i_gmix'
		tip='Control Panel\All Control Panel Items\Speech Recognition'
		cmd=cpl_cm[10] + '{58E3C745-D971-4081-9034-86E34B30836A}')
	separator()
	menu(image='' title='Speech Properties (Text to Speech)' ) {
		item(image=inherit
			title='Speech Properties (Text to Speech)@i_guid'
			tip='(Panel) Speech Properties (Text to Speech)'
			cmd=cpl_co[1]  + '{D17D1D6D-CC3F-4815-8FE3-607E7D5D10B3}')
		item(image=inherit
			title='Speech Properties (Text to Speech) (Category view)@i_guid'
			tip='(Panel) Speech Properties (Text to Speech)@"\n"(Panel) Speech Properties (Text to Speech)'
			cmd=if(!keys.shift(), cpl_cm[8], cpl_cm[0])+'{D17D1D6D-CC3F-4815-8FE3-607E7D5D10B3}')
		item(image=inherit
			title='Speech Properties (Text to Speech) (Icons view)@i_guid'
			tip='(Panel) Speech Properties (Text to Speech)'
			cmd=cpl_cm[9]  + '{D17D1D6D-CC3F-4815-8FE3-607E7D5D10B3}')
		item(image=inherit
			title='Speech Properties (Text to Speech)@i_gmix'
			tip='(Panel) Speech Properties (Text to Speech)'
			cmd=cpl_cm[10] + '{D17D1D6D-CC3F-4815-8FE3-607E7D5D10B3}') }}
menu(title='Storage Spaces@L1507'					image=icon.res('@sys.bin\SpaceControl.dll')					menu=is_m1 where=sys.version>=Win8 and path.exists('@sys.bin\SpaceControl.dll')) {
	item(image=inherit
		title='Storage Spaces@i_guid'
		tip='Storage Spaces'
		cmd=cpl_co[1]  + '{F942C606-0914-47AB-BE56-1321B8035096}')
	item(image=inherit
		title='Storage Spaces (Category view)@i_guid'
		tip='Control Panel\System and Security\Storage Spaces@"\n"Control Panel\All Control Panel Items\Storage Spaces'
		cmd=if(!keys.shift(), cpl_cm[8], cpl_cm[0])+'{F942C606-0914-47AB-BE56-1321B8035096}')
	item(image=inherit
		title='Storage Spaces (Icons view)@i_guid'
		tip='All Control Panel Items\Storage Spaces'
		cmd=cpl_cm[9]  + '{F942C606-0914-47AB-BE56-1321B8035096}')
	item(image=inherit
		title='Storage Spaces@i_gmix'
		tip='Control Panel\All Control Panel Items\Storage Spaces'
		cmd=cpl_cm[10] + '{F942C606-0914-47AB-BE56-1321B8035096}') }
menu(title='Sync Center@L1507'						image=icon.res('@sys.bin\SyncCenter.dll')					menu=is_m3 where=sys.version>=WinV and path.exists('@sys.bin\SyncCenter.dll')) {
	item(image=inherit
		title='Sync Center@i_guid'
		tip='Sync Center'
		cmd=cpl_co[1]  + '{9C73F5E5-7AE7-4E32-A8E8-8D23B85255BF}')
	item(image=inherit
		title='Sync Center (Category view)@i_guid'
		tip='Control Panel\Hardware and Sound\Sync Center@"\n"Control Panel\All Control Panel Items\Sync Center'
		cmd=if(!keys.shift(), cpl_cm[3], cpl_cm[0])+'{9C73F5E5-7AE7-4E32-A8E8-8D23B85255BF}')
	item(image=inherit
		title='Sync Center (Icons view)@i_guid'
		tip='All Control Panel Items\Sync Center'
		cmd=cpl_cm[9]  + '{9C73F5E5-7AE7-4E32-A8E8-8D23B85255BF}')
	item(image=inherit
		title='Sync Center@i_gmix'
		tip='Control Panel\All Control Panel Items\Sync Center'
		cmd=cpl_cm[10] + '{9C73F5E5-7AE7-4E32-A8E8-8D23B85255BF}')
	separator()
	item(image=inherit
		title='Sync Center@i_name'
		tip='Control Panel\All Control Panel Items\Sync Center'
		cmd=cpl_co[0]  + 'SyncCenterFolder')
	separator()
	menu(image=inherit title='Conflicts') {
		item(image=inherit
			title='Conflicts@i_name'
			tip='Control Panel\All Control Panel Items\Sync Center\Conflicts'
			cmd=cpl_co[0]  + 'ConflictFolder') }
	menu(image=inherit title='Sync Results') {
		item(image=inherit
			title='Sync Results@i_name'
			tip='Control Panel\All Control Panel Items\Sync Center\Sync Results'
			cmd=cpl_co[0]  + 'SyncResultsFolder') }
	menu(image=inherit title='Sync Setup') {
		item(image=inherit
			title='Sync Setup@i_guid'
			tip='Sync Center\Sync Setup'
			cmd=cpl_co[1]  + '{9C73F5E5-7AE7-4E32-A8E8-8D23B85255BF}\::{F1390A9A-A3F4-4E5D-9C5F-98F3BD8D935C}')
		item(image=inherit
			title='Sync Setup (Category view)@i_guid'
			tip='Control Panel\Hardware and Sound\Sync Center\Sync Setup@"\n"Control Panel\All Control Panel Items\Sync Center\Sync Setup'
			cmd=if(!keys.shift(), cpl_cm[3], cpl_cm[0])+'{9C73F5E5-7AE7-4E32-A8E8-8D23B85255BF}\::{F1390A9A-A3F4-4E5D-9C5F-98F3BD8D935C}')
		item(image=inherit
			title='Sync Setup (Icons view)@i_guid'
			tip='All Control Panel Items\Sync Center\Sync Setup'
			cmd=cpl_cm[9]  + '{9C73F5E5-7AE7-4E32-A8E8-8D23B85255BF}\::{F1390A9A-A3F4-4E5D-9C5F-98F3BD8D935C}')
		item(image=inherit
			title='Sync Setup@i_gmix'
			tip='Control Panel\All Control Panel Items\Sync Center\Sync Setup'
			cmd=cpl_cm[10] + '{9C73F5E5-7AE7-4E32-A8E8-8D23B85255BF}\::{F1390A9A-A3F4-4E5D-9C5F-98F3BD8D935C}')
		separator()
		item(image=inherit
			title='Sync Setup@i_name'
			tip='Control Panel\All Control Panel Items\Sync Center\Sync Setup'
			cmd=cpl_co[0]  + 'SyncSetupFolder')
		separator()
		item(image=inherit
			title='Sync Setup Folder@i_guid'
			tip='Sync Setup Folder'
			cmd=cpl_co[1]  + '{2E9E59C0-B437-4981-A647-9C34B9B90891}')
		item(image=inherit
			title='Sync Setup Folder (Category view)@i_guid'
			tip='Control Panel\Hardware and Sound\Sync Setup Folder@"\n"Control Panel\All Control Panel Items\Sync Center\Sync Setup Folder'
			cmd=if(!keys.shift(), cpl_cm[3], cpl_cm[0])+'{2E9E59C0-B437-4981-A647-9C34B9B90891}')
		item(image=inherit
			title='Sync Setup Folder (Icons view)@i_guid'
			tip='All Control Panel Items\Sync Setup Folder'
			cmd=cpl_cm[9]  + '{2E9E59C0-B437-4981-A647-9C34B9B90891}')
		item(image=inherit vis='disable'
			title='Sync Setup Folder@i_gmix'
			tip='Control Panel\All Control Panel Items\Sync Setup Folder'
			cmd=cpl_cm[10] + '{2E9E59C0-B437-4981-A647-9C34B9B90891}') }}
menu(title='System [R]@L1507'						image=icon.res('@sys.bin\imageres.dll', 143) /*-149*/		menu=is_m1 where=sys.version>=WinV and path.exists('@sys.bin\systemcpl.dll')) {
	// From Win10 20H2 it will be moved to the bottom so it will be hidden
	item(image=inherit
		title='System@i_guid'
		tip='System'
		cmd=cpl_co[1]  + '{BB06C0E4-D293-4F75-8A90-CB05B6477EEE}')
	item(image=inherit
		title='System (Category view)@i_guid'
		tip='Control Panel\System and Security\System@"\n"Control Panel\All Control Panel Items\System'
		cmd=if(!keys.shift(), cpl_cm[8], cpl_cm[0])+'{BB06C0E4-D293-4F75-8A90-CB05B6477EEE}')
	item(image=inherit
		title='System (Icons view)@i_guid'
		tip='All Control Panel Items\System'
		cmd=cpl_cm[9]  + '{BB06C0E4-D293-4F75-8A90-CB05B6477EEE}')
	item(image=inherit
		title='System@i_gmix'
		tip='Control Panel\All Control Panel Items\System'
		cmd=cpl_cm[10] + '{BB06C0E4-D293-4F75-8A90-CB05B6477EEE}') }
menu(title='Tablet PC Settings@L1507'				image=icon.res('@sys.bin\tabletpc.cpl', 0)					menu=is_m3 where=sys.version>=WinV and path.exists('@sys.bin\tabletpc.cpl')) {
	item(image=inherit
		title='Tablet PC Settings@i_guid'
		tip='(Panel) Tablet PC Settings'
		cmd=cpl_co[1]  + '{80F3F1D5-FECA-45F3-BC32-752C152E456E}')
	item(image=inherit
		title='Tablet PC Settings (Category view)@i_guid'
		tip='(Panel) Tablet PC Settings@"\n"(Panel) Tablet PC Settings'
		cmd=if(!keys.shift(), cpl_cm[3], cpl_cm[0])+'{80F3F1D5-FECA-45F3-BC32-752C152E456E}')
	item(image=inherit
		title='Tablet PC Settings (Icons view)@i_guid'
		tip='(Panel) Tablet PC Settings'
		cmd=cpl_cm[9]  + '{80F3F1D5-FECA-45F3-BC32-752C152E456E}')
	item(image=inherit
		title='Tablet PC Settings@i_gmix'
		tip='(Panel) Tablet PC Settings'
		cmd=cpl_cm[10] + '{80F3F1D5-FECA-45F3-BC32-752C152E456E}') }
menu(title='Taskbar and Navigation [R]@L1507'		image=icon.res('@sys.bin\imageres.dll', 75) /*-80*/			menu=is_m6 where=sys.version>=Win8) {
	item(image=inherit
		title='Taskbar and Navigation@i_guid'
		tip='(Panel) Taskbar and Navigation'
		cmd=cpl_co[1]  + '{0DF44EAA-FF21-4412-828E-260A8728E7F1}')
	item(image=inherit
		title='Taskbar and Navigation (Category view)@i_guid'
		tip='(Panel) Taskbar and Navigation@"\n"(Panel) Taskbar and Navigation'
		cmd=if(!keys.shift(), cpl_cm[6], cpl_cm[0])+'{0DF44EAA-FF21-4412-828E-260A8728E7F1}')
	item(image=inherit
		title='Taskbar and Navigation (Icons view)@i_guid'
		tip='(Panel) Taskbar and Navigation'
		cmd=cpl_cm[9]  + '{0DF44EAA-FF21-4412-828E-260A8728E7F1}')
	item(image=inherit
		title='Taskbar and Navigation@i_gmix'
		tip='(Panel) Taskbar and Navigation'
		cmd=cpl_cm[10] + '{0DF44EAA-FF21-4412-828E-260A8728E7F1}') }
menu(title='Text Services and Input Languages'		image=icon.res('@sys.bin\input.dll')			menu=is_m7 where=sys.version>=Win7) {
	// https://www.tenforums.com/tutorials/103101-create-text-services-input-languages-shortcut-windows.html
	item(image=inherit
		title='Text Services and Input Languages@i_rdll'
		tip='(Panel) Text Services and Input Languages'
		cmd='rundll32.exe' args='Shell32.dll,Control_RunDLL input.dll,,{C07337D3-DB2C-4D0B-9A93-B722A6C106E2}') }
menu(title='Troubleshootin [R]@L1507'				image=icon.res('@sys.bin\DiagCpl.dll')						menu=is_m1 where=sys.version>=Win7 and path.exists('@sys.bin\DiagCpl.dll')) {
	item(image=inherit
		title='Troubleshooting@i_guid'
		tip='Troubleshooting'
		cmd=cpl_co[1]  + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}')
	item(image=inherit
		title='Troubleshooting (Category view)@i_guid'
		tip='Control Panel\System and Security\Troubleshooting@"\n"Control Panel\All Control Panel Items\Troubleshooting'
		cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}')
	item(image=inherit
		title='Troubleshooting (Icons view)@i_guid'
		tip='All Control Panel Items\Troubleshooting'
		cmd=cpl_cm[9]  + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}')
	item(image=inherit
		title='Troubleshooting@i_gmix'
		tip='Control Panel\All Control Panel Items\Troubleshooting'
		cmd=cpl_cm[10] + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}')
	separator()
	menu(image=inherit title='Programs') {
		item(image=inherit
			title='Programs@i_guid'
			tip='Troubleshooting\Programs'
			cmd=cpl_co[1]  + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\applications')
		item(image=inherit
			title='Programs (Category view)@i_guid'
			tip='Control Panel\Hardware and Sound\Troubleshooting\Programs@"\n"Control Panel\All Control Panel Items\Troubleshooting\Programs'
			cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\applications')
		item(image=inherit
			title='Programs (Icons view)@i_guid'
			tip='All Control Panel Items\Troubleshooting\Programs'
			cmd=cpl_cm[9]  + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\applications')
		item(image=inherit
			title='Programs@i_gmix'
			tip='Control Panel\All Control Panel Items\Troubleshooting\Programs'
			cmd=cpl_cm[10] + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\applications') }
	menu(image=inherit title='Hardware and Sound') {
		item(image=inherit
			title='Hardware and Sound@i_guid'
			tip='Troubleshooting\Hardware and Sound'
			cmd=cpl_co[1]  + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\devices')
		item(image=inherit
			title='Hardware and Sound (Category view)@i_guid'
			tip='Control Panel\Hardware and Sound\Troubleshooting\Hardware and Sound@"\n"Control Panel\All Control Panel Items\Troubleshooting\Hardware and Sound'
			cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\devices')
		item(image=inherit
			title='Hardware and Sound (Icons view)@i_guid'
			tip='All Control Panel Items\Troubleshooting\Hardware and Sound'
			cmd=cpl_cm[9]  + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\devices')
		item(image=inherit
			title='Hardware and Sound@i_gmix'
			tip='Control Panel\All Control Panel Items\Troubleshooting\Hardware and Sound'
			cmd=cpl_cm[10] + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\devices') }
	menu(image=inherit title='Network and Internet') {
		item(image=inherit
			title='Network and Internet@i_guid'
			tip='Troubleshooting\Network and Internet'
			cmd=cpl_co[1]  + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\network')
		item(image=inherit
			title='Network and Internet (Category view)@i_guid'
			tip='Control Panel\Hardware and Sound\Troubleshooting\Network and Internet@"\n"Control Panel\All Control Panel Items\Troubleshooting\Network and Internet'
			cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\network')
		item(image=inherit
			title='Network and Internet (Icons view)@i_guid'
			tip='All Control Panel Items\Troubleshooting\Network and Internet'
			cmd=cpl_cm[9]  + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\network')
		item(image=inherit
			title='Network and Internet@i_gmix'
			tip='Control Panel\All Control Panel Items\Troubleshooting\Network and Internet'
			cmd=cpl_cm[10] + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\network') }
	menu(image=inherit title='System and Security') {
		item(image=inherit
			title='System and Security@i_guid'
			tip='Troubleshooting\System and Security'
			cmd=cpl_co[1]  + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\system')
		item(image=inherit
			title='System and Security (Category view)@i_guid'
			tip='Control Panel\Hardware and Sound\Troubleshooting\System and Security@"\n"Control Panel\All Control Panel Items\Troubleshooting\System and Security'
			cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\system')
		item(image=inherit
			title='System and Security (Icons view)@i_guid'
			tip='All Control Panel Items\Troubleshooting\System and Security'
			cmd=cpl_cm[9]  + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\system')
		item(image=inherit
			title='System and Security@i_gmix'
			tip='Control Panel\All Control Panel Items\Troubleshooting\System and Security'
			cmd=cpl_cm[10] + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\system') }
	menu(image=inherit title='History') {
		item(image=inherit
			title='History@i_guid'
			tip='Troubleshooting\History'
			cmd=cpl_co[1]  + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\historyPage')
		item(image=inherit
			title='History (Category view)@i_guid'
			tip='Control Panel\Hardware and Sound\Troubleshooting\History@"\n"Control Panel\All Control Panel Items\Troubleshooting\History'
			cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\historyPage')
		item(image=inherit
			title='History (Icons view)@i_guid'
			tip='All Control Panel Items\Troubleshooting\History'
			cmd=cpl_cm[9]  + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\historyPage')
		item(image=inherit
			title='History@i_gmix'
			tip='Control Panel\All Control Panel Items\Troubleshooting\History'
			cmd=cpl_cm[10] + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\historyPage') }
	menu(image=inherit title='Settings') {
		item(image=inherit
			title='Settings@i_guid'
			tip='Troubleshooting\Settings'
			cmd=cpl_co[1]  + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\settingPage')
		item(image=inherit
			title='Settings (Category view)@i_guid'
			tip='Control Panel\Hardware and Sound\Troubleshooting\Settings@"\n"Control Panel\All Control Panel Items\Troubleshooting\Settings'
			cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\settingPage')
		item(image=inherit
			title='Settings (Icons view)@i_guid'
			tip='All Control Panel Items\Troubleshooting\Settings'
			cmd=cpl_cm[9]  + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\settingPage')
		item(image=inherit
			title='Settings@i_gmix'
			tip='Control Panel\All Control Panel Items\Troubleshooting\Settings'
			cmd=cpl_cm[10] + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\settingPage') }
	menu(image=inherit title='Search') {
		item(image=inherit
			title='Search@i_guid'
			tip='Troubleshooting\Search'
			cmd=cpl_co[1]  + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\searchPage')
		item(image=inherit
			title='Search (Category view)@i_guid'
			tip='Control Panel\Hardware and Sound\Troubleshooting\Search@"\n"Control Panel\All Control Panel Items\Troubleshooting\Search'
			cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\searchPage')
		item(image=inherit
			title='Search (Icons view)@i_guid'
			tip='All Control Panel Items\Troubleshooting\Search'
			cmd=cpl_cm[9]  + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\searchPage')
		item(image=inherit
			title='Search@i_gmix'
			tip='Control Panel\All Control Panel Items\Troubleshooting\Search'
			cmd=cpl_cm[10] + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\searchPage') }
	menu(image=inherit title='Additional Information') {
		item(image=inherit
			title='Additional Information@i_guid'
			tip='Troubleshooting\Additional Information'
			cmd=cpl_co[1]  + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\resultPage')
		item(image=inherit
			title='Additional Information (Category view)@i_guid'
			tip='Control Panel\Hardware and Sound\Troubleshooting\Additional Information@"\n"Control Panel\All Control Panel Items\Troubleshooting\Additional Information'
			cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\resultPage')
		item(image=inherit
			title='Additional Information (Icons view)@i_guid'
			tip='All Control Panel Items\Troubleshooting\Additional Information'
			cmd=cpl_cm[9]  + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\resultPage')
		item(image=inherit
			title='Additional Information@i_gmix'
			tip='Control Panel\All Control Panel Items\Troubleshooting\Additional Information'
			cmd=cpl_cm[10] + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\resultPage') }
	menu(image=inherit title='Remote Assistance') {
		item(image=inherit
			title='Remote Assistance@i_guid'
			tip='Troubleshooting\Remote Assistance'
			cmd=cpl_co[1]  + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\raPage')
		item(image=inherit
			title='Remote Assistance (Category view)@i_guid'
			tip='Control Panel\Hardware and Sound\Troubleshooting\Remote Assistance@"\n"Control Panel\All Control Panel Items\Troubleshooting\Remote Assistance'
			cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\raPage')
		item(image=inherit
			title='Remote Assistance (Icons view)@i_guid'
			tip='All Control Panel Items\Troubleshooting\Remote Assistance'
			cmd=cpl_cm[9]  + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\raPage')
		item(image=inherit
			title='Remote Assistance@i_gmix'
			tip='Control Panel\All Control Panel Items\Troubleshooting\Remote Assistance'
			cmd=cpl_cm[10] + '{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\raPage') }}
menu(title='TSAppInstall [!]@L1507'					image=''													menu=is_m6 where=sys.version>=WinV) {
	/* https://learn.microsoft.com/en-us/windows/win32/shell/controlpanel-canonical-names#tsappinstall */ }
menu(title='User Accounts@L1507'					image=icon.res('@sys.bin\usercpl.dll')						menu=is_m5 where=sys.version>=Win7 and path.exists('@sys.bin\usercpl.dll')) {
	item(image=inherit
		title='User Accounts@i_guid'
		tip='User Accounts'
		cmd=cpl_co[1]  + '{60632754-C523-4B62-B45C-4172DA012619}')
	item(image=inherit
		title='User Accounts (Category view)@i_guid'
		tip='Control Panel\User Accounts\User Accounts@"\n"Control Panel\All Control Panel Items\User Accounts'
		cmd=if(!keys.shift(), cpl_cm[5], cpl_cm[0])+'{60632754-C523-4B62-B45C-4172DA012619}')
	item(image=inherit
		title='User Accounts (Icons view)@i_guid'
		tip='All Control Panel Items\User Accounts'
		cmd=cpl_cm[9]  + '{60632754-C523-4B62-B45C-4172DA012619}')
	item(image=inherit
		title='User Accounts@i_gmix'
		tip='Control Panel\All Control Panel Items\User Accounts'
		cmd=cpl_cm[10] + '{60632754-C523-4B62-B45C-4172DA012619}')
	separator()
	menu(image=inherit title='Manage Accounts') {
		item(image=inherit
			title='Manage Accounts@i_guid'
			tip='User Accounts\Manage Accounts'
			cmd=cpl_co[1]  + '{60632754-C523-4B62-B45C-4172DA012619}\pageAdminTasks')
		item(image=inherit
			title='Manage Accounts (Category view)@i_guid'
			tip='Control Panel\User Accounts\User Accounts\Manage Accounts@"\n"Control Panel\All Control Panel Items\User Accounts\Manage Accounts'
			cmd=if(!keys.shift(), cpl_cm[5], cpl_cm[0])+'{60632754-C523-4B62-B45C-4172DA012619}\pageAdminTasks')
		item(image=inherit
			title='Manage Accounts (Icons view)@i_guid'
			tip='All Control Panel Items\User Accounts\Manage Accounts'
			cmd=cpl_cm[9]  + '{60632754-C523-4B62-B45C-4172DA012619}\pageAdminTasks')
		item(image=inherit
			title='Manage Accounts@i_gmix'
			tip='Control Panel\All Control Panel Items\User Accounts\Manage Accounts'
			cmd=cpl_cm[10] + '{60632754-C523-4B62-B45C-4172DA012619}\pageAdminTasks') }
	menu(image=inherit title='Change Your Name') {
		item(image=inherit
			title='Change Your Name@i_guid'
			tip='User Accounts\Change Your Name'
			cmd=cpl_co[1]  + '{60632754-C523-4B62-B45C-4172DA012619}\pageRenameMyAccount')
		item(image=inherit
			title='Change Your Name (Category view)@i_guid'
			tip='Control Panel\User Accounts\User Accounts\Change Your Name@"\n"Control Panel\All Control Panel Items\User Accounts\Change Your Name'
			cmd=if(!keys.shift(), cpl_cm[5], cpl_cm[0])+'{60632754-C523-4B62-B45C-4172DA012619}\pageRenameMyAccount')
		item(image=inherit
			title='Change Your Name (Icons view)@i_guid'
			tip='All Control Panel Items\User Accounts\Change Your Name'
			cmd=cpl_cm[9]  + '{60632754-C523-4B62-B45C-4172DA012619}\pageRenameMyAccount')
		item(image=inherit
			title='Change Your Name@i_gmix'
			tip='Control Panel\All Control Panel Items\User Accounts\Change Your Name'
			cmd=cpl_cm[10] + '{60632754-C523-4B62-B45C-4172DA012619}\pageRenameMyAccount') }
	menu(image='' title='User Accounts' ) {
		item(image=inherit
			title='User Accounts@i_guid'
			tip='(Panel) User Accounts'
			cmd=cpl_co[1]  + '{7A9D77BD-5403-11d2-8785-2E0420524153}')
		item(image=inherit
			title='User Accounts (Category view)@i_guid'
			tip='(Panel) User Accounts@"\n"(Panel) User Accounts'
			cmd=if(!keys.shift(), cpl_cm[5], cpl_cm[0])+'{7A9D77BD-5403-11d2-8785-2E0420524153}')
		item(image=inherit
			title='User Accounts (Icons view)@i_guid'
			tip='(Panel) User Accounts'
			cmd=cpl_cm[9]  + '{7A9D77BD-5403-11d2-8785-2E0420524153}')
		item(image=inherit vis='disable'
			title='User Accounts@i_gmix'
			tip='(Panel) User Accounts'
			cmd=cpl_cm[10] + '{7A9D77BD-5403-11d2-8785-2E0420524153}') }}
menu(title='Windows Anytime Upgrade [!]@L1507'		image=''													menu=is_m6 where=sys.version>=WinV) {
	/* https://learn.microsoft.com/en-us/windows/win32/shell/controlpanel-canonical-names#windows-anytime-upgrade */ }
menu(title='Windows CardSpace [!]@L1507'			image=''													menu=is_m6 where=sys.version>=WinV) {
	/*	https://learn.microsoft.com/en-us/windows/win32/shell/controlpanel-canonical-names#deprecated-control-panel-canonical-names
		shell:::{78CB147A-98EA-4AA6-B0DF-C8681F69341C}
		%SystemRoot%\System32\icardres.dll,-4096 */ }
menu(title='Windows Defender [!]@L1507'				image=''													menu=is_m6 where=sys.version>=WinV) {
	/*	https://learn.microsoft.com/en-us/windows/win32/shell/controlpanel-canonical-names#windows-defender
		shell:::{D8559EB9-20C0-410E-BEDA-7ED416AECC2A}
		%ProgramFiles%\Windows Defender\MsMpRes.dll,-103 */ }
menu(title='Windows Defender Firewall@L1507'		image=icon.res('@sys.bin\FirewallControlPanel.dll')			menu=is_m1 where=sys.version>=Win7 and path.exists('@sys.bin\FirewallControlPanel.dll')) {
	// Windows Defender Firewall (From Win10 1709), Windows Firewall (up to Win10 1703) | if(sys.version>=win10_1709, 'Windows Defender Firewall', 'Windows Firewall')
	menu(title='test' expanded=true vis=0) {
		$g001= ['{4026492F-2F69-46B8-B9BF-5654FC07E423}', '']
		item(title=reg.get('HKCR\CLSID\@g001[0]') image=reg.get('HKCR\CLSID\@g001[0]\DefaultIcon'))
		$giud_catg=reg.get('HKCR\CLSID\{4026492F-2F69-46B8-B9BF-5654FC07E423}', 'System.ControlPanel.Category')
		$giud_info=str.res('C:\Windows\System32\FirewallControlPanel.dll,-12123')
		$giud_strg=str.res('C:\Windows\System32\FirewallControlPanel.dll,-12122')
		separator() }
	item(image=inherit
		title='Windows Defender Firewall@i_guid'
		tip='Windows Defender Firewall'
		cmd=cpl_co[1]  + '{4026492F-2F69-46B8-B9BF-5654FC07E423}')
	item(image=inherit
		title='Windows Defender Firewall (Category view)@i_guid'
		tip='Control Panel\System and Security\Windows Defender Firewall@"\n"Control Panel\All Control Panel Items\Windows Defender Firewall'
		cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{4026492F-2F69-46B8-B9BF-5654FC07E423}')
	item(image=inherit
		title='Windows Defender Firewall (Icons view)@i_guid'
		tip='All Control Panel Items\Windows Defender Firewall'
		cmd=cpl_cm[9]  + '{4026492F-2F69-46B8-B9BF-5654FC07E423}')
	item(image=inherit
		title='Windows Defender Firewall@i_gmix'
		tip='Control Panel\All Control Panel Items\Windows Defender Firewall'
		cmd=cpl_cm[10] + '{4026492F-2F69-46B8-B9BF-5654FC07E423}')
	separator()
	menu(image=inherit title='Allowed apps') {
		item(image=inherit
			title='Allowed apps@i_guid'
			tip='Windows Defender Firewall\Allowed apps'
			cmd=cpl_co[1]  + '{4026492F-2F69-46B8-B9BF-5654FC07E423}\pageConfigureApps')
		item(image=inherit
			title='Allowed apps (Category view)@i_guid'
			tip='Control Panel\System and Security\Windows Defender Firewall\Allowed apps@"\n"Control Panel\All Control Panel Items\Windows Defender Firewall\Allowed apps'
			cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{4026492F-2F69-46B8-B9BF-5654FC07E423}\pageConfigureApps')
		item(image=inherit
			title='Allowed apps (Icons view)@i_guid'
			tip='All Control Panel Items\Windows Defender Firewall\Allowed apps'
			cmd=cpl_cm[9]  + '{4026492F-2F69-46B8-B9BF-5654FC07E423}\pageConfigureApps')
		item(image=inherit
			title='Allowed apps@i_gmix'
			tip='Control Panel\All Control Panel Items\Windows Defender Firewall\Allowed apps'
			cmd=cpl_cm[10] + '{4026492F-2F69-46B8-B9BF-5654FC07E423}\pageConfigureApps') }
	menu(image=inherit title='Customize Settings') {
		item(image=inherit
			title='Customize Settings@i_guid'
			tip='Windows Defender Firewall\Customize Settings'
			cmd=cpl_co[1]  + '{4026492F-2F69-46B8-B9BF-5654FC07E423}\pageConfigureSettings')
		item(image=inherit
			title='Customize Settings (Category view)@i_guid'
			tip='Control Panel\System and Security\Windows Defender Firewall\Customize Settings@"\n"Control Panel\All Control Panel Items\Windows Defender Firewall\Customize Settings'
			cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{4026492F-2F69-46B8-B9BF-5654FC07E423}\pageConfigureSettings')
		item(image=inherit
			title='Customize Settings (Icons view)@i_guid'
			tip='All Control Panel Items\Windows Defender Firewall\Customize Settings'
			cmd=cpl_cm[9]  + '{4026492F-2F69-46B8-B9BF-5654FC07E423}\pageConfigureSettings')
		item(image=inherit
			title='Customize Settings@i_gmix'
			tip='Control Panel\All Control Panel Items\Windows Defender Firewall\Customize Settings'
			cmd=cpl_cm[10] + '{4026492F-2F69-46B8-B9BF-5654FC07E423}\pageConfigureSettings') }
	menu(image=inherit title='Restore defaults') {
		item(image=inherit
			title='Restore defaults@i_guid'
			tip='Windows Defender Firewall\Restore defaults'
			cmd=cpl_co[1]  + '{4026492F-2F69-46B8-B9BF-5654FC07E423}\pageRestoreDefaults')
		item(image=inherit
			title='Restore defaults (Category view)@i_guid'
			tip='Control Panel\System and Security\Windows Defender Firewall\Restore defaults@"\n"Control Panel\All Control Panel Items\Windows Defender Firewall\Restore defaults'
			cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{4026492F-2F69-46B8-B9BF-5654FC07E423}\pageRestoreDefaults')
		item(image=inherit
			title='Restore defaults (Icons view)@i_guid'
			tip='All Control Panel Items\Windows Defender Firewall\Restore defaults'
			cmd=cpl_cm[9]  + '{4026492F-2F69-46B8-B9BF-5654FC07E423}\pageRestoreDefaults')
		item(image=inherit
			title='Restore defaults@i_gmix'
			tip='Control Panel\All Control Panel Items\Windows Defender Firewall\Restore defaults'
			cmd=cpl_cm[10] + '{4026492F-2F69-46B8-B9BF-5654FC07E423}\pageRestoreDefaults') }}
menu(title='Windows Live Language Setting [!]@L1507'image=''													menu=is_m7 where=sys.version>=WinV) {
	/*	C:\Program Files (x86)\windows live\installer\LangSelectorRes.dll,0 */ }
menu(title='Windows Mobility Center@L1507'			image=icon.res('@sys.bin\mblctr.exe')						menu=is_m3 where=sys.version>=Win7 and path.exists('@sys.bin\mblctr.exe')) {
	item(image=inherit
		title='Windows Mobility Center@i_guid'
		tip='(Panel) Windows Mobility Center'
		cmd=cpl_co[1]  + '{5ea4f148-308c-46d7-98a9-49041b1dd468}')
	item(image=inherit
		title='Windows Mobility Center (Category view)@i_guid'
		tip='(Panel) Windows Mobility Center@"\n"(Panel) Windows Mobility Center'
		cmd=if(!keys.shift(), cpl_cm[3], cpl_cm[0])+'{5ea4f148-308c-46d7-98a9-49041b1dd468}')
	item(image=inherit
		title='Windows Mobility Center (Icons view)@i_guid'
		tip='(Panel) Windows Mobility Center'
		cmd=cpl_cm[9]  + '{5ea4f148-308c-46d7-98a9-49041b1dd468}')
	item(image=inherit
		title='Windows Mobility Center@i_gmix'
		tip='(Panel) Windows Mobility Center'
		cmd=cpl_cm[10] + '{5ea4f148-308c-46d7-98a9-49041b1dd468}') }
menu(title='Windows SideShow [!]@L1507'				image=''													menu=is_m1 where=sys.version>=WinV) {
	/* https://learn.microsoft.com/en-us/windows/win32/shell/controlpanel-canonical-names#deprecated-control-panel-canonical-names */ }
menu(title='Windows To Go [!]@L1507'				image=''													menu=is_m3 where=sys.version>=WinV) {
	/* https://learn.microsoft.com/en-us/windows/win32/shell/controlpanel-canonical-names#windows-to-go
		shell:::{8E0C279D-0BD1-43C3-9EBD-31C3DC5B8A77} */ }
menu(title='Windows Update [R]@L1507'				image=''													menu=is_m1 where=sys.version>=WinV) {
	/*	https://learn.microsoft.com/en-us/windows/win32/shell/controlpanel-canonical-names#windows-update
		https://winaero.com/how-to-add-windows-update-to-control-panel-in-windows-10/
		In Win11 22H2, it is moved to the ShellCommandsExceptFolders category so it is hidden.
		Windows Update (up to Win8.1)
		shell:::{36eef7db-88ad-4e81-ad49-0e313f0c35f8}
		%SystemRoot%\system32\wucltux.dll,-1 */
	// separator()
	item(image=inherit
		title='Windows Update@i_name'
		tip=''
		cmd=cpl_co[0]  + 'AppUpdatesFolder') }
menu(title='Windows Tools@Lsupp'					image=icon.res('@sys.bin\imageres.dll',-114)				menu=is_m1 where=sys.version>=Win7) {
	// Administrative Tools (up to Win10) | Windows Tools (from Win11 21H2)
	item(image=inherit
		title='Windows Tools@i_guid'
		tip='Windows Tools'
		cmd=cpl_co[1]  + '{D20EA4E1-3957-11D2-A40B-0C5020524153}')
	item(image=inherit
		title='Windows Tools (Category view)@i_guid'
		tip='Control Panel\System and Security\Windows Tools@"\n"Control Panel\All Control Panel Items\Windows Tools'
		cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{D20EA4E1-3957-11D2-A40B-0C5020524153}')
	item(image=inherit
		title='Windows Tools (Icons view)@i_guid'
		tip='All Control Panel Items\Windows Tools'
		cmd=cpl_cm[9]  + '{D20EA4E1-3957-11D2-A40B-0C5020524153}')
	item(image=inherit
		title='Windows Tools@i_gmix'
		tip='Control Panel\All Control Panel Items\Windows Tools'
		cmd=cpl_cm[10] + '{D20EA4E1-3957-11D2-A40B-0C5020524153}')
	separator()
	item(image=inherit
		title='Common Administrative Tools@i_name'
		tip='%ProgramData%\Microsoft\Windows\Start Menu\Programs\Administrative Tools'
		cmd=cpl_co[0]  + 'Common Administrative Tools') }
menu(title='Work Folders@L1507'						image=icon.res('@sys.bin\WorkfoldersControl.dll')			menu=is_m1 where=sys.version>=Win7 and path.exists('@sys.bin\WorkfoldersControl.dll')) {
	item(image=inherit
		title='Work Folders@i_guid'
		tip='Work Folders'
		cmd=cpl_co[1]  + '{ECDB0924-4208-451E-8EE0-373C0956DE16}')
	item(image=inherit
		title='Work Folders (Category view)@i_guid'
		tip='Control Panel\System and Security\Work Folders@"\n"Control Panel\All Control Panel Items\Work Folders'
		cmd=if(!keys.shift(), cpl_cm[1], cpl_cm[0])+'{ECDB0924-4208-451E-8EE0-373C0956DE16}')
	item(image=inherit
		title='Work Folders (Icons view)@i_guid'
		tip='All Control Panel Items\Work Folders'
		cmd=cpl_cm[9]  + '{ECDB0924-4208-451E-8EE0-373C0956DE16}')
	item(image=inherit
		title='Work Folders@i_gmix'
		tip='Control Panel\All Control Panel Items\Work Folders'
		cmd=cpl_cm[10] + '{ECDB0924-4208-451E-8EE0-373C0956DE16}') }
menu(title='Applet'																								menu=is_m9) {
		item(title='Run' cmd=cpl_co[1]  + '{2559a1f3-21d7-11d4-bdaf-00c04f60b9f0}')
		item(title='Show Desktop' cmd=cpl_co[1]  + '{3080F90D-D7AD-11D9-BD98-0000947B0257}')
	}
item(title=cpl_name_1 + i_guid						image=inherit sep=if(!classic, 'bottom')					menu=if(classic, is_m0+'/Control Panel@if(classic, L1507)', is_m1)  pos=if(!classic, 'top')
	cmd=cpl_co[1]  + '{26EE0668-A00A-44D7-9371-BEB064C98683}\@if(!keys.shift(), 5, 10)')
item(title=cpl_name_2 + i_guid						image=inherit sep=if(!classic, 'bottom')					menu=if(classic, is_m0+'/Control Panel@if(classic, L1507)', is_m2)  pos=if(!classic, 'top')
	cmd=cpl_co[1]  + '{26EE0668-A00A-44D7-9371-BEB064C98683}\3')
item(title=cpl_name_3 + i_guid						image=inherit sep=if(!classic, 'bottom')					menu=if(classic, is_m0+'/Control Panel@if(classic, L1507)', is_m3)  pos=if(!classic, 'top')
	cmd=cpl_co[1]  + '{26EE0668-A00A-44D7-9371-BEB064C98683}\@if(!keys.shift(), 2, 4)')
item(title=cpl_name_4 + i_guid						image=inherit sep=if(!classic, 'bottom')					menu=if(classic, is_m0+'/Control Panel@if(classic, L1507)', is_m4)  pos=if(!classic, 'top')
	cmd=cpl_co[1]  + '{26EE0668-A00A-44D7-9371-BEB064C98683}\8')
item(title=cpl_name_5 + i_guid						image=inherit sep=if(!classic, 'bottom')					menu=if(classic, is_m0+'/Control Panel@if(classic, L1507)', is_m5)  pos=if(!classic, 'top')
	cmd=cpl_co[1]  + '{26EE0668-A00A-44D7-9371-BEB064C98683}\9')
item(title=cpl_name_6 + i_guid						image=inherit sep=if(!classic, 'bottom')					menu=if(classic, is_m0+'/Control Panel@if(classic, L1507)', is_m6)  pos=if(!classic, 'top')
	cmd=cpl_co[1]  + '{26EE0668-A00A-44D7-9371-BEB064C98683}\1')
item(title=cpl_name_7 + i_guid						image=inherit sep=if(!classic, 'bottom')					menu=if(classic, is_m0+'/Control Panel@if(classic, L1507)', is_m7)  pos=if(!classic, 'top')
	cmd=cpl_co[1]  + '{26EE0668-A00A-44D7-9371-BEB064C98683}\6')
item(title=cpl_name_8 + i_guid						image=inherit sep=if(!classic, 'bottom')					menu=if(classic, is_m0+'/Control Panel@if(classic, L1507)', is_m8)  pos=if(!classic, 'top')
	cmd=cpl_co[1]  + '{26EE0668-A00A-44D7-9371-BEB064C98683}\7')
/* Win Server
	iSCSI Initiator
		https://www.informaticar.net/server-basics-11-create-shared-storage-in-windows-server-iscsi-target/
	iSNS Server
		https://thesolving.com/storage/how-to-install-and-configure-a-isns-server-on-windows-2012-r2/
	MPIO Properties
		https://support.purestorage.com/Solutions/Microsoft_Platform_Guide/Multipath-IO_and_Storage_Settings/Configuring_Multipath-IO
		https://support.microsoft.com/en-au/topic/how-to-set-up-the-microsoft-multipath-i-o-feature-for-storsimple-volumes-in-windows-server-2008-r2-3fadc4b3-37f6-589b-9d15-3582979d42e2 */
/* 3rd Party apps
	Broadcom Advanced Control Suite
		https://documentation.help/Broadcom-NetXtreme/BACS.htm
		https://cs.uwaterloo.ca/~brecht/servers/docs/PowerEdge-2600/en/Broadcom/UG/BACS.htm
	Flash Player Settings Manager
		https://www.howto-connect.com/customize-flash-player-settings-windows-10/
	Java (32-bit)
		https://docs.oracle.com/javase/8/docs/technotes/guides/deploy/jcp.html
	 	https://www.java.com/en/download/help/win_controlpanel.html
	MobileMe
		https://news.softpedia.com/news/Download-MobileMe-Control-Panel-for-Windows-113104.shtml
	NVIDIA Control Panel (if installed) {0bbca823-e77d-419e-9a44-5adec2c8eeb0}
	Realtek HD Audio Manager */


/* New:
	Add Network Location						{D4480A50-BA28-11d1-8E75-00C04FA31A86} 2
	Bluetooth Devices							{28803F59-3A75-4058-995F-4EE5503B023C} 2
	Command Folder								{437ff9c0-a07f-4fa0-af80-84b6c6440a16} 2
	Control Panel (All Tasks)					{ED7BA470-8E54-465E-825C-99712043E01C} 2 Control Panel (All Tasks) 
	E-mail (default e-mail program)				{2559a1f5-21d7-11d4-bdaf-00c04f60b9f0} 2 E-mail (default e-mail program)
	Games Explorer								{ED228FDF-9EA8-4870-83b1-96b02CFE0D52} 2
	Help and Support							{2559a1f1-21d7-11d4-bdaf-00c04f60b9f0} 2
	-		HomeGroup (settings)						{67CA7650-96E6-4FDD-BB43-A8E774F73A57} 2
	HomeGroup (users)							{B4FB3F98-C1EA-428d-A78A-D1F5659CBA93} 2
	Hyper-V Remote File Browsing				{0907616E-F5E6-48D8-9D61-A91C3D28106D} 2
	Language settings							{BF782CC9-5A52-4A17-806C-2A894FFEEAC5}
	Network Connections (in PC settings)		{38A98528-6CBF-4CA9-8DC0-B1E1D10F7B1B} 2 Connect To
	Network (WorkGroup)							{208D2C60-3AEA-1069-A2D7-08002B30309D} 2
	Previous Versions Results Folder			{f8c2ab3b-17bc-41da-9758-339d7dbf2d88} 2
	Remote Printers								{863aa9fd-42df-457b-8e4d-0de1b8015c60} 2
	Results Folder								{2965e715-eb66-4719-b53f-1672673bbefa} 2
	Search Everywhere (modern)					{2559a1f8-21d7-11d4-bdaf-00c04f60b9f0} 2 Search (Windows) 
	Search Files (modern)						{2559a1f0-21d7-11d4-bdaf-00c04f60b9f0} 2
	================================================================================
	ActiveX Cache Folder						{88C6C381-2E85-11D0-94DE-444553540000}
	All Settings								{5ED4F38C-D3FF-4D61-B506-6820320AEBFE}
	AppSuggestedLocations						{c57a6066-66a3-4d91-9eb9-41532179f0a5}
	Briefcase									{85BBD920-42A0-1069-A2E4-08002B30309D}
	Cabinet Shell Folder						{0CD7A5C0-9F37-11CE-AE65-08002B2E1262}
	CLSID_AppInstanceFolder						{64693913-1c21-4f30-a98f-4e52906d3b56}
	CLSID_DBFolder								{b2952b16-0e07-4e5a-b993-58c52cb94cae}
	CLSID_DBFolderBoth							{1bef2128-2f96-4500-ba7c-098dc0049cb2}
	CLSID_SearchHome							{9343812e-1c37-4a49-a12e-4b2d810d956b} Search (File Explorer) 
	CLSID_StartMenuCommandingProviderFolder		{a00ee528-ebd9-48b8-944a-8942113d46ac}
	CLSID_StartMenuLauncherProviderFolder		{98F275B4-4FFF-11E0-89E2-7B86DFD72085}
	CLSID_StartMenuPathCompleteProviderFolder	{e345f35f-9397-435c-8f95-4e922c26259e}
	CLSID_StartMenuProviderFolder				{daf95313-e44d-46af-be1b-cbacea2c3065}
	CompressedFolder							{E88DCCE0-B7B3-11d1-A9F0-00AA0060FA31}
	delegate folder that appears in Users Files Folder	{DFFACDC5-679F-4156-8947-C5C76BC0B67F}
	Desktop										{00021400-0000-0000-C000-000000000046}
	DeviceCenter Initialization					{C2B136E2-D50E-405C-8784-363C582BF43E}
	DevicePairingFolder Initialization			{AEE2420F-D50E-405C-8784-363C582BF45A}
	DLNA Content Directory Data Source			{D2035EDF-75CB-4EF1-95A7-410D9EE17170}
	DXP											{8FD8B88D-30E1-4F25-AC2B-553D3D65F0EA}
	Enhanced Storage Data Source				{9113A02D-00A3-46B9-BC5F-9C04DADDD5D7}
	Explorer Browser Results Folder				{418c8b64-5463-461d-88e0-75e2afa3c6fa}
	File Backup Index							{877ca5ac-cb41-4842-9c69-9136e42d47e2}
	FileHistoryDataSource						{2F6CE85C-F9EE-43CA-90C7-8A9BD53A2467}
	Folder Shortcut								{0AFACED1-E828-11D1-9187-B532F1E9575D}
	History										{FF393560-C2A7-11CF-BFF4-444553540000}
	Homegroup									{6785BFAC-9D2D-4be5-B7E2-59937E8FB80A} +++
	IE History and Feeds Shell Data Source for Windows Search	{11016101-E366-4D22-BC06-4ADA335C892B}
	IE RSS Feeds Folder							{9a096bb5-9dc3-4d1c-8526-c3cbf991ea4e}
	Language									{BF782CC9-5A52-4A17-806C-2A894FFEEAC5}
	LayoutFolder								{328B0346-7EAF-4BBE-A479-7CB88A095F5B}
	Libraries delegate folder that appears in Users Files Folder	{896664F7-12E1-490f-8782-C0835AFD98FC}
	Library Folder								{a5a3563a-5755-4a6f-854e-afa3230b199f}
	Location Folder								{267cf8a9-f4e3-41e6-95b1-af881be130ff}
	Manage Wireless Networks					{1FA9085F-25A2-489B-85D4-86326EEDCD87}
	Microsoft FTP Folder						{63da6ec0-2e98-11cf-8d82-444553540000}
	Pictures									{45e8e0e8-7ae9-41ad-a9e8-594972716684}
	Previous Versions							{9DB7A13C-F208-4981-8353-73CC61AE2783}
	Previous Versions Results Delegate Folder	{a3c3d402-e56c-4033-95f7-4885e80b0111}
	Search										{04731B67-D933-450a-90E6-4ACD2E9408FE}
	Search Connector Folder						{72b36e70-8700-42d6-a7f7-c9ab3323ee51}
	Shell DocObject Viewer						{E7E4BC40-E76A-11CE-A9BB-00AA004AE837}
	Shell File System Folder					{0E5AAE11-A475-4c5b-AB00-C66DE400274E}
	Shell File System Folder					{F3364BA0-65B9-11CE-A9BA-00AA004AE837}
	Start Menu									{48e7caab-b918-4e58-a94d-505519c795dc}
	StreamBackedFolder							{EDC978D6-4D53-4b2f-A265-5805674BE568}
	Subscription Folder							{F5175861-2688-11d0-9C5E-00AA00A45957}
	Switch between windows						{3080F90E-D7AD-11D9-BD98-0000947B0257} +++
	Sync Center Conflict Folder					{289978AC-A101-4341-A817-21EBA7FD046D}
	Sync Results Folder							{71D99464-3B6B-475C-B241-E15883207529}
	System Restore								{3f6bc534-dfa1-4ab4-ae54-ef25a74e0107} +++
	Temporary Internet Files					{7BD29E00-76C1-11CF-9DD0-00A0C9034933}
	Temporary Internet Files					{7BD29E01-76C1-11CF-9DD0-00A0C9034933}
	This PC										{5E5F29CE-E0A8-49D3-AF32-7A7BDC173478}
	Windows Security							{2559a1f2-21d7-11d4-bdaf-00c04f60b9f0}
	WWan Shell Folder							{87630419-6216-4ff8-a1f0-143562d16d5c}
	================================================================================
	Autoplay 									{9C60DE1E-E5FC-4of4-A487-460851A8D915}\DefaultIcon
	Desktop Gadgets 							{37efd44d-ef8d-41b1-940d-96973a50e9eo}\DefaultIcon
	Device Manager 								{74246bfc-4c96-11d0-9bef-0020afgb0b7a}\DefaultIcon
	Network and Sharing Center 					{8E908FC9-BECC-40f6-915B-F4CAOE70D03D}\DefaultIcon
	Parental Controls 							{96AE8D84-A250-4520-95A5-A46A7E3C548B}\DefaultIcon
	Performance Information and Tools			{78F3955E-3B90-4184-BD14-5397C15F1EFC}\DefaultIcon
	Personalization 							{ED834ED6-485A-4bfe-8F11-A626DCB6A921}\DefaultIcon
	System 										{BB06C0E4-D293-4f75-8A90-CB05B6A77EEE}\DefaultIcon
	Windows Live Language Setting 				{2BADA6D5-9815-4f01-9957-74AF8077FD18}\DefaultIcon
	Windows SideShow							{E95A4861-D57A-4be1-AD0F-35267E261739}\DefaultIcon
	================================================================================
	Favorites 									{323CA680-C24D-4099-B94D-446DD2D7249E} +++
	Intel Rapid Storage Technology (if installed) 	{E342F0FE-FF1C-4c41-BE37-A0271FC90396}
	All Categories								{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}\listAllPage +++
	Web browser (default) 						{871C5380-42A0-1069-A2EA-08002B30309D}
	*/

// control userpasswords2
// computerdefaults
// cttune
// SystemPropertiesAdvanced ++ rundll32 sysdm.cpl,EditEnvironmentVariables
// SystemPropertiesPerformance
