// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/
/* To-Do: 
	- export reg individual
	- export reg global 2
	- test "Quick access" on win10
	- "manage" group for system object
	- new object custom default
	- Hide "Local*"
	*/

menu(title='TreeView' type='*' where=(window.is_tree and sel.count==0) expanded=1) { /*where=(window.parent.name=='NamespaceTreeControl')*/
	// fast end commands
		$refresh = command.refresh()
		$reload  = run('ie4uinit', '-show')
		$reopen  = msg('You must reopen windows explorer to apply these changes!')
		$restart = if(msg('Do you want to restart the explorer to apply the changes?', 'NileSoft Shell', msg.warning|msg.yesno|msg.defbutton2)==msg.idyes, command.restart_explorer(), reload)
	// reg paths
		$guid = '{00000000-0000-0000-0000-000000000000}'
		$cr0 = 'HKCR\CLSID\{0}'
			$cr0_exist = guid!=null and reg.exists(str.fmt(cr0, guid))
			$cr0_title = reg.get(str.fmt(cr0, guid))
			$cr0_name  = str.res(sys.expand(str.trimstart(reg.get(str.fmt(cr0, guid), 'LocalizedString'), '@')))
			$cr0_tip   = str.res(sys.expand(str.trimstart(reg.get(str.fmt(cr0, guid), 'InfoTip'), '@')))
			$cr0_icon  = reg.get(str.fmt(cr0, guid)+'\DefaultIcon')
			$cr0_pos   = reg.get(str.fmt(cr0, guid), 'SortOrderIndex')	
		$cu1 = 'HKCU\Software\Classes\CLSID\{0}'
			$cu1_exist = guid!=null and reg.exists(str.fmt(cu1, guid))
			$cu1_title = reg.get(str.fmt(cu1, guid))
			$cu1_name  = str.res(sys.expand(str.trimstart(reg.get(str.fmt(cu1, guid), 'LocalizedString'), '@')))
			$cu1_tip   = str.res(sys.expand(str.trimstart(reg.get(str.fmt(cu1, guid), 'InfoTip'), '@')))
			$cu1_icon  = reg.get(str.fmt(cu1, guid)+'\DefaultIcon')
			$cu1_pos   = reg.get(str.fmt(cu1, guid), 'SortOrderIndex')
			$cu1_show  = reg.get(str.fmt(cu1, guid), 'System.IsPinnedToNameSpaceTree')
			$cu1_type  = reg.get(str.fmt(cu1, guid), 'DescriptionID')
			$cu1_atrb  = reg.get(str.fmt(cu1, guid)+'\ShellFolder', 'Attributes')
		$cu2 = 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{0}'
		$lm2 = 'HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{0}'
		$cu3 = 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel'
		$lm4 = 'HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0}'	
		$lm5 = 'HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0}'
		$cu8 = 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\{1}\NameSpace\DelegateFolders\{0}'
			// M: HomeFolderDesktop / MyComputer
			// G: HomeFolderMSGraph / HomeFolderMSGraph_WithRecommendations / HomeFolderMSGraph_WithShared / HomeFolderMSGraph_WithSharedNoRecommendations
			// 1: CommonPlaces / ControlPanel / Desktop / HomeFolderMobile / RemovableStorage / PrintersAndFaxes / UsersFiles / UsersLibraries
		$lm8 = 'HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\{1}\NameSpace\DelegateFolders\{0}'
		$cu9 = 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer'
		$lm9 = 'HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer'
	// Objects	
		/* https://learn.microsoft.com/en-us/windows/win32/shell/sfgao
			Folder (Standard)	0xf080004d	4034920525	Full access, all operations
			Folder (Protected)	0xb0800048	2962292808	Browse only, no modifications
			Drive Root			0xf080004d	4034920525	Same as folder, full access
			Shell/Virtual		0xb080010d	2962293005	Browse-only, link flag set
			Network Drive		0xfa08004d	4228653133	Add REMOVABLE flag
			Slow Network		0xfa08404d	4228669005	Add REMOVABLE + ISSLOW */
		$o__exists       = cu1_exist
		$o__create_dir   = reg.set(str.fmt(cu1, guid), 'CreatedBy', 'Nilesoft Shell', reg.sz)
			& reg.set(str.fmt(cu1, guid), null, get_name, reg.sz)
			& if(len(get_tip)>0, reg.set(str.fmt(cu1, guid), 'InfoTip', get_tip, reg.sz))
			& reg.set(str.fmt(cu1, guid), 'DescriptionID', if(toint(get_type)>0, get_type, 3), reg.dword)
			& reg.set(str.fmt(cu1, guid), 'SortOrderIndex', if(toint(get_pos)>0, get_pos, 81), reg.dword)
			& reg.set(str.fmt(cu1, guid), 'System.IsPinnedtoNameSpaceTree', 1, reg.dword)
			& reg.set(str.fmt(cu1, guid)+'\DefaultIcon', null, if(len(get_icon)>0, get_icon, 'shell32.dll,4'), reg.sz)
			& reg.set(str.fmt(cu1, guid)+'\InProcServer32', null, 'shell32.dll', reg.sz)
			& reg.set(str.fmt(cu1, guid)+'\InProcServer32', 'ThreadingModel', 'Both', reg.sz)
			& reg.set(str.fmt(cu1, guid)+'\Instance', 'CLSID', '{0afaced1-e828-11d1-9187-b532f1e9575d}', reg.sz)
			& reg.set(str.fmt(cu1, guid)+'\Instance\InitPropertyBag', 'Attributes', 17, reg.dword)	// dec 17 = dword:00000011 = READONLY + DIRECTORY // dec 21 = 0x15 = FILE_ATTRIBUTE_DIRECTORY, FILE_ATTRIBUTE_HIDDEN, FILE_ATTRIBUTE_READONLY
			& reg.set(str.fmt(cu1, guid)+'\Instance\InitPropertyBag', 'Target', get_path, reg.sz)														// only for {0afaced1-e828-11d1-9187-b532f1e9575d}
			// & reg.set(str.fmt(cu1, guid)+'\ShellEx\PropertySheetHandlers\tab 1 general', null, '{21b22460-3aea-1069-a2dc-08002b30309d}', reg.sz)		// only for {0afaced1-e828-11d1-9187-b532f1e9575d}
			// & reg.set(str.fmt(cu1, guid)+'\ShellEx\PropertySheetHandlers\tab 2 customize', null, '{ef43ecfe-2ab9-4632-bf21-58909dd177f0}', reg.sz)	// only for {0afaced1-e828-11d1-9187-b532f1e9575d}
			// & reg.set(str.fmt(cu1, guid)+'\ShellEx\PropertySheetHandlers\tab 3 sharing', null, '{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}', reg.sz)		// only for {0afaced1-e828-11d1-9187-b532f1e9575d}
			// & reg.set(str.fmt(cu1, guid)+'\ShellEx\PropertySheetHandlers\tab 4 security', null, '{1f2e5c40-9550-11ce-99d2-00aa006e086c}', reg.sz)	// only for {0afaced1-e828-11d1-9187-b532f1e9575d}
			& reg.set(str.fmt(cu1, guid)+'\ShellFolder', 'Attributes', if(get_attr>0, get_attr, 4034920525), reg.dword)
			& reg.set(str.fmt(cu1, guid)+'\ShellFolder', 'FolderValueFlags', 40, reg.dword)			// dword:00000028
			// & reg.set(str.fmt(cu1, guid)+'\ShellFolder', 'WantsFORPARSING', null, reg.sz)		// skip for 99% of namespace
			// & reg.set(str.fmt(cu1, guid)+'\ShellFolder', 'HideAsDeletePerUser', null, reg.sz)	// skip for 99% of namespace
		$o__create_drive = reg.set(str.fmt(cu1, guid), 'CreatedBy', 'Nilesoft Shell', reg.sz)
			& reg.set(str.fmt(cu1, guid), null, get_name, reg.sz)
			& if(len(get_tip)>0, reg.set(str.fmt(cu1, guid), 'InfoTip', get_tip, reg.sz))
			& reg.set(str.fmt(cu1, guid), 'DescriptionID', if(toint(get_type)>0, get_type, 0), reg.dword)
			& reg.set(str.fmt(cu1, guid), 'SortOrderIndex', if(toint(get_pos)>0, get_pos, 80), reg.dword)
			& reg.set(str.fmt(cu1, guid), 'System.IsPinnedtoNameSpaceTree', 1, reg.dword)
			& reg.set(str.fmt(cu1, guid)+'\DefaultIcon', null, if(sys.root==str.trim(get_path, '\'), 'imageres.dll,-36', 'imageres.dll,-32'), reg.sz)
			& reg.set(str.fmt(cu1, guid)+'\InProcServer32', null, 'shell32.dll', reg.sz)
			& reg.set(str.fmt(cu1, guid)+'\InProcServer32', 'ThreadingModel', 'Both', reg.sz)
			& reg.set(str.fmt(cu1, guid)+'\Instance', 'CLSID', '{0E5AAE11-A475-4c5b-AB00-C66DE400274E}', reg.sz)
			& reg.set(str.fmt(cu1, guid)+'\Instance\InitPropertyBag', 'Attributes', 17, reg.dword) 
			& reg.set(str.fmt(cu1, guid)+'\Instance\InitPropertyBag', 'TargetFolderPath', get_path, reg.sz)
			& reg.set(str.fmt(cu1, guid)+'\ShellFolder', 'Attributes', if(get_attr>0, get_attr, 4034920525), reg.dword)
			& reg.set(str.fmt(cu1, guid)+'\ShellFolder', 'FolderValueFlags', 40, reg.dword)
		$o__create_guid  = reg.set(str.fmt(cu1, guid), 'CreatedBy', 'Nilesoft Shell', reg.sz)
			& reg.set(str.fmt(cu1, guid), null, get_name, reg.sz)
			& if(len(get_tip)>0, reg.set(str.fmt(cu1, guid), 'InfoTip', get_tip, reg.sz))
			& reg.set(str.fmt(cu1, guid), 'DescriptionID', if(toint(get_type)>0, get_type, 3), reg.dword)
			& reg.set(str.fmt(cu1, guid), 'SortOrderIndex', if(toint(get_pos)>0, get_pos, 88), reg.dword)
			& reg.set(str.fmt(cu1, guid), 'System.IsPinnedtoNameSpaceTree', 1, reg.dword)
			& reg.set(str.fmt(cu1, guid)+'\DefaultIcon', null, if(len(get_icon)>0, get_icon, 'imageres.dll,157'), reg.sz)
			& reg.set(str.fmt(cu1, guid)+'\InProcServer32', null, 'shell32.dll', reg.sz)
			& reg.set(str.fmt(cu1, guid)+'\InProcServer32', 'ThreadingModel', 'Both', reg.sz)
			& reg.set(str.fmt(cu1, guid)+'\Instance', 'CLSID', '{0afaced1-e828-11d1-9187-b532f1e9575d}', reg.sz)
			& reg.set(str.fmt(cu1, guid)+'\Instance\InitPropertyBag', 'Attributes', 17, reg.dword)
			& reg.set(str.fmt(cu1, guid)+'\Instance\InitPropertyBag', 'Target', get_path, reg.sz)
			& reg.set(str.fmt(cu1, guid)+'\ShellFolder', 'Attributes', if(get_attr>0, get_attr, 4034920525), reg.dword)
			& reg.set(str.fmt(cu1, guid)+'\ShellFolder', 'FolderValueFlags', 40, reg.dword)
		$o__delete_it    = reg.delete(str.fmt(cu1, guid))
		$o__icon_new     = { t_icon=icon.box() reg.set(str.fmt(cu1, guid)+'\DefaultIcon', null, if(len(t_icon)>0, t_icon, cr0_icon), reg.sz) }
		$o__name_new     = if(input('Nilesoft SHell', 'Give a title', get_name) & len(input.result)>0, reg.set(str.fmt(cu1, guid), null, input.result, reg.sz), reg.set(str.fmt(cu1, guid), null, cr0_name, reg.sz))
		// in Navigation Pane
		$o_np_set        = if(!reg.exists(str.fmt(cu2, guid)), reg.set(str.fmt(cu2, guid), null, get_name) & reg.set(str.fmt(cu2, guid), 'CreatedBy', 'Nilesoft Shell') & reg.set(cu3, guid, 1, reg.dword))
		$o_np_del        = reg.delete(str.fmt(cu2, guid)) & reg.delete(cu3, guid)	
		$o_np_pin_toggle = reg.set(str.fmt(cu1, guid), 'System.IsPinnedToNameSpaceTree', if(pinned,0,1), reg.dword) & if(reg.get(str.fmt(lm2, guid), 'HiddenByDefault')==1 or reg.get(str.fmt(lm2, guid), 'HideIfEnabled')=='36354489', run('cmd', '/c reg delete "@str.fmt(lm2, guid)" /v HideIfEnabled /f & reg delete "@str.fmt(lm2, guid)" /v HiddenByDefault /f', 'runas', null, 0, 1))
		$o_np_pin_reset  = reg.delete(str.fmt(cu1, guid), 'System.IsPinnedToNameSpaceTree')
		$o_np_pos_set    = reg.set(str.fmt(cu1, guid), 'SortOrderIndex', get_pos, reg.dword)
		$o_np_pos_new    = if(input('Nilesoft Shell', 'Change the position by setting a position number beetween 40 and 130', get_pos) and toint(input.result)>0, reg.set(str.fmt(cu1, guid), 'SortOrderIndex', toint(input.result), reg.dword), msg('reseting position') and o_np_pos_reset, msg('skipping operation'))
		$o_np_pos_reset  = reg.delete(str.fmt(cu1, guid), 'SortOrderIndex')
		// in This PC
		$o_ps_ispin     = reg.exists(str.fmt(lm4, guid))
		$o_pc_set       = if(o_ps_ispin, run('cmd', '/c reg delete "@str.fmt(lm4, guid)" /f', 'runas', null, 0, 1), run('cmd', '/c reg add "@str.fmt(lm4, guid)" /f', 'runas', null, 0, 1))
		$o_pc_del       = if(o_ps_ispin, run('cmd', '/c reg delete "@str.fmt(lm4, guid)" /f', 'runas', null, 0, 1))
		$o_pc_type_new  = if(input('Nilesoft SHell', null, null,['Folder', 'Drive', 'Network Locations'], if(get_type==3, 0, if(get_type==9, 2, 1))) & input.selected>=0, reg.set(str.fmt(cu1, guid), 'DescriptionID', if(input.selected==0, 3, if(input.selected==1, 0, if(input.selected==2, 9))), reg.dword))
		// on desktop
		$o_dt_ispin     = reg.get(cu3, guid)!=1
		$o_dt_pin_set   = if(!reg.exists(str.fmt(cu2, guid)), reg.set(str.fmt(cu2, guid), null, get_name) & reg.set(str.fmt(cu2, guid), 'CreatedBy', 'Nilesoft Shell')) & reg.set(cu3, guid, if(o_dt_ispin,1,0), reg.dword)	
	// auto get info
		$get_vis   = if(not(cu1_exist or cr0_exist or reg.exists(str.fmt(lm5, guid))), 0)
		$get_path  = if(len(cu1_path)>0, cu1_path, cr0_path)
		$get_name  = if(len(cu1_name)>0, cu1_name, if(len(cu1_title)>0, cu1_title, if(len(cr0_name)>0, cr0_name, cr0_title)))
		$get_tip   = if(len(cu1_tip)>0, cu1_tip, cr0_tip)
		$get_icon  = if(len(cu1_icon)>0, cu1_icon, if(len(cr0_icon)>0, cr0_icon, reg.get(str.fmt(lm5, guid), 'Icon')))
		$get_pos   = if(len(cu1_pos)>0, cu1_pos, cr0_pos)
		$get_attr  = cu1_atrb
		$get_show  = cu1_show
		$get_type  = cu1_type
	// More 
		$h_name = if(sys.version.build>=22593, 'Home', 'Quick access')
		$h_icon = if(sys.version.build>=22593, \uE0FB, \uE0C8)
	menu(image=[h_icon, image.color2] title=h_name tip='Manage @h_name folder visibility and settings' sep=1) {
		$h_is10 = eval(sys.is10 and reg.exists(str.fmt(cr0, '{679F85CB-0220-4080-B29B-5540CC05AAB6}')))
		$h_is11 = eval(sys.is11 and reg.exists(str.fmt(cr0, '{f874310e-b6b7-47dc-bc84-b9e6b38f5903}')))
		menu(expanded=1 title='Favorites') {
			//> https://www.tenforums.com/tutorials/35873-add-remove-favorites-navigation-pane-windows-10-a.html
			$guid = '{323CA680-C24D-4099-B94D-446DD2D7249E}'
			$pinned = get_show!=0
			$cr0_pos = 64
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_np_pos_set & o_np_pin_toggle & reload)
			menu(where=key.shift() and o__exists title=get_name tip=get_tip image=get_icon) { 
				item(title='Show in Navigation Pane' sep=1 checked=pinned cmd=o_np_pin_toggle & reload)
				item(title='Change position' keys=if(len(get_pos)>0, 'pos: '+get_pos) image=\uE0A2 vis=if(!pinned, 2) cmd=o_np_pos_new & reload)
				item(title='Show in This PC' sep=1 checked=o_ps_ispin cmd=o_pc_set & command.sleep(100) & refresh)
				item(title='Change Type' image=\uE135 vis=if(!o_ps_ispin, 2) cmd=o_pc_type_new & refresh)
				item(title='Show on Desktop' sep=1 checked=o_dt_ispin cmd=o_dt_pin_set)
				separator()
				item(title='Change Title' keys='+ reset' image=\uE0B7 cmd=o__name_new & reload)
				item(title='Change Icon' keys='+ reset' image=\uE0BF cmd=o__icon_new & reload)
				menu(title='Attributes') {
					$rkey = str.fmt(cu1, guid)+'\ShellFolder'
					item(checked=(cu1_atrb & 0x01) keys='0x01' title='Can Copy' tip='Items can be copied (Ctrl+C). Disabling prevents copying files from this folder.'
						cmd=if((cu1_atrb & 0x01), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x01), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x01), reg.dword)))
					item(checked=(cu1_atrb & 0x02) keys='0x02' title='Can Move/Cut' tip='Items can be moved or cut (Ctrl+X). Disabling prevents moving/cutting files.'
						cmd=if((cu1_atrb & 0x02), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x02), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x02), reg.dword)))
					item(checked=(cu1_atrb & 0x04) keys='0x04' title='Can Create Link' tip='Shortcuts can be created for items. Disabling removes "Create shortcut" from context menu.'
						cmd=if((cu1_atrb & 0x04), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x04), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x04), reg.dword)))
					item(checked=(cu1_atrb & 0x08) keys='0x08' title='Has Storage' tip='Items support IStorage interface. Required for proper folder functionality - keep enabled.'
						cmd=if((cu1_atrb & 0x08), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x08), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x08), reg.dword)))
					item(checked=(cu1_atrb & 0x10) keys='0x10' title='Can Rename' tip='Items can be renamed (F2). Disabling prevents renaming files and folders.'
						cmd=if((cu1_atrb & 0x10), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10), reg.dword)))
					item(checked=(cu1_atrb & 0x20) keys='0x20' title='Can Delete' tip='Items can be deleted (Del). Disabling prevents deletion and removes "Delete" from context menu.'
						cmd=if((cu1_atrb & 0x20), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20), reg.dword)))
					item(checked=(cu1_atrb & 0x40) keys='0x40' title='Has Property Sheet' tip='Items have property sheets (right-click → Properties). Required for Properties dialog.'
						cmd=if((cu1_atrb & 0x40), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40), reg.dword)))
					item(checked=(cu1_atrb & 0x80) keys='0x80' title='Drop Target' tip='Folder can receive dropped files. Disabling prevents drag-and-drop into this folder.'
						cmd=if((cu1_atrb & 0x80), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80), reg.dword)))
					separator()
					// Additional Flags
					item(checked=(cu1_atrb & 0x100) keys='0x100' title='Is Link' tip='The specified items are shortcuts.'
						cmd=if((cu1_atrb & 0x100), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x100), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x100), reg.dword)))
					item(checked=(cu1_atrb & 0x200) keys='0x200' title='Can Share' tip='The specified folder objects are shared.'
						cmd=if((cu1_atrb & 0x200), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x200), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x200), reg.dword)))
					item(checked=(cu1_atrb & 0x400) keys='0x400' title='Read Only' tip='The specified items are read-only. In the case of folders, this means that new items cannot be created in those folders.'
						cmd=if((cu1_atrb & 0x400), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x400), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x400), reg.dword)))
					item(checked=(cu1_atrb & 0x800) keys='0x800' title='Ghosted/Dimmed'
						cmd=if((cu1_atrb & 0x800), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x800), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x800), reg.dword)))
					separator()
					// Folder Flags
					item(checked=(cu1_atrb & 0x1000) keys='0x1000' title='System' tip='Item is a system object. Windows treats it as protected system content.'
						cmd=if((cu1_atrb & 0x1000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x1000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x1000), reg.dword)))
					item(checked=(cu1_atrb & 0x2000) keys='0x2000' title='Encrypted' tip='Item is encrypted. Shows lock icon overlay for encrypted files/folders.'
						cmd=if((cu1_atrb & 0x2000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x2000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x2000), reg.dword)))
					item(checked=(cu1_atrb & 0x4000) keys='0x4000' title='Is Slow' tip='Accessing this item is slow (network drive, offline files). Explorer may cache aggressively.'
						cmd=if((cu1_atrb & 0x4000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x4000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x4000), reg.dword)))
					item(checked=(cu1_atrb & 0x8000) keys='0x8000' title='Ghosted/Dimmed' tip='Item appears dimmed/ghosted. Visual indication that item is unavailable or cut for move.'
						cmd=if((cu1_atrb & 0x8000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x8000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x8000), reg.dword)))
					item(checked=(cu1_atrb & 0x10000) keys='0x10000' title='Is Link' tip='Item is a shortcut/link. Sets visual shortcut arrow overlay on icon.'
						cmd=if((cu1_atrb & 0x10000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10000), reg.dword)))
					item(checked=(cu1_atrb & 0x20000) keys='0x20000' title='Is Shared' tip='Folder is shared on network. Shows sharing icon overlay.'
						cmd=if((cu1_atrb & 0x20000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20000), reg.dword)))
					item(checked=(cu1_atrb & 0x40000) keys='0x40000' title='Read Only' tip='Items are read-only. For folders: prevents creating new items. Shows lock icon overlay.'
						cmd=if((cu1_atrb & 0x40000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40000), reg.dword)))
					item(checked=(cu1_atrb & 0x80000) keys='0x80000' title='Hidden' tip='Item is hidden. Only visible when "Show hidden files" is enabled in Folder Options.'
						cmd=if((cu1_atrb & 0x80000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80000), reg.dword)))
					separator()
					// More High Flags
					item(checked=(cu1_atrb & 0x2000000) keys='0x2000000' title='Removable' tip='Content is on removable media (USB, CD). Affects caching and offline availability.'
						cmd=if((cu1_atrb & 0x2000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x2000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x2000000), reg.dword)))
					item(checked=(cu1_atrb & 0x8000000) keys='0x8000000' title='Browsable' tip='Can be browsed in place. Enables in-place navigation rather than new window.'
						cmd=if((cu1_atrb & 0x8000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x8000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x8000000), reg.dword)))
					item(checked=(cu1_atrb & 0x10000000) keys='0x10000000' title='Filesystem Ancestor' tip='Contains file system folders. Indicates descendant folders are on file system.'
						cmd=if((cu1_atrb & 0x10000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10000000), reg.dword)))
					item(checked=(cu1_atrb & 0x20000000) keys='0x20000000' title='Is Folder' tip='Item is a folder container. Required for proper folder behavior - keep enabled.'
						cmd=if((cu1_atrb & 0x20000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20000000), reg.dword)))
					item(checked=(cu1_atrb & 0x40000000) keys='0x40000000' title='Is Filesystem' tip='Item is part of file system (not virtual). Affects how Explorer handles the item.'
						cmd=if((cu1_atrb & 0x40000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40000000), reg.dword)))
					item(checked=(cu1_atrb & 0x80000000) keys='0x80000000' title='Has Subfolders' tip='Folder may contain subfolders. Shows expand arrow in tree view.'
						cmd=if((cu1_atrb & 0x80000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80000000), reg.dword)))				separator()
					separator()
					item(title='Documentation' image=\uE11F cmd='https://learn.microsoft.com/en-us/windows/win32/shell/sfgao') }
				separator()
				item(title='Export' image=\uE145 tip='Export the object in reg file. you can use it in anothe pc witout NS')
				item(title='Destoy' image=\uE0CE cmd=o__delete_it & o_np_del & o_pc_del & reg.delete(cu9+'\CLSID\'+guid) & reload & command.sleep(100) & refresh) }
			menu(title=get_name+' (manage)' image=get_icon where=key.shift()) { 
				item(title='Restore pinned' cmd=o_np_pin_reset & reload)
				separator()
				item(title='Change position' cmd=o_np_pos_new & reload)
				separator()
				item(title='Show on desktop' checked=o_dt_ispin cmd=o_dt_pin_set) }
			}
		menu(expanded=1 where=h_is10 title='Quick access') {
			//> https://www.tenforums.com/tutorials/4844-remove-quick-access-navigation-pane-windows-10-a.html
			$guid = '{679F85CB-0220-4080-B29B-5540CC05AAB6}'
			$cr0_name = 'Quick access'
			$rkey1 = 'ShowRecent' 
			$swap1 = reg.get(rpath, rkey1)!=1
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) image=get_icon vis=get_vis checked=swap1
				cmd=run('cmd', '/c reg add "@lm9" /v "@rkey1" /t REG_DWORD /d "@if(swap1,1,0)" /f', 'runas', null, 0, 1) & reload & refresh) }
		menu(expanded=1 where=h_is11 title='Home') {
			//> https://www.elevenforum.com/t/add-or-remove-home-in-navigation-pane-of-file-explorer-in-windows-11.2449/
			$guid = '{f874310e-b6b7-47dc-bc84-b9e6b38f5903}'
			$pinned = get_show!=0
			$cr0_name = h_name
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_np_pin_toggle & reload)
			menu(title=get_name+' (manage)' image=get_icon where=key.shift()) { 
				//> https://www.elevenforum.com/t/move-home-to-top-or-bottom-of-navigation-pane-in-windows-11.12183/
				item(title='Restore pinned' cmd=o_np_pin_reset & reload)
				separator()
				item(title='Change position' cmd=o_np_pos_new & reload)
				item(title='Restore position' cmd=o_np_pos_reset & reload)
				separator()
				item(title='Show on desktop' checked=o_dt_ispin cmd=o_dt_pin_set) 
			} }
		menu(expanded=1 title='Frequent Places Folder' where= reg.exists(str.fmt(lm8, '{3936E9E4-D92C-4EEE-A85A-BC16D5EA0819}', 'Desktop'))) {
			//> https://www.elevenforum.com/t/add-and-remove-quick-access-folders-on-navigation-pane-of-file-explorer-in-windows-11.12407/
			$guid = '{3936E9E4-D92C-4EEE-A85A-BC16D5EA0819}'
			$pinned = reg.exists(str.fmt(lm8, guid, 'Desktop'))
			$cr0_tip = 'Quick Access Section'
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=if(pinned, run('cmd', '/c reg delete "@str.fmt(lm8, guid, 'Desktop')" /f', 'runas', null, 0, 1), run('cmd', '/c reg add "@str.fmt(lm8, guid, 'Desktop')" /f', 'runas', null, 0, 1)) & reload & refresh) }
		menu(expanded=1 title='Frequent Places Folder' where=!reg.exists(str.fmt(lm8, '{3936E9E4-D92C-4EEE-A85A-BC16D5EA0819}', 'Desktop'))) {
			$guid = '{3936E9E4-D92C-4EEE-A85A-BC16D5EA0819}'
			$pinned = reg.exists(str.fmt(cu8, guid, 'Desktop'))
			$cr0_tip = 'Quick Access Section'
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=if(pinned, run('cmd', '/c reg delete "@str.fmt(cu8, guid, 'Desktop')" /f', 'open', null, 0, 1), run('cmd', '/c reg add "@str.fmt(cu8, guid, 'Desktop')" /f', 'open', null, 0, 1)) & reload & refresh) }
		separator()
		menu(expanded=1 where=h_is10 title='HomeFolderDesktop - Block1') {
			//> https://www.howto-connect.com/delete-recent-frequent-from-file-explorer-on-windows-10/
			//> https://www.tenforums.com/tutorials/2713-add-remove-recent-files-quick-access-windows-10-a.html
			$guid = '{3134ef9c-6b18-4996-ad04-ed5912e00eb5}'
			$pinned = reg.exists(str.fmt(lm8, guid, 'HomeFolderDesktop'))
			$cr0_name = 'Eanble Quick access Section'
			$cr0_tip = 'Recent Files Folder'
			item(title=get_name keys='delegate' tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=if(pinned, run('cmd', '/c reg delete "@str.fmt(lm8, guid, 'HomeFolderDesktop')" /f', 'runas', null, 0, 1), run('cmd', '/c reg add "@str.fmt(lm8, guid, 'HomeFolderDesktop')" /f', 'runas', null, 0, 1)) & reload & refresh) }
		menu(expanded=1 where=h_is10 title='HomeFolderDesktop - Block2' vis=0) {
			//> https://www.howto-connect.com/delete-recent-frequent-from-file-explorer-on-windows-10/
			//> https://www.tenforums.com/tutorials/2712-add-remove-frequent-folders-quick-access-windows-10-a.html
			$guid = '{3936E9E4-D92C-4EEE-A85A-BC16D5EA0819}'
			$pinned = reg.exists(str.fmt(lm8, guid, 'HomeFolderDesktop'))
			$cr0_name = 'Eanble Recent Section'
			$cr0_tip = 'Frequent Places Folder'
			item(title=get_name keys='delegate' tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=if(pinned, run('cmd', '/c reg delete "@str.fmt(lm8, guid, 'HomeFolderDesktop')" /f', 'runas', null, 0, 1), run('cmd', '/c reg add "@str.fmt(lm8, guid, 'HomeFolderDesktop')" /f', 'runas', null, 0, 1)) & reload & refresh) }
		menu(expanded=1 where=h_is11 title='HomeFolderMSGraph - Block1') {
			//> https://www.elevenforum.com/t/add-or-remove-quick-access-in-file-explorer-home-in-windows-11.7092/
			//> https://www.elevenforum.com/t/add-and-remove-favorites-in-file-explorer-home-in-windows-11.6786/
			$guid = '{3936E9E4-D92C-4EEE-A85A-BC16D5EA0819}'
			$rpath1 = str.fmt(lm8, guid, 'HomeFolderMSGraph')
			$rpath2 = str.fmt(lm8, guid, 'HomeFolderMSGraph_WithRecommendations')
			$rpath3 = str.fmt(lm8, guid, 'HomeFolderMSGraph_WithShared')
			$rpath4 = str.fmt(lm8, guid, 'HomeFolderMSGraph_WithSharedNoRecommendations')
			$pinned = reg.exists(rpath1) or reg.exists(rpath4)
			$cr0_name = 'Eanble Quick access Section'
			$cr0_tip = 'Frequent Places Folder'
			item(title=get_name keys='delegate' tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=if(pinned, run('cmd', '/c reg delete "@rpath1" /f & reg delete "@rpath4" /f', 'runas', null, 0, 1), run('cmd', '/c reg add "@rpath1" /ve /d "Frequent Places Folder" /f & reg add "@rpath4" /ve /d "Frequent Places Folder" /f', 'runas', null, 0, 1)) & reload & refresh) }
		menu(expanded=1 where=h_is11 title='HomeFolderMSGraph - Block2' vis=0) {
			$guid = '{3134ef9c-6b18-4996-ad04-ed5912e00eb5}'
			$rpath1 = str.fmt(lm8, guid, 'HomeFolderMSGraph')
			$rpath2 = str.fmt(lm8, guid, 'HomeFolderMSGraph_WithRecommendations')
			$rpath3 = str.fmt(lm8, guid, 'HomeFolderMSGraph_WithShared')
			$rpath4 = str.fmt(lm8, guid, 'HomeFolderMSGraph_WithSharedNoRecommendations')
			$rpath5 = str.fmt(lm8, '{42254EE9-E625-4065-8F70-775090256F72}', 'HomeFolderMSGraph')
			$rpath6 = str.fmt(lm8, '{42254EE9-E625-4065-8F70-775090256F72}', 'HomeFolderMSGraph_WithRecommendations')
			$rpath7 = str.fmt(lm8, '{42254EE9-E625-4065-8F70-775090256F72}', 'HomeFolderMSGraph_WithShared')
			$rpath8 = str.fmt(lm8, '{42254EE9-E625-4065-8F70-775090256F72}', 'HomeFolderMSGraph_WithSharedNoRecommendations')
			$rpath9 = str.fmt(lm8, '{18F546F6-B34B-4B30-B4C6-5E88BED8BD84}', 'HomeFolderMSGraph')
			$rpath10= str.fmt(lm8, '{18F546F6-B34B-4B30-B4C6-5E88BED8BD84}', 'HomeFolderMSGraph_WithRecommendations')
			$rpath11= str.fmt(lm8, '{18F546F6-B34B-4B30-B4C6-5E88BED8BD84}', 'HomeFolderMSGraph_WithShared')
			$rpath12= str.fmt(lm8, '{18F546F6-B34B-4B30-B4C6-5E88BED8BD84}', 'HomeFolderMSGraph_WithSharedNoRecommendations')
			$pinned = reg.exists(rpath1) or reg.exists(rpath2) or reg.exists(rpath3) or reg.exists(rpath4) or reg.exists(rpath5) or reg.exists(rpath6) or reg.exists(rpath7) or reg.exists(rpath8) or reg.exists(rpath11) or reg.exists(rpath12)
			$cr0_name = 'Eanble Recent/Favorites/Shared'
			$cr0_tip = 'Frequent Places Folder'
			item(title=get_name keys='delegate' tip=get_tip image=get_icon checked=pinned vis=get_vis
				cmd=if(pinned, run('cmd', '/c reg delete "@rpath1" /f & reg delete "@rpath2" /f & reg delete "@rpath3" /f & reg delete "@rpath4" /f & reg delete "@rpath5" /f & reg delete "@rpath6" /f & reg delete "@rpath7" /f & reg delete "@rpath8" /f & reg delete "@rpath11" /f & reg delete "@rpath12" /f', 'runas', null, 0, 1), run('cmd', '/c reg add "@rpath1" /ve /d "Recent Files Folder" /f & reg add "@rpath2" /ve /d "Recent Files Folder" /f & reg add "@rpath3" /ve /d "Recent Files Folder" /f & reg add "@rpath4" /ve /d "Recent Files Folder" /f & reg add "@rpath5" /ve /d "MS Graph Recent Files Folder" /f & reg add "@rpath6" /ve /d "MS Graph Recent Files Folder" /f & reg add "@rpath7" /ve /d "MS Graph Recent Files Folder" /f & reg add "@rpath8" /ve /d "MS Graph Recent Files Folder" /f & reg add "@rpath11" /ve /d "Shared Files Folder" /f & reg add "@rpath12" /ve /d "Shared Files Folder" /f', 'runas', null, 0, 1)) & reload & refresh) }
		separator()
		menu(expanded=1 title='Home items') {
			$rpath = cu9
			//> https://www.elevenforum.com/t/add-or-remove-recent-files-in-file-explorer-home-in-windows-11.6825/
			$rkey1 = 'ShowRecent' 
			$swap1 = reg.get(rpath, rkey1)!=0
			item(title='Show recently used files'     checked=swap1 cmd=reg.set(rpath, rkey1, if(swap1,0,1), reg.dword) & reload & refresh)
			//> https://www.tenforums.com/tutorials/2712-add-remove-frequent-folders-quick-access-windows-10-a.html
			$rkey2 = 'ShowFrequent' 
			$swap2 = reg.get(rpath, rkey2)!=0
			item(title='Show frequently used folders' checked=swap2 cmd=reg.set(rpath, rkey2, if(swap2,0,1), reg.dword) & reload & refresh)
			//> https://www.elevenforum.com/t/enable-or-disable-show-files-from-office-com-in-file-explorer-home-in-windows-11.6886/
			$rkey3 = 'ShowCloudFilesInQuickAccess' 
			$swap3 = reg.get(rpath, rkey3)!=0
			item(title='Show files from Office.com'   checked=swap3 cmd=reg.set(rpath, rkey3, if(swap3,0,1), reg.dword) & reload & refresh) }
		separator()
		menu(expanded=1 title='Reset Quick access') {
			//> https://www.elevenforum.com/t/clear-and-reset-quick-access-folders-in-windows-11.4693/
			//+ https://www.elevenforum.com/t/backup-and-restore-quick-access-pinned-folders-in-windows-11.17299/
			$js='%AppData%\Microsoft\Windows\Recent\AutomaticDestinations\f01b4d95cf55d32a.automaticDestinations-ms'
			item(image=\uE025 vis=if(!path.exists(js), 2) title='Reset Quick access' tip='Clearing and resetting Quick access folders will remove all frequent and pinned folders in Quick access, and restore the default pinned Desktop, Documents, Downloads, Music, Pictures, and Videos folders in Quick access and File Explorer jump list.'
				cmd=io.delete(js) & reload & refresh) }
		menu(expanded=1 where=h_is11 title='Reset Favorites, Recent') {
			//> https://www.elevenforum.com/t/add-and-remove-favorites-in-file-explorer-home-in-windows-11.6786/
			$jp='%AppData%\Microsoft\Windows\Recent'
			$js='@jp\AutomaticDestinations\5f7b5f1e01b83767.automaticDestinations-ms'
			$jf=path.files(jp, '*.lnk', 3|16)
			item(image=\uE025 vis=if(!path.exists(js), 2) title='Reset favorites files'
				cmd=io.delete(js) & reload & refresh)
			item(image=\uE025 vis=if(len(jf)==0, 2) title='Reset favorites and recent files'
				cmd=run('powershell', `Get-ChildItem "$env:AppData\Microsoft\Windows\Recent" -Filter *.lnk | ForEach-Object { $sc = (New-Object -ComObject WScript.Shell).CreateShortcut($_.FullName); if([IO.Path]::GetExtension($sc.TargetPath)){ Remove-Item $_.FullName -Force } }`, 'open', null, 0, 1) & io.delete(js) & reload & refresh)
			item(image=\uE025 vis=if(len(jf)==0, 2) title='Reset favorites, recent files and folders'
				cmd=run('powershell', `Get-ChildItem "$env:AppData\Microsoft\Windows\Recent" -Filter *.lnk | ForEach-Object { Remove-Item $_.FullName -Force }`, 'open', null, 0, 1) & io.delete(js) & reload & refresh) }
		menu(expanded=1 where=h_is11 title='Reset OneDrive Jump List') {
			$js='%AppData%\Microsoft\Windows\Recent\AutomaticDestinations\5a2098e080cf7ac4.automaticDestinations-ms'
			item(image=\uE025 vis=if(!path.exists(js), 2) title='Reset recent files from Office.com'
				cmd=run('cmd', '/c del /f /s /q /a "@js', 'open', null, 0, 1) & reload & refresh) }
		menu(expanded=0 title='Jump List'+"\t"+'helper' vis=0) {
			/* editors
				https://github.com/Royosef/JumpListReader
				https://github.com/EricZimmerman/JLECmd */
			item(title='wiki' cmd='https://forensics.wiki/list_of_jump_list_ids')
			$jp='%AppData%\Microsoft\Windows\Recent'
			item(title='Open Recent' cmd=jp)
			item(title='Open AutomaticDestinations' cmd='@jp\AutomaticDestinations')
			item(title='Open CustomDestinations' cmd='@jp\CustomDestinations') } }
	menu(image=[\uE09C, image.color1] title='Clouds' tip='Cloud storage providers' where=reg.exists(str.fmt(cu1, '{018D5C66-4533-4307-9B53-224DE2ED1FE6}')) or reg.exists(str.fmt(cu1, '{E31EA727-12ED-4702-820C-4B6445F28E1A}'))) {
		menu(expanded=1 title='One Drive') {
			//> https://www.elevenforum.com/t/add-or-remove-onedrive-in-navigation-pane-of-file-explorer-in-windows-11.2478/
			$guid = '{018D5C66-4533-4307-9B53-224DE2ED1FE6}'
			$pinned = get_show==1
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_np_pin_toggle & o_np_set & reload) }
		menu(expanded=1 title='Dropbox') {
			//> https://www.thewindowsclub.com/remove-dropbox-from-explorer-navigation-pane
			$guid = '{E31EA727-12ED-4702-820C-4B6445F28E1A}'
			$pinned = get_show==1
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_np_pin_toggle & o_np_set & reload) }
		menu(expanded=1 title='Google Drive' tip='empty') {
			//> https://winaero.com/download-add-remove-google-drive-in-navigation-pane-in-windows-10/
			//- https://superuser.com/questions/1750754/custom-entry-in-windows-explorer-navigation-pane
			// https://learn.microsoft.com/en-us/windows/win32/shell/integrate-cloud-storage
			}
		separator()
		menu(expanded=1 title='Show availability status' where=reg.exists(str.fmt(cu1, '{018D5C66-4533-4307-9B53-224DE2ED1FE6}'))) {
			//> https://www.elevenforum.com/t/enable-or-disable-show-onedrive-status-on-navigation-pane-in-windows-11.10952/
			//- https://en.wikipedia.org/wiki/List_of_shell_icon_overlay_identifiers
			$rpath = cu9+'\Advanced'
			$rkey1 = 'NavPaneShowAllCloudStates'
			$show1 = reg.get(rpath, rkey1)==1
			item(title='Show availability status' image=\uE083 checked=show1 tip='Show OneDrive status on Navigation Pane. reopen explorer to take effects' cmd=reg.set(rpath, rkey1, if(show1,0,1), reg.dword) & reload & refresh & reopen) } }
	menu(image=[\uE09F, image.color1] title='Private' tip='User folders and libraries') {
		menu(expanded=1 title='Gallery') {
			//> https://www.elevenforum.com/t/add-or-remove-gallery-in-file-explorer-navigation-pane-in-windows-11.14178/
			$guid = '{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}'
			$pinned = get_show!=0
			$cu1_name = 'Gallery'
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_np_pin_toggle & o_np_set & reload) }
		menu(expanded=1 title='Cross Device') {
			//> https://www.elevenforum.com/t/enable-or-disable-android-phone-access-in-file-explorer-in-windows-11.27098/
			$rpath = 'HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\SyncRootManager'
			$rk = reg.keys(rpath)
			$guid = null
			$guid_search = for(i=0, i<len(rk)) { if(guid!=null , break) if(str.start(rk[i], 'CrossDevice'), { guid=reg.get(rpath+'\'+rk[i], 'NamespaceCLSID') }) }
			$pinned = get_show==1
			item(title=guid_search+get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_np_pin_toggle & o_np_set & reload) }
		menu(expanded=1 title='User Folder') {
			//> https://www.elevenforum.com/t/add-or-remove-user-folder-in-navigation-pane-of-file-explorer-in-windows-11.10628/
			$guid = '{59031a47-3f72-44a7-89c5-5595fe6b30ee}'
			$cr0_name = 'User Folder'
			$cr0_pos = 73
			$pinned = get_show!=0
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_np_pin_toggle & o_np_set & reload) }
		separator()
		menu(expanded=1 title='Desktop') {
			$guid = if(reg.exists(str.fmt(lm5, '{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}'), 'ParsingName'), reg.get(str.fmt(lm5, '{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}'), 'ParsingName').replace('shell:::',''), '{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}')
			$pinned = get_show==1
			$cr0_pos  = 65
			$cr0_name = 'Desktop' 
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_np_pin_toggle & o_np_pos_set & o_np_set & reload) }
		menu(expanded=1 title='Local Documents' where= str.contains(reg.get(cu9+'\User Shell Folders', 'Personal'), 'OneDrive')) {
			$guid = if(reg.exists(str.fmt(lm5, '{f42ee2d3-909f-4907-8871-4c22fc0bf756}'), 'ParsingName'), reg.get(str.fmt(lm5, '{f42ee2d3-909f-4907-8871-4c22fc0bf756}'), 'ParsingName').replace('shell:::',''), '{f42ee2d3-909f-4907-8871-4c22fc0bf756}')
			$pinned = get_show==1
			$cr0_name = 'Local Documents' // {d3162b92-9365-467a-956b-92703aca08af}
			$cr0_pos  = 65
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_np_pin_toggle & o_np_set & reload) }
		menu(expanded=1 title='Documents'       where=!str.contains(reg.get(cu9+'\User Shell Folders', 'Personal'), 'OneDrive')) {
			$guid = if(reg.exists(str.fmt(lm5, '{FDD39AD0-238F-46AF-ADB4-6C85480369C7}'), 'ParsingName'), reg.get(str.fmt(lm5, '{FDD39AD0-238F-46AF-ADB4-6C85480369C7}'), 'ParsingName').replace('shell:::',''), '{FDD39AD0-238F-46AF-ADB4-6C85480369C7}')
			$pinned = get_show==1
			$cr0_name = 'Documents' 
			$cr0_pos  = 65
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_np_pin_toggle & o_np_pos_set & o_np_set & reload) }
		menu(expanded=1 title='Local Downloads' where= str.contains(reg.get(cu9+'\User Shell Folders', 'Downloads'), 'OneDrive')) {
			$guid = if(reg.exists(str.fmt(lm5, '{7d83ee9b-2244-4e70-b1f5-5393042af1e4}'), 'ParsingName'), reg.get(str.fmt(lm5, '{7d83ee9b-2244-4e70-b1f5-5393042af1e4}'), 'ParsingName').replace('shell:::',''), '{7d83ee9b-2244-4e70-b1f5-5393042af1e4}')
			$pinned = get_show==1
			$cr0_name = 'Local Downloads' 
			$cr0_pos  = 65
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_np_pin_toggle & o_np_pos_set & o_np_set & reload) }
		menu(expanded=1 title='Downloads'       where=!str.contains(reg.get(cu9+'\User Shell Folders', 'Downloads'), 'OneDrive')) {
			$guid = if(reg.exists(str.fmt(lm5, '{374DE290-123F-4565-9164-39C4925E467B}'), 'ParsingName'), reg.get(str.fmt(lm5, '{374DE290-123F-4565-9164-39C4925E467B}'), 'ParsingName').replace('shell:::',''), '{374DE290-123F-4565-9164-39C4925E467B}')
			$pinned = get_show==1
			$cr0_name = 'Downloads' 
			$cr0_pos  = 65
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_np_pin_toggle & o_np_pos_set & o_np_set & reload) }
		menu(expanded=1 title='Local Pictures'  where= str.contains(reg.get(cu9+'\User Shell Folders', 'My Pictures'), 'OneDrive')) {
			$guid = if(reg.exists(str.fmt(lm5, '{0ddd015d-b06c-45d5-8c4c-f59713854639}'), 'ParsingName'), reg.get(str.fmt(lm5, '{0ddd015d-b06c-45d5-8c4c-f59713854639}'), 'ParsingName').replace('shell:::',''), '{0ddd015d-b06c-45d5-8c4c-f59713854639}')
			$pinned = get_show==1
			$cr0_name = 'Local Pictures' 
			$cr0_pos  = 65
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_np_pin_toggle & o_np_pos_set & o_np_set & reload) }
		menu(expanded=1 title='Pictures'        where=!str.contains(reg.get(cu9+'\User Shell Folders', 'My Pictures'), 'OneDrive')) {
			$guid = if(reg.exists(str.fmt(lm5, '{33E28130-4E1E-4676-835A-98395C3BC3BB}'), 'ParsingName'), reg.get(str.fmt(lm5, '{33E28130-4E1E-4676-835A-98395C3BC3BB}'), 'ParsingName').replace('shell:::',''), '{33E28130-4E1E-4676-835A-98395C3BC3BB}')
			$pinned = get_show==1
			$cr0_name = 'Pictures' 
			$cr0_pos  = 65
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_np_pin_toggle & o_np_pos_set & o_np_set & reload) }
		menu(expanded=1 title='Local Music'     where= str.contains(reg.get(cu9+'\User Shell Folders', 'My Music'), 'OneDrive')) {
			$guid = if(reg.exists(str.fmt(lm5, '{a0c69a99-21c8-4671-8703-7934162fcf1d}'), 'ParsingName'), reg.get(str.fmt(lm5, '{a0c69a99-21c8-4671-8703-7934162fcf1d}'), 'ParsingName').replace('shell:::',''), '{a0c69a99-21c8-4671-8703-7934162fcf1d}')
			$pinned = get_show==1
			$cr0_name = 'Local Music' 
			$cr0_pos  = 65
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_np_pin_toggle & o_np_pos_set & o_np_set & reload) }
		menu(expanded=1 title='Music'           where=!str.contains(reg.get(cu9+'\User Shell Folders', 'My Music'), 'OneDrive')) {
			$guid = if(reg.exists(str.fmt(lm5, '{4BD8D571-6D19-48D3-BE97-422220080E43}'), 'ParsingName'), reg.get(str.fmt(lm5, '{4BD8D571-6D19-48D3-BE97-422220080E43}'), 'ParsingName').replace('shell:::',''), '{4BD8D571-6D19-48D3-BE97-422220080E43}')
			$pinned = get_show==1
			$cr0_name = 'Music' 
			$cr0_pos  = 65
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_np_pin_toggle & o_np_pos_set & o_np_set & reload) }
		menu(expanded=1 title='Local Videos'    where= str.contains(reg.get(cu9+'\User Shell Folders', 'My Video'), 'OneDrive')) {
			$guid = if(reg.exists(str.fmt(lm5, '{35286a68-3c57-41a1-bbb1-0eae73d76c95}'), 'ParsingName'), reg.get(str.fmt(lm5, '{35286a68-3c57-41a1-bbb1-0eae73d76c95}'), 'ParsingName').replace('shell:::',''), '{35286a68-3c57-41a1-bbb1-0eae73d76c95}')
			$pinned = get_show==1
			$cr0_name = 'Local Videos' 
			$cr0_pos  = 65
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_np_pin_toggle & o_np_pos_set & o_np_set & reload) }
		menu(expanded=1 title='Videos'          where=!str.contains(reg.get(cu9+'\User Shell Folders', 'My Video'), 'OneDrive')) {
			$guid = if(reg.exists(str.fmt(lm5, '{18989B1D-99B5-455B-841C-AB7C74E4DDFC}'), 'ParsingName'), reg.get(str.fmt(lm5, '{18989B1D-99B5-455B-841C-AB7C74E4DDFC}'), 'ParsingName').replace('shell:::',''), '{18989B1D-99B5-455B-841C-AB7C74E4DDFC}')
			$pinned = get_show==1
			$cr0_name = 'Videos' 
			$cr0_pos  = 65
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_np_pin_toggle & o_np_pos_set & o_np_set & reload) }
		menu(expanded=1 title='3D Objects'      where=path.exists(path.getknownfolder('{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}'))) {
			$guid = if(reg.exists(str.fmt(lm5, '{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}'), 'ParsingName'), reg.get(str.fmt(lm5, '{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}'), 'ParsingName').replace('shell:::',''), '{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}')
			$pinned = get_show==1
			$cr0_name = '3D Objects' 
			$cr0_pos  = 65
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_np_pin_toggle & o_np_pos_set & o_np_set & reload) }
		separator()
		menu(expanded=1 title='Libraries') {
			//> https://www.elevenforum.com/t/add-or-remove-libraries-in-file-explorer-navigation-pane-in-windows-11.5953/
			$guid = '{031E4825-7B94-4dc3-B131-E946B44C8DD5}'
			$pinned = get_show==1
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_np_pin_toggle & o_np_set & reload) } }
	menu(image=[\uE0D1, image.color2] title='This PC' tip='This PC settings and folders') {
		// \uE1D9
		menu(expanded=1 title='This PC') {
			//> https://www.elevenforum.com/t/add-or-remove-this-pc-in-navigation-pane-of-file-explorer-in-windows-11.7293/
			$guid = '{20D04FE0-3AEA-1069-A2D8-08002B30309D}'
			$pinned = get_show!=0
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_np_pin_toggle & o_np_set & reload) }
		separator()
		menu(expanded=0 title='Hide Drives' image=\uE12D tip='Hide specific drives from the system. it requires a restart to take effect.') {
			// https://www.elevenforum.com/t/hide-specific-drives-in-windows-11.16124/
			$rpath = 'HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer'
			$r_hex = reg.get(rpath, 'NoDrives')
			$hex = null
			$result = null
			$check = for(i=0, i>=0) {
				if(i==0, hex=1)
				if(i==0, result='|')
				$temp = (r_hex / hex) % 2
				if(temp == 1, result += hex + '|')
				hex = hex*2
				if(hex > r_hex, break) }
			menu(expanded=1 title={ check }) {
				item(title = "\xE10B" tip='Show all drives' sep='after' checked=len(result)<3 where=key.shift()
					commands { admin cmd-line='/c reg add "@rpath" /v NoDrives /t REG_DWORD /d 0 /f & exit' window=0 wait=1, cmd=restart })
				item(vis=if(!path.exists('A:'),2) title = 'A:' checked=str.contains(result, '|1|') where=key.shift()
					commands { admin cmd-line='/c reg add "@rpath" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|1|'), r_hex - 1, r_hex + 1) /f & exit' window=0 wait=1, cmd=restart })
				item(vis=if(!path.exists('B:'),2) title = 'B:' checked=str.contains(result, '|2|') where=key.shift()
					commands { admin cmd-line='/c reg add "@rpath" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|2|'), r_hex - 2, r_hex + 2) /f & exit' window=0 wait=1, cmd=restart })
				item(vis=if(!path.exists('C:'),2) title = 'C:' checked=str.contains(result, '|4|')
					commands { admin cmd-line='/c reg add "@rpath" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|4|'), r_hex - 4, r_hex + 4) /f & exit' window=0 wait=1, cmd=restart })
				item(vis=if(!path.exists('D:'),2) title = 'D:' checked=str.contains(result, '|8|')
					commands { admin cmd-line='/c reg add "@rpath" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|8|'), r_hex - 8, r_hex + 8) /f & exit' window=0 wait=1, cmd=restart })  
				item(vis=if(!path.exists('E:'),2) title = 'E:' checked=str.contains(result, '|16|')
					commands { admin cmd-line='/c reg add "@rpath" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|16|'), r_hex - 16, r_hex + 16) /f & exit' window=0 wait=1, cmd=restart })
				item(vis=if(!path.exists('F:'),2) title = 'F:' checked=str.contains(result, '|32|')
					commands { admin cmd-line='/c reg add "@rpath" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|32|'), r_hex - 32, r_hex + 32) /f & exit' window=0 wait=1, cmd=restart })
				item(vis=if(!path.exists('G:'),2) title = 'G:' checked=str.contains(result, '|64|')
					commands { admin cmd-line='/c reg add "@rpath" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|64|'), r_hex - 64, r_hex + 64) /f & exit' window=0 wait=1, cmd=restart })
				item(vis=if(!path.exists('H:'),2) title = 'H:' checked=str.contains(result, '|128|')
					commands { admin cmd-line='/c reg add "@rpath" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|128|'), r_hex - 128, r_hex + 128) /f & exit' window=0 wait=1, cmd=restart })
				item(vis=if(!path.exists('I:'),2) title = 'I:' checked=str.contains(result, '|256|')
					commands { admin cmd-line='/c reg add "@rpath" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|256|'), r_hex - 256, r_hex + 256) /f & exit' window=0 wait=1, cmd=restart })
				item(vis=if(!path.exists('J:'),2) title = 'J:' checked=str.contains(result, '|512|')
					commands { admin cmd-line='/c reg add "@rpath" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|512|'), r_hex - 512, r_hex + 512) /f & exit' window=0 wait=1, cmd=restart })
				item(vis=if(!path.exists('K:'),2) title = 'K:' checked=str.contains(result, '|1024|')
					commands { admin cmd-line='/c reg add "@rpath" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|1024|'), r_hex - 1024, r_hex + 1024) /f & exit' window=0 wait=1, cmd=restart })
				item(vis=if(!path.exists('L:'),2) title = 'L:' checked=str.contains(result, '|2048|')
					commands { admin cmd-line='/c reg add "@rpath" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|2048|'), r_hex - 2048, r_hex + 2048) /f & exit' window=0 wait=1, cmd=restart })
				item(vis=if(!path.exists('M:'),2) title = 'M:' checked=str.contains(result, '|4096|')
					commands { admin cmd-line='/c reg add "@rpath" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|4096|'), r_hex - 4096, r_hex + 4096) /f & exit' window=0 wait=1, cmd=restart })
				item(title = "\xE10A" tip='Hide all drives' sep='after' checked=str.contains(result, '|67108863|') where=key.shift() col=key.shift()
					commands { admin cmd-line='/c reg add "@rpath" /v NoDrives /t REG_DWORD /d 67108863 /f & exit' window=0 wait=1, cmd=restart })
				item(vis=if(!path.exists('N:'),2) title = 'N:' checked=str.contains(result, '|8192|')
					commands { admin cmd-line='/c reg add "@rpath" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|8192|'), r_hex - 8192, r_hex + 8192) /f & exit' window=0 wait=1, cmd=restart })
				item(vis=if(!path.exists('O:'),2) title = 'O:' checked=str.contains(result, '|16384|') col=!key.shift()
					commands { admin cmd-line='/c reg add "@rpath" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|16384|'), r_hex - 16384, r_hex + 16384) /f & exit' window=0 wait=1, cmd=restart })
				item(vis=if(!path.exists('P:'),2) title = 'P:' checked=str.contains(result, '|32768|')
					commands { admin cmd-line='/c reg add "@rpath" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|32768|'), r_hex - 32768, r_hex + 32768) /f & exit' window=0 wait=1, cmd=restart })
				item(vis=if(!path.exists('Q:'),2) title = 'Q:' checked=str.contains(result, '|65536|')
					commands { admin cmd-line='/c reg add "@rpath" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|65536|'), r_hex - 65536, r_hex + 65536) /f & exit' window=0 wait=1, cmd=restart })
				item(vis=if(!path.exists('R:'),2) title = 'R:' checked=str.contains(result, '|131072|')
					commands { admin cmd-line='/c reg add "@rpath" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|131072|'), r_hex - 131072, r_hex + 131072) /f & exit' window=0 wait=1, cmd=restart })
				item(vis=if(!path.exists('S:'),2) title = 'S:' checked=str.contains(result, '|262144|')
					commands { admin cmd-line='/c reg add "@rpath" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|262144|'), r_hex - 262144, r_hex + 262144) /f & exit' window=0 wait=1, cmd=restart })
				item(vis=if(!path.exists('T:'),2) title = 'T:' checked=str.contains(result, '|524288|')
					commands { admin cmd-line='/c reg add "@rpath" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|524288|'), r_hex - 524288, r_hex + 524288) /f & exit' window=0 wait=1, cmd=restart })
				item(vis=if(!path.exists('U:'),2) title = 'U:' checked=str.contains(result, '|1048576|')
					commands { admin cmd-line='/c reg add "@rpath" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|1048576|'), r_hex - 1048576, r_hex + 1048576) /f & exit' window=0 wait=1, cmd=restart })
				item(vis=if(!path.exists('V:'),2) title = 'V:' checked=str.contains(result, '|2097152|')
					commands { admin cmd-line='/c reg add "@rpath" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|2097152|'), r_hex - 2097152, r_hex + 2097152) /f & exit' window=0 wait=1, cmd=restart })
				item(vis=if(!path.exists('W:'),2) title = 'W:' checked=str.contains(result, '|4194304|')
					commands { admin cmd-line='/c reg add "@rpath" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|4194304|'), r_hex - 4194304, r_hex + 4194304) /f & exit' window=0 wait=1, cmd=restart })
				item(vis=if(!path.exists('X:'),2) title = 'X:' checked=str.contains(result, '|8388608|')
					commands { admin cmd-line='/c reg add "@rpath" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|8388608|'), r_hex - 8388608, r_hex + 8388608) /f & exit' window=0 wait=1, cmd=restart })
				item(vis=if(!path.exists('Y:'),2) title = 'Y:' checked=str.contains(result, '|16777216|')
					commands { admin cmd-line='/c reg add "@rpath" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|16777216|'), r_hex - 16777216, r_hex + 16777216) /f & exit' window=0 wait=1, cmd=restart })
				item(vis=if(!path.exists('Z:'),2) title = 'Z:' checked=str.contains(result, '|33554432|')
					commands { admin cmd-line='/c reg add "@rpath" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|33554432|'), r_hex - 33554432, r_hex + 33554432) /f & exit' window=0 wait=1, cmd=restart }) } }
		menu(expanded=0 title='Private Folders' image='shell32.dll,19' tip='Show or hide folders under This PC') {
			//> https://www.elevenforum.com/t/add-or-remove-folders-under-this-pc-in-file-explorer-in-windows-11.7122/
			//> https://winaero.com/windows-11-remove-folders-from-this-pc/
			$guid_2 = if(reg.exists(str.fmt(lm5, guid), 'ParsingName'), reg.get(str.fmt(lm5, guid), 'ParsingName').replace('shell:::',''), guid)
			$desabled1 = reg.get(str.fmt(lm5+'\PropertyBag', guid), 'ThisPCPolicy')=='Hide'
			$desabled2 = reg.get(str.fmt(lm4, pco_guid), 'HideIfEnabled')=='36354489'
			$desabled3 = reg.get(str.fmt(lm4, pco_guid), 'HiddenByDefault')==1			
			$pinned = not(desabled1 or desabled2 or desabled3)
			$o_pc_pin_toggle = run('cmd', '/c reg add "@str.fmt(lm5+'\PropertyBag', guid)" /v "ThisPCPolicy" /d @if(pinned,'Hide','Show') /f & reg delete "@str.fmt(lm4, guid_2)" /v HideIfEnabled /f & reg delete "@str.fmt(lm4, guid_2)" /v HiddenByDefault /f', 'runas', null, 0, 1)
			separator()
			menu(expanded=1 title='Desktop') {
				$guid  = '{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}'
				$cr0_name = 'Desktop' 
				item(title=get_name tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_pc_pin_toggle & reload & command.sleep(100) & refresh) }
			menu(expanded=1 title='Local Documents') {
				$guid = '{f42ee2d3-909f-4907-8871-4c22fc0bf756}'
				$cr0_name = 'Local Documents' 
				item(title=get_name tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_pc_pin_toggle & reload & command.sleep(100) & refresh) }
			menu(expanded=1 title='Documents') {
				$guid = '{FDD39AD0-238F-46AF-ADB4-6C85480369C7}'
				$cr0_name = 'Documents' 
				item(title=get_name tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_pc_pin_toggle & reload & command.sleep(100) & refresh) }
			menu(expanded=1 title='Local Downloads') {
				$guid = '{7d83ee9b-2244-4e70-b1f5-5393042af1e4}'
				$cr0_name = 'Local Downloads' 
				item(title=get_name tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_pc_pin_toggle & reload & command.sleep(100) & refresh) }
			menu(expanded=1 title='Downloads') {
				$guid = '{374DE290-123F-4565-9164-39C4925E467B}'
				$cr0_name = 'Downloads' 
				item(title=get_name tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_pc_pin_toggle & reload & command.sleep(100) & refresh) }
			menu(expanded=1 title='Local Pictures') {
				$guid = '{0ddd015d-b06c-45d5-8c4c-f59713854639}'
				$cr0_name = 'Local Pictures' 
				item(title=get_name tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_pc_pin_toggle & reload & command.sleep(100) & refresh) }
			menu(expanded=1 title='Pictures') {
				$guid = '{33E28130-4E1E-4676-835A-98395C3BC3BB}'
				$cr0_name = 'Pictures' 
				item(title=get_name tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_pc_pin_toggle & reload & command.sleep(100) & refresh) }
			menu(expanded=1 title='Local Music') {
				$guid = '{a0c69a99-21c8-4671-8703-7934162fcf1d}'
				$cr0_name = 'Local Music' 
				item(title=get_name tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_pc_pin_toggle & reload & command.sleep(100) & refresh) }
			menu(expanded=1 title='Music') {
				$guid = '{4BD8D571-6D19-48D3-BE97-422220080E43}'
				$cr0_name = 'Music' 
				item(title=get_name tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_pc_pin_toggle & reload & command.sleep(100) & refresh) }
			menu(expanded=1 title='Local Videos') {
				$guid = '{35286a68-3c57-41a1-bbb1-0eae73d76c95}'
				$cr0_name = 'Local Videos' 
				item(title=get_name tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_pc_pin_toggle & reload & command.sleep(100) & refresh) }
			menu(expanded=1 title='Videos') {
				$guid = '{18989B1D-99B5-455B-841C-AB7C74E4DDFC}'
				$cr0_name = 'Videos' 
				item(title=get_name tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_pc_pin_toggle & reload & command.sleep(100) & refresh) }
			menu(expanded=1 title='3D Objects' where=path.exists(path.getknownfolder('{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}'))) {
				$guid = '{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}'
				$cr0_name = '3D Objects'
				item(title=get_name tip=get_tip image=get_icon checked=o_ps_ispin vis=get_vis cmd=o_pc_set & reload & command.sleep(100) & refresh) } }
		separator()
		menu(expanded=1 title='This PC') {
			item(title='Add Network Location' image='shell32.dll,85' cmd-shell='shell:::{D4480A50-BA28-11d1-8E75-00C04FA31A86}') } }
	menu(image=[\uE169, image.color1] title='System' tip='System folders and devices') {
		menu(expanded=1 title='Removable Drives' where= reg.exists(str.fmt(lm8, '{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}', 'Desktop'))) {
			//> https://www.elevenforum.com/t/add-or-remove-duplicate-drives-in-navigation-pane-of-file-explorer-in-windows-11.3043/
			//> https://winaero.com/how-to-remove-removable-drives-from-navigation-pane-in-windows-11/
			$guid = '{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}'
			$pinned = reg.exists(str.fmt(lm8, guid, 'Desktop'))
			$cr0_tip = 'Duplicate Drives in Navigation Pane of File Explorer'
			$cr0_icon = 'imageres.dll,-75'
			item(title=get_name keys='delegate' tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=if(pinned, run('cmd', '/c reg delete "@str.fmt(lm8, guid, 'Desktop')" /f', 'runas', null, 0, 1), run('cmd', '/c reg add "@str.fmt(lm8, guid, 'Desktop')" /f', 'runas', null, 0, 1)) & reload & refresh) }
		menu(expanded=1 title='Removable Drives' where=!reg.exists(str.fmt(lm8, '{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}', 'Desktop'))) {
			$guid = '{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}'
			$pinned = reg.exists(str.fmt(cu8, guid, 'Desktop'))
			$cr0_tip = 'Duplicate Drives in Navigation Pane of File Explorer'
			$cr0_icon = 'imageres.dll,-75'
			item(title=get_name keys='delegate' tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=if(pinned, run('cmd', '/c reg delete "@str.fmt(cu8, guid, 'Desktop')" /f', 'open', null, 0, 1), run('cmd', '/c reg add "@str.fmt(cu8, guid, 'Desktop')" /f', 'open', null, 0, 1)) & reload & refresh) }
		menu(expanded=1 title='Removable Drives' where=key.shift()) {
			//> https://www.elevenforum.com/t/add-or-remove-network-in-navigation-pane-of-file-explorer-in-windows-11.7272/
			$guid = '{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}'
			$pinned = get_show==1
			$cr0_icon = 'imageres.dll,-75'
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_np_pin_toggle & o_np_set & reload) }
		separator()
		menu(expanded=1 title='Network') {
			//> https://www.elevenforum.com/t/add-or-remove-network-in-navigation-pane-of-file-explorer-in-windows-11.7272/
			$guid = '{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}'
			$pinned = get_show!=0
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_np_pin_toggle & o_np_set & reload) }
		menu(expanded=1 title='Network Connections*' where=key.shift()) {
			$guid = '{7007ACC7-3202-11D1-AAD2-00805FC1270E}'
			$pinned = get_show==1
			$cr0_pos = 88
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_np_pin_toggle & o_np_set & reload) }
		menu(expanded=1 title='Control Panel') {
			//> https://www.elevenforum.com/t/add-or-remove-control-panel-in-navigation-pane-of-file-explorer-in-windows-11.12388/
			$guid = '{26EE0668-A00A-44D7-9371-BEB064C98683}'
			$pinned = get_show==1
			$cr0_pos  = 88
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_np_pin_toggle & o_np_set & reload) }
		menu(expanded=1 title='Device Center*' where=key.shift()) {
			//> https://www.elevenforum.com/t/add-or-remove-devices-and-printers-in-navigation-pane-of-file-explorer-in-windows-11.7783/
			$guid = '{A8A91A66-3A7D-4424-8D24-04E180695C7A}'
			$pinned = get_show==1
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_np_pin_toggle & o_np_set & reload) }
		menu(expanded=1 title='Printers*') {
			//> https://www.elevenforum.com/t/add-or-remove-printers-in-navigation-pane-of-file-explorer-in-windows-11.10553/
			$guid = '{2227A280-3AEA-1069-A2DE-08002B30309D}'
			$pinned = get_show==1
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_np_pin_toggle & o_np_set & reload) }
		separator()
		menu(expanded=1 title='Linux' where=reg.exists('HKCU\Software\Microsoft\Windows\CurrentVersion\Lxss')) {
			//> https://www.elevenforum.com/t/add-or-remove-linux-in-navigation-pane-of-file-explorer-in-windows-11.2531/
			$guid = '{B2B4A4D1-2754-4140-A2EB-9A76D9D7CDC6}'
			$pinned = get_show!=0
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_np_pin_toggle & o_np_set & reload) }
		menu(expanded=1 title='Recycle Bin') {
			//> https://www.elevenforum.com/t/add-or-remove-recycle-bin-in-navigation-pane-of-file-explorer-in-windows-11.6255/
			$guid = '{645FF040-5081-101B-9F08-00AA002F954E}'
			$pinned = get_show==1
			item(title=get_name keys=if(len(get_pos)>0, 'pos: '+get_pos) tip=get_tip image=get_icon checked=pinned vis=get_vis cmd=o_np_pin_toggle & o_np_set & reload) } }
	menu(image=[\uE142, image.color1] title='Custom' tip='Custom navigation pane items') {
		//> https://www.winhelponline.com/blog/add-custom-folder-this-pc-navigation-pane-windows/
		//- https://gist.github.com/rikka0w0/f4fdedb1c6a39a484f6ac982c4a4dedd
		/* guid keys to use  
			{00000000-0000-0000-8A32-11F3E2A9B4D0} # Nilesoft Shell
			{00000000-0000-0000-A12F-4478BC12EE89} # Nilesoft Shell
			{00000000-0000-0000-9C45-72F11D99A501} # custom path
			{00000000-0000-0000-B7E4-5560A3C8D2F7} # custom path
			{00000000-0000-0000-F843-23DD7100A5E2} # custom path
			{00000000-0000-0000-82F1-44C9A77B9E32} # custom path
			{00000000-0000-0000-CE98-0F4435A1C6BB} - in use
			{00000000-0000-0000-D221-19A8B55EE490} - in use
			{00000000-0000-0000-EF10-8BC92A43F7C1} - in use
			{00000000-0000-0000-94AB-0F2C1137D5A4}
			{00000000-0000-0000-A7C4-6E5B88201F9D}
			{00000000-0000-0000-B3D0-514CC7E49128}
			{00000000-0000-0000-C8F9-7B22AA4DE013}
			{00000000-0000-0000-DB14-2AEF6C0B8AA5}
			{00000000-0000-0000-E0CE-9D5814420F7C}
			{00000000-0000-0000-F9A2-333771A8C4D1}
			*/
		menu(expanded=1 title='Nilesoft Shell') {
			$guid = '{00000000-0000-0000-8A32-11F3E2A9B4D0}'
			$pinned = get_show==1
			$cr0_path = app.dir
			$cr0_name = 'Nilesoft Shell'
			$cr0_tip  = get_path
			$cr0_icon = app.exe
			menu(where= o__exists title=get_name tip=get_tip image=get_icon) { 
				item(title='Show in Navigation Pane' sep=1 checked=pinned cmd=o_np_pin_toggle & reload)
				item(title='Change position' keys=if(len(get_pos)>0, 'pos: '+get_pos) image=\uE0A2 vis=if(!pinned, 2) cmd=o_np_pos_new & reload)
				item(title='Show in This PC' sep=1 checked=o_ps_ispin cmd=o_pc_set & command.sleep(100) & refresh)
				item(title='Change Type' image=\uE135 vis=if(!o_ps_ispin, 2) cmd=o_pc_type_new & refresh)
				item(title='Show on Desktop' sep=1 checked=o_dt_ispin cmd=o_dt_pin_set)
				separator()
				item(title='Change Title' keys='+ reset' image=\uE0B7 cmd=o__name_new & reload)
				item(title='Change Icon' keys='+ reset' image=\uE0BF cmd=o__icon_new & reload)
				menu(title='Attributes') {
					$rkey = str.fmt(cu1, guid)+'\ShellFolder'
					item(checked=(cu1_atrb & 0x01) keys='0x01' title='Can Copy' tip='Items can be copied (Ctrl+C). Disabling prevents copying files from this folder.'
						cmd=if((cu1_atrb & 0x01), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x01), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x01), reg.dword)))
					item(checked=(cu1_atrb & 0x02) keys='0x02' title='Can Move/Cut' tip='Items can be moved or cut (Ctrl+X). Disabling prevents moving/cutting files.'
						cmd=if((cu1_atrb & 0x02), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x02), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x02), reg.dword)))
					item(checked=(cu1_atrb & 0x04) keys='0x04' title='Can Create Link' tip='Shortcuts can be created for items. Disabling removes "Create shortcut" from context menu.'
						cmd=if((cu1_atrb & 0x04), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x04), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x04), reg.dword)))
					item(checked=(cu1_atrb & 0x08) keys='0x08' title='Has Storage' tip='Items support IStorage interface. Required for proper folder functionality - keep enabled.'
						cmd=if((cu1_atrb & 0x08), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x08), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x08), reg.dword)))
					item(checked=(cu1_atrb & 0x10) keys='0x10' title='Can Rename' tip='Items can be renamed (F2). Disabling prevents renaming files and folders.'
						cmd=if((cu1_atrb & 0x10), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10), reg.dword)))
					item(checked=(cu1_atrb & 0x20) keys='0x20' title='Can Delete' tip='Items can be deleted (Del). Disabling prevents deletion and removes "Delete" from context menu.'
						cmd=if((cu1_atrb & 0x20), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20), reg.dword)))
					item(checked=(cu1_atrb & 0x40) keys='0x40' title='Has Property Sheet' tip='Items have property sheets (right-click → Properties). Required for Properties dialog.'
						cmd=if((cu1_atrb & 0x40), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40), reg.dword)))
					item(checked=(cu1_atrb & 0x80) keys='0x80' title='Drop Target' tip='Folder can receive dropped files. Disabling prevents drag-and-drop into this folder.'
						cmd=if((cu1_atrb & 0x80), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80), reg.dword)))
					separator()
					// Additional Flags
					item(checked=(cu1_atrb & 0x100) keys='0x100' title='Is Link' tip='The specified items are shortcuts.'
						cmd=if((cu1_atrb & 0x100), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x100), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x100), reg.dword)))
					item(checked=(cu1_atrb & 0x200) keys='0x200' title='Can Share' tip='The specified folder objects are shared.'
						cmd=if((cu1_atrb & 0x200), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x200), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x200), reg.dword)))
					item(checked=(cu1_atrb & 0x400) keys='0x400' title='Read Only' tip='The specified items are read-only. In the case of folders, this means that new items cannot be created in those folders.'
						cmd=if((cu1_atrb & 0x400), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x400), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x400), reg.dword)))
					item(checked=(cu1_atrb & 0x800) keys='0x800' title='Ghosted/Dimmed'
						cmd=if((cu1_atrb & 0x800), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x800), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x800), reg.dword)))
					separator()
					// Folder Flags
					item(checked=(cu1_atrb & 0x1000) keys='0x1000' title='System' tip='Item is a system object. Windows treats it as protected system content.'
						cmd=if((cu1_atrb & 0x1000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x1000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x1000), reg.dword)))
					item(checked=(cu1_atrb & 0x2000) keys='0x2000' title='Encrypted' tip='Item is encrypted. Shows lock icon overlay for encrypted files/folders.'
						cmd=if((cu1_atrb & 0x2000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x2000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x2000), reg.dword)))
					item(checked=(cu1_atrb & 0x4000) keys='0x4000' title='Is Slow' tip='Accessing this item is slow (network drive, offline files). Explorer may cache aggressively.'
						cmd=if((cu1_atrb & 0x4000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x4000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x4000), reg.dword)))
					item(checked=(cu1_atrb & 0x8000) keys='0x8000' title='Ghosted/Dimmed' tip='Item appears dimmed/ghosted. Visual indication that item is unavailable or cut for move.'
						cmd=if((cu1_atrb & 0x8000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x8000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x8000), reg.dword)))
					item(checked=(cu1_atrb & 0x10000) keys='0x10000' title='Is Link' tip='Item is a shortcut/link. Sets visual shortcut arrow overlay on icon.'
						cmd=if((cu1_atrb & 0x10000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10000), reg.dword)))
					item(checked=(cu1_atrb & 0x20000) keys='0x20000' title='Is Shared' tip='Folder is shared on network. Shows sharing icon overlay.'
						cmd=if((cu1_atrb & 0x20000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20000), reg.dword)))
					item(checked=(cu1_atrb & 0x40000) keys='0x40000' title='Read Only' tip='Items are read-only. For folders: prevents creating new items. Shows lock icon overlay.'
						cmd=if((cu1_atrb & 0x40000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40000), reg.dword)))
					item(checked=(cu1_atrb & 0x80000) keys='0x80000' title='Hidden' tip='Item is hidden. Only visible when "Show hidden files" is enabled in Folder Options.'
						cmd=if((cu1_atrb & 0x80000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80000), reg.dword)))
					separator()
					// More High Flags
					item(checked=(cu1_atrb & 0x2000000) keys='0x2000000' title='Removable' tip='Content is on removable media (USB, CD). Affects caching and offline availability.'
						cmd=if((cu1_atrb & 0x2000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x2000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x2000000), reg.dword)))
					item(checked=(cu1_atrb & 0x8000000) keys='0x8000000' title='Browsable' tip='Can be browsed in place. Enables in-place navigation rather than new window.'
						cmd=if((cu1_atrb & 0x8000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x8000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x8000000), reg.dword)))
					item(checked=(cu1_atrb & 0x10000000) keys='0x10000000' title='Filesystem Ancestor' tip='Contains file system folders. Indicates descendant folders are on file system.'
						cmd=if((cu1_atrb & 0x10000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10000000), reg.dword)))
					item(checked=(cu1_atrb & 0x20000000) keys='0x20000000' title='Is Folder' tip='Item is a folder container. Required for proper folder behavior - keep enabled.'
						cmd=if((cu1_atrb & 0x20000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20000000), reg.dword)))
					item(checked=(cu1_atrb & 0x40000000) keys='0x40000000' title='Is Filesystem' tip='Item is part of file system (not virtual). Affects how Explorer handles the item.'
						cmd=if((cu1_atrb & 0x40000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40000000), reg.dword)))
					item(checked=(cu1_atrb & 0x80000000) keys='0x80000000' title='Has Subfolders' tip='Folder may contain subfolders. Shows expand arrow in tree view.'
						cmd=if((cu1_atrb & 0x80000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80000000), reg.dword)))				separator()
					separator()
					item(title='Documentation' image=\uE11F cmd='https://learn.microsoft.com/en-us/windows/win32/shell/sfgao') }
				separator()
				item(title='Export' image=\uE145 tip='Export the object in reg file. you can use it in anothe pc witout NS')
				item(title='Destoy' image=\uE0CE cmd=o__delete_it & o_np_del & o_pc_del & reg.delete(cu9+'\CLSID\'+guid) & reload & command.sleep(100) & refresh) }
			item(where=!o__exists title=get_name tip=get_tip image=get_icon keys='create' cmd=o__create_dir & o_np_set & restart) }
		menu(expanded=1 title='Nilesoft Shell' where=reg.exists('HKCU\Software\Nilesoft\Shell', 'config')) {
			$guid = '{00000000-0000-0000-A12F-4478BC12EE89}'
			$pinned = get_show==1
			$cr0_path = path.parent(reg.get('HKCU\Software\Nilesoft\Shell', 'config'))
			$cr0_name = 'Nilesoft Shell (R)'
			$cr0_tip  = get_path +"\n"+'(redirected path with registry)'
			$cr0_icon = app.exe
			menu(where= o__exists title=get_name tip=get_tip image=get_icon) { 
				item(title='Show in Navigation Pane' sep=1 checked=pinned cmd=o_np_pin_toggle & reload)
				item(title='Change position' keys=if(len(get_pos)>0, 'pos: '+get_pos) image=\uE0A2 vis=if(!pinned, 2) cmd=o_np_pos_new & reload)
				item(title='Show in This PC' sep=1 checked=o_ps_ispin cmd=o_pc_set & command.sleep(100) & refresh)
				item(title='Change Type' image=\uE135 vis=if(!o_ps_ispin, 2) cmd=o_pc_type_new & refresh)
				item(title='Show on Desktop' sep=1 checked=o_dt_ispin cmd=o_dt_pin_set)
				separator()
				item(title='Change Title' keys='+ reset' image=\uE0B7 cmd=o__name_new & reload)
				item(title='Change Icon' keys='+ reset' image=\uE0BF cmd=o__icon_new & reload)
				menu(title='Attributes') {
					$rkey = str.fmt(cu1, guid)+'\ShellFolder'
					item(checked=(cu1_atrb & 0x01) keys='0x01' title='Can Copy' tip='Items can be copied (Ctrl+C). Disabling prevents copying files from this folder.'
						cmd=if((cu1_atrb & 0x01), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x01), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x01), reg.dword)))
					item(checked=(cu1_atrb & 0x02) keys='0x02' title='Can Move/Cut' tip='Items can be moved or cut (Ctrl+X). Disabling prevents moving/cutting files.'
						cmd=if((cu1_atrb & 0x02), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x02), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x02), reg.dword)))
					item(checked=(cu1_atrb & 0x04) keys='0x04' title='Can Create Link' tip='Shortcuts can be created for items. Disabling removes "Create shortcut" from context menu.'
						cmd=if((cu1_atrb & 0x04), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x04), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x04), reg.dword)))
					item(checked=(cu1_atrb & 0x08) keys='0x08' title='Has Storage' tip='Items support IStorage interface. Required for proper folder functionality - keep enabled.'
						cmd=if((cu1_atrb & 0x08), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x08), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x08), reg.dword)))
					item(checked=(cu1_atrb & 0x10) keys='0x10' title='Can Rename' tip='Items can be renamed (F2). Disabling prevents renaming files and folders.'
						cmd=if((cu1_atrb & 0x10), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10), reg.dword)))
					item(checked=(cu1_atrb & 0x20) keys='0x20' title='Can Delete' tip='Items can be deleted (Del). Disabling prevents deletion and removes "Delete" from context menu.'
						cmd=if((cu1_atrb & 0x20), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20), reg.dword)))
					item(checked=(cu1_atrb & 0x40) keys='0x40' title='Has Property Sheet' tip='Items have property sheets (right-click → Properties). Required for Properties dialog.'
						cmd=if((cu1_atrb & 0x40), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40), reg.dword)))
					item(checked=(cu1_atrb & 0x80) keys='0x80' title='Drop Target' tip='Folder can receive dropped files. Disabling prevents drag-and-drop into this folder.'
						cmd=if((cu1_atrb & 0x80), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80), reg.dword)))	
					separator()
					// Additional Flags
					item(checked=(cu1_atrb & 0x100) keys='0x100' title='Is Link' tip='The specified items are shortcuts.'
						cmd=if((cu1_atrb & 0x100), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x100), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x100), reg.dword)))
					item(checked=(cu1_atrb & 0x200) keys='0x200' title='Can Share' tip='The specified folder objects are shared.'
						cmd=if((cu1_atrb & 0x200), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x200), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x200), reg.dword)))
					item(checked=(cu1_atrb & 0x400) keys='0x400' title='Read Only' tip='The specified items are read-only. In the case of folders, this means that new items cannot be created in those folders.'
						cmd=if((cu1_atrb & 0x400), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x400), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x400), reg.dword)))
					item(checked=(cu1_atrb & 0x800) keys='0x800' title='Ghosted/Dimmed'
						cmd=if((cu1_atrb & 0x800), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x800), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x800), reg.dword)))
					separator()
					// Folder Flags
					item(checked=(cu1_atrb & 0x1000) keys='0x1000' title='System' tip='Item is a system object. Windows treats it as protected system content.'
						cmd=if((cu1_atrb & 0x1000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x1000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x1000), reg.dword)))
					item(checked=(cu1_atrb & 0x2000) keys='0x2000' title='Encrypted' tip='Item is encrypted. Shows lock icon overlay for encrypted files/folders.'
						cmd=if((cu1_atrb & 0x2000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x2000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x2000), reg.dword)))
					item(checked=(cu1_atrb & 0x4000) keys='0x4000' title='Is Slow' tip='Accessing this item is slow (network drive, offline files). Explorer may cache aggressively.'
						cmd=if((cu1_atrb & 0x4000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x4000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x4000), reg.dword)))
					item(checked=(cu1_atrb & 0x8000) keys='0x8000' title='Ghosted/Dimmed' tip='Item appears dimmed/ghosted. Visual indication that item is unavailable or cut for move.'
						cmd=if((cu1_atrb & 0x8000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x8000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x8000), reg.dword)))
					item(checked=(cu1_atrb & 0x10000) keys='0x10000' title='Is Link' tip='Item is a shortcut/link. Sets visual shortcut arrow overlay on icon.'
						cmd=if((cu1_atrb & 0x10000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10000), reg.dword)))
					item(checked=(cu1_atrb & 0x20000) keys='0x20000' title='Is Shared' tip='Folder is shared on network. Shows sharing icon overlay.'
						cmd=if((cu1_atrb & 0x20000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20000), reg.dword)))
					item(checked=(cu1_atrb & 0x40000) keys='0x40000' title='Read Only' tip='Items are read-only. For folders: prevents creating new items. Shows lock icon overlay.'
						cmd=if((cu1_atrb & 0x40000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40000), reg.dword)))
					item(checked=(cu1_atrb & 0x80000) keys='0x80000' title='Hidden' tip='Item is hidden. Only visible when "Show hidden files" is enabled in Folder Options.'
						cmd=if((cu1_atrb & 0x80000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80000), reg.dword)))
					separator()
					// More High Flags
					item(checked=(cu1_atrb & 0x2000000) keys='0x2000000' title='Removable' tip='Content is on removable media (USB, CD). Affects caching and offline availability.'
						cmd=if((cu1_atrb & 0x2000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x2000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x2000000), reg.dword)))
					item(checked=(cu1_atrb & 0x8000000) keys='0x8000000' title='Browsable' tip='Can be browsed in place. Enables in-place navigation rather than new window.'
						cmd=if((cu1_atrb & 0x8000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x8000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x8000000), reg.dword)))
					item(checked=(cu1_atrb & 0x10000000) keys='0x10000000' title='Filesystem Ancestor' tip='Contains file system folders. Indicates descendant folders are on file system.'
						cmd=if((cu1_atrb & 0x10000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10000000), reg.dword)))
					item(checked=(cu1_atrb & 0x20000000) keys='0x20000000' title='Is Folder' tip='Item is a folder container. Required for proper folder behavior - keep enabled.'
						cmd=if((cu1_atrb & 0x20000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20000000), reg.dword)))
					item(checked=(cu1_atrb & 0x40000000) keys='0x40000000' title='Is Filesystem' tip='Item is part of file system (not virtual). Affects how Explorer handles the item.'
						cmd=if((cu1_atrb & 0x40000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40000000), reg.dword)))
					item(checked=(cu1_atrb & 0x80000000) keys='0x80000000' title='Has Subfolders' tip='Folder may contain subfolders. Shows expand arrow in tree view.'
						cmd=if((cu1_atrb & 0x80000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80000000), reg.dword)))				separator()
					separator()
					item(title='Documentation' image=\uE11F cmd='https://learn.microsoft.com/en-us/windows/win32/shell/sfgao') }
				separator()
				item(title='Export' image=\uE145 tip='Export the object in reg file. you can use it in anothe pc witout NS')
				item(title='Destoy' image=\uE0CE cmd=o__delete_it & o_np_del & o_pc_del & reg.delete(cu9+'\CLSID\'+guid) & reload & command.sleep(100) & refresh) }
			item(where=!o__exists title=get_name tip=get_tip image=get_icon keys='create' cmd=o__create_dir & o_np_set & restart) }
		separator()
		menu(expanded=1 title='custom path 1') {
			$guid = '{00000000-0000-0000-9C45-72F11D99A501}'
			$pinned = get_show==1
			$cr0_path = if(t_path!=null, t_path, if(len(reg.get(str.fmt(cu1, guid)+'\Instance\InitPropertyBag', 'Target'))>0, reg.get(str.fmt(cu1, guid)+'\Instance\InitPropertyBag', 'Target'), app.dir))
			$cr0_name = if(t_path!=null, path.name(t_path), 'custom path...')
			$cr0_tip  = get_path
			$cr0_icon = if(t_icon!=null, t_icon, 'shell32.dll,4')
			$t_path   = null
			$t_icon   = null
			menu(where= o__exists title=get_name tip=get_tip image=get_icon) { 
				item(title='Show in Navigation Pane' sep=1 checked=pinned cmd=o_np_pin_toggle & reload)
				item(title='Change position' keys=if(len(get_pos)>0, 'pos: '+get_pos) image=\uE0A2 vis=if(!pinned, 2) cmd=o_np_pos_new & reload)
				item(title='Show in This PC' sep=1 checked=o_ps_ispin cmd=o_pc_set & command.sleep(100) & refresh)
				item(title='Change Type' image=\uE135 vis=if(!o_ps_ispin, 2) cmd=o_pc_type_new & refresh)
				item(title='Show on Desktop' sep=1 checked=o_dt_ispin cmd=o_dt_pin_set)
				separator()
				item(title='Change Title' keys='+ reset' image=\uE0B7 cmd=o__name_new & reload)
				item(title='Change Icon' keys='+ reset' image=\uE0BF cmd=o__icon_new & reload)
				menu(title='Attributes') {
					$rkey = str.fmt(cu1, guid)+'\ShellFolder'
					item(checked=(cu1_atrb & 0x01) keys='0x01' title='Can Copy' tip='Items can be copied (Ctrl+C). Disabling prevents copying files from this folder.'
						cmd=if((cu1_atrb & 0x01), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x01), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x01), reg.dword)))
					item(checked=(cu1_atrb & 0x02) keys='0x02' title='Can Move/Cut' tip='Items can be moved or cut (Ctrl+X). Disabling prevents moving/cutting files.'
						cmd=if((cu1_atrb & 0x02), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x02), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x02), reg.dword)))
					item(checked=(cu1_atrb & 0x04) keys='0x04' title='Can Create Link' tip='Shortcuts can be created for items. Disabling removes "Create shortcut" from context menu.'
						cmd=if((cu1_atrb & 0x04), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x04), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x04), reg.dword)))
					item(checked=(cu1_atrb & 0x08) keys='0x08' title='Has Storage' tip='Items support IStorage interface. Required for proper folder functionality - keep enabled.'
						cmd=if((cu1_atrb & 0x08), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x08), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x08), reg.dword)))
					item(checked=(cu1_atrb & 0x10) keys='0x10' title='Can Rename' tip='Items can be renamed (F2). Disabling prevents renaming files and folders.'
						cmd=if((cu1_atrb & 0x10), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10), reg.dword)))
					item(checked=(cu1_atrb & 0x20) keys='0x20' title='Can Delete' tip='Items can be deleted (Del). Disabling prevents deletion and removes "Delete" from context menu.'
						cmd=if((cu1_atrb & 0x20), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20), reg.dword)))
					item(checked=(cu1_atrb & 0x40) keys='0x40' title='Has Property Sheet' tip='Items have property sheets (right-click → Properties). Required for Properties dialog.'
						cmd=if((cu1_atrb & 0x40), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40), reg.dword)))
					item(checked=(cu1_atrb & 0x80) keys='0x80' title='Drop Target' tip='Folder can receive dropped files. Disabling prevents drag-and-drop into this folder.'
						cmd=if((cu1_atrb & 0x80), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80), reg.dword)))	
					separator()
					// Additional Flags
					item(checked=(cu1_atrb & 0x100) keys='0x100' title='Is Link' tip='The specified items are shortcuts.'
						cmd=if((cu1_atrb & 0x100), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x100), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x100), reg.dword)))
					item(checked=(cu1_atrb & 0x200) keys='0x200' title='Can Share' tip='The specified folder objects are shared.'
						cmd=if((cu1_atrb & 0x200), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x200), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x200), reg.dword)))
					item(checked=(cu1_atrb & 0x400) keys='0x400' title='Read Only' tip='The specified items are read-only. In the case of folders, this means that new items cannot be created in those folders.'
						cmd=if((cu1_atrb & 0x400), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x400), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x400), reg.dword)))
					item(checked=(cu1_atrb & 0x800) keys='0x800' title='Ghosted/Dimmed'
						cmd=if((cu1_atrb & 0x800), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x800), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x800), reg.dword)))
					separator()
					// Folder Flags
					item(checked=(cu1_atrb & 0x1000) keys='0x1000' title='System' tip='Item is a system object. Windows treats it as protected system content.'
						cmd=if((cu1_atrb & 0x1000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x1000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x1000), reg.dword)))
					item(checked=(cu1_atrb & 0x2000) keys='0x2000' title='Encrypted' tip='Item is encrypted. Shows lock icon overlay for encrypted files/folders.'
						cmd=if((cu1_atrb & 0x2000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x2000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x2000), reg.dword)))
					item(checked=(cu1_atrb & 0x4000) keys='0x4000' title='Is Slow' tip='Accessing this item is slow (network drive, offline files). Explorer may cache aggressively.'
						cmd=if((cu1_atrb & 0x4000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x4000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x4000), reg.dword)))
					item(checked=(cu1_atrb & 0x8000) keys='0x8000' title='Ghosted/Dimmed' tip='Item appears dimmed/ghosted. Visual indication that item is unavailable or cut for move.'
						cmd=if((cu1_atrb & 0x8000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x8000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x8000), reg.dword)))
					item(checked=(cu1_atrb & 0x10000) keys='0x10000' title='Is Link' tip='Item is a shortcut/link. Sets visual shortcut arrow overlay on icon.'
						cmd=if((cu1_atrb & 0x10000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10000), reg.dword)))
					item(checked=(cu1_atrb & 0x20000) keys='0x20000' title='Is Shared' tip='Folder is shared on network. Shows sharing icon overlay.'
						cmd=if((cu1_atrb & 0x20000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20000), reg.dword)))
					item(checked=(cu1_atrb & 0x40000) keys='0x40000' title='Read Only' tip='Items are read-only. For folders: prevents creating new items. Shows lock icon overlay.'
						cmd=if((cu1_atrb & 0x40000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40000), reg.dword)))
					item(checked=(cu1_atrb & 0x80000) keys='0x80000' title='Hidden' tip='Item is hidden. Only visible when "Show hidden files" is enabled in Folder Options.'
						cmd=if((cu1_atrb & 0x80000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80000), reg.dword)))
					separator()
					// More High Flags
					item(checked=(cu1_atrb & 0x2000000) keys='0x2000000' title='Removable' tip='Content is on removable media (USB, CD). Affects caching and offline availability.'
						cmd=if((cu1_atrb & 0x2000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x2000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x2000000), reg.dword)))
					item(checked=(cu1_atrb & 0x8000000) keys='0x8000000' title='Browsable' tip='Can be browsed in place. Enables in-place navigation rather than new window.'
						cmd=if((cu1_atrb & 0x8000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x8000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x8000000), reg.dword)))
					item(checked=(cu1_atrb & 0x10000000) keys='0x10000000' title='Filesystem Ancestor' tip='Contains file system folders. Indicates descendant folders are on file system.'
						cmd=if((cu1_atrb & 0x10000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10000000), reg.dword)))
					item(checked=(cu1_atrb & 0x20000000) keys='0x20000000' title='Is Folder' tip='Item is a folder container. Required for proper folder behavior - keep enabled.'
						cmd=if((cu1_atrb & 0x20000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20000000), reg.dword)))
					item(checked=(cu1_atrb & 0x40000000) keys='0x40000000' title='Is Filesystem' tip='Item is part of file system (not virtual). Affects how Explorer handles the item.'
						cmd=if((cu1_atrb & 0x40000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40000000), reg.dword)))
					item(checked=(cu1_atrb & 0x80000000) keys='0x80000000' title='Has Subfolders' tip='Folder may contain subfolders. Shows expand arrow in tree view.'
						cmd=if((cu1_atrb & 0x80000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80000000), reg.dword)))				separator()
					separator()
					item(title='Documentation' image=\uE11F cmd='https://learn.microsoft.com/en-us/windows/win32/shell/sfgao') }
				separator()
				item(title='Export' image=\uE145 tip='Export the object in reg file. you can use it in anothe pc witout NS')
				item(title='Destoy' image=\uE0CE cmd=o__delete_it & o_np_del & o_pc_del & reg.delete(cu9+'\CLSID\'+guid) & reload & command.sleep(100) & refresh) }
			item(where=!o__exists title=get_name tip=get_tip image=get_icon keys='create' cmd={ t_path=path.dir.box() t_icon=icon.box() } & o__create_dir & o_np_set & restart + { t_path=null t_icon=null} ) }
		menu(expanded=1 title='custom path 2') {
			$guid = '{00000000-0000-0000-B7E4-5560A3C8D2F7}'
			$pinned = get_show==1
			$cr0_path = if(t_path!=null, t_path, if(len(reg.get(str.fmt(cu1, guid)+'\Instance\InitPropertyBag', 'Target'))>0, reg.get(str.fmt(cu1, guid)+'\Instance\InitPropertyBag', 'Target'), app.dir))
			$cr0_name = if(t_path!=null, path.name(t_path), 'custom path...')
			$cr0_tip  = get_path
			$cr0_icon = if(t_icon!=null, t_icon, 'shell32.dll,4')
			$t_path = null
			$t_icon = null			
			menu(where= o__exists title=get_name tip=get_tip image=get_icon) { 
				item(title='Show in Navigation Pane' sep=1 checked=pinned cmd=o_np_pin_toggle & reload)
				item(title='Change position' keys=if(len(get_pos)>0, 'pos: '+get_pos) image=\uE0A2 vis=if(!pinned, 2) cmd=o_np_pos_new & reload)
				item(title='Show in This PC' sep=1 checked=o_ps_ispin cmd=o_pc_set & command.sleep(100) & refresh)
				item(title='Change Type' image=\uE135 vis=if(!o_ps_ispin, 2) cmd=o_pc_type_new & refresh)
				item(title='Show on Desktop' sep=1 checked=o_dt_ispin cmd=o_dt_pin_set)
				separator()
				item(title='Change Title' keys='+ reset' image=\uE0B7 cmd=o__name_new & reload)
				item(title='Change Icon' keys='+ reset' image=\uE0BF cmd=o__icon_new & reload)
				menu(title='Attributes') {
					$rkey = str.fmt(cu1, guid)+'\ShellFolder'
					item(checked=(cu1_atrb & 0x01) keys='0x01' title='Can Copy' tip='Items can be copied (Ctrl+C). Disabling prevents copying files from this folder.'
						cmd=if((cu1_atrb & 0x01), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x01), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x01), reg.dword)))
					item(checked=(cu1_atrb & 0x02) keys='0x02' title='Can Move/Cut' tip='Items can be moved or cut (Ctrl+X). Disabling prevents moving/cutting files.'
						cmd=if((cu1_atrb & 0x02), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x02), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x02), reg.dword)))
					item(checked=(cu1_atrb & 0x04) keys='0x04' title='Can Create Link' tip='Shortcuts can be created for items. Disabling removes "Create shortcut" from context menu.'
						cmd=if((cu1_atrb & 0x04), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x04), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x04), reg.dword)))
					item(checked=(cu1_atrb & 0x08) keys='0x08' title='Has Storage' tip='Items support IStorage interface. Required for proper folder functionality - keep enabled.'
						cmd=if((cu1_atrb & 0x08), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x08), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x08), reg.dword)))
					item(checked=(cu1_atrb & 0x10) keys='0x10' title='Can Rename' tip='Items can be renamed (F2). Disabling prevents renaming files and folders.'
						cmd=if((cu1_atrb & 0x10), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10), reg.dword)))
					item(checked=(cu1_atrb & 0x20) keys='0x20' title='Can Delete' tip='Items can be deleted (Del). Disabling prevents deletion and removes "Delete" from context menu.'
						cmd=if((cu1_atrb & 0x20), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20), reg.dword)))
					item(checked=(cu1_atrb & 0x40) keys='0x40' title='Has Property Sheet' tip='Items have property sheets (right-click → Properties). Required for Properties dialog.'
						cmd=if((cu1_atrb & 0x40), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40), reg.dword)))
					item(checked=(cu1_atrb & 0x80) keys='0x80' title='Drop Target' tip='Folder can receive dropped files. Disabling prevents drag-and-drop into this folder.'
						cmd=if((cu1_atrb & 0x80), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80), reg.dword)))
					separator()
					// Additional Flags
					item(checked=(cu1_atrb & 0x100) keys='0x100' title='Is Link' tip='The specified items are shortcuts.'
						cmd=if((cu1_atrb & 0x100), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x100), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x100), reg.dword)))
					item(checked=(cu1_atrb & 0x200) keys='0x200' title='Can Share' tip='The specified folder objects are shared.'
						cmd=if((cu1_atrb & 0x200), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x200), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x200), reg.dword)))
					item(checked=(cu1_atrb & 0x400) keys='0x400' title='Read Only' tip='The specified items are read-only. In the case of folders, this means that new items cannot be created in those folders.'
						cmd=if((cu1_atrb & 0x400), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x400), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x400), reg.dword)))
					item(checked=(cu1_atrb & 0x800) keys='0x800' title='Ghosted/Dimmed'
						cmd=if((cu1_atrb & 0x800), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x800), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x800), reg.dword)))
					separator()
					// Folder Flags
					item(checked=(cu1_atrb & 0x1000) keys='0x1000' title='System' tip='Item is a system object. Windows treats it as protected system content.'
						cmd=if((cu1_atrb & 0x1000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x1000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x1000), reg.dword)))
					item(checked=(cu1_atrb & 0x2000) keys='0x2000' title='Encrypted' tip='Item is encrypted. Shows lock icon overlay for encrypted files/folders.'
						cmd=if((cu1_atrb & 0x2000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x2000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x2000), reg.dword)))
					item(checked=(cu1_atrb & 0x4000) keys='0x4000' title='Is Slow' tip='Accessing this item is slow (network drive, offline files). Explorer may cache aggressively.'
						cmd=if((cu1_atrb & 0x4000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x4000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x4000), reg.dword)))
					item(checked=(cu1_atrb & 0x8000) keys='0x8000' title='Ghosted/Dimmed' tip='Item appears dimmed/ghosted. Visual indication that item is unavailable or cut for move.'
						cmd=if((cu1_atrb & 0x8000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x8000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x8000), reg.dword)))
					item(checked=(cu1_atrb & 0x10000) keys='0x10000' title='Is Link' tip='Item is a shortcut/link. Sets visual shortcut arrow overlay on icon.'
						cmd=if((cu1_atrb & 0x10000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10000), reg.dword)))
					item(checked=(cu1_atrb & 0x20000) keys='0x20000' title='Is Shared' tip='Folder is shared on network. Shows sharing icon overlay.'
						cmd=if((cu1_atrb & 0x20000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20000), reg.dword)))
					item(checked=(cu1_atrb & 0x40000) keys='0x40000' title='Read Only' tip='Items are read-only. For folders: prevents creating new items. Shows lock icon overlay.'
						cmd=if((cu1_atrb & 0x40000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40000), reg.dword)))
					item(checked=(cu1_atrb & 0x80000) keys='0x80000' title='Hidden' tip='Item is hidden. Only visible when "Show hidden files" is enabled in Folder Options.'
						cmd=if((cu1_atrb & 0x80000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80000), reg.dword)))
					separator()
					// More High Flags
					item(checked=(cu1_atrb & 0x2000000) keys='0x2000000' title='Removable' tip='Content is on removable media (USB, CD). Affects caching and offline availability.'
						cmd=if((cu1_atrb & 0x2000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x2000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x2000000), reg.dword)))
					item(checked=(cu1_atrb & 0x8000000) keys='0x8000000' title='Browsable' tip='Can be browsed in place. Enables in-place navigation rather than new window.'
						cmd=if((cu1_atrb & 0x8000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x8000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x8000000), reg.dword)))
					item(checked=(cu1_atrb & 0x10000000) keys='0x10000000' title='Filesystem Ancestor' tip='Contains file system folders. Indicates descendant folders are on file system.'
						cmd=if((cu1_atrb & 0x10000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10000000), reg.dword)))
					item(checked=(cu1_atrb & 0x20000000) keys='0x20000000' title='Is Folder' tip='Item is a folder container. Required for proper folder behavior - keep enabled.'
						cmd=if((cu1_atrb & 0x20000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20000000), reg.dword)))
					item(checked=(cu1_atrb & 0x40000000) keys='0x40000000' title='Is Filesystem' tip='Item is part of file system (not virtual). Affects how Explorer handles the item.'
						cmd=if((cu1_atrb & 0x40000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40000000), reg.dword)))
					item(checked=(cu1_atrb & 0x80000000) keys='0x80000000' title='Has Subfolders' tip='Folder may contain subfolders. Shows expand arrow in tree view.'
						cmd=if((cu1_atrb & 0x80000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80000000), reg.dword)))				separator()
					separator()
					item(title='Documentation' image=\uE11F cmd='https://learn.microsoft.com/en-us/windows/win32/shell/sfgao') }
				separator()
				item(title='Export' image=\uE145 tip='Export the object in reg file. you can use it in anothe pc witout NS')
				item(title='Destoy' image=\uE0CE cmd=o__delete_it & o_np_del & o_pc_del & reg.delete(cu9+'\CLSID\'+guid) & reload & command.sleep(100) & refresh) }
			item(where=!o__exists title=get_name tip=get_tip image=get_icon keys='create' cmd={ t_path=path.dir.box() t_icon=icon.box() } & o__create_dir & o_np_set & restart + { t_path=null t_icon=null} ) }
		menu(expanded=1 title='custom path 3') {
			$guid = '{00000000-0000-0000-F843-23DD7100A5E2}'
			$pinned = get_show==1
			$cr0_path = if(t_path!=null, t_path, if(len(reg.get(str.fmt(cu1, guid)+'\Instance\InitPropertyBag', 'Target'))>0, reg.get(str.fmt(cu1, guid)+'\Instance\InitPropertyBag', 'Target'), app.dir))
			$cr0_name = if(t_path!=null, path.name(t_path), 'custom path...')
			$cr0_tip  = get_path
			$cr0_icon = if(t_icon!=null, t_icon, 'shell32.dll,4')
			$t_path = null
			$t_icon = null			
			menu(where= o__exists title=get_name tip=get_tip image=get_icon) { 
				item(title='Show in Navigation Pane' sep=1 checked=pinned cmd=o_np_pin_toggle & reload)
				item(title='Change position' keys=if(len(get_pos)>0, 'pos: '+get_pos) image=\uE0A2 vis=if(!pinned, 2) cmd=o_np_pos_new & reload)
				item(title='Show in This PC' sep=1 checked=o_ps_ispin cmd=o_pc_set & command.sleep(100) & refresh)
				item(title='Change Type' image=\uE135 vis=if(!o_ps_ispin, 2) cmd=o_pc_type_new & refresh)
				item(title='Show on Desktop' sep=1 checked=o_dt_ispin cmd=o_dt_pin_set)
				separator()
				item(title='Change Title' keys='+ reset' image=\uE0B7 cmd=o__name_new & reload)
				item(title='Change Icon' keys='+ reset' image=\uE0BF cmd=o__icon_new & reload)
				menu(title='Attributes') {
					$rkey = str.fmt(cu1, guid)+'\ShellFolder'
					item(checked=(cu1_atrb & 0x01) keys='0x01' title='Can Copy' tip='Items can be copied (Ctrl+C). Disabling prevents copying files from this folder.'
						cmd=if((cu1_atrb & 0x01), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x01), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x01), reg.dword)))
					item(checked=(cu1_atrb & 0x02) keys='0x02' title='Can Move/Cut' tip='Items can be moved or cut (Ctrl+X). Disabling prevents moving/cutting files.'
						cmd=if((cu1_atrb & 0x02), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x02), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x02), reg.dword)))
					item(checked=(cu1_atrb & 0x04) keys='0x04' title='Can Create Link' tip='Shortcuts can be created for items. Disabling removes "Create shortcut" from context menu.'
						cmd=if((cu1_atrb & 0x04), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x04), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x04), reg.dword)))
					item(checked=(cu1_atrb & 0x08) keys='0x08' title='Has Storage' tip='Items support IStorage interface. Required for proper folder functionality - keep enabled.'
						cmd=if((cu1_atrb & 0x08), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x08), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x08), reg.dword)))
					item(checked=(cu1_atrb & 0x10) keys='0x10' title='Can Rename' tip='Items can be renamed (F2). Disabling prevents renaming files and folders.'
						cmd=if((cu1_atrb & 0x10), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10), reg.dword)))
					item(checked=(cu1_atrb & 0x20) keys='0x20' title='Can Delete' tip='Items can be deleted (Del). Disabling prevents deletion and removes "Delete" from context menu.'
						cmd=if((cu1_atrb & 0x20), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20), reg.dword)))
					item(checked=(cu1_atrb & 0x40) keys='0x40' title='Has Property Sheet' tip='Items have property sheets (right-click → Properties). Required for Properties dialog.'
						cmd=if((cu1_atrb & 0x40), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40), reg.dword)))
					item(checked=(cu1_atrb & 0x80) keys='0x80' title='Drop Target' tip='Folder can receive dropped files. Disabling prevents drag-and-drop into this folder.'
						cmd=if((cu1_atrb & 0x80), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80), reg.dword)))
					separator()
					// Additional Flags
					item(checked=(cu1_atrb & 0x100) keys='0x100' title='Is Link' tip='The specified items are shortcuts.'
						cmd=if((cu1_atrb & 0x100), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x100), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x100), reg.dword)))
					item(checked=(cu1_atrb & 0x200) keys='0x200' title='Can Share' tip='The specified folder objects are shared.'
						cmd=if((cu1_atrb & 0x200), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x200), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x200), reg.dword)))
					item(checked=(cu1_atrb & 0x400) keys='0x400' title='Read Only' tip='The specified items are read-only. In the case of folders, this means that new items cannot be created in those folders.'
						cmd=if((cu1_atrb & 0x400), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x400), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x400), reg.dword)))
					item(checked=(cu1_atrb & 0x800) keys='0x800' title='Ghosted/Dimmed'
						cmd=if((cu1_atrb & 0x800), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x800), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x800), reg.dword)))
					separator()
					// Folder Flags
					item(checked=(cu1_atrb & 0x1000) keys='0x1000' title='System' tip='Item is a system object. Windows treats it as protected system content.'
						cmd=if((cu1_atrb & 0x1000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x1000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x1000), reg.dword)))
					item(checked=(cu1_atrb & 0x2000) keys='0x2000' title='Encrypted' tip='Item is encrypted. Shows lock icon overlay for encrypted files/folders.'
						cmd=if((cu1_atrb & 0x2000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x2000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x2000), reg.dword)))
					item(checked=(cu1_atrb & 0x4000) keys='0x4000' title='Is Slow' tip='Accessing this item is slow (network drive, offline files). Explorer may cache aggressively.'
						cmd=if((cu1_atrb & 0x4000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x4000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x4000), reg.dword)))
					item(checked=(cu1_atrb & 0x8000) keys='0x8000' title='Ghosted/Dimmed' tip='Item appears dimmed/ghosted. Visual indication that item is unavailable or cut for move.'
						cmd=if((cu1_atrb & 0x8000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x8000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x8000), reg.dword)))
					item(checked=(cu1_atrb & 0x10000) keys='0x10000' title='Is Link' tip='Item is a shortcut/link. Sets visual shortcut arrow overlay on icon.'
						cmd=if((cu1_atrb & 0x10000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10000), reg.dword)))
					item(checked=(cu1_atrb & 0x20000) keys='0x20000' title='Is Shared' tip='Folder is shared on network. Shows sharing icon overlay.'
						cmd=if((cu1_atrb & 0x20000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20000), reg.dword)))
					item(checked=(cu1_atrb & 0x40000) keys='0x40000' title='Read Only' tip='Items are read-only. For folders: prevents creating new items. Shows lock icon overlay.'
						cmd=if((cu1_atrb & 0x40000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40000), reg.dword)))
					item(checked=(cu1_atrb & 0x80000) keys='0x80000' title='Hidden' tip='Item is hidden. Only visible when "Show hidden files" is enabled in Folder Options.'
						cmd=if((cu1_atrb & 0x80000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80000), reg.dword)))
					separator()
					// More High Flags
					item(checked=(cu1_atrb & 0x2000000) keys='0x2000000' title='Removable' tip='Content is on removable media (USB, CD). Affects caching and offline availability.'
						cmd=if((cu1_atrb & 0x2000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x2000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x2000000), reg.dword)))
					item(checked=(cu1_atrb & 0x8000000) keys='0x8000000' title='Browsable' tip='Can be browsed in place. Enables in-place navigation rather than new window.'
						cmd=if((cu1_atrb & 0x8000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x8000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x8000000), reg.dword)))
					item(checked=(cu1_atrb & 0x10000000) keys='0x10000000' title='Filesystem Ancestor' tip='Contains file system folders. Indicates descendant folders are on file system.'
						cmd=if((cu1_atrb & 0x10000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10000000), reg.dword)))
					item(checked=(cu1_atrb & 0x20000000) keys='0x20000000' title='Is Folder' tip='Item is a folder container. Required for proper folder behavior - keep enabled.'
						cmd=if((cu1_atrb & 0x20000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20000000), reg.dword)))
					item(checked=(cu1_atrb & 0x40000000) keys='0x40000000' title='Is Filesystem' tip='Item is part of file system (not virtual). Affects how Explorer handles the item.'
						cmd=if((cu1_atrb & 0x40000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40000000), reg.dword)))
					item(checked=(cu1_atrb & 0x80000000) keys='0x80000000' title='Has Subfolders' tip='Folder may contain subfolders. Shows expand arrow in tree view.'
						cmd=if((cu1_atrb & 0x80000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80000000), reg.dword)))				separator()
					separator()
					item(title='Documentation' image=\uE11F cmd='https://learn.microsoft.com/en-us/windows/win32/shell/sfgao') }
				separator()
				item(title='Export' image=\uE145 tip='Export the object in reg file. you can use it in anothe pc witout NS')
				item(title='Destoy' image=\uE0CE cmd=o__delete_it & o_np_del & o_pc_del & reg.delete(cu9+'\CLSID\'+guid) & reload & command.sleep(100) & refresh) }
			item(where=!o__exists title=get_name tip=get_tip image=get_icon keys='create' cmd={ t_path=path.dir.box() t_icon=icon.box() } & o__create_dir & o_np_set & restart + { t_path=null t_icon=null} ) }
		menu(expanded=1 title='custom path 4') {
			$guid = '{00000000-0000-0000-82F1-44C9A77B9E32}'
			$pinned = get_show==1
			$cr0_path = if(t_path!=null, t_path, if(len(reg.get(str.fmt(cu1, guid)+'\Instance\InitPropertyBag', 'Target'))>0, reg.get(str.fmt(cu1, guid)+'\Instance\InitPropertyBag', 'Target'), app.dir))
			$cr0_name = if(t_path!=null, path.name(t_path), 'custom path...')
			$cr0_tip  = get_path
			$cr0_icon = if(t_icon!=null, t_icon, 'shell32.dll,4')
			$t_path = null
			$t_icon = null			
			menu(where= o__exists title=get_name tip=get_tip image=get_icon) { 
				item(title='Show in Navigation Pane' sep=1 checked=pinned cmd=o_np_pin_toggle & reload)
				item(title='Change position' keys=if(len(get_pos)>0, 'pos: '+get_pos) image=\uE0A2 vis=if(!pinned, 2) cmd=o_np_pos_new & reload)
				item(title='Show in This PC' sep=1 checked=o_ps_ispin cmd=o_pc_set & command.sleep(100) & refresh)
				item(title='Change Type' image=\uE135 vis=if(!o_ps_ispin, 2) cmd=o_pc_type_new & refresh)
				item(title='Show on Desktop' sep=1 checked=o_dt_ispin cmd=o_dt_pin_set)
				separator()
				item(title='Change Title' keys='+ reset' image=\uE0B7 cmd=o__name_new & reload)
				item(title='Change Icon' keys='+ reset' image=\uE0BF cmd=o__icon_new & reload)
				menu(title='Attributes') {
					$rkey = str.fmt(cu1, guid)+'\ShellFolder'
					item(checked=(cu1_atrb & 0x01) keys='0x01' title='Can Copy' tip='Items can be copied (Ctrl+C). Disabling prevents copying files from this folder.'
						cmd=if((cu1_atrb & 0x01), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x01), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x01), reg.dword)))
					item(checked=(cu1_atrb & 0x02) keys='0x02' title='Can Move/Cut' tip='Items can be moved or cut (Ctrl+X). Disabling prevents moving/cutting files.'
						cmd=if((cu1_atrb & 0x02), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x02), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x02), reg.dword)))
					item(checked=(cu1_atrb & 0x04) keys='0x04' title='Can Create Link' tip='Shortcuts can be created for items. Disabling removes "Create shortcut" from context menu.'
						cmd=if((cu1_atrb & 0x04), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x04), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x04), reg.dword)))
					item(checked=(cu1_atrb & 0x08) keys='0x08' title='Has Storage' tip='Items support IStorage interface. Required for proper folder functionality - keep enabled.'
						cmd=if((cu1_atrb & 0x08), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x08), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x08), reg.dword)))
					item(checked=(cu1_atrb & 0x10) keys='0x10' title='Can Rename' tip='Items can be renamed (F2). Disabling prevents renaming files and folders.'
						cmd=if((cu1_atrb & 0x10), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10), reg.dword)))
					item(checked=(cu1_atrb & 0x20) keys='0x20' title='Can Delete' tip='Items can be deleted (Del). Disabling prevents deletion and removes "Delete" from context menu.'
						cmd=if((cu1_atrb & 0x20), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20), reg.dword)))
					item(checked=(cu1_atrb & 0x40) keys='0x40' title='Has Property Sheet' tip='Items have property sheets (right-click → Properties). Required for Properties dialog.'
						cmd=if((cu1_atrb & 0x40), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40), reg.dword)))
					item(checked=(cu1_atrb & 0x80) keys='0x80' title='Drop Target' tip='Folder can receive dropped files. Disabling prevents drag-and-drop into this folder.'
						cmd=if((cu1_atrb & 0x80), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80), reg.dword)))
					separator()
					// Additional Flags
					item(checked=(cu1_atrb & 0x100) keys='0x100' title='Is Link' tip='The specified items are shortcuts.'
						cmd=if((cu1_atrb & 0x100), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x100), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x100), reg.dword)))
					item(checked=(cu1_atrb & 0x200) keys='0x200' title='Can Share' tip='The specified folder objects are shared.'
						cmd=if((cu1_atrb & 0x200), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x200), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x200), reg.dword)))
					item(checked=(cu1_atrb & 0x400) keys='0x400' title='Read Only' tip='The specified items are read-only. In the case of folders, this means that new items cannot be created in those folders.'
						cmd=if((cu1_atrb & 0x400), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x400), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x400), reg.dword)))
					item(checked=(cu1_atrb & 0x800) keys='0x800' title='Ghosted/Dimmed'
						cmd=if((cu1_atrb & 0x800), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x800), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x800), reg.dword)))
					separator()
					// Folder Flags
					item(checked=(cu1_atrb & 0x1000) keys='0x1000' title='System' tip='Item is a system object. Windows treats it as protected system content.'
						cmd=if((cu1_atrb & 0x1000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x1000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x1000), reg.dword)))
					item(checked=(cu1_atrb & 0x2000) keys='0x2000' title='Encrypted' tip='Item is encrypted. Shows lock icon overlay for encrypted files/folders.'
						cmd=if((cu1_atrb & 0x2000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x2000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x2000), reg.dword)))
					item(checked=(cu1_atrb & 0x4000) keys='0x4000' title='Is Slow' tip='Accessing this item is slow (network drive, offline files). Explorer may cache aggressively.'
						cmd=if((cu1_atrb & 0x4000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x4000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x4000), reg.dword)))
					item(checked=(cu1_atrb & 0x8000) keys='0x8000' title='Ghosted/Dimmed' tip='Item appears dimmed/ghosted. Visual indication that item is unavailable or cut for move.'
						cmd=if((cu1_atrb & 0x8000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x8000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x8000), reg.dword)))
					item(checked=(cu1_atrb & 0x10000) keys='0x10000' title='Is Link' tip='Item is a shortcut/link. Sets visual shortcut arrow overlay on icon.'
						cmd=if((cu1_atrb & 0x10000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10000), reg.dword)))
					item(checked=(cu1_atrb & 0x20000) keys='0x20000' title='Is Shared' tip='Folder is shared on network. Shows sharing icon overlay.'
						cmd=if((cu1_atrb & 0x20000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20000), reg.dword)))
					item(checked=(cu1_atrb & 0x40000) keys='0x40000' title='Read Only' tip='Items are read-only. For folders: prevents creating new items. Shows lock icon overlay.'
						cmd=if((cu1_atrb & 0x40000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40000), reg.dword)))
					item(checked=(cu1_atrb & 0x80000) keys='0x80000' title='Hidden' tip='Item is hidden. Only visible when "Show hidden files" is enabled in Folder Options.'
						cmd=if((cu1_atrb & 0x80000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80000), reg.dword)))
					separator()
					// More High Flags
					item(checked=(cu1_atrb & 0x2000000) keys='0x2000000' title='Removable' tip='Content is on removable media (USB, CD). Affects caching and offline availability.'
						cmd=if((cu1_atrb & 0x2000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x2000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x2000000), reg.dword)))
					item(checked=(cu1_atrb & 0x8000000) keys='0x8000000' title='Browsable' tip='Can be browsed in place. Enables in-place navigation rather than new window.'
						cmd=if((cu1_atrb & 0x8000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x8000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x8000000), reg.dword)))
					item(checked=(cu1_atrb & 0x10000000) keys='0x10000000' title='Filesystem Ancestor' tip='Contains file system folders. Indicates descendant folders are on file system.'
						cmd=if((cu1_atrb & 0x10000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10000000), reg.dword)))
					item(checked=(cu1_atrb & 0x20000000) keys='0x20000000' title='Is Folder' tip='Item is a folder container. Required for proper folder behavior - keep enabled.'
						cmd=if((cu1_atrb & 0x20000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20000000), reg.dword)))
					item(checked=(cu1_atrb & 0x40000000) keys='0x40000000' title='Is Filesystem' tip='Item is part of file system (not virtual). Affects how Explorer handles the item.'
						cmd=if((cu1_atrb & 0x40000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40000000), reg.dword)))
					item(checked=(cu1_atrb & 0x80000000) keys='0x80000000' title='Has Subfolders' tip='Folder may contain subfolders. Shows expand arrow in tree view.'
						cmd=if((cu1_atrb & 0x80000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80000000), reg.dword)))				separator()
					separator()
					item(title='Documentation' image=\uE11F cmd='https://learn.microsoft.com/en-us/windows/win32/shell/sfgao') }
				separator()
				item(title='Export' image=\uE145 tip='Export the object in reg file. you can use it in anothe pc witout NS')
				item(title='Destoy' image=\uE0CE cmd=o__delete_it & o_np_del & o_pc_del & reg.delete(cu9+'\CLSID\'+guid) & reload & command.sleep(100) & refresh) }
			item(where=!o__exists title=get_name tip=get_tip image=get_icon keys='create' cmd={ t_path=path.dir.box() t_icon=icon.box() } & o__create_dir & o_np_set & restart + { t_path=null t_icon=null} ) }
		separator()
		menu(expanded=1 title='C:') {
			//> https://www.elevenforum.com/t/add-or-remove-windows-c-drive-in-navigation-pane-of-file-explorer-in-windows-11.7342/
			$guid = '{445a2e0d-9142-4458-a84a-66dee0196d3c}'
			$pinned = get_show==1
			$cr0_path = 'C:\'
			$cr0_name = 'C: Drive'
			$cr0_tip  = 'Local Disk (C:)'
			$cr0_icon = 'imageres.dll,-32'
			menu(where= o__exists title=get_name tip=get_tip image=get_icon) { 
				item(title='Show in Navigation Pane' sep=1 checked=pinned cmd=o_np_pin_toggle & reload)
				item(title='Change position' keys=if(len(get_pos)>0, 'pos: '+get_pos) image=\uE0A2 vis=if(!pinned, 2) cmd=o_np_pos_new & reload)
				item(title='Show in This PC' sep=1 checked=o_ps_ispin cmd=o_pc_set & command.sleep(100) & refresh)
				item(title='Change Type' image=\uE135 vis=if(!o_ps_ispin, 2) cmd=o_pc_type_new & refresh)
				item(title='Show on Desktop' sep=1 checked=o_dt_ispin cmd=o_dt_pin_set)
				separator()
				item(title='Change Title' keys='+ reset' image=\uE0B7 cmd=o__name_new & reload)
				item(title='Change Icon' keys='+ reset' image=\uE0BF cmd=o__icon_new & reload)
				menu(title='Attributes') {
					$rkey = str.fmt(cu1, guid)+'\ShellFolder'
					item(checked=(cu1_atrb & 0x01) keys='0x01' title='Can Copy' tip='Items can be copied (Ctrl+C). Disabling prevents copying files from this folder.'
						cmd=if((cu1_atrb & 0x01), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x01), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x01), reg.dword)))
					item(checked=(cu1_atrb & 0x02) keys='0x02' title='Can Move/Cut' tip='Items can be moved or cut (Ctrl+X). Disabling prevents moving/cutting files.'
						cmd=if((cu1_atrb & 0x02), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x02), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x02), reg.dword)))
					item(checked=(cu1_atrb & 0x04) keys='0x04' title='Can Create Link' tip='Shortcuts can be created for items. Disabling removes "Create shortcut" from context menu.'
						cmd=if((cu1_atrb & 0x04), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x04), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x04), reg.dword)))
					item(checked=(cu1_atrb & 0x08) keys='0x08' title='Has Storage' tip='Items support IStorage interface. Required for proper folder functionality - keep enabled.'
						cmd=if((cu1_atrb & 0x08), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x08), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x08), reg.dword)))
					item(checked=(cu1_atrb & 0x10) keys='0x10' title='Can Rename' tip='Items can be renamed (F2). Disabling prevents renaming files and folders.'
						cmd=if((cu1_atrb & 0x10), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10), reg.dword)))
					item(checked=(cu1_atrb & 0x20) keys='0x20' title='Can Delete' tip='Items can be deleted (Del). Disabling prevents deletion and removes "Delete" from context menu.'
						cmd=if((cu1_atrb & 0x20), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20), reg.dword)))
					item(checked=(cu1_atrb & 0x40) keys='0x40' title='Has Property Sheet' tip='Items have property sheets (right-click → Properties). Required for Properties dialog.'
						cmd=if((cu1_atrb & 0x40), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40), reg.dword)))
					item(checked=(cu1_atrb & 0x80) keys='0x80' title='Drop Target' tip='Folder can receive dropped files. Disabling prevents drag-and-drop into this folder.'
						cmd=if((cu1_atrb & 0x80), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80), reg.dword)))			
					separator()
					// Additional Flags
					item(checked=(cu1_atrb & 0x100) keys='0x100' title='Is Link' tip='The specified items are shortcuts.'
						cmd=if((cu1_atrb & 0x100), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x100), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x100), reg.dword)))
					item(checked=(cu1_atrb & 0x200) keys='0x200' title='Can Share' tip='The specified folder objects are shared.'
						cmd=if((cu1_atrb & 0x200), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x200), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x200), reg.dword)))
					item(checked=(cu1_atrb & 0x400) keys='0x400' title='Read Only' tip='The specified items are read-only. In the case of folders, this means that new items cannot be created in those folders.'
						cmd=if((cu1_atrb & 0x400), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x400), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x400), reg.dword)))
					item(checked=(cu1_atrb & 0x800) keys='0x800' title='Ghosted/Dimmed'
						cmd=if((cu1_atrb & 0x800), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x800), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x800), reg.dword)))
					separator()
					// Folder Flags
					item(checked=(cu1_atrb & 0x1000) keys='0x1000' title='System' tip='Item is a system object. Windows treats it as protected system content.'
						cmd=if((cu1_atrb & 0x1000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x1000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x1000), reg.dword)))
					item(checked=(cu1_atrb & 0x2000) keys='0x2000' title='Encrypted' tip='Item is encrypted. Shows lock icon overlay for encrypted files/folders.'
						cmd=if((cu1_atrb & 0x2000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x2000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x2000), reg.dword)))
					item(checked=(cu1_atrb & 0x4000) keys='0x4000' title='Is Slow' tip='Accessing this item is slow (network drive, offline files). Explorer may cache aggressively.'
						cmd=if((cu1_atrb & 0x4000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x4000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x4000), reg.dword)))
					item(checked=(cu1_atrb & 0x8000) keys='0x8000' title='Ghosted/Dimmed' tip='Item appears dimmed/ghosted. Visual indication that item is unavailable or cut for move.'
						cmd=if((cu1_atrb & 0x8000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x8000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x8000), reg.dword)))
					item(checked=(cu1_atrb & 0x10000) keys='0x10000' title='Is Link' tip='Item is a shortcut/link. Sets visual shortcut arrow overlay on icon.'
						cmd=if((cu1_atrb & 0x10000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10000), reg.dword)))
					item(checked=(cu1_atrb & 0x20000) keys='0x20000' title='Is Shared' tip='Folder is shared on network. Shows sharing icon overlay.'
						cmd=if((cu1_atrb & 0x20000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20000), reg.dword)))
					item(checked=(cu1_atrb & 0x40000) keys='0x40000' title='Read Only' tip='Items are read-only. For folders: prevents creating new items. Shows lock icon overlay.'
						cmd=if((cu1_atrb & 0x40000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40000), reg.dword)))
					item(checked=(cu1_atrb & 0x80000) keys='0x80000' title='Hidden' tip='Item is hidden. Only visible when "Show hidden files" is enabled in Folder Options.'
						cmd=if((cu1_atrb & 0x80000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80000), reg.dword)))
					separator()
					// More High Flags
					item(checked=(cu1_atrb & 0x2000000) keys='0x2000000' title='Removable' tip='Content is on removable media (USB, CD). Affects caching and offline availability.'
						cmd=if((cu1_atrb & 0x2000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x2000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x2000000), reg.dword)))
					item(checked=(cu1_atrb & 0x8000000) keys='0x8000000' title='Browsable' tip='Can be browsed in place. Enables in-place navigation rather than new window.'
						cmd=if((cu1_atrb & 0x8000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x8000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x8000000), reg.dword)))
					item(checked=(cu1_atrb & 0x10000000) keys='0x10000000' title='Filesystem Ancestor' tip='Contains file system folders. Indicates descendant folders are on file system.'
						cmd=if((cu1_atrb & 0x10000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10000000), reg.dword)))
					item(checked=(cu1_atrb & 0x20000000) keys='0x20000000' title='Is Folder' tip='Item is a folder container. Required for proper folder behavior - keep enabled.'
						cmd=if((cu1_atrb & 0x20000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20000000), reg.dword)))
					item(checked=(cu1_atrb & 0x40000000) keys='0x40000000' title='Is Filesystem' tip='Item is part of file system (not virtual). Affects how Explorer handles the item.'
						cmd=if((cu1_atrb & 0x40000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40000000), reg.dword)))
					item(checked=(cu1_atrb & 0x80000000) keys='0x80000000' title='Has Subfolders' tip='Folder may contain subfolders. Shows expand arrow in tree view.'
						cmd=if((cu1_atrb & 0x80000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80000000), reg.dword)))				separator()
					separator()
					item(title='Documentation' image=\uE11F cmd='https://learn.microsoft.com/en-us/windows/win32/shell/sfgao') }
				separator()
				item(title='Export' image=\uE145 tip='Export the object in reg file. you can use it in anothe pc witout NS')
				item(title='Destoy' image=\uE0CE cmd=o__delete_it & o_np_del & o_pc_del & reg.delete(cu9+'\CLSID\'+guid) & reload & command.sleep(100) & refresh) }
			item(where=!o__exists title=get_name tip=get_tip image=get_icon keys='create' cmd=o__create_drive & o_np_set & restart) }
		menu(expanded=1 title='D:') {
			//> https://www.elevenforum.com/t/add-or-remove-d-drive-in-navigation-pane-of-file-explorer-in-windows-11.7636/
			$guid = '{0525388b-89d9-4112-bf4d-2aaccb716a7f}'
			$pinned = get_show==1
			$cr0_path = 'D:\'
			$cr0_name = 'D: Drive'
			$cr0_tip  = 'Local Disk (D:)'
			$cr0_icon = 'imageres.dll,-32'
			menu(where= o__exists title=get_name tip=get_tip image=get_icon) { 
				item(title='Show in Navigation Pane' sep=1 checked=pinned cmd=o_np_pin_toggle & reload)
				item(title='Change position' keys=if(len(get_pos)>0, 'pos: '+get_pos) image=\uE0A2 vis=if(!pinned, 2) cmd=o_np_pos_new & reload)
				item(title='Show in This PC' sep=1 checked=o_ps_ispin cmd=o_pc_set & command.sleep(100) & refresh)
				item(title='Change Type' image=\uE135 vis=if(!o_ps_ispin, 2) cmd=o_pc_type_new & refresh)
				item(title='Show on Desktop' sep=1 checked=o_dt_ispin cmd=o_dt_pin_set)
				separator()
				item(title='Change Title' keys='+ reset' image=\uE0B7 cmd=o__name_new & reload)
				item(title='Change Icon' keys='+ reset' image=\uE0BF cmd=o__icon_new & reload)
				menu(title='Attributes') {
					$rkey = str.fmt(cu1, guid)+'\ShellFolder'
					item(checked=(cu1_atrb & 0x01) keys='0x01' title='Can Copy' tip='Items can be copied (Ctrl+C). Disabling prevents copying files from this folder.'
						cmd=if((cu1_atrb & 0x01), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x01), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x01), reg.dword)))
					item(checked=(cu1_atrb & 0x02) keys='0x02' title='Can Move/Cut' tip='Items can be moved or cut (Ctrl+X). Disabling prevents moving/cutting files.'
						cmd=if((cu1_atrb & 0x02), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x02), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x02), reg.dword)))
					item(checked=(cu1_atrb & 0x04) keys='0x04' title='Can Create Link' tip='Shortcuts can be created for items. Disabling removes "Create shortcut" from context menu.'
						cmd=if((cu1_atrb & 0x04), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x04), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x04), reg.dword)))
					item(checked=(cu1_atrb & 0x08) keys='0x08' title='Has Storage' tip='Items support IStorage interface. Required for proper folder functionality - keep enabled.'
						cmd=if((cu1_atrb & 0x08), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x08), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x08), reg.dword)))
					item(checked=(cu1_atrb & 0x10) keys='0x10' title='Can Rename' tip='Items can be renamed (F2). Disabling prevents renaming files and folders.'
						cmd=if((cu1_atrb & 0x10), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10), reg.dword)))
					item(checked=(cu1_atrb & 0x20) keys='0x20' title='Can Delete' tip='Items can be deleted (Del). Disabling prevents deletion and removes "Delete" from context menu.'
						cmd=if((cu1_atrb & 0x20), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20), reg.dword)))
					item(checked=(cu1_atrb & 0x40) keys='0x40' title='Has Property Sheet' tip='Items have property sheets (right-click → Properties). Required for Properties dialog.'
						cmd=if((cu1_atrb & 0x40), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40), reg.dword)))
					item(checked=(cu1_atrb & 0x80) keys='0x80' title='Drop Target' tip='Folder can receive dropped files. Disabling prevents drag-and-drop into this folder.'
						cmd=if((cu1_atrb & 0x80), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80), reg.dword)))	
					separator()
					// Additional Flags
					item(checked=(cu1_atrb & 0x100) keys='0x100' title='Is Link' tip='The specified items are shortcuts.'
						cmd=if((cu1_atrb & 0x100), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x100), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x100), reg.dword)))
					item(checked=(cu1_atrb & 0x200) keys='0x200' title='Can Share' tip='The specified folder objects are shared.'
						cmd=if((cu1_atrb & 0x200), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x200), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x200), reg.dword)))
					item(checked=(cu1_atrb & 0x400) keys='0x400' title='Read Only' tip='The specified items are read-only. In the case of folders, this means that new items cannot be created in those folders.'
						cmd=if((cu1_atrb & 0x400), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x400), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x400), reg.dword)))
					item(checked=(cu1_atrb & 0x800) keys='0x800' title='Ghosted/Dimmed'
						cmd=if((cu1_atrb & 0x800), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x800), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x800), reg.dword)))
					separator()
					// Folder Flags
					item(checked=(cu1_atrb & 0x1000) keys='0x1000' title='System' tip='Item is a system object. Windows treats it as protected system content.'
						cmd=if((cu1_atrb & 0x1000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x1000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x1000), reg.dword)))
					item(checked=(cu1_atrb & 0x2000) keys='0x2000' title='Encrypted' tip='Item is encrypted. Shows lock icon overlay for encrypted files/folders.'
						cmd=if((cu1_atrb & 0x2000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x2000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x2000), reg.dword)))
					item(checked=(cu1_atrb & 0x4000) keys='0x4000' title='Is Slow' tip='Accessing this item is slow (network drive, offline files). Explorer may cache aggressively.'
						cmd=if((cu1_atrb & 0x4000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x4000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x4000), reg.dword)))
					item(checked=(cu1_atrb & 0x8000) keys='0x8000' title='Ghosted/Dimmed' tip='Item appears dimmed/ghosted. Visual indication that item is unavailable or cut for move.'
						cmd=if((cu1_atrb & 0x8000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x8000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x8000), reg.dword)))
					item(checked=(cu1_atrb & 0x10000) keys='0x10000' title='Is Link' tip='Item is a shortcut/link. Sets visual shortcut arrow overlay on icon.'
						cmd=if((cu1_atrb & 0x10000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10000), reg.dword)))
					item(checked=(cu1_atrb & 0x20000) keys='0x20000' title='Is Shared' tip='Folder is shared on network. Shows sharing icon overlay.'
						cmd=if((cu1_atrb & 0x20000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20000), reg.dword)))
					item(checked=(cu1_atrb & 0x40000) keys='0x40000' title='Read Only' tip='Items are read-only. For folders: prevents creating new items. Shows lock icon overlay.'
						cmd=if((cu1_atrb & 0x40000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40000), reg.dword)))
					item(checked=(cu1_atrb & 0x80000) keys='0x80000' title='Hidden' tip='Item is hidden. Only visible when "Show hidden files" is enabled in Folder Options.'
						cmd=if((cu1_atrb & 0x80000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80000), reg.dword)))
					separator()
					// More High Flags
					item(checked=(cu1_atrb & 0x2000000) keys='0x2000000' title='Removable' tip='Content is on removable media (USB, CD). Affects caching and offline availability.'
						cmd=if((cu1_atrb & 0x2000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x2000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x2000000), reg.dword)))
					item(checked=(cu1_atrb & 0x8000000) keys='0x8000000' title='Browsable' tip='Can be browsed in place. Enables in-place navigation rather than new window.'
						cmd=if((cu1_atrb & 0x8000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x8000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x8000000), reg.dword)))
					item(checked=(cu1_atrb & 0x10000000) keys='0x10000000' title='Filesystem Ancestor' tip='Contains file system folders. Indicates descendant folders are on file system.'
						cmd=if((cu1_atrb & 0x10000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10000000), reg.dword)))
					item(checked=(cu1_atrb & 0x20000000) keys='0x20000000' title='Is Folder' tip='Item is a folder container. Required for proper folder behavior - keep enabled.'
						cmd=if((cu1_atrb & 0x20000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20000000), reg.dword)))
					item(checked=(cu1_atrb & 0x40000000) keys='0x40000000' title='Is Filesystem' tip='Item is part of file system (not virtual). Affects how Explorer handles the item.'
						cmd=if((cu1_atrb & 0x40000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40000000), reg.dword)))
					item(checked=(cu1_atrb & 0x80000000) keys='0x80000000' title='Has Subfolders' tip='Folder may contain subfolders. Shows expand arrow in tree view.'
						cmd=if((cu1_atrb & 0x80000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80000000), reg.dword)))				separator()
					separator()
					item(title='Documentation' image=\uE11F cmd='https://learn.microsoft.com/en-us/windows/win32/shell/sfgao') }
				separator()
				item(title='Export' image=\uE145 tip='Export the object in reg file. you can use it in anothe pc witout NS')
				item(title='Destoy' image=\uE0CE cmd=o__delete_it & o_np_del & o_pc_del & reg.delete(cu9+'\CLSID\'+guid) & reload & command.sleep(100) & refresh) }
			item(where=!o__exists title=get_name tip=get_tip image=get_icon keys='create' cmd=o__create_drive & o_np_set & restart) }
		menu(expanded=1 title='E:') {
			//> https://www.elevenforum.com/t/add-or-remove-e-drive-in-navigation-pane-of-file-explorer-in-windows-11.14886/
			$guid = '{856360c3-1ba4-4732-b279-41a6d03fb99b}'
			$pinned = get_show==1
			$cr0_path = 'E:\'
			$cr0_name = 'E: Drive'
			$cr0_tip  = 'Local Disk (E:)'
			$cr0_icon = 'imageres.dll,-32'
			menu(where= o__exists title=get_name tip=get_tip image=get_icon) { 
				item(title='Show in Navigation Pane' sep=1 checked=pinned cmd=o_np_pin_toggle & reload)
				item(title='Change position' keys=if(len(get_pos)>0, 'pos: '+get_pos) image=\uE0A2 vis=if(!pinned, 2) cmd=o_np_pos_new & reload)
				item(title='Show in This PC' sep=1 checked=o_ps_ispin cmd=o_pc_set & command.sleep(100) & refresh)
				item(title='Change Type' image=\uE135 vis=if(!o_ps_ispin, 2) cmd=o_pc_type_new & refresh)
				item(title='Show on Desktop' sep=1 checked=o_dt_ispin cmd=o_dt_pin_set)
				separator()
				item(title='Change Title' keys='+ reset' image=\uE0B7 cmd=o__name_new & reload)
				item(title='Change Icon' keys='+ reset' image=\uE0BF cmd=o__icon_new & reload)
				menu(title='Attributes') {
					$rkey = str.fmt(cu1, guid)+'\ShellFolder'
					item(checked=(cu1_atrb & 0x01) keys='0x01' title='Can Copy' tip='Items can be copied (Ctrl+C). Disabling prevents copying files from this folder.'
						cmd=if((cu1_atrb & 0x01), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x01), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x01), reg.dword)))
					item(checked=(cu1_atrb & 0x02) keys='0x02' title='Can Move/Cut' tip='Items can be moved or cut (Ctrl+X). Disabling prevents moving/cutting files.'
						cmd=if((cu1_atrb & 0x02), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x02), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x02), reg.dword)))
					item(checked=(cu1_atrb & 0x04) keys='0x04' title='Can Create Link' tip='Shortcuts can be created for items. Disabling removes "Create shortcut" from context menu.'
						cmd=if((cu1_atrb & 0x04), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x04), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x04), reg.dword)))
					item(checked=(cu1_atrb & 0x08) keys='0x08' title='Has Storage' tip='Items support IStorage interface. Required for proper folder functionality - keep enabled.'
						cmd=if((cu1_atrb & 0x08), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x08), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x08), reg.dword)))
					item(checked=(cu1_atrb & 0x10) keys='0x10' title='Can Rename' tip='Items can be renamed (F2). Disabling prevents renaming files and folders.'
						cmd=if((cu1_atrb & 0x10), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10), reg.dword)))
					item(checked=(cu1_atrb & 0x20) keys='0x20' title='Can Delete' tip='Items can be deleted (Del). Disabling prevents deletion and removes "Delete" from context menu.'
						cmd=if((cu1_atrb & 0x20), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20), reg.dword)))
					item(checked=(cu1_atrb & 0x40) keys='0x40' title='Has Property Sheet' tip='Items have property sheets (right-click → Properties). Required for Properties dialog.'
						cmd=if((cu1_atrb & 0x40), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40), reg.dword)))
					item(checked=(cu1_atrb & 0x80) keys='0x80' title='Drop Target' tip='Folder can receive dropped files. Disabling prevents drag-and-drop into this folder.'
						cmd=if((cu1_atrb & 0x80), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80), reg.dword)))		
					separator()
					// Additional Flags
					item(checked=(cu1_atrb & 0x100) keys='0x100' title='Is Link' tip='The specified items are shortcuts.'
						cmd=if((cu1_atrb & 0x100), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x100), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x100), reg.dword)))
					item(checked=(cu1_atrb & 0x200) keys='0x200' title='Can Share' tip='The specified folder objects are shared.'
						cmd=if((cu1_atrb & 0x200), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x200), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x200), reg.dword)))
					item(checked=(cu1_atrb & 0x400) keys='0x400' title='Read Only' tip='The specified items are read-only. In the case of folders, this means that new items cannot be created in those folders.'
						cmd=if((cu1_atrb & 0x400), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x400), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x400), reg.dword)))
					item(checked=(cu1_atrb & 0x800) keys='0x800' title='Ghosted/Dimmed'
						cmd=if((cu1_atrb & 0x800), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x800), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x800), reg.dword)))
					separator()
					// Folder Flags
					item(checked=(cu1_atrb & 0x1000) keys='0x1000' title='System' tip='Item is a system object. Windows treats it as protected system content.'
						cmd=if((cu1_atrb & 0x1000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x1000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x1000), reg.dword)))
					item(checked=(cu1_atrb & 0x2000) keys='0x2000' title='Encrypted' tip='Item is encrypted. Shows lock icon overlay for encrypted files/folders.'
						cmd=if((cu1_atrb & 0x2000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x2000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x2000), reg.dword)))
					item(checked=(cu1_atrb & 0x4000) keys='0x4000' title='Is Slow' tip='Accessing this item is slow (network drive, offline files). Explorer may cache aggressively.'
						cmd=if((cu1_atrb & 0x4000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x4000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x4000), reg.dword)))
					item(checked=(cu1_atrb & 0x8000) keys='0x8000' title='Ghosted/Dimmed' tip='Item appears dimmed/ghosted. Visual indication that item is unavailable or cut for move.'
						cmd=if((cu1_atrb & 0x8000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x8000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x8000), reg.dword)))
					item(checked=(cu1_atrb & 0x10000) keys='0x10000' title='Is Link' tip='Item is a shortcut/link. Sets visual shortcut arrow overlay on icon.'
						cmd=if((cu1_atrb & 0x10000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10000), reg.dword)))
					item(checked=(cu1_atrb & 0x20000) keys='0x20000' title='Is Shared' tip='Folder is shared on network. Shows sharing icon overlay.'
						cmd=if((cu1_atrb & 0x20000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20000), reg.dword)))
					item(checked=(cu1_atrb & 0x40000) keys='0x40000' title='Read Only' tip='Items are read-only. For folders: prevents creating new items. Shows lock icon overlay.'
						cmd=if((cu1_atrb & 0x40000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40000), reg.dword)))
					item(checked=(cu1_atrb & 0x80000) keys='0x80000' title='Hidden' tip='Item is hidden. Only visible when "Show hidden files" is enabled in Folder Options.'
						cmd=if((cu1_atrb & 0x80000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80000), reg.dword)))
					separator()
					// More High Flags
					item(checked=(cu1_atrb & 0x2000000) keys='0x2000000' title='Removable' tip='Content is on removable media (USB, CD). Affects caching and offline availability.'
						cmd=if((cu1_atrb & 0x2000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x2000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x2000000), reg.dword)))
					item(checked=(cu1_atrb & 0x8000000) keys='0x8000000' title='Browsable' tip='Can be browsed in place. Enables in-place navigation rather than new window.'
						cmd=if((cu1_atrb & 0x8000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x8000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x8000000), reg.dword)))
					item(checked=(cu1_atrb & 0x10000000) keys='0x10000000' title='Filesystem Ancestor' tip='Contains file system folders. Indicates descendant folders are on file system.'
						cmd=if((cu1_atrb & 0x10000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10000000), reg.dword)))
					item(checked=(cu1_atrb & 0x20000000) keys='0x20000000' title='Is Folder' tip='Item is a folder container. Required for proper folder behavior - keep enabled.'
						cmd=if((cu1_atrb & 0x20000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20000000), reg.dword)))
					item(checked=(cu1_atrb & 0x40000000) keys='0x40000000' title='Is Filesystem' tip='Item is part of file system (not virtual). Affects how Explorer handles the item.'
						cmd=if((cu1_atrb & 0x40000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40000000), reg.dword)))
					item(checked=(cu1_atrb & 0x80000000) keys='0x80000000' title='Has Subfolders' tip='Folder may contain subfolders. Shows expand arrow in tree view.'
						cmd=if((cu1_atrb & 0x80000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80000000), reg.dword)))				separator()
					separator()
					item(title='Documentation' image=\uE11F cmd='https://learn.microsoft.com/en-us/windows/win32/shell/sfgao') }
				separator()
				item(title='Export' image=\uE145 tip='Export the object in reg file. you can use it in anothe pc witout NS')
				item(title='Destoy' image=\uE0CE cmd=o__delete_it & o_np_del & o_pc_del & reg.delete(cu9+'\CLSID\'+guid) & reload & command.sleep(100) & refresh) }
			item(where=!o__exists title=get_name tip=get_tip image=get_icon keys='create' cmd=o__create_drive & o_np_set & restart) }
		menu(expanded=1 title='F:') {
			//> https://www.elevenforum.com/t/add-or-remove-f-drive-in-navigation-pane-of-file-explorer-in-windows-11.18663/
			$guid = '{1979a718-e483-4d99-bd12-78e74c13b73f}'
			$pinned = get_show==1
			$cr0_path = 'F:\'
			$cr0_name = 'F: Drive'
			$cr0_tip  = 'Local Disk (F:)'
			$cr0_icon = 'imageres.dll,-32'
			menu(where= o__exists title=get_name tip=get_tip image=get_icon) { 
				item(title='Show in Navigation Pane' sep=1 checked=pinned cmd=o_np_pin_toggle & reload)
				item(title='Change position' keys=if(len(get_pos)>0, 'pos: '+get_pos) image=\uE0A2 vis=if(!pinned, 2) cmd=o_np_pos_new & reload)
				item(title='Show in This PC' sep=1 checked=o_ps_ispin cmd=o_pc_set & command.sleep(100) & refresh)
				item(title='Change Type' image=\uE135 vis=if(!o_ps_ispin, 2) cmd=o_pc_type_new & refresh)
				item(title='Show on Desktop' sep=1 checked=o_dt_ispin cmd=o_dt_pin_set)
				separator()
				item(title='Change Title' keys='+ reset' image=\uE0B7 cmd=o__name_new & reload)
				item(title='Change Icon' keys='+ reset' image=\uE0BF cmd=o__icon_new & reload)
				menu(title='Attributes') {
					$rkey = str.fmt(cu1, guid)+'\ShellFolder'
					item(checked=(cu1_atrb & 0x01) keys='0x01' title='Can Copy' tip='Items can be copied (Ctrl+C). Disabling prevents copying files from this folder.'
						cmd=if((cu1_atrb & 0x01), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x01), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x01), reg.dword)))
					item(checked=(cu1_atrb & 0x02) keys='0x02' title='Can Move/Cut' tip='Items can be moved or cut (Ctrl+X). Disabling prevents moving/cutting files.'
						cmd=if((cu1_atrb & 0x02), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x02), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x02), reg.dword)))
					item(checked=(cu1_atrb & 0x04) keys='0x04' title='Can Create Link' tip='Shortcuts can be created for items. Disabling removes "Create shortcut" from context menu.'
						cmd=if((cu1_atrb & 0x04), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x04), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x04), reg.dword)))
					item(checked=(cu1_atrb & 0x08) keys='0x08' title='Has Storage' tip='Items support IStorage interface. Required for proper folder functionality - keep enabled.'
						cmd=if((cu1_atrb & 0x08), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x08), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x08), reg.dword)))
					item(checked=(cu1_atrb & 0x10) keys='0x10' title='Can Rename' tip='Items can be renamed (F2). Disabling prevents renaming files and folders.'
						cmd=if((cu1_atrb & 0x10), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10), reg.dword)))
					item(checked=(cu1_atrb & 0x20) keys='0x20' title='Can Delete' tip='Items can be deleted (Del). Disabling prevents deletion and removes "Delete" from context menu.'
						cmd=if((cu1_atrb & 0x20), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20), reg.dword)))
					item(checked=(cu1_atrb & 0x40) keys='0x40' title='Has Property Sheet' tip='Items have property sheets (right-click → Properties). Required for Properties dialog.'
						cmd=if((cu1_atrb & 0x40), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40), reg.dword)))
					item(checked=(cu1_atrb & 0x80) keys='0x80' title='Drop Target' tip='Folder can receive dropped files. Disabling prevents drag-and-drop into this folder.'
						cmd=if((cu1_atrb & 0x80), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80), reg.dword)))
					separator()
					// Additional Flags
					item(checked=(cu1_atrb & 0x100) keys='0x100' title='Is Link' tip='The specified items are shortcuts.'
						cmd=if((cu1_atrb & 0x100), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x100), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x100), reg.dword)))
					item(checked=(cu1_atrb & 0x200) keys='0x200' title='Can Share' tip='The specified folder objects are shared.'
						cmd=if((cu1_atrb & 0x200), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x200), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x200), reg.dword)))
					item(checked=(cu1_atrb & 0x400) keys='0x400' title='Read Only' tip='The specified items are read-only. In the case of folders, this means that new items cannot be created in those folders.'
						cmd=if((cu1_atrb & 0x400), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x400), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x400), reg.dword)))
					item(checked=(cu1_atrb & 0x800) keys='0x800' title='Ghosted/Dimmed'
						cmd=if((cu1_atrb & 0x800), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x800), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x800), reg.dword)))
					separator()
					// Folder Flags
					item(checked=(cu1_atrb & 0x1000) keys='0x1000' title='System' tip='Item is a system object. Windows treats it as protected system content.'
						cmd=if((cu1_atrb & 0x1000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x1000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x1000), reg.dword)))
					item(checked=(cu1_atrb & 0x2000) keys='0x2000' title='Encrypted' tip='Item is encrypted. Shows lock icon overlay for encrypted files/folders.'
						cmd=if((cu1_atrb & 0x2000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x2000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x2000), reg.dword)))
					item(checked=(cu1_atrb & 0x4000) keys='0x4000' title='Is Slow' tip='Accessing this item is slow (network drive, offline files). Explorer may cache aggressively.'
						cmd=if((cu1_atrb & 0x4000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x4000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x4000), reg.dword)))
					item(checked=(cu1_atrb & 0x8000) keys='0x8000' title='Ghosted/Dimmed' tip='Item appears dimmed/ghosted. Visual indication that item is unavailable or cut for move.'
						cmd=if((cu1_atrb & 0x8000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x8000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x8000), reg.dword)))
					item(checked=(cu1_atrb & 0x10000) keys='0x10000' title='Is Link' tip='Item is a shortcut/link. Sets visual shortcut arrow overlay on icon.'
						cmd=if((cu1_atrb & 0x10000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10000), reg.dword)))
					item(checked=(cu1_atrb & 0x20000) keys='0x20000' title='Is Shared' tip='Folder is shared on network. Shows sharing icon overlay.'
						cmd=if((cu1_atrb & 0x20000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20000), reg.dword)))
					item(checked=(cu1_atrb & 0x40000) keys='0x40000' title='Read Only' tip='Items are read-only. For folders: prevents creating new items. Shows lock icon overlay.'
						cmd=if((cu1_atrb & 0x40000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40000), reg.dword)))
					item(checked=(cu1_atrb & 0x80000) keys='0x80000' title='Hidden' tip='Item is hidden. Only visible when "Show hidden files" is enabled in Folder Options.'
						cmd=if((cu1_atrb & 0x80000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80000), reg.dword)))
					separator()
					// More High Flags
					item(checked=(cu1_atrb & 0x2000000) keys='0x2000000' title='Removable' tip='Content is on removable media (USB, CD). Affects caching and offline availability.'
						cmd=if((cu1_atrb & 0x2000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x2000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x2000000), reg.dword)))
					item(checked=(cu1_atrb & 0x8000000) keys='0x8000000' title='Browsable' tip='Can be browsed in place. Enables in-place navigation rather than new window.'
						cmd=if((cu1_atrb & 0x8000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x8000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x8000000), reg.dword)))
					item(checked=(cu1_atrb & 0x10000000) keys='0x10000000' title='Filesystem Ancestor' tip='Contains file system folders. Indicates descendant folders are on file system.'
						cmd=if((cu1_atrb & 0x10000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10000000), reg.dword)))
					item(checked=(cu1_atrb & 0x20000000) keys='0x20000000' title='Is Folder' tip='Item is a folder container. Required for proper folder behavior - keep enabled.'
						cmd=if((cu1_atrb & 0x20000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20000000), reg.dword)))
					item(checked=(cu1_atrb & 0x40000000) keys='0x40000000' title='Is Filesystem' tip='Item is part of file system (not virtual). Affects how Explorer handles the item.'
						cmd=if((cu1_atrb & 0x40000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40000000), reg.dword)))
					item(checked=(cu1_atrb & 0x80000000) keys='0x80000000' title='Has Subfolders' tip='Folder may contain subfolders. Shows expand arrow in tree view.'
						cmd=if((cu1_atrb & 0x80000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80000000), reg.dword)))				separator()
					separator()
					item(title='Documentation' image=\uE11F cmd='https://learn.microsoft.com/en-us/windows/win32/shell/sfgao') }
				separator()
				item(title='Export' image=\uE145 tip='Export the object in reg file. you can use it in anothe pc witout NS')
				item(title='Destoy' image=\uE0CE cmd=o__delete_it & o_np_del & o_pc_del & reg.delete(cu9+'\CLSID\'+guid) & reload & command.sleep(100) & refresh) }
			item(where=!o__exists title=get_name tip=get_tip image=get_icon keys='create' cmd=o__create_drive & o_np_set & restart) }
		separator()
		menu(expanded=1 title='All Tasks (God Mode)') {
			$guid = '{00000000-0000-0000-CE98-0F4435A1C6BB}'
			$pinned = get_show==1
			$cr0_path = 'shell:::{ED7BA470-8E54-465E-825C-99712043E01C}'
			$cr0_name = 'All Tasks'
			$cr0_tip  = str.res(sys.expand(str.trimstart(reg.get(str.fmt(cr0, '{ED7BA470-8E54-465E-825C-99712043E01C}'), 'InfoTip'), '@'))) // "All Windows Settings and Control Panel Items"
			$cr0_icon = '@sys.bin\shell32.dll,21' // "imageres.dll,-27"
			menu(where= o__exists title=get_name tip=get_tip image=get_icon) { 
				item(title='Show in Navigation Pane' sep=1 checked=pinned cmd=o_np_pin_toggle & reload)
				item(title='Change position' keys=if(len(get_pos)>0, 'pos: '+get_pos) image=\uE0A2 vis=if(!pinned, 2) cmd=o_np_pos_new & reload)
				item(title='Show in This PC' sep=1 checked=o_ps_ispin cmd=o_pc_set & command.sleep(100) & refresh)
				item(title='Change Type' image=\uE135 vis=if(!o_ps_ispin, 2) cmd=o_pc_type_new & refresh)
				item(title='Show on Desktop' sep=1 checked=o_dt_ispin cmd=o_dt_pin_set)
				separator()
				item(title='Change Title' keys='+ reset' image=\uE0B7 cmd=o__name_new & reload & refresh)
				item(title='Change Icon' keys='+ reset' image=\uE0BF cmd=o__icon_new & reload & refresh)
				menu(title='Attributes') {
					$rkey = str.fmt(cu1, guid)+'\ShellFolder'
					item(checked=(cu1_atrb & 0x01) keys='0x01' title='Can Copy' tip='Items can be copied (Ctrl+C). Disabling prevents copying files from this folder.'
						cmd=if((cu1_atrb & 0x01), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x01), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x01), reg.dword)))
					item(checked=(cu1_atrb & 0x02) keys='0x02' title='Can Move/Cut' tip='Items can be moved or cut (Ctrl+X). Disabling prevents moving/cutting files.'
						cmd=if((cu1_atrb & 0x02), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x02), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x02), reg.dword)))
					item(checked=(cu1_atrb & 0x04) keys='0x04' title='Can Create Link' tip='Shortcuts can be created for items. Disabling removes "Create shortcut" from context menu.'
						cmd=if((cu1_atrb & 0x04), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x04), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x04), reg.dword)))
					item(checked=(cu1_atrb & 0x08) keys='0x08' title='Has Storage' tip='Items support IStorage interface. Required for proper folder functionality - keep enabled.'
						cmd=if((cu1_atrb & 0x08), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x08), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x08), reg.dword)))
					item(checked=(cu1_atrb & 0x10) keys='0x10' title='Can Rename' tip='Items can be renamed (F2). Disabling prevents renaming files and folders.'
						cmd=if((cu1_atrb & 0x10), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10), reg.dword)))
					item(checked=(cu1_atrb & 0x20) keys='0x20' title='Can Delete' tip='Items can be deleted (Del). Disabling prevents deletion and removes "Delete" from context menu.'
						cmd=if((cu1_atrb & 0x20), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20), reg.dword)))
					item(checked=(cu1_atrb & 0x40) keys='0x40' title='Has Property Sheet' tip='Items have property sheets (right-click → Properties). Required for Properties dialog.'
						cmd=if((cu1_atrb & 0x40), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40), reg.dword)))
					item(checked=(cu1_atrb & 0x80) keys='0x80' title='Drop Target' tip='Folder can receive dropped files. Disabling prevents drag-and-drop into this folder.'
						cmd=if((cu1_atrb & 0x80), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80), reg.dword)))	
					separator()
					// Additional Flags
					item(checked=(cu1_atrb & 0x100) keys='0x100' title='Is Link' tip='The specified items are shortcuts.'
						cmd=if((cu1_atrb & 0x100), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x100), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x100), reg.dword)))
					item(checked=(cu1_atrb & 0x200) keys='0x200' title='Can Share' tip='The specified folder objects are shared.'
						cmd=if((cu1_atrb & 0x200), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x200), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x200), reg.dword)))
					item(checked=(cu1_atrb & 0x400) keys='0x400' title='Read Only' tip='The specified items are read-only. In the case of folders, this means that new items cannot be created in those folders.'
						cmd=if((cu1_atrb & 0x400), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x400), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x400), reg.dword)))
					item(checked=(cu1_atrb & 0x800) keys='0x800' title='Ghosted/Dimmed'
						cmd=if((cu1_atrb & 0x800), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x800), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x800), reg.dword)))
					separator()
					// Folder Flags
					item(checked=(cu1_atrb & 0x1000) keys='0x1000' title='System' tip='Item is a system object. Windows treats it as protected system content.'
						cmd=if((cu1_atrb & 0x1000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x1000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x1000), reg.dword)))
					item(checked=(cu1_atrb & 0x2000) keys='0x2000' title='Encrypted' tip='Item is encrypted. Shows lock icon overlay for encrypted files/folders.'
						cmd=if((cu1_atrb & 0x2000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x2000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x2000), reg.dword)))
					item(checked=(cu1_atrb & 0x4000) keys='0x4000' title='Is Slow' tip='Accessing this item is slow (network drive, offline files). Explorer may cache aggressively.'
						cmd=if((cu1_atrb & 0x4000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x4000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x4000), reg.dword)))
					item(checked=(cu1_atrb & 0x8000) keys='0x8000' title='Ghosted/Dimmed' tip='Item appears dimmed/ghosted. Visual indication that item is unavailable or cut for move.'
						cmd=if((cu1_atrb & 0x8000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x8000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x8000), reg.dword)))
					item(checked=(cu1_atrb & 0x10000) keys='0x10000' title='Is Link' tip='Item is a shortcut/link. Sets visual shortcut arrow overlay on icon.'
						cmd=if((cu1_atrb & 0x10000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10000), reg.dword)))
					item(checked=(cu1_atrb & 0x20000) keys='0x20000' title='Is Shared' tip='Folder is shared on network. Shows sharing icon overlay.'
						cmd=if((cu1_atrb & 0x20000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20000), reg.dword)))
					item(checked=(cu1_atrb & 0x40000) keys='0x40000' title='Read Only' tip='Items are read-only. For folders: prevents creating new items. Shows lock icon overlay.'
						cmd=if((cu1_atrb & 0x40000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40000), reg.dword)))
					item(checked=(cu1_atrb & 0x80000) keys='0x80000' title='Hidden' tip='Item is hidden. Only visible when "Show hidden files" is enabled in Folder Options.'
						cmd=if((cu1_atrb & 0x80000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80000), reg.dword)))
					separator()
					// More High Flags
					item(checked=(cu1_atrb & 0x2000000) keys='0x2000000' title='Removable' tip='Content is on removable media (USB, CD). Affects caching and offline availability.'
						cmd=if((cu1_atrb & 0x2000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x2000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x2000000), reg.dword)))
					item(checked=(cu1_atrb & 0x8000000) keys='0x8000000' title='Browsable' tip='Can be browsed in place. Enables in-place navigation rather than new window.'
						cmd=if((cu1_atrb & 0x8000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x8000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x8000000), reg.dword)))
					item(checked=(cu1_atrb & 0x10000000) keys='0x10000000' title='Filesystem Ancestor' tip='Contains file system folders. Indicates descendant folders are on file system.'
						cmd=if((cu1_atrb & 0x10000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10000000), reg.dword)))
					item(checked=(cu1_atrb & 0x20000000) keys='0x20000000' title='Is Folder' tip='Item is a folder container. Required for proper folder behavior - keep enabled.'
						cmd=if((cu1_atrb & 0x20000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20000000), reg.dword)))
					item(checked=(cu1_atrb & 0x40000000) keys='0x40000000' title='Is Filesystem' tip='Item is part of file system (not virtual). Affects how Explorer handles the item.'
						cmd=if((cu1_atrb & 0x40000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40000000), reg.dword)))
					item(checked=(cu1_atrb & 0x80000000) keys='0x80000000' title='Has Subfolders' tip='Folder may contain subfolders. Shows expand arrow in tree view.'
						cmd=if((cu1_atrb & 0x80000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80000000), reg.dword)))				separator()
					separator()
					item(title='Documentation' image=\uE11F cmd='https://learn.microsoft.com/en-us/windows/win32/shell/sfgao') }
				separator()
				item(title='Export' image=\uE145 tip='Export the object in reg file. you can use it in anothe pc witout NS')
				item(title='Destoy' image=\uE0CE cmd=o__delete_it & o_np_del & o_pc_del & reg.delete(cu9+'\CLSID\'+guid) & reload & command.sleep(100) & refresh) }
			item(where=!o__exists title=get_name tip=get_tip image=get_icon keys='create' cmd=o__create_dir & o_np_set & restart) }
		menu(expanded=1 title='Applications') {
			$guid = '{00000000-0000-0000-D221-19A8B55EE490}'
			$pinned = get_show==1
			$cr0_path = 'shell:::{4234d49b-0245-4df3-b780-3893943456e1}'
			$cr0_name = 'Applications'
			$cr0_tip  = str.res(sys.expand(str.trimstart(reg.get(str.fmt(cr0, '{4234d49b-0245-4df3-b780-3893943456e1}'), 'InfoTip'), '@')))
			$cr0_icon = '@sys.bin\imageres.dll,9'
			menu(where= o__exists title=get_name tip=get_tip image=get_icon) { 
				item(title='Show in Navigation Pane' sep=1 checked=pinned cmd=o_np_pin_toggle & reload)
				item(title='Change position' keys=if(len(get_pos)>0, 'pos: '+get_pos) image=\uE0A2 vis=if(!pinned, 2) cmd=o_np_pos_new & reload)
				item(title='Show in This PC' sep=1 checked=o_ps_ispin cmd=o_pc_set & command.sleep(100) & refresh)
				item(title='Change Type' image=\uE135 vis=if(!o_ps_ispin, 2) cmd=o_pc_type_new & refresh)
				item(title='Show on Desktop' sep=1 checked=o_dt_ispin cmd=o_dt_pin_set)
				separator()
				item(title='Change Title' keys='+ reset' image=\uE0B7 cmd=o__name_new & reload & refresh)
				item(title='Change Icon' keys='+ reset' image=\uE0BF cmd=o__icon_new & reload & refresh)
				menu(title='Attributes') {
					$rkey = str.fmt(cu1, guid)+'\ShellFolder'
					item(checked=(cu1_atrb & 0x01) keys='0x01' title='Can Copy' tip='Items can be copied (Ctrl+C). Disabling prevents copying files from this folder.'
						cmd=if((cu1_atrb & 0x01), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x01), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x01), reg.dword)))
					item(checked=(cu1_atrb & 0x02) keys='0x02' title='Can Move/Cut' tip='Items can be moved or cut (Ctrl+X). Disabling prevents moving/cutting files.'
						cmd=if((cu1_atrb & 0x02), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x02), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x02), reg.dword)))
					item(checked=(cu1_atrb & 0x04) keys='0x04' title='Can Create Link' tip='Shortcuts can be created for items. Disabling removes "Create shortcut" from context menu.'
						cmd=if((cu1_atrb & 0x04), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x04), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x04), reg.dword)))
					item(checked=(cu1_atrb & 0x08) keys='0x08' title='Has Storage' tip='Items support IStorage interface. Required for proper folder functionality - keep enabled.'
						cmd=if((cu1_atrb & 0x08), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x08), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x08), reg.dword)))
					item(checked=(cu1_atrb & 0x10) keys='0x10' title='Can Rename' tip='Items can be renamed (F2). Disabling prevents renaming files and folders.'
						cmd=if((cu1_atrb & 0x10), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10), reg.dword)))
					item(checked=(cu1_atrb & 0x20) keys='0x20' title='Can Delete' tip='Items can be deleted (Del). Disabling prevents deletion and removes "Delete" from context menu.'
						cmd=if((cu1_atrb & 0x20), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20), reg.dword)))
					item(checked=(cu1_atrb & 0x40) keys='0x40' title='Has Property Sheet' tip='Items have property sheets (right-click → Properties). Required for Properties dialog.'
						cmd=if((cu1_atrb & 0x40), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40), reg.dword)))
					item(checked=(cu1_atrb & 0x80) keys='0x80' title='Drop Target' tip='Folder can receive dropped files. Disabling prevents drag-and-drop into this folder.'
						cmd=if((cu1_atrb & 0x80), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80), reg.dword)))	
					separator()
					// Additional Flags
					item(checked=(cu1_atrb & 0x100) keys='0x100' title='Is Link' tip='The specified items are shortcuts.'
						cmd=if((cu1_atrb & 0x100), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x100), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x100), reg.dword)))
					item(checked=(cu1_atrb & 0x200) keys='0x200' title='Can Share' tip='The specified folder objects are shared.'
						cmd=if((cu1_atrb & 0x200), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x200), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x200), reg.dword)))
					item(checked=(cu1_atrb & 0x400) keys='0x400' title='Read Only' tip='The specified items are read-only. In the case of folders, this means that new items cannot be created in those folders.'
						cmd=if((cu1_atrb & 0x400), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x400), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x400), reg.dword)))
					item(checked=(cu1_atrb & 0x800) keys='0x800' title='Ghosted/Dimmed'
						cmd=if((cu1_atrb & 0x800), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x800), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x800), reg.dword)))
					separator()
					// Folder Flags
					item(checked=(cu1_atrb & 0x1000) keys='0x1000' title='System' tip='Item is a system object. Windows treats it as protected system content.'
						cmd=if((cu1_atrb & 0x1000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x1000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x1000), reg.dword)))
					item(checked=(cu1_atrb & 0x2000) keys='0x2000' title='Encrypted' tip='Item is encrypted. Shows lock icon overlay for encrypted files/folders.'
						cmd=if((cu1_atrb & 0x2000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x2000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x2000), reg.dword)))
					item(checked=(cu1_atrb & 0x4000) keys='0x4000' title='Is Slow' tip='Accessing this item is slow (network drive, offline files). Explorer may cache aggressively.'
						cmd=if((cu1_atrb & 0x4000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x4000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x4000), reg.dword)))
					item(checked=(cu1_atrb & 0x8000) keys='0x8000' title='Ghosted/Dimmed' tip='Item appears dimmed/ghosted. Visual indication that item is unavailable or cut for move.'
						cmd=if((cu1_atrb & 0x8000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x8000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x8000), reg.dword)))
					item(checked=(cu1_atrb & 0x10000) keys='0x10000' title='Is Link' tip='Item is a shortcut/link. Sets visual shortcut arrow overlay on icon.'
						cmd=if((cu1_atrb & 0x10000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10000), reg.dword)))
					item(checked=(cu1_atrb & 0x20000) keys='0x20000' title='Is Shared' tip='Folder is shared on network. Shows sharing icon overlay.'
						cmd=if((cu1_atrb & 0x20000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20000), reg.dword)))
					item(checked=(cu1_atrb & 0x40000) keys='0x40000' title='Read Only' tip='Items are read-only. For folders: prevents creating new items. Shows lock icon overlay.'
						cmd=if((cu1_atrb & 0x40000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40000), reg.dword)))
					item(checked=(cu1_atrb & 0x80000) keys='0x80000' title='Hidden' tip='Item is hidden. Only visible when "Show hidden files" is enabled in Folder Options.'
						cmd=if((cu1_atrb & 0x80000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80000), reg.dword)))
					separator()
					// More High Flags
					item(checked=(cu1_atrb & 0x2000000) keys='0x2000000' title='Removable' tip='Content is on removable media (USB, CD). Affects caching and offline availability.'
						cmd=if((cu1_atrb & 0x2000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x2000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x2000000), reg.dword)))
					item(checked=(cu1_atrb & 0x8000000) keys='0x8000000' title='Browsable' tip='Can be browsed in place. Enables in-place navigation rather than new window.'
						cmd=if((cu1_atrb & 0x8000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x8000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x8000000), reg.dword)))
					item(checked=(cu1_atrb & 0x10000000) keys='0x10000000' title='Filesystem Ancestor' tip='Contains file system folders. Indicates descendant folders are on file system.'
						cmd=if((cu1_atrb & 0x10000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10000000), reg.dword)))
					item(checked=(cu1_atrb & 0x20000000) keys='0x20000000' title='Is Folder' tip='Item is a folder container. Required for proper folder behavior - keep enabled.'
						cmd=if((cu1_atrb & 0x20000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20000000), reg.dword)))
					item(checked=(cu1_atrb & 0x40000000) keys='0x40000000' title='Is Filesystem' tip='Item is part of file system (not virtual). Affects how Explorer handles the item.'
						cmd=if((cu1_atrb & 0x40000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40000000), reg.dword)))
					item(checked=(cu1_atrb & 0x80000000) keys='0x80000000' title='Has Subfolders' tip='Folder may contain subfolders. Shows expand arrow in tree view.'
						cmd=if((cu1_atrb & 0x80000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80000000), reg.dword)))				separator()
					separator()
					item(title='Documentation' image=\uE11F cmd='https://learn.microsoft.com/en-us/windows/win32/shell/sfgao') }
				separator()
				item(title='Export' image=\uE145 tip='Export the object in reg file. you can use it in anothe pc witout NS')
				item(title='Destoy' image=\uE0CE cmd=o__delete_it & o_np_del & o_pc_del & reg.delete(cu9+'\CLSID\'+guid) & reload & command.sleep(100) & refresh) }
			item(where=!o__exists title=get_name tip=get_tip image=get_icon keys='create' cmd=o__create_dir & o_np_set & restart) }
		menu(expanded=1 title='Quick access' where=sys.is11 and reg.exists(str.fmt(cr0, '{f874310e-b6b7-47dc-bc84-b9e6b38f5903}'))) {
			$guid = '{00000000-0000-0000-EF10-8BC92A43F7C1}'
			$pinned = get_show==1
			$cr0_path = 'shell:::{679F85CB-0220-4080-B29B-5540CC05AAB6}'
			$cr0_name = 'Quick access'
			$cr0_tip  = str.res(sys.expand(str.trimstart(reg.get(str.fmt(cr0, '{679F85CB-0220-4080-B29B-5540CC05AAB6}'), 'InfoTip'), '@')))
			$cr0_icon = 'imageres.dll,-1024'
			$cr0_pos  = 64
			menu(where= o__exists title=get_name tip=get_tip image=get_icon) { 
				item(title='Show in Navigation Pane' sep=1 checked=pinned cmd=o_np_pin_toggle & reload)
				item(title='Change position' keys=if(len(get_pos)>0, 'pos: '+get_pos) image=\uE0A2 vis=if(!pinned, 2) cmd=o_np_pos_new & reload)
				item(title='Show in This PC' sep=1 checked=o_ps_ispin cmd=o_pc_set & command.sleep(100) & refresh)
				item(title='Change Type' image=\uE135 vis=if(!o_ps_ispin, 2) cmd=o_pc_type_new & refresh)
				item(title='Show on Desktop' sep=1 checked=o_dt_ispin cmd=o_dt_pin_set)
				separator()
				item(title='Change Title' keys='+ reset' image=\uE0B7 cmd=o__name_new & reload & refresh)
				item(title='Change Icon' keys='+ reset' image=\uE0BF cmd=o__icon_new & reload & refresh)
				menu(title='Attributes') {
					$rkey = str.fmt(cu1, guid)+'\ShellFolder'
					item(checked=(cu1_atrb & 0x01) keys='0x01' title='Can Copy' tip='Items can be copied (Ctrl+C). Disabling prevents copying files from this folder.'
						cmd=if((cu1_atrb & 0x01), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x01), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x01), reg.dword)))
					item(checked=(cu1_atrb & 0x02) keys='0x02' title='Can Move/Cut' tip='Items can be moved or cut (Ctrl+X). Disabling prevents moving/cutting files.'
						cmd=if((cu1_atrb & 0x02), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x02), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x02), reg.dword)))
					item(checked=(cu1_atrb & 0x04) keys='0x04' title='Can Create Link' tip='Shortcuts can be created for items. Disabling removes "Create shortcut" from context menu.'
						cmd=if((cu1_atrb & 0x04), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x04), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x04), reg.dword)))
					item(checked=(cu1_atrb & 0x08) keys='0x08' title='Has Storage' tip='Items support IStorage interface. Required for proper folder functionality - keep enabled.'
						cmd=if((cu1_atrb & 0x08), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x08), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x08), reg.dword)))
					item(checked=(cu1_atrb & 0x10) keys='0x10' title='Can Rename' tip='Items can be renamed (F2). Disabling prevents renaming files and folders.'
						cmd=if((cu1_atrb & 0x10), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10), reg.dword)))
					item(checked=(cu1_atrb & 0x20) keys='0x20' title='Can Delete' tip='Items can be deleted (Del). Disabling prevents deletion and removes "Delete" from context menu.'
						cmd=if((cu1_atrb & 0x20), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20), reg.dword)))
					item(checked=(cu1_atrb & 0x40) keys='0x40' title='Has Property Sheet' tip='Items have property sheets (right-click → Properties). Required for Properties dialog.'
						cmd=if((cu1_atrb & 0x40), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40), reg.dword)))
					item(checked=(cu1_atrb & 0x80) keys='0x80' title='Drop Target' tip='Folder can receive dropped files. Disabling prevents drag-and-drop into this folder.'
						cmd=if((cu1_atrb & 0x80), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80), reg.dword)))	
					separator()
					// Additional Flags
					item(checked=(cu1_atrb & 0x100) keys='0x100' title='Is Link' tip='The specified items are shortcuts.'
						cmd=if((cu1_atrb & 0x100), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x100), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x100), reg.dword)))
					item(checked=(cu1_atrb & 0x200) keys='0x200' title='Can Share' tip='The specified folder objects are shared.'
						cmd=if((cu1_atrb & 0x200), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x200), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x200), reg.dword)))
					item(checked=(cu1_atrb & 0x400) keys='0x400' title='Read Only' tip='The specified items are read-only. In the case of folders, this means that new items cannot be created in those folders.'
						cmd=if((cu1_atrb & 0x400), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x400), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x400), reg.dword)))
					item(checked=(cu1_atrb & 0x800) keys='0x800' title='Ghosted/Dimmed'
						cmd=if((cu1_atrb & 0x800), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x800), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x800), reg.dword)))
					separator()
					// Folder Flags
					item(checked=(cu1_atrb & 0x1000) keys='0x1000' title='System' tip='Item is a system object. Windows treats it as protected system content.'
						cmd=if((cu1_atrb & 0x1000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x1000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x1000), reg.dword)))
					item(checked=(cu1_atrb & 0x2000) keys='0x2000' title='Encrypted' tip='Item is encrypted. Shows lock icon overlay for encrypted files/folders.'
						cmd=if((cu1_atrb & 0x2000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x2000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x2000), reg.dword)))
					item(checked=(cu1_atrb & 0x4000) keys='0x4000' title='Is Slow' tip='Accessing this item is slow (network drive, offline files). Explorer may cache aggressively.'
						cmd=if((cu1_atrb & 0x4000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x4000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x4000), reg.dword)))
					item(checked=(cu1_atrb & 0x8000) keys='0x8000' title='Ghosted/Dimmed' tip='Item appears dimmed/ghosted. Visual indication that item is unavailable or cut for move.'
						cmd=if((cu1_atrb & 0x8000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x8000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x8000), reg.dword)))
					item(checked=(cu1_atrb & 0x10000) keys='0x10000' title='Is Link' tip='Item is a shortcut/link. Sets visual shortcut arrow overlay on icon.'
						cmd=if((cu1_atrb & 0x10000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10000), reg.dword)))
					item(checked=(cu1_atrb & 0x20000) keys='0x20000' title='Is Shared' tip='Folder is shared on network. Shows sharing icon overlay.'
						cmd=if((cu1_atrb & 0x20000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20000), reg.dword)))
					item(checked=(cu1_atrb & 0x40000) keys='0x40000' title='Read Only' tip='Items are read-only. For folders: prevents creating new items. Shows lock icon overlay.'
						cmd=if((cu1_atrb & 0x40000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40000), reg.dword)))
					item(checked=(cu1_atrb & 0x80000) keys='0x80000' title='Hidden' tip='Item is hidden. Only visible when "Show hidden files" is enabled in Folder Options.'
						cmd=if((cu1_atrb & 0x80000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80000), reg.dword)))
					separator()
					// More High Flags
					item(checked=(cu1_atrb & 0x2000000) keys='0x2000000' title='Removable' tip='Content is on removable media (USB, CD). Affects caching and offline availability.'
						cmd=if((cu1_atrb & 0x2000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x2000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x2000000), reg.dword)))
					item(checked=(cu1_atrb & 0x8000000) keys='0x8000000' title='Browsable' tip='Can be browsed in place. Enables in-place navigation rather than new window.'
						cmd=if((cu1_atrb & 0x8000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x8000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x8000000), reg.dword)))
					item(checked=(cu1_atrb & 0x10000000) keys='0x10000000' title='Filesystem Ancestor' tip='Contains file system folders. Indicates descendant folders are on file system.'
						cmd=if((cu1_atrb & 0x10000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x10000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x10000000), reg.dword)))
					item(checked=(cu1_atrb & 0x20000000) keys='0x20000000' title='Is Folder' tip='Item is a folder container. Required for proper folder behavior - keep enabled.'
						cmd=if((cu1_atrb & 0x20000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x20000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x20000000), reg.dword)))
					item(checked=(cu1_atrb & 0x40000000) keys='0x40000000' title='Is Filesystem' tip='Item is part of file system (not virtual). Affects how Explorer handles the item.'
						cmd=if((cu1_atrb & 0x40000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x40000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x40000000), reg.dword)))
					item(checked=(cu1_atrb & 0x80000000) keys='0x80000000' title='Has Subfolders' tip='Folder may contain subfolders. Shows expand arrow in tree view.'
						cmd=if((cu1_atrb & 0x80000000), reg.set(@rkey, 'Attributes', @(cu1_atrb & ~0x80000000), reg.dword), reg.set(@rkey, 'Attributes', @(cu1_atrb | 0x80000000), reg.dword)))				separator()
					separator()
					item(title='Documentation' image=\uE11F cmd='https://learn.microsoft.com/en-us/windows/win32/shell/sfgao') }
				separator()
				item(title='Export' image=\uE145 tip='Export the object in reg file. you can use it in anothe pc witout NS')
				item(title='Destoy' image=\uE0CE cmd=o__delete_it & o_np_del & o_pc_del & reg.delete(cu9+'\CLSID\'+guid) & reload & command.sleep(100) & refresh) }
			item(where=!o__exists title=get_name tip=get_tip image=get_icon keys='create' cmd=o__create_dir & o_np_set & restart) }
		}
	menu(image=[\uE27C, image.color2] title='Panes' tip='Show or hide navigation, preview, and details panes' sep=1) {
		menu(expanded=1 title='Navigation pane') {
			//>	https://www.elevenforum.com/t/show-or-hide-navigation-pane-in-file-explorer-in-windows-11.2537/
			//> https://www.elevenforum.com/t/reset-navigation-pane-width-to-default-in-file-explorer-in-windows-11.9351/
			// Navigation pane
			$np_name = str.res('shell32.dll', -31421) // Navigation pane // 38226
			$np_info = str.res('shell32.dll', -31422) // Show or hide the navigation pane.
			$np_icon =icon.res('shell32.dll', -16755)
			separator()
			item(title=np_name image=np_icon tip='Hide Navigation Pane in File Explorer for current user' where=key.shift()
				cmd=run('cmd', '/c reg.exe add "@cu9\Modules\GlobalSettings\Sizer" /v "PageSpaceControlSizer" /t REG_BINARY /d "a000000000000000000000006b060000" /f', 'open', null, 0, 1) & reopen)
			item(title='Reset Navigation Pane width' image=\uE025 tip='Reset Navigation Pane width to default in File Explorer for current user'
				cmd=reg.delete(cu9+'\Modules\GlobalSettings\Sizer', 'PageSpaceControlSizer') & reopen)
			separator() }
		menu(expanded=1 title='Details and Preview pane') {
			//> https://www.elevenforum.com/t/show-or-hide-details-pane-in-file-explorer-in-windows-11.1774/
			//> https://www.elevenforum.com/t/show-or-hide-preview-pane-in-file-explorer-in-windows-11.1776/
			//> https://www.elevenforum.com/t/reset-details-and-preview-pane-width-to-default-in-file-explorer-in-windows-11.9352/
			// Details pane
			$dp_name = str.res('shell32.dll', -31415) // Details pane // 38227
			$dp_info = str.res('shell32.dll', -31416) // Show or hide the details pane.
			$dp_icon =icon.res('shell32.dll', -16758)
			$dp_show = str.res('shell32.dll', -31425) // Show the Details pane.
			// Preview pane
			$pp_name = str.res('shell32.dll', -31423) // Preview pane // 38228
			$pp_info = str.res('shell32.dll', -31424) // Show or hide the preview pane.
			$pp_icon =icon.res('shell32.dll', -16757)
			$pp_show = str.res('shell32.dll', -31426) // Show the Preview pane.
			// Details and Preview pane
			$bp_name = str.res('shell32.dll', -31429) // Details and Preview pane
			$bp_info = str.res('shell32.dll', -31430) // Hide both the Details and Preview pane.
			separator()
			item(title=dp_name keys='Alt+Shift+P' image=dp_icon tip=dp_info
				cmd=keys.send(key.alt, key.shift, 'P'))
			item(title=dp_show image=dp_icon tip='Show Details Pane in File Explorer for current user' where=key.shift()
				cmd=run('cmd', '/c reg.exe add "@cu9\Modules\GlobalSettings\DetailsContainer" /v "DetailsContainer" /t REG_BINARY /d "0100000002000000" /f', 'open', null, 0, 1) & reopen)
			item(title=pp_name keys='Alt+P' image=pp_icon tip=pp_info
				cmd=keys.send(key.alt, 'P'))
			item(title=pp_show image=pp_icon tip='Show Preview Pane in File Explorer for current user' where=key.shift()
				cmd=run('cmd', '/c reg.exe add "@cu9\Modules\GlobalSettings\DetailsContainer" /v "DetailsContainer" /t REG_BINARY /d "0200000001000000" /f', 'open', null, 0, 1) & reopen)
			item(title=bp_info image=\uE12D tip='Hide Details or Preview Pane in File Explorer for current user' where=key.shift()
				cmd=run('cmd', '/c reg.exe add "@cu9\Modules\GlobalSettings\DetailsContainer" /v "DetailsContainer" /t REG_BINARY /d "0200000002000000" /f', 'open', null, 0, 1) & reopen)
			item(title='Reset Right Pane width' image=\uE025 tip='Reset Details and Preview Pane width to default in File Explorer for current user'
				cmd=reg.delete(cu9+'\Modules\GlobalSettings\Sizer', 'DetailsContainerSizer') & reopen)
			separator() } }
	menu(image=[\uE0EE, image.color1] title='Legacy' tip='Legacy Settings' where=key.shift()) {
		modify(type='*' menu='TreeView/Legacy' where=window.is_tree find='Show This PC|Show Libraries|Show Network' tip='Legacy menu items (lower priority)' vis=2) }
	menu(image=[\uE0F6, image.color1] title='Settings' tip='File Explorer global settings' sep=2) {
		//> https://www.elevenforum.com/t/turn-on-or-off-expand-folder-in-navigation-pane-of-file-explorer-in-windows-11.2544/
			// HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\NavPaneShowAllFolders
		modify(type='*' menu='TreeView/Settings' where=window.is_tree and this.title=='Expand to &current folder' image=\uE257 pos=indexof('Open File Explorer to', 1) sep=2)
		//> https://www.elevenforum.com/t/turn-on-or-off-show-all-folders-in-navigation-pane-of-file-explorer-in-windows-11.2535/
			// HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\NavPaneExpandToCurrentFolder
		modify(type='*' menu='TreeView/Settings' where=window.is_tree and this.title=='Show &all folders' image=\uE0EA pos=indexof('Compact view', 0))
		menu(title='Open File Explorer to:' image=\uE257) {
			//> https://www.elevenforum.com/t/change-folder-to-open-file-explorer-to-by-default-in-windows-11.675/
			//> https://winaero.com/windows-11-open-file-explorer-to-this-pc-or-downloads/
			//> https://www.tenforums.com/tutorials/3734-change-folder-open-file-explorer-default-windows-10-a.html
			$rpath1 = cu9+'\Advanced'
			$rpath2 = str.fmt(cu1, '{52205fd8-5dfb-447d-801a-d0b52f2e83e1}\shell\opennewwindow\command')
			$customed = reg.exists(rpath2)
			item(title='Default'   checked=!customed and !reg.exists(rpath1,'LaunchTo') sep=2 cmd=reg.delete(rpath2) & reg.delete(rpath1))
			item(title=h_name      checked=!customed and  reg.get(rpath1,'LaunchTo')==2 cmd=reg.delete(rpath2) & reg.set(rpath1,'LaunchTo', 2, reg.dword))
			item(title='This PC'   checked=!customed and  reg.get(rpath1,'LaunchTo')==1 cmd=reg.delete(rpath2) & reg.set(rpath1,'LaunchTo', 1, reg.dword))
			item(title='Downloads' checked=!customed and  reg.get(rpath1,'LaunchTo')==3 cmd=reg.delete(rpath2) & reg.set(rpath1,'LaunchTo', 3, reg.dword))
			separator()
			$rpath3 = 'HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\SyncRootManager'
			$rk = reg.keys(rpath3)
			item(title=reg.get(rpath3+'\'+rk[0],'DisplayNameResource') where=len($rk)>0 checked=!customed and reg.get(rpath1,'LaunchTo')==4 and reg.get(rpath1,'LaunchToSyncRoot')==rk[0] cmd=reg.delete(rpath2) & reg.set(rpath1,'LaunchTo', 4, reg.dword) & reg.set(rpath1,'LaunchToSyncRoot', rk[0], reg.sz))
			item(title=reg.get(rpath3+'\'+rk[1],'DisplayNameResource') where=len($rk)>1 checked=!customed and reg.get(rpath1,'LaunchTo')==4 and reg.get(rpath1,'LaunchToSyncRoot')==rk[1] cmd=reg.delete(rpath2) & reg.set(rpath1,'LaunchTo', 4, reg.dword) & reg.set(rpath1,'LaunchToSyncRoot', rk[1], reg.sz))
			item(title=reg.get(rpath3+'\'+rk[2],'DisplayNameResource') where=len($rk)>2 checked=!customed and reg.get(rpath1,'LaunchTo')==4 and reg.get(rpath1,'LaunchToSyncRoot')==rk[2] cmd=reg.delete(rpath2) & reg.set(rpath1,'LaunchTo', 4, reg.dword) & reg.set(rpath1,'LaunchToSyncRoot', rk[2], reg.sz))
			item(title=reg.get(rpath3+'\'+rk[3],'DisplayNameResource') where=len($rk)>3 checked=!customed and reg.get(rpath1,'LaunchTo')==4 and reg.get(rpath1,'LaunchToSyncRoot')==rk[3] cmd=reg.delete(rpath2) & reg.set(rpath1,'LaunchTo', 4, reg.dword) & reg.set(rpath1,'LaunchToSyncRoot', rk[3], reg.sz))
			item(title=reg.get(rpath3+'\'+rk[4],'DisplayNameResource') where=len($rk)>4 checked=!customed and reg.get(rpath1,'LaunchTo')==4 and reg.get(rpath1,'LaunchToSyncRoot')==rk[4] cmd=reg.delete(rpath2) & reg.set(rpath1,'LaunchTo', 4, reg.dword) & reg.set(rpath1,'LaunchToSyncRoot', rk[4], reg.sz))
			separator()
			item(title='Custom' checked= customed cmd={ t_path=path.dir.box() if(len(t_path)>3, reg.set(rpath2, null, 'explorer "@t_path"', reg.sz) & reg.set(rpath2, 'DelegateExecute', null, reg.sz))  }) }
		item(title='Compact view' image=\uE0D7 checked=reg.get(cu9+'\Advanced', 'UseCompactMode')==1
			cmd=reg.set(cu9+'\Advanced', 'UseCompactMode', if(reg.get(cu9+'\Advanced', 'UseCompactMode')==1, 0, 1), reg.dword) & reload)
		item(title='Folder options' image=image.res('imageres.dll,-166') pos=-1 sep=1
			cmd='rundll32.exe' args='shell32.dll,Options_RunDLL 0')
		item(title='Desktop icon settings' image=image.res('@sys.bin\desk.cpl', 0) pos=-1
			cmd='rundll32.exe' args='shell32.dll,Control_RunDLL desk.cpl,,0')
		}
	item(title='R&eload' image=icon.refresh	tip='Refresh navigation pane' sep=3 cmd=reload & refresh)
	menu(expanded=1 vis=0) {
		$guid = "{00000000-0000-0000-8A32-11F3E2A9B4D0}"
		$output = 'D:\@(guid).reg'
		item(title='Export' image=\uE145 tip='Export registry settings to .reg file' 
			cmd=run('powershell', `-noexit -NoProfile $out='@output'; Write-Output $out; 
			'Windows Registry Editor Version 5.00@"\n"' | Out-File $out -Encoding ASCII;
			@@('@str.fmt(cu1, guid)', '@str.fmt(cu2, guid)', '@str.fmt(lm4, guid)') | ForEach-Object { 
				if (Test-Path "Registry::$($_.Replace('HKCU','HKEY_CURRENT_USER').Replace('HKLM','HKEY_LOCAL_MACHINE'))") { Write-Output $_; $t=[IO.Path]::GetTempFileName(); reg.exe export $_ $t /y >$null; (Get-Content $t -Encoding Unicode | Select-Object -Skip 1) | Out-File $out -Append -Encoding ASCII; Remove-Item $t } };
				// if (Test-Path "Registry::@cu3") { $val = Get-ItemProperty -Path 'Registry::@cu3' -Name '@guid' -EA SilentlyContinue; if ($val) { "[@cu3] "@guid"=dword:$(('{0:x8}' -f $val.'@guid'))" | Out-File $out -Append -Encoding ASCII } };
			pause`, 'open', null, 1, 1)
			)
	}
}


/*
item(title=str.res('shell32.dll', -31421) image=icon.res('shell32.dll', -16755) pos=0 where=(wnd.is_explorer and sel.back)
	cmd=run('powershell', `-noexit & { $path=\"HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Modules\GlobalSettings\Sizer\"; $name=\"PageSpaceControlSizer\"; $bytes=(Get-ItemProperty -Path $path -Name $name).$name; $bytes[4]=1-$bytes[4]; Set-ItemProperty -Path $path -Name $name -Value $bytes; }`, 'open', null, 0, 1) & msg('You must reopen windows explorer to apply these changes!'))
*/

/* additional links to check
	https://www.elevenforum.com/pages/tutorial-index/
	https://www.tenforums.com/tutorials/1977-windows-10-tutorial-index.html
	default menu
	https://www.elevenforum.com/t/add-show-home-on-navigation-pane-to-folder-options-in-windows-11.27300/
	https://www.elevenforum.com/t/add-show-gallery-on-navigation-pane-to-folder-options-in-windows-11.27301/
	https://www.elevenforum.com/t/add-show-linux-on-navigation-pane-to-folder-options-in-windows-11.27302/
	Move
	https://www.elevenforum.com/t/move-home-to-top-or-bottom-of-navigation-pane-in-windows-11.12183/
	https://www.elevenforum.com/t/move-gallery-to-top-or-bottom-of-navigation-pane-in-windows-11.18632/
	https://www.elevenforum.com/t/move-libraries-above-or-below-this-pc-in-navigation-pane-in-windows-11.12173/
	look
	https://www.elevenforum.com/t/add-or-remove-folders-in-file-explorer-navigation-pane-in-windows-11.15704/
	*/