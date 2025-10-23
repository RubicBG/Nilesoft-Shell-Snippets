// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

// remove clsid=
	// Global
	$global_non = 0
	$global_uwp = 0
	remove(clsid='*' where=!this.isuwp and global_non title='Temp non-UWP')
	remove(clsid='*' where= this.isuwp and global_uwp title='Temp UWP')
	remove(clsid='*' where=!this.isuwp and app.exists('{00000000-0000-0000-0000-000000000001}') title='All non-UWP')
	remove(clsid='*' where= this.isuwp and app.exists('{00000000-0000-0000-0000-000000000002}') title='All UWP')
	// Windows
	remove(clsid='{e2bf9676-5f8f-435c-97eb-11607a5bedf7}' where=app.exists('{e2bf9676-5f8f-435c-97eb-11607a5bedf7}') title='&Share')
	remove(clsid='{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}' where=app.exists('{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}') title='&Give access to')
	remove(clsid='{09A47860-11B0-4DA5-AFA5-26D86198A780}' where=app.exists('{09A47860-11B0-4DA5-AFA5-26D86198A780}') title='Scan with Windows Defender...')
	remove(clsid='{7AD84985-87B4-4a16-BE58-8B72A5B390F7}' where=app.exists('{7AD84985-87B4-4a16-BE58-8B72A5B390F7}') title='Cast to Device')
	remove(clsid='{596AB062-B4D2-4215-9F74-E9109B0A8153}' where=app.exists('{596AB062-B4D2-4215-9F74-E9109B0A8153}') title='Restore previous &versions')
	remove(clsid='{b8cdcb65-b1bf-4b42-9428-1dfdb7ee92af}' where=app.exists('{b8cdcb65-b1bf-4b42-9428-1dfdb7ee92af}') title='Ex&tract All')
	remove(clsid='{1d27f844-3a1f-4410-85ac-14651078412d}' where=app.exists('{1d27f844-3a1f-4410-85ac-14651078412d}') title='Troubleshoot compatibilit&y')
	remove(clsid='{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}' where=app.exists('{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}') title='Rotate &left/righ&t')
	remove(clsid='{0bf754aa-c967-445c-ab3d-d8fda9bae7ef}' where=app.exists('{0bf754aa-c967-445c-ab3d-d8fda9bae7ef}') title='&Next desktop background')
	remove(clsid='{1a184871-359e-4f67-aad9-5b9905d62232}' where=app.exists('{1a184871-359e-4f67-aad9-5b9905d62232}') title='Install Fonts')
	remove(clsid='{3C0E1E28-51F1-4130-98AC-0FBFB5FE4638}' where=app.exists('{3C0E1E28-51F1-4130-98AC-0FBFB5FE4638}') title='Add or edit stickers')
	// Microsoft
	remove(clsid='{CB3D0F55-BC2C-4C1A-85ED-23ED75B5106B}' where=app.exists('{CB3D0F55-BC2C-4C1A-85ED-23ED75B5106B}') title='OneDrive')
	remove(clsid='{1FA0E654-C9F2-4A1F-9800-B9A75D744B00}' where=app.exists('{1FA0E654-C9F2-4A1F-9800-B9A75D744B00}') title='OneDrive')
	remove(clsid='{776DBC8D-7347-478C-8D71-791E12EF49D8}' where=app.exists('{776DBC8D-7347-478C-8D71-791E12EF49D8}') title='Skype')
	remove(clsid='{CA6CC9F1-867A-481E-951E-A28C5E4F01EA}' where=app.exists('{CA6CC9F1-867A-481E-951E-A28C5E4F01EA}') title='Edit with Notepad')
	remove(clsid='{2430F218-B743-4FD6-97BF-5C76541B4AE9}' where=app.exists('{2430F218-B743-4FD6-97BF-5C76541B4AE9}') title='Edit with Paint')
	remove(clsid='{BFE0E2A4-C70C-4AD7-AC3D-10D1ECEBB5B4}' where=app.exists('{BFE0E2A4-C70C-4AD7-AC3D-10D1ECEBB5B4}') title='Edit with Photos')
	remove(clsid='{1100CBCD-B822-43F0-84CB-16814C2F6B44}' where=app.exists('{1100CBCD-B822-43F0-84CB-16814C2F6B44}') title='Erase Object with Photos')
	remove(clsid='{7A53B94A-4E6E-4826-B48E-535020B264E5}' where=app.exists('{7A53B94A-4E6E-4826-B48E-535020B264E5}') title='Create with Designer')
	remove(clsid='{9AAFEDA2-97B6-43EA-9466-9DE90501B1B6}' where=app.exists('{9AAFEDA2-97B6-43EA-9466-9DE90501B1B6}') title='Visual Search with Bing')
	remove(clsid='{8AB635F8-9A67-4698-AB99-784AD929F3B4}' where=app.exists('{8AB635F8-9A67-4698-AB99-784AD929F3B4}') title='Edit with Clipchamp')
	remove(clsid='{CB3B0003-8088-4EDE-8769-8B354AB2FF8C}' where=app.exists('{CB3B0003-8088-4EDE-8769-8B354AB2FF8C}') title='Ask Copilot')
	remove(clsid='{9F156763-7844-4DC4-B2B1-901F640F5155}' where=app.exists('{9F156763-7844-4DC4-B2B1-901F640F5155}') title='Windows Terminal; Open in Windows Terminal; Open in Terminal')
	remove(clsid='{02DB545A-3E20-46DE-83A5-1329B1E88B6B}' where=app.exists('{02DB545A-3E20-46DE-83A5-1329B1E88B6B}') title='Windows Terminal Preview')
	remove(clsid='{0440049F-D1DC-4E46-B27B-98393D79486B}' where=app.exists('{0440049F-D1DC-4E46-B27B-98393D79486B}') title='PowerToys PowerRename')
	remove(clsid='{84D68575-E186-46AD-B0CB-BAEB45EE29C0}' where=app.exists('{84D68575-E186-46AD-B0CB-BAEB45EE29C0}') title='PowerToys File Locksmith')
	remove(clsid='{51B4D7E5-7568-4234-B4BB-47FB3C016A69}' where=app.exists('{51B4D7E5-7568-4234-B4BB-47FB3C016A69}') title='PowerToys Image Resizer')
	remove(clsid='{FF90D477-E32A-4BE8-8CC5-A502A97F5401}' where=app.exists('{FF90D477-E32A-4BE8-8CC5-A502A97F5401}') title='PowerToys NewPlus')
	remove(clsid='{69824FC6-4660-4A09-9E7C-48DA63C6CC0F}' where=app.exists('{69824FC6-4660-4A09-9E7C-48DA63C6CC0F}') title='PowerToys NewPlus')
	// 3rd
	remove(clsid='{23170F69-40C1-278A-1000-000100020000}' where=app.exists('{23170F69-40C1-278A-1000-000100020000}') title='7-Zip')
	remove(clsid='{CAE3F1D4-7765-4D98-A060-52CD14D56EAB}' where=app.exists('{CAE3F1D4-7765-4D98-A060-52CD14D56EAB}') title='NanaZip')
	remove(clsid='{469D94E9-6AF4-4395-B396-99B1308F8CE5}' where=app.exists('{469D94E9-6AF4-4395-B396-99B1308F8CE5}') title='NanaZip Preview')
	remove(clsid='{B41DB860-64E4-11D2-9906-E49FADC173CA}' where=app.exists('{B41DB860-64E4-11D2-9906-E49FADC173CA}') title='WinRAR')
	remove(clsid='{DCACA03D-01CA-410C-8F35-FBEB05CA8BF0}' where=app.exists('{DCACA03D-01CA-410C-8F35-FBEB05CA8BF0}') title='ABBYY FineReader (3)')
	remove(clsid='{E6950302-61F0-4FEB-97DB-855E30D4A991}' where=app.exists('{E6950302-61F0-4FEB-97DB-855E30D4A991}') title='Notepad++')
	remove(clsid='{B298D29A-A6ED-11DE-BA8C-A68E55D89593}' where=app.exists('{B298D29A-A6ED-11DE-BA8C-A68E55D89593}') title='Notepad++')
	remove(clsid='{6A451C0A-9597-4915-BCCE-6E859BC996B2}' where=app.exists('{6A451C0A-9597-4915-BCCE-6E859BC996B2}') title='Strat 10/11')
	remove(clsid='{5995D43F-41BD-4EF4-9111-19B117879231}' where=app.exists('{5995D43F-41BD-4EF4-9111-19B117879231}') title='UnLockIT')
	remove(clsid='{3D1975AF-48C6-4f8e-A182-BE0E08FA86A9}' where=app.exists('{3D1975AF-48C6-4f8e-A182-BE0E08FA86A9}') title='NVIDIA Control Panel')
	remove(clsid='{5E2121EE-0300-11D4-8D3B-444553540000}' where=app.exists('{5E2121EE-0300-11D4-8D3B-444553540000}') title='AMD Radeon Software')
	remove(clsid='{3AB1675A-CCFF-11D2-8B20-00A0C93CB1F4}' where=app.exists('{3AB1675A-CCFF-11D2-8B20-00A0C93CB1F4}') title='Intel(R) Graphics Settings')
