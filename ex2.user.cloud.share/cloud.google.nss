// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

// Change the menu name of the "Google Drive" menu if you want
$menu_gd_name = 'Google Drive'
$menu_gd_external_mod = false
menu(title=menu_gd_name mode='multiple' where=!menu_gd_external_mod image=\uE09C) { }

$ext_ge = '.gcsesheet|.gcseslides|.gdoc|.gdraw|.gdrive|.gform|.gjam|.glink|.gmaillayout|.gmap|.gnote|.gscript|.gsheet|.gsite|.gslides|.gtable|'
$ext_ge_web = '.gdocx|'

modify(menu=menu_cloud find='Sync or Backup this Folder'	    type='dir|desktop')
modify(menu=menu_cloud find='Copy Link to clipboard'	    	type='dir|file')
modify(menu=menu_cloud find='Open with Google Drive'    		type='dir')
modify(menu=menu_cloud find='Open with Google Drive'	    	type='file' where=!str.contains(ext_ge+ext_ge_web, sel.file.ext+'|'))
modify(menu=menu_cloud find='Share with Google Drive')
modify(menu=menu_cloud find='Copy diagnostic info to clipboard' title='Copy Diagnostic Info')
modify(menu=menu_cloud find='Add shortcut to Drive|Add shortcut to Google Drive')
modify(menu=menu_cloud find='Manage Version'			        type='file')
modify(menu=menu_cloud find='Refresh Folder|OFfline access')

/* information for further use
    Open with Google Docs
    Open with Google Sheets
    Open with Google Slides
*/