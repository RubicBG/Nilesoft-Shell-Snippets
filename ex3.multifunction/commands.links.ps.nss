// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

menu(title='Create NTFS link' where=!sel.namespaces mode='single' image=\uE17F expanded=0) {
	// Symbolic links can technically exist on other filesystems (not just NTFS), but Windows native support is NTFS-specific
	//> https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item?view=powershell-7.4#example-7-create-a-symbolic-link-to-a-file-or-folder
	$path_clb = str.trim(clipboard.get, '"')
	$path_dir = path.dir.box()
	$path_fle = path.file.box()
	$path_sel = sel

	separator()
	/* Restrictions:
		Administrator Permissions: Creating symbolic links typically requires elevated privileges (administrator rights) unless the SeCreateSymbolicLinkPrivilege is enabled for non-admin users.
		Cross-Volume Support: Supported; symbolic links can point to targets on different volumes.
		Network Support: Supported; can link to targets on network shares (e.g., \\server\share), but performance may be slower.
		Broken Links: Symbolic links can exist without the target being present. Accessing a broken link will result in an error.
		Relative vs. Absolute: Symlinks can use either relative or absolute paths. */
	$img_sym_link = [[\uE055],[\uE056]]
	$tip_sym_link = 'A symbolic link is a file system object that acts as a shortcut, pointing to a file or directory elsewhere. It can span different volumes or drives and is essentially a pointer to the target path. If the target is moved or deleted, the symlink becomes broken because it doesn@"'"t contain the file@"'"s actual data.'
	item(image=img_sym_link title='Create symbolic link' type='dir|file' tip=tip_sym_link
		admin cmd-ps=`$src = Get-Item -LiteralPath '@path_sel'; $lnk = if ($src.PSIsContainer) { \"$($src.FullName) - Symbolic Link\" } else { Join-Path -Path $src.DirectoryName -ChildPath \"$($src.BaseName) - Symbolic Link$($src.Extension)\" }; New-Item -ItemType SymbolicLink -Path $lnk -Target $src.FullName; Read-Host -Prompt '[Enter] to close'`)
	item(image=img_sym_link title='Create symbolic link to ...' type='dir|file|drive' tip=tip_sym_link
		admin cmd-ps=`$src = Get-Item -LiteralPath '@path_sel'; $in = Get-Item -LiteralPath '@path_dir'; $lnk = if ($src.PSIsContainer) { if (($src.PSDrive.Name + ':\') -eq $src.FullName) { Join-Path -Path $in -ChildPath \"Drive $($src.PSDrive.Name) - Symbolic Link\" } else { Join-Path -Path $in -ChildPath \"$($src.Name) - Symbolic Link\" } } else { Join-Path -Path $in -ChildPath \"$($src.BaseName) - Symbolic Link$($src.Extension)\" }; New-Item -ItemType SymbolicLink -Path $lnk -Target $src.FullName; Read-Host -Prompt '[Enter] to close'`)
	item(image=img_sym_link title='Create symbolic link from file ...' type='back.dir|back.drive|desktop' tip=tip_sym_link
		admin cmd-ps=`$in = Get-Item -LiteralPath '@path_sel'; $src = Get-Item -LiteralPath '@path_fle'; $lnk = if ($src.PSIsContainer) { if (($src.PSDrive.Name + ':\') -eq $src.FullName) { Join-Path -Path $in -ChildPath \"Drive $($src.PSDrive.Name) - Symbolic Link\" } else { Join-Path -Path $in -ChildPath \"$($src.Name) - Symbolic Link\" } } else { Join-Path -Path $in -ChildPath \"$($src.BaseName) - Symbolic Link$($src.Extension)\" }; New-Item -ItemType SymbolicLink -Path $lnk -Target $src.FullName; Read-Host -Prompt '[Enter] to close'`)
	item(image=img_sym_link title='Create symbolic link from folder ...' type='back.dir|back.drive|desktop' tip=tip_sym_link
		admin cmd-ps=`$in = Get-Item -LiteralPath '@path_sel'; $src = Get-Item -LiteralPath '@path_dir'; $lnk = if ($src.PSIsContainer) { if (($src.PSDrive.Name + ':\') -eq $src.FullName) { Join-Path -Path $in -ChildPath \"Drive $($src.PSDrive.Name) - Symbolic Link\" } else { Join-Path -Path $in -ChildPath \"$($src.Name) - Symbolic Link\" } } else { Join-Path -Path $in -ChildPath \"$($src.BaseName) - Symbolic Link$($src.Extension)\" }; New-Item -ItemType SymbolicLink -Path $lnk -Target $src.FullName; Read-Host -Prompt '[Enter] to close'`)
	item(image=img_sym_link title='Create symbolic link from path in clipboard' where=path.exists(path_clb) type='back.dir|back.drive|desktop' tip=path_clb + "\n\n" + tip_sym_link
		admin cmd-ps=`$in = Get-Item -LiteralPath '@path_sel'; $src = Get-Item -LiteralPath '@path_clb'; $lnk = if ($src.PSIsContainer) { if (($src.PSDrive.Name + ':\') -eq $src.FullName) { Join-Path -Path $in -ChildPath \"Drive $($src.PSDrive.Name) - Symbolic Link\" } else { Join-Path -Path $in -ChildPath \"$($src.Name) - Symbolic Link\" } } else { Join-Path -Path $in -ChildPath \"$($src.BaseName) - Symbolic Link$($src.Extension)\" }; New-Item -ItemType SymbolicLink -Path $lnk -Target $src.FullName; Read-Host -Prompt '[Enter] to close'`)

	separator()
	/* Restrictions:
		File-Only: Only files (not directories) can have hard links.
		Same Volume: Hard links must reside on the same volume as the target file because they point to the same physical file record in the Master File Table (MFT).
		No Network Support: Cannot point to files on network shares or other remote locations.
		Max Links: A file can have a maximum of 1024 hard links. */
	$img_hard_link = [[\uE1BE],[\uE052]]
	$tip_hard_link = 'A hard link allows multiple paths to reference the same physical file on disk. This means that different file names point to the same data, but it only works within the same volume because hard links rely on the file system@"'"s internal structure. Changes made to the file through any of these paths will affect the same underlying data, and the file is only deleted when all hard links to it are removed.'
	item(image=img_hard_link title='Create hard link' type='file' tip=tip_hard_link
		admin cmd-ps=`$src = Get-Item -LiteralPath '@path_sel'; $lnk = Join-Path -Path $src.DirectoryName -ChildPath \"$($src.BaseName) - Hard Link$($src.Extension)\"; New-Item -ItemType HardLink -Path $lnk -Target $src.FullName; Read-Host -Prompt '[Enter] to close'`)
	item(image=img_hard_link title='Create hard link to ...' type='file' tip=tip_hard_link
		admin cmd-ps=`$src = Get-Item -LiteralPath '@path_sel'; $in = Get-Item -LiteralPath '@path_dir'; $lnk = Join-Path -Path $in -ChildPath \"$($src.BaseName) - Hard Link$($src.Extension)\"; New-Item -ItemType HardLink -Path $lnk -Target $src.FullName; Read-Host -Prompt '[Enter] to close'`)
	item(image=img_hard_link title='Create hard link from file ...' type='back.dir|back.drive|desktop' tip=tip_hard_link
		admin cmd-ps=`$in = Get-Item -LiteralPath '@path_sel'; $src = Get-Item -LiteralPath '@path_fle'; $lnk = Join-Path -Path $in -ChildPath \"$($src.BaseName) - Hard Link$($src.Extension)\"; New-Item -ItemType HardLink -Path $lnk -Target $src.FullName; Read-Host -Prompt '[Enter] to close'`)
	item(image=img_hard_link title='Create hard link from file path in clipboard' where=(path.exists(path_clb) and !path.isdir(path_clb)) type='back.dir|back.drive|desktop' tip=path_clb + "\n\n" + tip_hard_link
		admin cmd-ps=`$in = Get-Item -LiteralPath '@path_sel'; $src = Get-Item -LiteralPath '@path_clb'; $lnk = Join-Path -Path $in -ChildPath \"$($src.BaseName) - Hard Link$($src.Extension)\"; New-Item -ItemType HardLink -Path $lnk -Target $src.FullName; Read-Host -Prompt '[Enter] to close'`)

	separator()
	/* Restrictions:
		Directory-Only: Junctions can only link to directories, not files.
		Same Volume: Junction targets must be on the same volume as the link because they rely on volume-relative paths.
		No Network Support: Junctions cannot target network shares directly. However, this can be bypassed using symbolic links or mounting network shares as local drives.
		Broken Links: If the target is missing, the junction will be broken, and accessing it will result in an error. */
	$img_soft_link = [[\uE08B],[\uE052]]
	$tip_soft_link = 'A soft link (junction) is a type of directory symbolic link that points to another directory, either on the same drive or a different drive. Junctions are specific to directories and are commonly used for organizing file systems. If the target directory is moved, the junction becomes broken.'
	item(image=img_soft_link title='Create soft link (junction)' type='dir' tip=tip_soft_link
		admin cmd-ps=`$src = Get-Item -LiteralPath '@path_sel'; $lnk = \"$($src.FullName) - Soft Link\"; New-Item -ItemType Junction -Path $lnk -Target $src.FullName; Read-Host -Prompt '[Enter] to close'`)
	item(image=img_soft_link title='Create soft link (junction) to ...' type='dir|drive' tip=tip_soft_link
		admin cmd-ps=`$src = Get-Item -LiteralPath '@path_sel'; $in = Get-Item -LiteralPath '@path_dir'; $lnk = if (($src.PSDrive.Name + ':\') -eq $src.FullName) { Join-Path -Path $in -ChildPath \"Drive $($src.PSDrive.Name) - Soft Link\" } else { Join-Path -Path $in -ChildPath \"$($src.Name) - Soft Link\" }; New-Item -ItemType Junction -Path $lnk -Target $src.FullName; Read-Host -Prompt '[Enter] to close'`)	
	item(image=img_soft_link title='Create soft link from folder ...' type='back.dir|back.drive|desktop' tip=tip_soft_link
		admin cmd-ps=`$in = Get-Item -LiteralPath '@path_sel'; $src = Get-Item -LiteralPath '@path_dir'; $lnk = if (($src.PSDrive.Name + ':\') -eq $src.FullName) { Join-Path -Path $in -ChildPath \"Drive $($src.PSDrive.Name) - Soft Link\" } else { Join-Path -Path $in -ChildPath \"$($src.Name) - Soft Link\" }; New-Item -ItemType Junction -Path $lnk -Target $src.FullName; Read-Host -Prompt '[Enter] to close'`)
	item(image=img_soft_link title='Create soft link from folder path in clipboard' where=(path.exists(path_clb) and path.isdir(path_clb)) type='back.dir|back.drive|desktop' tip=path_clb + "\n\n" + tip_soft_link
		admin cmd-ps=`$in = Get-Item -LiteralPath '@path_sel'; $src = Get-Item -LiteralPath '@path_clb'; $lnk = if (($src.PSDrive.Name + ':\') -eq $src.FullName) { Join-Path -Path $in -ChildPath \"Drive $($src.PSDrive.Name) - Soft Link\" } else { Join-Path -Path $in -ChildPath \"$($src.Name) - Soft Link\" }; New-Item -ItemType Junction -Path $lnk -Target $src.FullName; Read-Host -Prompt '[Enter] to close'`)
	
	/* information
		+-----------------------+-----------------------------------------------------------+----------------------------------------------------------------------+
		| mklink syntax         | PowerShell equivalent                                                                                                            |
		+-----------------------+-----------------------------------------------------------+----------------------------------------------------------------------+
		| mklink Link Target    | New-Item -ItemType SymbolicLink -Path Link -Target Target | New-Item -ItemType SymbolicLink -Name Link -Path Link -Target Target |
		| mklink /D Link Target | New-Item -ItemType SymbolicLink -Path Link -Target Target | New-Item -ItemType SymbolicLink -Name Link -Path Link -Target Target |
		| mklink /H Link Target | New-Item -ItemType HardLink -Path Link -Target Target     | New-Item -ItemType HardLink -Name Link -Path Link -Target Target     |
		| mklink /J Link Target | New-Item -ItemType Junction -Path Link -Target Target     | New-Item -ItemType Junction -Name Link -Path Link -Target Target     |
		+-----------------------+-----------------------------------------------------------+----------------------------------------------------------------------+ */
}