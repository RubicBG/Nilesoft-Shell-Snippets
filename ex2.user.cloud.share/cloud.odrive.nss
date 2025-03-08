// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

// Change the menu name of the "OneDrive" menu if you want
$menu_odrive_name='ODrive'
$menu_odrive_external_mod = false
menu(title=menu_odrive_name mode='multiple' where=!menu_odrive_external_mod image='@sys.prog\odrive\odrive.exe') { }

$is_odrive_path = str.contains(sel, '@user.home\odrive')

modify(menu=menu_odrive_name image=inherit find='"Sync"|"Unsync"' where=is_odrive_path)
modify(menu=menu_odrive_name image=inherit where=str.equals(this.title, 'refresh') and is_odrive_path)
modify(menu=menu_odrive_name image=inherit find='Share Link|Share Storage|Open Web Preview' where=is_odrive_path)