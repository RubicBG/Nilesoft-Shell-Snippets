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