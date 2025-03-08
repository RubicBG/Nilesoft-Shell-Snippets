// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

$menu_cloud = eval('Cloud and Share')
menu(title=menu_cloud mode='multiple' where=sel.namespaces.count==0 image=\uE09C) { }

// reverse order of appearance 
import 'cloud.odrive.nss'
$menu_od_name = menu_cloud
$menu_od_external_mod = true

//import 'cloud.dropbox.basic.ml.nss'
import 'cloud.dropbox.enhanced.nss'
$menu_db_name = menu_cloud
$menu_db_external_mod = true

import 'cloud.google.nss'
$menu_gd_name = menu_cloud
$menu_gd_external_mod = true

import 'cloud.onedrive.nss'
$menu_od_name = menu_cloud
$menu_od_external_mod = true