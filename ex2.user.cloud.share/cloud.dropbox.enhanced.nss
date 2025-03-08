// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/
// To-Do: Currently i am using "Microsoft OneDrive Free Plan", need information about "OneDrive Basic/Personal/Family"

// Change the menu name of the "Dropbox" menu if you want
$menu_db_name = 'Dropbox'
$menu_db_external_mod = false
menu(title=menu_db_name mode='multiple' where=!menu_db_external_mod image=\uE09C) { }

$path_db_dll = reg.get('HKCR\CLSID\{ECD97DE5-3C8F-4ACB-AEEE-CCAB78F7711C}\InprocServer32')
$path_db_exe = path.combine(path.parent(path_db_dll), 'dropbox.exe')
$path_db_dir = reg.get('HKCR\CLSID\{E31EA727-12ED-4702-820C-4B6445F28E1A}\Instance\InitPropertyBag','TargetFolderPath')
$is_db_path	 = str.contains(sel, path_db_dir)

$svg_db_win = '<svg width="100" height="100" viewBox="0 -19 256 256" fill="#200200">
  <g fill="#0061FF">
    <polygon points="63.9945638 0 0 40.7712563 63.9945638 81.5425125 128 40.7712563"/>
    <polygon points="192.200442 0 128 40.7750015 192.200442 81.5520031 256.200885 40.7750015"/>
    <polygon points="0 122.321259 63.9945638 163.092516 128 122.321259 63.9945638 81.5520031"/>
    <polygon points="192 81.5520031 128 122.324723 192 163.099442 256 122.324723"/>
    <polygon points="64 176.771256 128.005436 217.542513 192 176.771256 128.005436 136"/>
  </g></svg>'
$svg_db_web = str.replace(svg_db_win, "#0061FF", "#00FFFF")
$svg_db_tag = str.replace(svg_db_win, "#0061FF", "#ff6600")

modify(menu=menu_db_name image=svg_db_win where=this.title==eval(str.res(path_db_dll, -224))
	tip='Move this file/folder to Dropbox') // "Move to Dropbox"
modify(menu=menu_db_name image=svg_db_win where=this.title==eval(str.res(path_db_dll, -225))
	tip='Move this file/folder to Dropbox') // "Move to Dropbox (Business)"
modify(menu=menu_db_name image=svg_db_win where=this.title==eval(str.res(path_db_dll, -232))
	tip='Back up this file/folder to Dropbox') // "Back up to Dropbox..."
modify(menu=menu_db_name image=svg_db_win where=this.title==eval(str.res(path_db_dll, -214)) && is_db_path
	tip='Copy a Dropbox link to this file/folder to your clipboard.') // "Copy Dropbox &link"
// remove(where=this.title==eval(str.res(path_db_dll, -226)) && sel.back)
modify(menu=menu_db_name image=svg_db_win where=this.title==eval(str.res(path_db_dll, -226))
	tip='securely deliver a copy of your files, and track downloads with Dropbox Transfer') // "Transfer a copy..." "Send with Dropbox Transfer"
// remove(where=this.title==eval(str.res(path_db_dll, -227)) && sel.back)
modify(menu=menu_db_name image=svg_db_win where=this.title==eval(str.res(path_db_dll, -227))
	tip='securely deliver a copy of your files, and track downloads with Dropbox Transfer') // "Transfer a copy (Business)" "Send with Dropbox Transfer (Business)"
modify(menu=menu_db_name image=svg_db_win where=this.title==eval(str.res(path_db_dll, -210)) && is_db_path
	tip='create a shared link to share with others') // "&Share..."
modify(menu=menu_db_name image=svg_db_win where=this.title==eval(str.res(path_db_dll, -249)) && is_db_path
	tip='manage who has access to this folder') // "Manage folder access"
modify(menu=menu_db_name image=svg_db_win where=this.title==eval(str.res(path_db_dll, -248)) && is_db_path
	tip='manage who has access to this file') // "Manage file access"
modify(menu=menu_db_name image=svg_db_win where=this.title==eval(str.res(path_db_dll, -239)) && is_db_path
	tip='manage your hard drive space') // "Manage hard drive space"
modify(menu=menu_db_name image=svg_db_web where=this.title==eval(str.res(path_db_dll, -212)) && is_db_path
	tip='View in Browser') // "View on &Dropbox.com" "View in &Dropbox"
modify(menu=menu_db_name image=svg_db_web where=this.title==eval(str.res(path_db_dll, -231)) && is_db_path
	tip='three free signature requests per month') // "Send for signature"
modify(menu=menu_db_name image=svg_db_web where=this.title==eval(str.res(path_db_dll, -233)) && is_db_path
	tip='Request files from anyone, whether they have a Dropbox account or not') // "Request files..."
// modify(menu=menu_db_name image=svg_db_web find='Rewind' where=is_db_path
	// tip='Rewind to a previous time (with Dropbox Plans)') // (https://help.dropbox.com/delete-restore/rewind)
modify(menu=menu_db_name image=svg_db_web where=this.title==eval(str.res(path_db_dll, -218)) && is_db_path
	tip='View and restore past versions (with Dropbox Plans)') // "Version history"
// modify(menu=menu_db_name image=svg_db_web find='View Comments' where=is_db_path
	// tip='Leave a comment and view other comments')
// modify(menu=menu_db_name image=svg_db_web find='Organize' where=is_db_path and this.type==2
	// tip='Move, rename, or delete files and folders (with Dropbox Plans)')
modify(menu=menu_db_name image=svg_db_tag where=this.title==eval(str.res(path_db_dll, -216)) && is_db_path
	tip='Make this file available offline') // "Make available offline"
modify(menu=menu_db_name image=svg_db_tag where=this.title==eval(str.res(path_db_dll, -217)) && is_db_path
	tip='Make this file only available online') // "Make online-only" 
modify(menu=menu_db_name image=svg_db_tag where=this.title==eval(str.res(path_db_dll, -240)) && is_db_path
	tip='Do not sync this file to Dropbox.com') // "Don't sync to Dropbox.com" (https://help.dropbox.com/sync/ignored-files)
modify(menu=menu_db_name image=svg_db_tag where=this.title==eval(str.res(path_db_dll, -241)) && is_db_path
	tip='Sync this file to Dropbox.com') // "Sync to Dropbox.com"

//> https://github.com/KWottrich/context-menu-dropbox-ignore
//> https://github.com/KWottrich/context-menu-dropbox-ignore/blob/main/Regedit/InstallContextMenuEntries.reg
item(menu=menu_db_name image=svg_db_tag where=is_db_path and sel!=path_db_dir title='Ignore from Dropbox' pos='bottom'
	tip='Do not sync this file to Dropbox.com'
	cmd-line='/k echo 1 > "@sel(false):com.dropbox.ignored"' window='hidden')
item(menu=menu_db_name image=svg_db_tag where=is_db_path and sel!=path_db_dir title='Un-Ignore from Dropbox' pos='bottom'
	tip='Sync this file to Dropbox.com'
	cmd-line='/k echo. > "@sel(false):com.dropbox.ignored"' window='hidden')