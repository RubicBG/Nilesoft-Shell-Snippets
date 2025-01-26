// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

menu(title='Create NTFS link' where=!sel.namespaces mode='single' image=\uE17F expanded=0) {
	// Symbolic links can technically exist on other filesystems (not just NTFS), but Windows native support is NTFS-specific
	$path_clip =str.trim(str.trim(clipboard.get, '"'), '\')
	
	separator()
	//> https://ss64.com/nt/mklink.html
	//+ https://www.2brightsparks.com/resources/articles/ntfs-hard-links-junctions-and-symbolic-links.html
	/* Restrictions:
		Administrator Permissions: Creating symbolic links typically requires elevated privileges (administrator rights) unless the SeCreateSymbolicLinkPrivilege is enabled for non-admin users.
		Cross-Volume Support: Supported; symbolic links can point to targets on different volumes.
		Network Support: Supported; can link to targets on network shares (e.g., \\server\share), but performance may be slower.
		Broken Links: Symbolic links can exist without the target being present. Accessing a broken link will result in an error.
		Relative vs. Absolute: Symlinks can use either relative or absolute paths. */
	$img_sym_link = [[\uE055],[\uE056]]
	$tip_sym_link = 'A symbolic link is a file system object that acts as a shortcut, pointing to a file or directory elsewhere. It can span different volumes or drives and is essentially a pointer to the target path. If the target is moved or deleted, the symlink becomes broken because it doesn@"'"t contain the file@"'"s actual data.'
	item(image=img_sym_link title='Create symbolic link' type='dir|file' tip=tip_sym_link
		admin cmd-line='/k MKLINK @if(path.isdir(@sel), '/D "@(sel) - Symbolic Link"', '"@sel.directory\@sel.title - Symbolic Link@(sel.file.ext)"') @sel(true) & pause & exit')
	item(image=img_sym_link title='Create symbolic link to ...' type='dir|file|drive' tip=tip_sym_link
		admin cmd-line='/k MKLINK @if(path.isdir(@sel), '/D "@path.dir.box()\@sel.title - Symbolic Link"', '"@path.dir.box()\@sel.title - Symbolic Link@(sel.file.ext)"') @sel(true) & pause & exit')
	item(image=img_sym_link title='Create symbolic link from file ...' type='back.dir|back.drive|desktop' tip=tip_sym_link
		vis=0)
	item(image=img_sym_link title='Create symbolic link from folder ...' type='back.dir|back.drive|desktop' tip=tip_sym_link
		admin cmd-line='/k (set "pth=@path.dir.box()" & if defined pth (call MKLINK /D "@str.trim(sel, '\')\Folder - Symbolic Link" "%pth%") else (echo Path is empty)) & pause & exit')
	item(image=img_sym_link title='Create symbolic link from path in clipboard' where=path.exists(path_clip) type='back.dir|back.drive|desktop' tip=path_clip + "\n\n" + tip_sym_link
		admin cmd-line='/k MKLINK @if(path.isdir(@path_clip), '/D "@(path_clip) - Symbolic Link"', '"@path.location(path_clip)\@path.file.title(path_clip) - Symbolic Link@path.file.ext(path_clip)"') "@path_clip" & pause & exit')
	
	separator()
	//> https://learn.microsoft.com/en-us/windows/win32/fileio/hard-links-and-junctions#hard-links
	/* Restrictions:
		File-Only: Only files (not directories) can have hard links.
		Same Volume: Hard links must reside on the same volume as the target file because they point to the same physical file record in the Master File Table (MFT).
		No Network Support: Cannot point to files on network shares or other remote locations.
		Max Links: A file can have a maximum of 1024 hard links. */
	$img_hard_link = [[\uE1BE],[\uE052]]
	$tip_hard_link = 'A hard link allows multiple paths to reference the same physical file on disk. This means that different file names point to the same data, but it only works within the same volume because hard links rely on the file system@"'"s internal structure. Changes made to the file through any of these paths will affect the same underlying data, and the file is only deleted when all hard links to it are removed.'
	item(image=img_hard_link title='Create hard link' type='file' tip=tip_hard_link
		admin cmd-line='/k MKLINK /H "@sel.directory\@sel.title - Hard Link@(sel.file.ext)" @sel(true) & pause & exit')
	item(image=img_hard_link title='Create hard link to ...' type='file' tip=tip_hard_link
		admin cmd-line='/k MKLINK /H "@path.dir.box()\@sel.title - Hard Link@(sel.file.ext)" @sel(true) & pause & exit') 
	item(image=img_hard_link  title='Create hard link from file ...' type='back.dir|back.drive|desktop' tip=tip_hard_link
		vis=0) // admin cmd-line='/k (set "pth=@path.file.box()" & if defined pth (call MKLINK /H "@str.trim(sel, '\')\File - Hard Link" "%pth%") else (echo Path is empty)) & pause & exit')
	item(image=img_hard_link title='Create hard link from file path in clipboard' where=(path.exists(path_clip) and !path.isdir(path_clip)) type='back.dir|back.drive|desktop' tip=path_clip + "\n\n" + tip_hard_link
		admin cmd-line='/k MKLINK /H "@path.location(path_clip)\@path.file.title(path_clip) - Hard Link@path.file.ext(path_clip)" "@path_clip" & pause & exit')

	separator()
	//> https://learn.microsoft.com/en-us/windows/win32/fileio/hard-links-and-junctions#junctions
	/* Restrictions:
		Directory-Only: Junctions can only link to directories, not files.
		Same Volume: Junction targets must be on the same volume as the link because they rely on volume-relative paths.
		No Network Support: Junctions cannot target network shares directly. However, this can be bypassed using symbolic links or mounting network shares as local drives.
		Broken Links: If the target is missing, the junction will be broken, and accessing it will result in an error. */
	$img_soft_link = [[\uE08B],[\uE052]]
	$tip_soft_link = 'A soft link (junction) is a type of directory symbolic link that points to another directory, either on the same drive or a different drive. Junctions are specific to directories and are commonly used for organizing file systems. If the target directory is moved, the junction becomes broken.'
	item(image=img_soft_link title='Create soft link (junction)' type='dir' tip=tip_soft_link
		admin cmd-line='/k MKLINK /J "@(sel) - Soft Link" @sel(true) & pause & exit')
	item(image=img_soft_link title='Create soft link (junction) to ...' type='dir|drive' tip=tip_soft_link
		admin cmd-line='/k MKLINK /J "@path.dir.box()\@sel.title - Soft Link" @sel(true) & pause & exit')
	item(image=img_soft_link title='Create soft link from folder ...' type='back.dir|back.drive|desktop' tip=tip_soft_link
		admin cmd-line='/k (set "pth=@path.dir.box()" & if defined pth (call MKLINK /J "@str.trim(sel, '\')\Folder - Soft Link" "%pth%") else (echo Path is empty)) & pause & exit')
	item(image=img_soft_link title='Create soft link from folder path in clipboard' where=(path.exists(path_clip) and path.isdir(path_clip)) type='back.dir|back.drive|desktop' tip=path_clip + "\n\n" + tip_soft_link
		admin cmd-line='/k MKLINK /J "@path.location(path_clip)\@path.file.title(path_clip) - Symbolic Link@path.file.ext(path_clip)" "@path_clip" & pause & exit') }