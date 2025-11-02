// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

// Supported media file extensions for MPC-BE
$ext_match = '.3gp|.3gp2|.3gpp|.apl|.asf|.au|.avi|.bik|.cda|.divx|.dss|.f4v|.flc|.fli|.flic|.flv|.hdm|.ifo|.ivf|.m2v|.mkv|.mk3d|.mlp|.mov|.mp2v|.mp3|.mpc|.mpe|.mpeg|.mpg|.ofr|.ofs|.oga|.ogm|.ogv|.opus|.pls|.ram|.rm|.rmm|.rmvb|.roq|.rp|.rt|.sfd|.smil|.smk|.swf|.vob|.webm|.wmv|.wv'
// Retrieve MPC-BE executable path and icon from package settings
// Note: Manually edit these paths if needed for non-package installations
$exe_mpcbe = eval(path.join(appx('HaukeGtze', 'path'), appx('HaukeGtze', 'executable')))
$ico_mpcbe = eval(appx('HaukeGtze', 'logo'))

// Context menu item for individual video files
item(title='Open in MPC' keys='SHIFT add' image=ico_mpcbe tip='Play selected video@if(sel.count>1, 's') in MPC-BE@"\n"Hold SHIFT to add to playlist instead'
    mode='multiple' type='file' where=str.contains(ext_match+'|', sel.file.ext+'|')
	cmd=exe_mpcbe args=if(keys.shift(), '/add ', '/play ')+sel(true))

// Context menu for directories containing supported video files
menu(expanded=1 mode='sigle' type='dir' where=len(regex.matches(str.join(path.files(sel, '*', 3|16), '|'), '\.(?:@str.replace(ext_match, '.', null))(?:\b|$)'))>0) {
	$dir_files = null
	item(title='Open in MPC' keys='SHIFT add' image=ico_mpcbe tip='Play all supported videos from this folder in MPC-BE@"\n"Hold SHIFT to add to existing playlist'
		cmd={ fr=null
            // Scan directory for all files (flags: 3=files, 16=full path)
            fs=path.files(sel, '*', 3|16)
            // Filter for supported video formats
			for(i=0, i<len(fs)) { if(str.contains(ext_match+'|', path.file.ext(fs[i])+'|'), fr+=quote(fs[i])+' ') } 
			 // Launch MPC-BE with filtered files (/play starts playback, /add appends to playlist)
            launch(exe_mpcbe, if(keys.shift(), '/add ', '/play ')+str.trim(fr)) }) }