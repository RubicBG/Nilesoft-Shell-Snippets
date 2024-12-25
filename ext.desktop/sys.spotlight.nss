/*	Author: Rubic / RubicBG
	https://github.com/RubicBG/Nilesoft-Shell-Snippets/

	Description: This script enhances Windows Spotlight functionality by adding a context menu to manage desktop wallpapers and related content from Windows Spotlight.
*/

// Define key variables
$sp_default_type  = sel.type==0 and wnd.is_desktop and sel.raw=='::{2cc5ca98-6485-489a-920e-b3e88a6ccce3}'
$wp_path = ''  
// PowerShell command for setting wallpaper using SystemParametersInfo
$wp_setc = `param ([string]$Image = \"@wp_path\"); Add-Type -TypeDefinition 'using System; using System.Runtime.InteropServices; public class Params { [DllImport(\"User32.dll\", CharSet = CharSet.Unicode)] public static extern int SystemParametersInfo (Int32 uAction, Int32 uParam, String lpvParam, Int32 fuWinIni); }'; $SPI_SETDESKWALLPAPER = 0x0014; $UpdateIniFile = 0x01; $SendChangeEvent = 0x02; $fWinIni = $UpdateIniFile -bor $SendChangeEvent; [Params]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $Image, $fWinIni)`

// Hide default context menu items for Spotlight
remove(where=sp_default_type find='"Open"')
remove(where=sp_default_type and this.title==title.cut)
remove(where=sp_default_type and this.title==title.delete)
remove(where=sp_default_type and this.title==title.create_shortcut)

