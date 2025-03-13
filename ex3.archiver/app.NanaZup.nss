// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

// Hide default menu: NS can not recognize drag&drop paths, so use:
remove(find='NanaZip')
// remove(clsid='{CAE3F1D4-7765-4D98-A060-52CD14D56EAB}' where=this.isuwp)

// ? HKEY_CLASSES_ROOT\PackagedCom\ClassIndex\{CAE3F1D4-7765-4D98-A060-52CD14D56EAB}
// ? HKEY_LOCAL_MACHINE\SOFTWARE\Classes\PackagedCom\ClassIndex\{CAE3F1D4-7765-4D98-A060-52CD14D56EAB}
// ? HKEY_CLASSES_ROOT\PackagedCom\Package\40174MouriNaruto.NanaZip_3.1.1080.0_x64__gnj4mf6z9tkrc
// ? HKEY_LOCAL_MACHINE\SOFTWARE\Classes\PackagedCom\Package\40174MouriNaruto.NanaZip_3.1.1080.0_x64__gnj4mf6z9tkrc
// ? HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages\40174MouriNaruto.NanaZip_3.1.1080.0_x64__gnj4mf6z9tkrc\NanaZip.Modern\Capabilities\FileAssociations

// supported formats by 7-zip
$se7zP = '7z|xz|bz2|gz|tar|zip|wim'
$se7zU = 'apfs|ar|arj|cab|chm|cpio|cramfs|dmg|ext|fat|gpt|hfs|ihex|iso|lzh|lzma|mbr|msi|nsis|ntfs|qcow2|rar|rpm|squashfs|udf|uefi|vdi|vhd|vhdx|vmdk|xar|z'

// path to NanaZip
$cmd_NanaM = path.combine(package('NanaZip'),'NanaZip.Modern.exe')
$cmd_NanaW = path.combine(package('NanaZip'),'NanaZip.Windows.exe')

item(title='Browse with NanaZip...' mode='single' type='dir|drive|back'
	image cmd=cmd_NanaM args=sel(true))
item(title='Open with NanaZip...' mode='single' type='file' find=str.replace('."'+se7zP+'|'+se7zU+'"', '|', '"|."')
	image cmd=cmd_NanaM args=sel(true))
item(title='Extract files...' keys='single' mode='single'  type='file' find=str.replace('."'+se7zP+'|'+se7zU+'"', '|', '"|."')
	image cmd=cmd_NanaW args='x @sel(true) -o@sel.path.title\ -ad')
// or
item(title=title.extract_to keys='single' mode='single'  type='file' find=str.replace('."'+se7zP+'|'+se7zU+'"', '|', '"|."')
    image=icon.extract_to cmd=cmd_NanaW args='x @sel(true) -o@sel.path.title\ -ad')



// Extra
item(title='NanaZip in Microsoft Store Mini' cmd='ms-windows-store://pdp/?mode=mini&ProductId=9N8G7TSCL18R')
item(title='NanaZip in Microsoft Store' cmd='ms-windows-store://pdp/?ProductId=9N8G7TSCL18R')