menu(title='Shell Disabler' image=\uE1E5 tip='Disable/Enable common context menu items') {
	$reg_non = 'HKCR\CLSID\{0}'
	$reg_uwp = 'HKCR\PackagedCom\ClassIndex\{0}'
	menu(title='Quick Toggle' image=[\uE231, image.color2] sep=2 tip=['Override all settings from all other menus. Temporarily or permanently disable/enable all GUID-based context menu items. Test first with "one session" option to verify everything works without terminating explorer.exe. If no issues occur, you can safely apply the permanent setting. Changes may not take effect immediately', tip.warning]) {
		/* guids db
			https://www.magnumdb.com/search?q=
			https://strontic.github.io/xcyclopedia/index-com-objects.html
			https://gist.github.com/olafhartong/980e9cd51925ff06a5a3fdfb24fb96c2 */
		// can not exclude {9C07355E-C50A-45D2-B4A3-0A8235F8047F}
		menu(expanded=1 title='All Context Menu Items') {
			$guid1 = '{00000000-0000-0000-0000-000000000001}'
			$guid2 = '{00000000-0000-0000-0000-000000000002}'
			$exst =  app.exists(guid1) and app.exists(guid2)
			// remove(clsid='*' where=true)
	        item(title='All Context Menu Items' tip=['Permanent setting. Applies to all context menu items. May cause explorer.exe to crash if issues occur. Use "one session" first to test', tip.danger]
				vis=keys.shift()
				checked=exst
				cmd=if(exst, app.delete(guid1) and app.delete(guid2), app.set(guid1, this.title) and app.set(guid2, this.title)) and app.reload)
			item(title='All Context Menu Items' keys='one session' image=[\uE123, image.color2] tip=['Temporary for current session only. Applies to all context menu items. Safe to test. Resets after explorer.exe restarts', tip.success]
 				vis=if((global_non and global_uwp) and (app.exists(guid2) and app.exists(guid2)), 2)
				cmd={ global_non=1 global_uwp=1 }) }
		separator()
		menu(expanded=1 title='Standard Context Menu Items') {
			$guid = '{00000000-0000-0000-0000-000000000001}'
			item(title='Standard Context Menu Items' tip=['Permanent setting. Applies to all non-UWP context menu items. May cause explorer.exe to crash if issues occur. Use "one session" first to test', tip.danger]
 				vis=keys.shift()
				checked=app.exists(guid)
				cmd=if(app.exists(guid), app.delete(guid), app.set(guid, this.title)) and app.reload)
			item(title='Standard Context Menu Items' keys='one session' image=[\uE123, image.color2] tip=['Temporary for current session only. Applies to all non-UWP context menu items. Safe to test. Resets after explorer.exe restarts', tip.success]
				vis=if(global_non or app.exists(guid), 2)
				cmd={ global_non=1 }) }
		menu(expanded=1 title='UWP Context Menu Items') {
			$guid = '{00000000-0000-0000-0000-000000000002}'
			item(title='UWP Context Menu Items' tip=['Permanent setting. Applies to all UWP context menu items', tip.warning]
				checked=app.exists(guid)
				cmd=if(app.exists(guid), app.delete(guid), app.set(guid, this.title)) and app.reload)
			item(title='UWP Context Menu Items' keys='one session' image=[\uE123, image.color2] tip=['Temporary for current session only. Applies to all UWP context menu items. Safe to test. Resets after explorer.exe restarts', tip.success]
				vis=if(global_uwp or app.exists(guid), 2)
				cmd={ global_uwp=1 }) }
		}
	menu(title='Windows Built-in' image=\uE1B7 tip=['Control default Windows context menu items. Safe for testing. Changes may not take effect immediately', tip.success]) {
		menu(expanded=1 title='&Share') {
			// https://www.elevenforum.com/t/add-or-remove-share-context-menu-in-windows-11.1690/
			// https://winaero.com/remove-share-context-menu-windows-10/
			$guid = '{E2BF9676-5F8F-435C-97EB-11607A5BEDF7}'
			$exst = app.exists(guid)
			item(title=title.share + ' (modern)'
				image=icon.share
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_non, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		menu(expanded=1 title='&Give access to') {
			// https://winaero.com/remove-give-access-menu-windows-10/
			$guid = '{F81E9010-6EA4-11CE-A7FF-00AA003CA9F6}'
			$exst = app.exists(guid)
			item(title=title.give_access_to
				image=icon.give_access_to
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_non, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		menu(expanded=1 title='Scan with Windows Defender...') {
			$guid = '{09A47860-11B0-4DA5-AFA5-26D86198A780}'
			$exst = app.exists(guid)
			item(title='Scan with Windows Defender'
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_non, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		menu(expanded=1 title='Restore previous &versions') {
			// https://www.elevenforum.com/t/add-or-remove-previous-versions-from-context-menu-and-properties-in-windows-11.9391/
			$guid = '{596AB062-B4D2-4215-9F74-E9109B0A8153}'
			$exst = app.exists(guid)
			item(title=str.res('twext.dll', 1037)
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_non, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		separator()
		menu(expanded=1 title='Rotate &left/righ&t') {
			// https://www.elevenforum.com/t/add-or-remove-rotate-left-and-rotate-right-context-menu-in-windows-11.11063/
			$guid = '{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}'
			$exst = app.exists(guid)
			item(title=title.rotate_right+' / '+title.rotate_left
				image=icon.rotate_right
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_non, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		menu(expanded=1 title='Ex&tract All') {
			// https://www.tenforums.com/tutorials/3233-add-remove-extract-all-context-menu-windows.html
			// https://winaero.com/remove-extract-context-menu-windows-10/
			$guid = '{b8cdcb65-b1bf-4b42-9428-1dfdb7ee92af}'
			$exst = app.exists(guid)
			item(title=title.extract_all
				image=icon.extract_all
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_non, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		menu(expanded=1 title='Troubleshoot compatibilit&y') {
			// https://winaero.com/remove-troubleshoot-compatibility-windows-10/
			$guid = '{1d27f844-3a1f-4410-85ac-14651078412d}'
			$exst = app.exists(guid)
			item(title=title.troubleshoot_compatibility
				image=icon.troubleshoot_compatibility
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_non, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		menu(expanded=1 title='Cast to Device') {
			// https://winaero.com/remove-cast-to-device-from-context-menu-in-windows-10/
			$guid = '{7AD84985-87B4-4a16-BE58-8B72A5B390F7}'
			$exst = app.exists(guid)
			item(title=title.cast_to_device
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_non, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		separator()
		menu(expanded=1 title='&Next desktop background') {
			$guid = '{0bf754aa-c967-445c-ab3d-d8fda9bae7ef}'
			$exst = app.exists(guid)
			item(title=title.next_desktop_background
				image=icon.next_desktop_background
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_non, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		menu(expanded=1 title='Install Fonts') {
			$guid = '{1a184871-359e-4f67-aad9-5b9905d62232}'
			$exst = app.exists(guid)
			item(title='Install Fonts'
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_non, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		menu(expanded=1 title='Add or edit stickers') {
			// https://www.elevenforum.com/t/add-or-remove-add-or-edit-stickers-desktop-context-menu-in-windows-11.7977/
			$guid = '{3C0E1E28-51F1-4130-98AC-0FBFB5FE4638}'
			$exst = app.exists(guid)
			$reg_path='HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Stickers'
			item(title=str.res('themecpl.dll', 704)
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_non, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload)
			item(title='Enable "Stickers"' keys='HKLM'
				where=keys.shift()
				vis=if(reg.exists(reg_path, 'EnableStickers')==1, 2)
				admin cmd-line='/c reg add "@reg_path" /t REG_DWORD /v EnableStickers /d 1 /f' window=0) }
		}
	menu(title='Microsoft Applications' image=\uE1BB tip=['Manage context menu entries from Microsoft applications. Safe for testing. Changes may not take effect immediately', tip.success]) {
		menu(expanded=1 title='OneDrive' tip='UWP + non-UWP') {
			// https://www.tenforums.com/tutorials/127208-add-remove-move-onedrive-context-menu-windows-10-a.html
			// https://winaero.com/remove-onedrive-context-menu-windows-10/
			$guid1 = '{1FA0E654-C9F2-4A1F-9800-B9A75D744B00}'
			$guid2 = '{CB3D0F55-BC2C-4C1A-85ED-23ED75B5106B}'
			$exst = app.exists(guid1) and app.exists(guid2)
			item(title='OneDrive' keys='mix'
				image=package.logo('OneDrive')
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_uwp, guid1)) or reg.exists(str.fmt(reg_non, guid2))), 2)
				cmd=if(exst, app.delete(guid1) and app.delete(guid2), app.set(guid1, this.title) and app.set(guid2, this.title)) and app.reload) }
		menu(expanded=1 title='Skype' tip='UWP') {
			// https://winaero.com/remove-ask-copilot-right-click-menu/
			$guid = '{776DBC8D-7347-478C-8D71-791E12EF49D8}'
			$exst = app.exists(guid)
			item(title='Skype' keys='UWP'
				image=package.logo('skype')
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_uwp, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		menu(expanded=1 title='Send to My Phone' tip='non-UWP' vis=0) {
			// https://www.elevenforum.com/t/add-or-remove-send-to-my-phone-context-menu-in-windows-11.36440/
			// does not effect legacy context menu
			$guid = '{2F788D0F-1317-441B-86D2-4725301BD49D}'
			$exst = app.exists(guid)
			item(title='Send to My Phone'
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_non, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		separator()
		menu(expanded=1 title='Edit with Notepad' tip='UWP') {
			// https://winaero.com/remove-edit-in-notepad-context-menu/
			$guid = '{CA6CC9F1-867A-481E-951E-A28C5E4F01EA}'
			$exst = app.exists(guid)
			item(title='Edit with Notepad' keys='UWP'
				image=package.logo('microsoft.windowsnotepad_')
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_uwp, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		menu(expanded=1 title='Edit with Paint' tip='UWP') {
			$guid = '{2430F218-B743-4FD6-97BF-5C76541B4AE9}'
			$exst = app.exists(guid)
			item(title='Edit with Paint' keys='UWP'
				image=package.logo('microsoft.paint_')
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_uwp, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		menu(expanded=1 title='Edit with Photos' tip='UWP') {
			// https://www.elevenforum.com/t/add-or-remove-photos-context-menu-in-windows-10-and-windows-11.28302/
			$guid = '{BFE0E2A4-C70C-4AD7-AC3D-10D1ECEBB5B4}' // ? {CD349BB6-A2BC-47ED-874F-7185ABA53BD4}
			$exst = app.exists(guid)
			item(title='Edit with Photos' keys='UWP'
				image=package.logo('microsoft.windows.photos_')
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_uwp, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		menu(expanded=1 title='Erase Object with Photos' tip='UWP') {
			// https://www.elevenforum.com/t/add-or-remove-photos-context-menu-in-windows-10-and-windows-11.28302/
			$guid = '{1100CBCD-B822-43F0-84CB-16814C2F6B44}'
			$exst = app.exists(guid)
			item(title='Erase Object with Photos' keys='UWP'
				image=package.logo('microsoft.windows.photos_')
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_uwp, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		menu(expanded=1 title='Create with Designer' tip='UWP') {
			// https://www.elevenforum.com/t/add-or-remove-photos-context-menu-in-windows-10-and-windows-11.28302/
			$guid = '{7A53B94A-4E6E-4826-B48E-535020B264E5}'
			$exst = app.exists(guid)
			item(title='Create with Designer' keys='UWP'
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_uwp, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		menu(expanded=1 title='Visual Search with Bing' tip='UWP') {
			// https://www.elevenforum.com/t/add-or-remove-photos-context-menu-in-windows-10-and-windows-11.28302/
			$guid = '{9AAFEDA2-97B6-43EA-9466-9DE90501B1B6}'
			$exst = app.exists(guid)
			item(title='Visual Search with Bing' keys='UWP'
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_uwp, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		menu(expanded=1 title='Edit with Clipchamp' tip='UWP') {
			// https://winaero.com/how-to-remove-edit-with-clipchamp-from-context-menu-in-file-explorer/
			$guid = '{8AB635F8-9A67-4698-AB99-784AD929F3B4}'
			$exst = app.exists(guid)
			item(title='Edit with Clipchamp' keys='UWP'
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_uwp, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		menu(expanded=1 title='Ask Copilot' tip='UWP') {
			// https://winaero.com/remove-ask-copilot-right-click-menu/
			$guid = '{CB3B0003-8088-4EDE-8769-8B354AB2FF8C}'
			$exst = app.exists(guid)
			item(title='Ask Copilot' keys='UWP'
				image=package.logo('microsoft.copilot')
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_uwp, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		separator()
		menu(expanded=1 title='Windows Terminal' tip='UWP') {
			// https://www.elevenforum.com/t/add-or-remove-open-in-terminal-context-menu-in-windows-11.2479/
			// https://winaero.com/remove-open-in-windows-terminal-context-menu-in-windows-10/
			// https://winaero.com/how-to-remove-open-in-windows-terminal-context-menu-in-windows-11/
			$guid = '{9F156763-7844-4DC4-B2B1-901F640F5155}'
			$exst = app.exists(guid)
			item(title='Windows Terminal' keys='UWP'
				image=package.logo('Microsoft.WindowsTerminal_')
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_uwp, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		menu(expanded=1 title='Windows Terminal Preview' tip='UWP') {
			// https://www.elevenforum.com/t/add-or-remove-open-in-terminal-preview-context-menu-in-windows-11.23990/
			$guid = '{02DB545A-3E20-46DE-83A5-1329B1E88B6B}'
			$exst = app.exists(guid)
			item(title='Windows Terminal Preview' keys='UWP'
				image=package.logo('Microsoft.WindowsTerminalPreview_')
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_uwp, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		separator()
		menu(expanded=1 title='PowerToys PowerRename') {
			$guid = '{0440049F-D1DC-4E46-B27B-98393D79486B}'
			$exst = app.exists(guid)
			item(title='PowerToys PowerRename'
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_non, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		menu(expanded=1 title='PowerToys File Locksmith') {
			$guid = '{84D68575-E186-46AD-B0CB-BAEB45EE29C0}'
			$exst = app.exists(guid)
			item(title='PowerToys File Locksmith'
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_non, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		menu(expanded=1 title='PowerToys Image Resizer') {
			$guid = '{51B4D7E5-7568-4234-B4BB-47FB3C016A69}' // ? {8F491918-259F-451A-950F-8C3EBF4864AF}
			$exst = app.exists(guid)
			item(title='PowerToys Image Resizer'
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_non, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		menu(expanded=1 title='PowerToys NewPlus') {
			$guid1 = '{69824FC6-4660-4A09-9E7C-48DA63C6CC0F}'
			$guid2 = '{FF90D477-E32A-4BE8-8CC5-A502A97F5401}'
			$exst = app.exists(guid1) and app.exists(guid2)
			item(title='PowerToys NewPlus' keys='mix'
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_uwp, guid1)) or reg.exists(str.fmt(reg_non, guid2))), 2)
				cmd=if(exst, app.delete(guid1) and app.delete(guid2), app.set(guid1, this.title) and app.set(guid2, this.title)) and app.reload) }
		}
	menu(title='Third-Party Applications' image=[[\uE253], [\uE252]] tip=['Control context menu items added by installed applications. Safe for testing. Changes may not take effect immediately', tip.success]) {
		menu(expanded=1 title='7-Zip') {
			$guid = '{23170F69-40C1-278A-1000-000100020000}'
			$exst = app.exists(guid)
			item(title='7-Zip'
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_non, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		menu(expanded=1 title='NanaZip' tip='UWP') {
			$guid = '{CAE3F1D4-7765-4D98-A060-52CD14D56EAB}'
			$exst = app.exists(guid)
			item(title='NanaZip' keys='UWP'
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_uwp, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		menu(expanded=1 title='NanaZip Preview' tip='UWP') {
			$guid = '{469D94E9-6AF4-4395-B396-99B1308F8CE5}'
			$exst = app.exists(guid)
			item(title='NanaZip Preview' keys='UWP'
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_uwp, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		menu(expanded=1 title='WinRAR') {
			$guid = '{B41DB860-64E4-11D2-9906-E49FADC173CA}'
			// '{B41DB860-8EE4-11D2-9906-E49FADC173CA}'
			$exst = app.exists(guid)
			item(title='WinRAR'
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_non, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		separator()
		menu(expanded=1 title='ABBYY FineReader') {
			$guid = '{DCACA03D-01CA-410C-8F35-FBEB05CA8BF0}'
			$exst = app.exists(guid)
			item(title='ABBYY FineReader'
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_non, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		menu(expanded=1 title='Dropbox' vis=0) {
			$guid = '{ECD97DE5-3C8F-4ACB-AEEE-CCAB78F7711C}'
			$exst = app.exists(guid)
			item(title='Dropbox'
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_non, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		menu(expanded=1 title='Notepad++' tip='UWP + non-UWP') {
			$guid1 = '{E6950302-61F0-4FEB-97DB-855E30D4A991}'
			$guid2 = '{B298D29A-A6ED-11DE-BA8C-A68E55D89593}'
			$exst = app.exists(guid1) and app.exists(guid2)
			item(title='Notepad++' keys='mix'
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_uwp, guid1)) or reg.exists(str.fmt(reg_non, guid2))), 2)
				cmd=if(exst, app.delete(guid1) and app.delete(guid2), app.set(guid1, this.title) and app.set(guid2, this.title)) and app.reload) }
		menu(expanded=1 title='Start10/11') {
			$guid = '{6A451C0A-9597-4915-BCCE-6E859BC996B2}'
			$exst = app.exists(guid)
			item(title='Start10' +' / ' + 'Start11'
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_non, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		menu(expanded=1 title='StartIsBack' vis=0) {
			$guid = '{a2a9545d-a0c2-42b4-9708-a0b2badd77c9}'
			$exst = app.exists(guid)
			item(title='StartIsBack'
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_non, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		menu(expanded=1 title='UnLockIT' tip='UWP') {
			$guid = '{5995D43F-41BD-4EF4-9111-19B117879231}'
			$exst = app.exists(guid)
			item(title='UnLockIT' keys='UWP'
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_uwp, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		separator()
		/* new?
			https://www.reddit.com/r/Windows11/comments/1le8k8q/slow_right_click_should_i_ignore_it/
			grepWin: {3C557AFF-6181-4BBC-937D-E2FE8844DD49}
			Mp3Tag: {6351E20C-35FA-4BE3-98FB-4CABF1363E12}
			https://www.elevenforum.com/t/edit-remove-from-the-desktop-context-menu-amd-adrenalin.7923/
			AMDSoftwareAdrenalinEdition: 6767B3BC-8FF7-11EC-B909-0242AC120002}
			https://www.elevenforum.com/t/how-to-remove-this-from-the-new-context-menu.4457/page-2
			Edit with Adobe Acrobat: {30DEEDF6-63EA-4042-A7D8-0A9E1B17BB99}
			https://www.deskmodder.de/wiki/index.php?title=Windows_11_Eintr%C3%A4ge_aus_neuem_Kontextmen%C3%BC_entfernen
			{73961F92-4E9C-11EE-BE56-0242AC120002} "Dropbox"
			Convert to Adobe PDF: {3282E233-C5D3-4533-9B25-44B8AAAFACFA}
			Adobe Acrobat Elements: {A6595CD1-BF77-430A-A452-18696685F7C7}
			https://www.deskmodder.de/phpBB3/viewtopic.php?t=33449
			*/
		separator()
		menu(expanded=1 title='NVIDIA Control Panel') {
			$guid = '{3D1975AF-48C6-4f8e-A182-BE0E08FA86A9}'
			$exst = app.exists(guid)
			item(title='NVIDIA Control Panel'
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_non, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		menu(expanded=1 title='AMD Radeon Software') {
			$guid = '{5E2121EE-0300-11D4-8D3B-444553540000}'
			$exst = app.exists(guid)
			item(title='AMD Radeon Software'
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_non, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		menu(expanded=1 title='Intel(R) Graphics Settings') {
			$guid = '{3AB1675A-CCFF-11D2-8B20-00A0C93CB1F4}'
			$exst = app.exists(guid)
			item(title='Intel(R) Graphics Settings'
				checked=exst
				vis=if(not(reg.exists(str.fmt(reg_non, guid))), 2)
				cmd=if(exst, app.delete(guid), app.set(guid, this.title)) and app.reload) }
		}
	menu(title='Settings' image=[[\uE069],[\uE002]] sep=1) {
		item(title='Reset all' keys='auto'
			commands { cmd-ps=`$p='HKCU:\Software\Nilesoft\Shell\Variables';(gi $p).Property|?{$_ -match'^\{\w{8}(-\w{4}){3}-\w{12}\}$'}|%{rp $p $_ -EA 0}` window=0, cmd=app.reload })
		item(title='Reset all' keys='massages'
			commands { cmd-ps=`-noexit $p='HKCU:\Software\Nilesoft\Shell\Variables'; Write-Host 'Checking...';(gi $p).Property|%{Write-Host $_;if($_ -match'^\{\w{8}(-\w{4}){3}-\w{12}\}$'){Write-Host 'Deleting';rp $p $_ -EA 0}}`, cmd=app.reload })
		$path_export = path.combine(app.directory, 'NS Disabler Settings Export.reg')
		item(title='Export settings' tip='...in "@path_export"' where=keys.shift()
			admin cmd-ps=`$p='HKCU:\Software\Nilesoft\Shell\Variables';$g=(gi $p).Property|?{$_ -match'^\{\w{8}(-\w{4}){3}-\w{12}\}$'};$n=[char]13+[char]10;(\"Windows Registry Editor Version 5.00$n$n[HKEY_CURRENT_USER\Software\Nilesoft\Shell\Variables]\"+($g|%{\"$n\"\"$_\"\"=\"\"$((gp $p).$_)\"\"\"}) )|Out-File \"@path_export\" -Encoding ASCII` window=0) }
	 	$svg_registry=image.svg('<svg  width="100" height="100" viewBox="0 0 461 461">
		<path fill="@image.color2" d="M0 301.058h147.916v147.919H0zm194.432 147.919H342.35V301.058H194.432zM2.802 257.347h147.916V109.434H2.802z"/>
		<path fill="@image.color1" d="M325.476 92.219l-51.603-79.437-79.441 51.601 51.604 79.437zM219.337 213.733l71.045 62.663 62.66-71.039-71.044-62.669zm192.77-155.766-80.668 49.656 49.652 80.666 80.668-49.65z"/></svg>')
	menu(title='Advanced Registry Control' image=svg_registry sep=1 tip=['ADVANCED: Directly modifies Windows Registry. Tested on Windows 11 only. May cause compatibility issues on other Windows versions. Changes take effect immediately. It may not work if Windows prevents it', tip.danger]) {
		menu(expanded=1 title='Ne&w') {
			// https://www.elevenforum.com/t/add-or-remove-new-context-menu-in-windows-11.6752/
			$guid = '{D969A300-E7FF-11d0-A93B-00A0C90F2719}'
			$reg_path1 = 'HKCR\Directory\Background\shellex\ContextMenuHandlers\New'
			$reg_path2 = 'HKCR\LibraryFolder\background\shellex\ContextMenuHandlers\New'
			item(title='Ne&w'  keys='HKCR'
				image=icon.new
				checked=!reg.exists(reg_path1) and !reg.exists(reg_path2)
				admin cmd-line='/c reg @if(reg.exists(reg_path1), 'delete "@reg_path1"', 'add "@reg_path1" /ve /d "@guid"') /f & reg @if(reg.exists(reg_path2), 'delete "@reg_path2"', 'add "@reg_path2" /ve /d "@guid"') /f'  window=0) }
		menu(expanded=1 title='Se&nd to') {
			// https://www.elevenforum.com/t/add-or-remove-send-to-context-menu-in-windows-11.4958/
			$guid = '{D969A300-E7FF-11d0-A93B-00A0C90F2719}'
			$reg_path1 = 'HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\SendTo'
			$reg_path2 = 'HKCR\UserLibraryFolder\shellex\ContextMenuHandlers\SendTo'
			item(title=title.send_to  keys='HKCR'
				image=icon.send_to
				checked=!reg.exists(reg_path1) and !reg.exists(reg_path2)
				admin cmd-line='/c reg @if(reg.exists(reg_path1), 'delete "@reg_path1"', 'add "@reg_path1" /ve /d "@guid"') /f & reg @if(reg.exists(reg_path2), 'delete "@reg_path2"', 'add "@reg_path2" /ve /d "@guid"') /f'  window=0) }
		menu(expanded=1 title='Open wit&h' tip='look') {
			// https://www.elevenforum.com/t/add-or-remove-open-with-context-menu-in-windows-11.11938/
			// https://www.tenforums.com/tutorials/33975-add-remove-open-context-menu-windows-10-a.html
			// https://winaero.com/remove-extract-context-menu-windows-10/
			$guidA = '{D969A300-E7FF-11d0-A93B-00A0C90F2719}'
			$reg_path1 = 'HKCR\*\shellex\ContextMenuHandlers\Open With'
			$guidB = '{09799AFB-AD67-11d1-ABCD-00C04FC30936}'
			$reg_path2 = 'HKCR\*\shellex\ContextMenuHandlers\Open With EncryptionMenu'
			$guidC = '{A470F8CF-A1E8-4f65-8335-227475AA5C46}'
			item(title='Open wit&h' + ' (item)' keys='HKCR' where=sys.is11
				image=icon.open_with
				checked=!reg.exists(reg_path1)
				admin cmd-line='/c reg @if(reg.exists(reg_path1), 'delete "@reg_path1"', 'add "@reg_path1" /ve /d "@guidA"') /f'  window=0)
			item(title='Open wit&h' + ' (menu)' keys='HKCR' where=sys.is11
				image=icon.open_with
				checked=!reg.exists(reg_path2)
				admin cmd-line='/c reg @if(reg.exists(reg_path2), 'delete "@reg_path2"', 'add "@reg_path2" /ve /d "@guidB"') /f'  window=0)
			item(title='Open wit&h' + ' (both)' keys='HKCR' where=0
				image=icon.open_with
				checked=!reg.exists(reg_path1) and !reg.exists(reg_path2)
				admin cmd-line='/c reg @if(reg.exists(reg_path1), 'delete "@reg_path1"', 'add "@reg_path1" /ve /d "@guidA"') /f & reg @if(reg.exists(reg_path2), 'delete "@reg_path2"', 'add "@reg_path2" /ve /d "@guidB"') /f'  window=0)
			item(title='Open wit&h' + ' (item)' keys='HKCR' where=!sys.is11
				image=icon.open_with
				checked=!reg.exists(reg_path1)
				admin cmd-line='/c reg @if(reg.exists(reg_path1), 'delete "@reg_path1"', 'add "@reg_path1" /ve /d "@guidB"') /f'  window=0)
			item(title='Open wit&h' + ' (menu)' keys='HKCR' where=!sys.is11
				image=icon.open_with
				checked=!reg.exists(reg_path2)
				admin cmd-line='/c reg @if(reg.exists(reg_path2), 'delete "@reg_path2"', 'add "@reg_path2" /ve /d "@guidC"') /f'  window=0) }
		separator()
		menu(expanded=1 title='Pin/Unpin All' vis=0 tip='look') {
			// https://www.elevenforum.com/t/add-or-remove-pin-to-start-context-menu-in-windows-11.6861/
			// https://winaero.com/remove-pin-start-windows-10/
			$guid = '{470C0EBD-5D73-4d58-9CED-E91E22E23282}'
			$reg_path1 = 'HKCR\exefile\shellex\ContextMenuHandlers\PintoStartScreen'
			$reg_path2 = 'HKCR\Folder\ShellEx\ContextMenuHandlers\PintoStartScreen'
			$reg_path3 = 'HKCR\Microsoft.Website\shellex\ContextMenuHandlers\PintoStartScreen'
			$reg_path4 = 'HKCR\mscfile\shellex\ContextMenuHandlers\PintoStartScreen'
			$reg_path0 = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked'
			item(title='Pin/Unpin All'  keys='HKLM+HKCR'
				image=icon.pin
				checked=!reg.exists(reg_path1) and !reg.exists(reg_path2) and !reg.exists(reg_path3) and !reg.exists(reg_path4) and reg.exists(reg_path0, guid)
				admin cmd-line='/c ' +
					'reg @if(reg.exists(reg_path1), 'delete "@reg_path1"', 'add "@reg_path1" /ve /d "@guid"') /f & ' +
					'reg @if(reg.exists(reg_path2), 'delete "@reg_path2"', 'add "@reg_path2" /ve /d "@guid"') /f & ' +
					'reg @if(reg.exists(reg_path3), 'delete "@reg_path3"', 'add "@reg_path3" /ve /d "@guid"') /f & ' +
					'reg @if(reg.exists(reg_path4), 'delete "@reg_path4"', 'add "@reg_path4" /ve /d "@guid"') /f & ' +
					'reg @if(reg.exists(reg_path0, guid), 'add "@reg_path0" /v "@guid" /t REG_SZ /d ""', 'delete "@reg_path0" /v "@guid"') /f' window=0) }
		menu(expanded=1 title='Pin to/Unpin from taskbar' vis=keys.shift() tip='look') {
			// https://winaero.com/remove-pin-taskbar-windows-10/
			$guid = '{90AA3A4E-1CBA-4233-B8BB-535773D48449}'
			$reg_path = 'HKCR\*\shellex\ContextMenuHandlers\@guid'
			item(title=title.pin_to_taskbar + ' / ' + title.unpin_from_taskbar keys='HKCR'
				image=icon.pin
				checked=!reg.exists(reg_path)
				admin cmd-line='/c reg @if(reg.exists(reg_path), 'delete "@reg_path"', 'add "@reg_path" /ve /d "Taskband Pin"') /f'  window=0) }
		menu(expanded=1 title='Pin to Start Men&u') {
			// https://winaero.com/how-to-add-pin-to-start-menu-command-for-folders-in-windows-7/
			$guid = '{a2a9545d-a0c2-42b4-9708-a0b2badd77c8}'
			$reg_path1 = 'HKCR\*\shellex\ContextMenuHandlers\@guid'
			$reg_path2 = 'HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\@guid'
			$reg_path3 = 'HKCR\Folder\shellex\ContextMenuHandlers\@guid'
			item(title=title.pin_to_start + ' / ' + title.unpin_from_start keys='HKCR'
				image=icon.pin
				checked=!reg.exists(reg_path1) and !reg.exists(reg_path2) and !reg.exists(reg_path3)
				admin cmd-line='/c ' +
					'reg @if(reg.exists(reg_path1), 'delete "@reg_path1"', 'add "@reg_path1" /ve /d "Start Menu Pin"') /f & ' +
					'reg @if(reg.exists(reg_path2), 'delete "@reg_path2"', 'add "@reg_path2" /ve /d "Start Menu Pin"') /f & ' +
					'reg @if(reg.exists(reg_path3), 'delete "@reg_path3"', 'add "@reg_path3" /ve /d "Start Menu Pin"') /f' window=0) }
		menu(expanded=1 title='Add to Favorites') {
			// https://www.elevenforum.com/t/add-or-remove-add-to-favorites-context-menu-in-windows-11.6795/
			$reg_path = if(!sys.is11 and reg.exists('HKCR\*\shell\pintohome'), 'HKCR\*\shell\pintohome', 'HKCR\*\shell\pintohomefile')
			item(title=title.add_to_favorites + ' / ' + title.remove_from_favorites  keys='HKCR'
				image=icon.add_to_favorites
				checked=!reg.exists(reg_path)
				admin cmd-line='/c '+ if(reg.exists(reg_path),
					'reg delete "@reg_path" /f',
					'reg add "@reg_path" /v "CommandStateHandler" /t REG_SZ /d "{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}" /f & ' +
					'reg add "@reg_path" /v "CommandStateSync" /t REG_SZ /d "" /f & ' +
					'reg add "@reg_path" /v "MUIVerb" /t REG_SZ /d "@@shell32.dll,-51389" /f & ' + // 51388
					'reg add "@reg_path" /v "NeverDefault" /t REG_SZ /d "" /f & ' +
					'reg add "@reg_path" /v "SkipCloudDownload" /t REG_DWORD /d 0 /f & ' +
					'reg add "@reg_path\command" /v "DelegateExecute" /t REG_SZ /d "{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}" /f') window=0) }		
		menu(expanded=1 title='&Include in library') {
			// https://www.elevenforum.com/t/add-or-remove-include-in-library-context-menu-in-windows-11.15843/
			// https://winaero.com/remove-include-library-windows-10/
			$guid = '{3dad6c5d-2167-4cae-9914-f99e41c12cfa}'
			$reg_path1 = 'HKCR\Folder\ShellEx\ContextMenuHandlers\Library Location'
			$reg_path2 = 'HKLM\SOFTWARE\Classes\Folder\ShellEx\ContextMenuHandlers\Library Location'
			item(title=title.include_in_library  keys='HKCR+HKLM'
				image=icon.include_in_library
				checked=!reg.exists(reg_path1) and !reg.exists(reg_path2)
				admin cmd-line='/c reg @if(reg.exists(reg_path1), 'delete "@reg_path1"', 'add "@reg_path1" /ve /d "@guid"') /f & reg @if(reg.exists(reg_path2), 'delete "@reg_path2"', 'add "@reg_path2" /ve /d "@guid"') /f'  window=0) }
		
		separator()
		menu(expanded=1 title='Copy &as path') {
			// https://www.elevenforum.com/t/add-or-remove-copy-as-path-context-menu-in-windows-11.12900/
			// https://winaero.com/get-copy-path-always-visible-in-context-menu-in-windows-10/
			$guid = '{f3d06e7c-1e45-4a26-847e-f9fcdee59be0}'
			$reg_path = 'HKLM\SOFTWARE\Classes\AllFileSystemObjects\shellex\ContextMenuHandlers\CopyAsPathMenu'
			item(title=title.copy_as_path  keys='HKLM'
				image=icon.copy_as_path
				checked=!reg.exists(reg_path)
				admin cmd-line='/c reg @if(reg.exists(reg_path), 'delete "@reg_path"', 'add "@reg_path" /ve /d "@guid"') /f'  window=0) }
		menu(expanded=1 title='Copy To &folder...') {
			// https://www.elevenforum.com/t/add-or-remove-copy-to-folder-and-move-to-folder-context-menu-in-windows-11.1339/
			$guid = '{C2FBB630-2971-11d1-A18C-00C04FD75D13}'
			$reg_path = 'HKCU\SOFTWARE\Classes\AllFileSystemObjects\shellex\ContextMenuHandlers\@guid'
			item(title='Copy To &folder...' keys='HKCU'
				image=icon.copy_to
				checked=!reg.exists(reg_path)
				cmd-line='/c reg @if(reg.exists(reg_path), 'delete', 'add') "@reg_path" /f' window=0) }
		menu(expanded=1 title='Mo&ve To folder...') {
			// https://www.elevenforum.com/t/add-or-remove-copy-to-folder-and-move-to-folder-context-menu-in-windows-11.1339/
			$guid = '{C2FBB631-2971-11d1-A18C-00C04FD75D13}'
			$reg_path = 'HKCU\SOFTWARE\Classes\AllFileSystemObjects\shellex\ContextMenuHandlers\@guid'
			item(title='Mo&ve To folder...' keys='HKCU'
				image=icon.move_to
				checked=!reg.exists(reg_path)
				cmd-line='/c reg @if(reg.exists(reg_path), 'delete', 'add') "@reg_path" /f' window=0) }
		separator()
		menu(expanded=1 title='Open file/folder loca&tion') {
			// https://www.elevenforum.com/t/add-or-remove-open-file-location-and-open-folder-location-context-menu-in-windows.11959/
			$guid = '{37ea3a21-7493-4208-a011-7f9ea79ce9f5}'
			$reg_path1 = 'HKCR\.symlink\shellex\ContextMenuHandlers\OpenContainingFolderMenu'
			$reg_path2 = 'HKCR\LibraryLocation\ShellEx\ContextMenuHandlers\OpenContainingFolderMenu'
			$reg_path3 = 'HKCR\lnkfile\shellex\ContextMenuHandlers\OpenContainingFolderMenu'
			$reg_path4 = 'HKCR\PinnedRecentDocument\ShellEx\ContextMenuHandlers\OpenContainingFolderMenu'
			$reg_path5 = 'HKCR\RecentDocument\ShellEx\ContextMenuHandlers\OpenContainingFolderMenu'
			$reg_path6 = 'HKCR\RecommendationsFile\ShellEx\ContextMenuHandlers\OpenContainingFolderMenu'
			$reg_path7 = 'HKCR\Results\ShellEx\ContextMenuHandlers\OpenContainingFolderMenu'
			item(title=title.open_folder_location +' / '+title.open_file_location  keys='HKCR'
				image=icon.open_folder_location
				checked=!reg.exists(reg_path1) and !reg.exists(reg_path2) and !reg.exists(reg_path3) and !reg.exists(reg_path4) and !reg.exists(reg_path5) and !reg.exists(reg_path6) and !reg.exists(reg_path7)
				admin cmd-line='/c ' +
					'reg @if(reg.exists(reg_path1), 'delete "@reg_path1"', 'add "@reg_path1" /ve /d "@guid"') /f & ' +
					'reg @if(reg.exists(reg_path2), 'delete "@reg_path2"', 'add "@reg_path2" /ve /d "@guid"') /f & ' +
					'reg @if(reg.exists(reg_path3), 'delete "@reg_path3"', 'add "@reg_path3" /ve /d "@guid"') /f & ' +
					'reg @if(reg.exists(reg_path4), 'delete "@reg_path4"', 'add "@reg_path4" /ve /d "@guid"') /f & ' +
					'reg @if(reg.exists(reg_path5), 'delete "@reg_path5"', 'add "@reg_path5" /ve /d "@guid"') /f & ' +
					'reg @if(reg.exists(reg_path6), 'delete "@reg_path6"', 'add "@reg_path6" /ve /d "@guid"') /f & ' +
					'reg @if(reg.exists(reg_path7), 'delete "@reg_path7"', 'add "@reg_path7" /ve /d "@guid"') /f' window=0) }
		menu(expanded=1 title='Open as portable') {
			// https://www.elevenforum.com/t/add-or-remove-open-as-portable-device-context-menu-in-windows-11.12911/
			$guid = '{D6791A63-E7E2-4fee-BF52-5DED8E86E9B8}'
			$reg_path = 'HKCR\Drive\shellex\ContextMenuHandlers\@guid'
			item(title=title.open_as_portable  keys='HKCR'
				image=icon.open_as_portable
				checked=!reg.exists(reg_path)
				admin cmd-line='/c reg @if(reg.exists(reg_path), 'delete "@reg_path"', 'add "@reg_path" /v "@guid" /d "Portable Devices Menu"') /f'  window=0) }
		separator()
		menu(expanded=1 title='Run as di&fferent user' vis=0 tip='simple registry') {
			// https://www.elevenforum.com/t/add-or-remove-run-as-different-user-context-menu-in-explorer-in-windows-11.5080/
			$guid = '{ea72d00e-4960-42fa-ba92-7792a7944c1d}' }
		menu(expanded=1 title='Set as desktop background' vis=0 tip='simple registry') {
			// https://www.elevenforum.com/t/add-or-remove-set-as-desktop-background-context-menu-in-windows-11.6170/
			}
		menu(expanded=1 title='Always available offline') {
			// https://winaero.com/add-or-remove-always-available-offline-context-menu-in-windows-10/
			$guid = '{474C98EE-CF3D-41f5-80E3-4AAB0AB04301}'
			$reg_path1 = 'HKCU\AllFilesystemObjects\shellex\ContextMenuHandlers\@guid'
			$reg_path2 = 'HKCU\Folder\shellex\ContextMenuHandlers\Offline Files'
			$reg_path3 = 'HKCU\Directory\shellex\ContextMenuHandlers\Offline Files'
			item(title='Always available offline' keys='HKCU'
				checked=!reg.exists(reg_path1) and !reg.exists(reg_path2) and !reg.exists(reg_path3)
				cmd-line='/c ' +
					'reg @if(reg.exists(reg_path1), 'delete', 'add') "@reg_path1" /f & ' +
					'reg @if(reg.exists(reg_path2), 'delete "@reg_path2"', 'add "@reg_path2" /ve /d "@guid"') /f & ' +
					'reg @if(reg.exists(reg_path3), 'delete "@reg_path3"', 'add "@reg_path3" /ve /d "@guid"') /f' window=0) }
		}
}