menu(where=sp_default_type expanded='true') {
	$svg_wall ='<svg width="100" height="100" viewBox="0 0 24 24" fill="none">
		<path d="M2 6C2 3.79086 3.79086 2 6 2H18C20.2091 2 22 3.79086 22 6V18C22 20.2091 20.2091 22 18 22H6C3.79086 22 2 20.2091 2 18V6Z" stroke="@image.color1" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
		<circle cx="8.5" cy="8.5" r="2.5" stroke="@image.color2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
		<path d="M14.5262 12.6211L6 22H18.1328C20.2686 22 22 20.2686 22 18.1328V18C22 17.5335 21.8251 17.3547 21.5099 17.0108L17.4804 12.615C16.6855 11.7479 15.3176 11.7507 14.5262 12.6211Z" stroke="@image.color1" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/> </svg>'
	
	// Registry key for Windows Spotlight data
	$reg_new = 'HKCU\Software\Microsoft\Windows\CurrentVersion\DesktopSpotlight\Creatives'

	$tmp_asset			= regex.matches(reg.get(reg_new, 'Creatives'), '"asset":"(.*?)"')			// 8
	$tmp_iconHoverText	= regex.matches(reg.get(reg_new, 'Creatives'), '"iconHoverText":"(.*?)"')	// 16
	$tmp_iconLabel		= regex.matches(reg.get(reg_new, 'Creatives'), '"iconLabel":"(.*?)"')		// 12
	$tmp_title			= regex.matches(reg.get(reg_new, 'Creatives'), '"title":"(.*?)"')			//  8
	$tmp_description	= regex.matches(reg.get(reg_new, 'Creatives'), '"description":"(.*?)"')		// 14
	$tmp_copyright		= regex.matches(reg.get(reg_new, 'Creatives'), '"copyright":"(.*?)"')		// 12
	$tmp_ctaText		= regex.matches(reg.get(reg_new, 'Creatives'), '"ctaText":"(.*?)"')			// 10
	$tmp_ctaUri			= regex.matches(reg.get(reg_new, 'Creatives'), '"ctaUri":"(.*?)"')			//  9
	$tmp_label			= regex.matches(reg.get(reg_new, 'Creatives'), '"label":"(.*?)"')			//  8
	$tmp_actionUri		= regex.matches(reg.get(reg_new, 'Creatives'), '"actionUri":"(.*?)"')		// 12
	$tmp_system_id		= regex.matches(reg.get(reg_new, 'Creatives'), '"entityId":"(.*?)"')		// 11

	// Feature flags for related content
	$use_relatedContent	= 1
	$use_relatedHotspots= 0
	$is_relatedContent	= len(regex.matches(reg.get(reg_new, 'Creatives'), '"relatedContent":\[(.*?)\]'))==4
	$is_relatedHotspots	= len(regex.matches(reg.get(reg_new, 'Creatives'), '"relatedHotspots":\[(.*?)\]'))==4
 
    // Process extracted data into usable arrays
    // TIP: The array indices [0-3] correspond to the 4 available Spotlight images
	$get_system_InfoTip	= [str.replace(str.trim(str.sub(tmp_iconHoverText[0], 16), '"'), '\r\n', '@"\r\n"'), str.replace(str.trim(str.sub(tmp_iconHoverText[1], 16), '"'), '\r\n', '@"\r\n"'), str.replace(str.trim(str.sub(tmp_iconHoverText[2], 16), '"'), '\r\n', '@"\r\n"'), str.replace(str.trim(str.sub(tmp_iconHoverText[3], 16), '"'), '\r\n', '@"\r\n"')]
	$get_system_id		= [str.trim(str.sub(tmp_system_id[0], 11), '"'), str.trim(str.sub(tmp_system_id[1], 11), '"'), str.trim(str.sub(tmp_system_id[2], 11), '"'), str.trim(str.sub(tmp_system_id[3], 11), '"')]
	$get_text_landscape	= [str.trim(str.sub(tmp_iconHoverText[0], 16, str.find(tmp_iconHoverText[0], '\r\n')-16), '"'), str.trim(str.sub(tmp_iconHoverText[1], 16, str.find(tmp_iconHoverText[1], '\r\n')-16), '"'), str.trim(str.sub(tmp_iconHoverText[2], 16, str.find(tmp_iconHoverText[2], '\r\n')-16), '"'), str.trim(str.sub(tmp_iconHoverText[3], 16, str.find(tmp_iconHoverText[3], '\r\n')-16), '"')]
	$get_text_copyright	= [str.trim(str.sub(tmp_copyright[0], 12), '"'), str.trim(str.sub(tmp_copyright[1], 12), '"'), str.trim(str.sub(tmp_copyright[2], 12), '"'), str.trim(str.sub(tmp_copyright[3], 12), '"')]
	$get_text_descriptn	= [str.trim(str.sub(tmp_description[0], 14), '"'), str.trim(str.sub(tmp_description[1], 14), '"'), str.trim(str.sub(tmp_description[2], 14), '"'), str.trim(str.sub(tmp_description[3], 14), '"')]
	$get_text_title		= [str.trim(str.sub(tmp_title[0], 8), '"'), str.trim(str.sub(tmp_title[1], 8), '"'), str.trim(str.sub(tmp_title[2], 8), '"'), str.trim(str.sub(tmp_title[3], 8), '"')]
	$get_image_path1	= [str.trim(str.sub(tmp_asset[0+0], 8), '"'), str.trim(str.sub(tmp_asset[2+0], 8), '"'), str.trim(str.sub(tmp_asset[4+0], 8), '"'), str.trim(str.sub(tmp_asset[6+0], 8), '"')]
	$get_image_path2	= [str.trim(str.sub(tmp_asset[0+1], 8), '"'), str.trim(str.sub(tmp_asset[2+1], 8), '"'), str.trim(str.sub(tmp_asset[4+1], 8), '"'), str.trim(str.sub(tmp_asset[6+1], 8), '"')]
	$get_text_learn1	= [str.trim(str.sub(tmp_iconLabel[0], 12), '"'), str.trim(str.sub(tmp_iconLabel[1], 12), '"'), str.trim(str.sub(tmp_iconLabel[2], 12), '"'), str.trim(str.sub(tmp_iconLabel[3], 12), '"')]
	$get_text_learn2	= [str.trim(str.sub(tmp_ctaText[0], 10), '"'), str.trim(str.sub(tmp_ctaText[1], 10), '"'), str.trim(str.sub(tmp_ctaText[2], 10), '"'), str.trim(str.sub(tmp_ctaText[3], 10), '"')]
	$get_url_name1		= [str.trim(str.sub(tmp_label[0+6*0], 8), '"'), str.trim(str.sub(tmp_label[0+6*1], 8), '"'), str.trim(str.sub(tmp_label[0+6*2], 8), '"'), str.trim(str.sub(tmp_label[0+6*3], 8), '"')]
	$get_url_name2		= [str.trim(str.sub(tmp_label[1+6*0], 8), '"'), str.trim(str.sub(tmp_label[1+6*1], 8), '"'), str.trim(str.sub(tmp_label[1+6*2], 8), '"'), str.trim(str.sub(tmp_label[1+6*3], 8), '"')]
	$get_url_name3		= [str.trim(str.sub(tmp_label[2+6*0], 8), '"'), str.trim(str.sub(tmp_label[2+6*1], 8), '"'), str.trim(str.sub(tmp_label[2+6*2], 8), '"'), str.trim(str.sub(tmp_label[2+6*3], 8), '"')]
	$get_url_name4		= [str.trim(str.sub(tmp_label[3+6*0], 8), '"'), str.trim(str.sub(tmp_label[3+6*1], 8), '"'), str.trim(str.sub(tmp_label[3+6*2], 8), '"'), str.trim(str.sub(tmp_label[3+6*3], 8), '"')]
	$get_url_name5		= [str.trim(str.sub(tmp_label[4+6*0], 8), '"'), str.trim(str.sub(tmp_label[4+6*1], 8), '"'), str.trim(str.sub(tmp_label[4+6*2], 8), '"'), str.trim(str.sub(tmp_label[4+6*3], 8), '"')]
	$get_url_name6		= [str.trim(str.sub(tmp_label[5+6*0], 8), '"'), str.trim(str.sub(tmp_label[5+6*1], 8), '"'), str.trim(str.sub(tmp_label[5+6*2], 8), '"'), str.trim(str.sub(tmp_label[5+6*3], 8), '"')]
	$get_url_link0		= [str.trim(str.sub(tmp_ctaUri[0], 9), '"'), str.trim(str.sub(tmp_ctaUri[1], 9), '"'), str.trim(str.sub(tmp_ctaUri[2], 9), '"'), str.trim(str.sub(tmp_ctaUri[3], 9), '"')]
	$get_url_link1		= [str.trim(str.sub(tmp_actionUri[0+6*0], 12), '"'), str.trim(str.sub(tmp_actionUri[0+6*1], 12), '"'), str.trim(str.sub(tmp_actionUri[0+6*2], 12), '"'), str.trim(str.sub(tmp_actionUri[0+6*3], 12), '"')]
	$get_url_link2		= [str.trim(str.sub(tmp_actionUri[1+6*0], 12), '"'), str.trim(str.sub(tmp_actionUri[1+6*1], 12), '"'), str.trim(str.sub(tmp_actionUri[1+6*2], 12), '"'), str.trim(str.sub(tmp_actionUri[1+6*3], 12), '"')]
	$get_url_link3		= [str.trim(str.sub(tmp_actionUri[2+6*0], 12), '"'), str.trim(str.sub(tmp_actionUri[2+6*1], 12), '"'), str.trim(str.sub(tmp_actionUri[2+6*2], 12), '"'), str.trim(str.sub(tmp_actionUri[2+6*3], 12), '"')]
	$get_url_link4		= [str.trim(str.sub(tmp_actionUri[3+6*0], 12), '"'), str.trim(str.sub(tmp_actionUri[3+6*1], 12), '"'), str.trim(str.sub(tmp_actionUri[3+6*2], 12), '"'), str.trim(str.sub(tmp_actionUri[3+6*3], 12), '"')]
	$get_url_link5		= [str.trim(str.sub(tmp_actionUri[4+6*0], 12), '"'), str.trim(str.sub(tmp_actionUri[4+6*1], 12), '"'), str.trim(str.sub(tmp_actionUri[4+6*2], 12), '"'), str.trim(str.sub(tmp_actionUri[4+6*3], 12), '"')]
	$get_url_link6		= [str.trim(str.sub(tmp_actionUri[5+6*0], 12), '"'), str.trim(str.sub(tmp_actionUri[5+6*1], 12), '"'), str.trim(str.sub(tmp_actionUri[5+6*2], 12), '"'), str.trim(str.sub(tmp_actionUri[5+6*3], 12), '"')]
		
	$wi = reg.get(reg_new, 'ImageIndex')
	item(title = get_text_landscape[wi] tip=get_text_copyright[wi] sep='after' vis='disable')
	item(title = get_text_learn2[wi] image=image.glyph(\uE11F) cmd=get_url_link0[wi])
	item(title='Next' keys='current: '+(wi+1) image=icon.send_to commands {
			cmd = reg.set(reg_new, 'ImageIndex', (wi+1)%4, reg.dword) wait=1,
			cmd = { wp_path=path.separator(get_image_path1[wi],'\') } wait=1,
			cmd-ps = wp_setc window='hidden' wait=1,
			cmd = reg.set('HKCR\CLSID\{2cc5ca98-6485-489a-920e-b3e88a6ccce3}', 'InfoTip', get_system_InfoTip[wi], reg.sz) wait=1,
			cmd = reg.set('HKCR\CLSID\{2cc5ca98-6485-489a-920e-b3e88a6ccce3}', 'InitiallyPlaced', wi, reg.dword) wait=1,
			cmd = reg.set('HKCR\CLSID\{2cc5ca98-6485-489a-920e-b3e88a6ccce3}\shell\SpotlightClick', 'contentId', get_system_id[wi], reg.sz) wait=1,
			cmd = reg.set('HKCR\CLSID\{2cc5ca98-6485-489a-920e-b3e88a6ccce3}\shell\SpotlightClick', 'EdgeUri', get_url_link0[wi], reg.sz) wait=1,
			})
	separator()
	menu(title = get_text_title[0] + "\t" + if(wi==0, 'Activ') image=svg_wall) {
		item(title = get_text_landscape[0] tip=get_text_copyright[0] sep='after' vis='disable')
		item(title = get_text_learn1[0] tip=str.left(get_text_descriptn[0], 100) +'...' cmd=msg(get_text_descriptn[0]))
		item(title = 'View Wallpaper' tip='On shift + click opens cropet wallpaper' cmd=if(keys.shift(), get_image_path2[0], get_image_path1[0]))
		item(title = 'Set Wallpaper' commands {
			cmd = reg.set(reg_new, 'ImageIndex', 0, reg.dword) wait=1,
			cmd= { wp_path=path.separator(get_image_path1[0],'\') } wait=1,
			cmd-ps = wp_setc window='hidden' wait=1,
			cmd = reg.set('HKCR\CLSID\{2cc5ca98-6485-489a-920e-b3e88a6ccce3}', 'InfoTip', get_system_InfoTip[0], reg.sz) wait=1,
			cmd = reg.set('HKCR\CLSID\{2cc5ca98-6485-489a-920e-b3e88a6ccce3}', 'InitiallyPlaced', 0, reg.dword) wait=1,
			cmd = reg.set('HKCR\CLSID\{2cc5ca98-6485-489a-920e-b3e88a6ccce3}\shell\SpotlightClick', 'contentId', get_system_id[0], reg.sz) wait=1,
			cmd = reg.set('HKCR\CLSID\{2cc5ca98-6485-489a-920e-b3e88a6ccce3}\shell\SpotlightClick', 'EdgeUri', get_url_link0[0], reg.sz) wait=1,
			})
		separator()
		item(title = get_text_learn2[0] image=image.glyph(\uE11F) cmd=get_url_link0[0])
		item(title = get_url_name1[0] where=(is_relatedContent and use_relatedContent) image=image.glyph(\uE11F) cmd=get_url_link1[0])
		item(title = get_url_name2[0] where=(is_relatedContent and use_relatedContent) image=image.glyph(\uE11F) cmd=get_url_link2[0])
		item(title = get_url_name3[0] where=(is_relatedContent and use_relatedContent) image=image.glyph(\uE11F) cmd=get_url_link3[0])
		item(title = get_url_name4[0] where=(is_relatedContent and use_relatedContent) image=image.glyph(\uE11F) cmd=get_url_link4[0])
		item(title = get_url_name5[0] where=(is_relatedHotspots and use_relatedHotspots) image=image.glyph(\uE11F) cmd=get_url_link5[0])
		item(title = get_url_name6[0] where=(is_relatedHotspots and use_relatedHotspots) image=image.glyph(\uE11F) cmd=get_url_link6[0]) }
	menu(title = get_text_title[1] + "\t" + if(wi==1, 'Activ') image=svg_wall) {
		item(title = get_text_landscape[1] tip=get_text_copyright[1] sep='after' vis='disable')
		item(title = get_text_learn1[1] tip=str.left(get_text_descriptn[1], 100) +'...' cmd=msg(get_text_descriptn[1]))
		item(title = 'View Wallpaper' tip='On shift + click opens cropet wallpaper' cmd=if(keys.shift(), get_image_path2[1], get_image_path1[1]))
		item(title = 'Set Wallpaper' commands {
			cmd = reg.set(reg_new, 'ImageIndex', 1, reg.dword) wait=1,
			cmd= { wp_path=path.separator(get_image_path1[1],'\') } wait=1,
			cmd-ps = wp_setc window='hidden' wait=1,
			cmd = reg.set('HKCR\CLSID\{2cc5ca98-6485-489a-920e-b3e88a6ccce3}', 'InfoTip', get_system_InfoTip[1], reg.sz) wait=1,
			cmd = reg.set('HKCR\CLSID\{2cc5ca98-6485-489a-920e-b3e88a6ccce3}', 'InitiallyPlaced', 1, reg.dword) wait=1,
			cmd = reg.set('HKCR\CLSID\{2cc5ca98-6485-489a-920e-b3e88a6ccce3}\shell\SpotlightClick', 'contentId', get_system_id[1], reg.sz) wait=1,
			cmd = reg.set('HKCR\CLSID\{2cc5ca98-6485-489a-920e-b3e88a6ccce3}\shell\SpotlightClick', 'EdgeUri', get_url_link0[1], reg.sz) wait=1,
			})
		separator()
		item(title = get_text_learn2[1] image=image.glyph(\uE11F) cmd=get_url_link0[1])
		item(title = get_url_name1[1] where=(is_relatedContent and use_relatedContent) image=image.glyph(\uE11F) cmd=get_url_link1[1])
		item(title = get_url_name2[1] where=(is_relatedContent and use_relatedContent) image=image.glyph(\uE11F) cmd=get_url_link2[1])
		item(title = get_url_name3[1] where=(is_relatedContent and use_relatedContent) image=image.glyph(\uE11F) cmd=get_url_link3[1])
		item(title = get_url_name4[1] where=(is_relatedContent and use_relatedContent) image=image.glyph(\uE11F) cmd=get_url_link4[1])
		item(title = get_url_name5[1] where=(is_relatedHotspots and use_relatedHotspots) image=image.glyph(\uE11F) cmd=get_url_link5[1])
		item(title = get_url_name6[1] where=(is_relatedHotspots and use_relatedHotspots) image=image.glyph(\uE11F) cmd=get_url_link6[1]) }
	menu(title = get_text_title[2] + "\t" + if(wi==2, 'Activ') image=svg_wall) {
		item(title = get_text_landscape[2] tip=get_text_copyright[2] sep='after' vis='disable')
		item(title = get_text_learn1[2] tip=str.left(get_text_descriptn[2], 100) +'...' cmd=msg(get_text_descriptn[2]))
		item(title = 'View Wallpaper' tip='On shift + click opens cropet wallpaper' cmd=if(keys.shift(), get_image_path2[2], get_image_path1[2]))
		item(title = 'Set Wallpaper' commands {
			cmd = reg.set(reg_new, 'ImageIndex', 2, reg.dword) wait=1,
			cmd= { wp_path=path.separator(get_image_path1[2],'\') } wait=1,
			cmd-ps = wp_setc window='hidden' wait=1,
			cmd = reg.set('HKCR\CLSID\{2cc5ca98-6485-489a-920e-b3e88a6ccce3}', 'InfoTip', get_system_InfoTip[2], reg.sz) wait=1,
			cmd = reg.set('HKCR\CLSID\{2cc5ca98-6485-489a-920e-b3e88a6ccce3}', 'InitiallyPlaced', 2, reg.dword) wait=1,
			cmd = reg.set('HKCR\CLSID\{2cc5ca98-6485-489a-920e-b3e88a6ccce3}\shell\SpotlightClick', 'contentId', get_system_id[2], reg.sz) wait=1,
			cmd = reg.set('HKCR\CLSID\{2cc5ca98-6485-489a-920e-b3e88a6ccce3}\shell\SpotlightClick', 'EdgeUri', get_url_link0[2], reg.sz) wait=1,
			})
		separator()
		item(title = get_text_learn2[2] image=image.glyph(\uE11F) cmd=get_url_link0[2])
		item(title = get_url_name1[2] where=(is_relatedContent and use_relatedContent) image=image.glyph(\uE11F) cmd=get_url_link1[2])
		item(title = get_url_name2[2] where=(is_relatedContent and use_relatedContent) image=image.glyph(\uE11F) cmd=get_url_link2[2])
		item(title = get_url_name3[2] where=(is_relatedContent and use_relatedContent) image=image.glyph(\uE11F) cmd=get_url_link3[2])
		item(title = get_url_name4[2] where=(is_relatedContent and use_relatedContent) image=image.glyph(\uE11F) cmd=get_url_link4[2])
		item(title = get_url_name5[2] where=(is_relatedHotspots and use_relatedHotspots) image=image.glyph(\uE11F) cmd=get_url_link5[2])
		item(title = get_url_name6[2] where=(is_relatedHotspots and use_relatedHotspots) image=image.glyph(\uE11F) cmd=get_url_link6[2]) }
	menu(title = get_text_title[3] + "\t" + if(wi==3, 'Activ') image=svg_wall) {
		item(title = get_text_landscape[3] tip=get_text_copyright[3] sep='after' vis='disable')
		item(title = get_text_learn1[3] tip=str.left(get_text_descriptn[3], 100) +'...' cmd=msg(get_text_descriptn[3]))
		item(title = 'View Wallpaper' tip='On shift + click opens cropet wallpaper' cmd=if(keys.shift(), get_image_path2[3], get_image_path1[3]))
		item(title = 'Set Wallpaper' commands {
			cmd = reg.set(reg_new, 'ImageIndex', 3, reg.dword) wait=1,
			cmd= { wp_path=path.separator(get_image_path1[3],'\') } wait=1,
			cmd-ps = wp_setc window='hidden' wait=1,
			cmd = reg.set('HKCR\CLSID\{2cc5ca98-6485-489a-920e-b3e88a6ccce3}', 'InfoTip', get_system_InfoTip[3], reg.sz) wait=1,
			cmd = reg.set('HKCR\CLSID\{2cc5ca98-6485-489a-920e-b3e88a6ccce3}', 'InitiallyPlaced', 3, reg.dword) wait=1,
			cmd = reg.set('HKCR\CLSID\{2cc5ca98-6485-489a-920e-b3e88a6ccce3}\shell\SpotlightClick', 'contentId', get_system_id[3], reg.sz) wait=1,
			cmd = reg.set('HKCR\CLSID\{2cc5ca98-6485-489a-920e-b3e88a6ccce3}\shell\SpotlightClick', 'EdgeUri', get_url_link0[3], reg.sz) wait=1,
			})
		separator()
		item(title = get_text_learn2[3] image=image.glyph(\uE11F) cmd=get_url_link0[3])
		item(title = get_url_name1[3] where=(is_relatedContent and use_relatedContent) image=image.glyph(\uE11F) cmd=get_url_link1[3])
		item(title = get_url_name2[3] where=(is_relatedContent and use_relatedContent) image=image.glyph(\uE11F) cmd=get_url_link2[3])
		item(title = get_url_name3[3] where=(is_relatedContent and use_relatedContent) image=image.glyph(\uE11F) cmd=get_url_link3[3])
		item(title = get_url_name4[3] where=(is_relatedContent and use_relatedContent) image=image.glyph(\uE11F) cmd=get_url_link4[3])
		item(title = get_url_name5[3] where=(is_relatedHotspots and use_relatedHotspots) image=image.glyph(\uE11F) cmd=get_url_link5[3])
		item(title = get_url_name6[3] where=(is_relatedHotspots and use_relatedHotspots) image=image.glyph(\uE11F) cmd=get_url_link6[3]) }
	separator()
	item(title='Save this wallpaper' image=image.glyph(\uE10D) 
		cmd=io.copy(str.trim(path.separator(get_image_path1[wi],'\'), '"'), path.combine(path.dir.box(), get_text_landscape[wi]+'.jpg'))) 
	menu(title='manage and settings' image=icon.settings) {
		$ws_ico=''
		item(title='Change Icon' commands {
			cmd={ ws_ico = icon.box('@sys.bin\imageres.dll', -8201) } & reg.set('HKCR\CLSID\{2cc5ca98-6485-489a-920e-b3e88a6ccce3}\DefaultIcon', '', if(len(ws_ico)>0, ws_ico, '@sys.bin\imageres.dll,-8201'), reg.sz) wait=1,
			cmd='ie4uinit.exe' args='-show' wait=1,
			cmd=command.refresh invoke=500 wait=1, })
		item(title=title.rename image=icon.rename commands {
			cmd=reg.set('HKCR\CLSID\{2cc5ca98-6485-489a-920e-b3e88a6ccce3}', '', if(input('Nilesoft Shell', 'Give a new name'), input.result, 'Learn about this picture'), reg.sz) wait=1,
			cmd='ie4uinit.exe' args='-show' wait=1,
			cmd=command.refresh invoke=500 wait=1, })
		$enable_delete = keys.shift()
		item(title=title.delete image=icon.delete vis=if(not(enable_delete), 'disable') tip=if(not(enable_delete), 'Press SHIFT key to enable the command') commands {
			cmd=reg.set('HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel', '{2cc5ca98-6485-489a-920e-b3e88a6ccce3}', 1, reg.dword) wait=1,
			cmd=io.file.write('@user.desktop\Restore Windows Spotlight icon on the Desktop.reg', 'Windows Registry Editor Version 5.00@"\n\n"[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel]@"\n""{2cc5ca98-6485-489a-920e-b3e88a6ccce3}"="-"') wait=1,
			cmd='ie4uinit.exe' args='-show' wait=1,
			cmd=command.refresh invoke=500 wait=1, })
		separator()
		item(title='Related Content' tip='Show links to related content, if available. It also depends on the system language.' checked=use_relatedContent cmd={ use_relatedContent = not(use_relatedContent) } vis=if(!is_relatedContent, 'disable'))
		item(title='Related Hotspots' tip='Show links to associated hotspots, if available. It also depends on the system language' checked=use_relatedHotspots cmd={ use_relatedHotspots = not(use_relatedHotspots) } vis=if(!is_relatedHotspots, 'disable'))
		separator()
		item(title='Background'		image=inherit cmd='ms-settings:personalization-background')
		item(title='Colors'			image=inherit cmd='ms-settings:personalization-colors')
		item(title='Lock screen'	image=inherit cmd='ms-settings:personalization-lockscreen') //ms-settings:lockscreen
		}
	
	menu(title='Developer' image=\uE26E where=keys.shift()) {	
		item(title = 'Show Images Path' cmd=msg(str.join(get_image_path1, "\n")))
		item(title = 'Open current image folder' cmd=path.location(get_image_path1[0]))
		$reg_new2 = 'HKCU\Software\Microsoft\Windows\CurrentVersion\DesktopSpotlight\Creatives'
		$test=regex.matches(reg.get(reg_new2, 'Creatives'), 'IrisService\\(.*?)"') 
		item(title=str.sub(test[0], 13, 20) cmd='@reg.get('HKCU\Software\Microsoft\Windows\CurrentVersion\IrisService\Cache\'+this.title, 'RequestUri')')
		// https://www.elevenforum.com/t/reset-and-re-register-windows-spotlight-in-windows-11.5248/
		item(title='Windows Spotlight on Eleven Forum' cmd='https://www.elevenforum.com/tags/spotlight/') }
}
