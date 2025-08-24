// Author: Rubic / RubicBG
// Еnhancer: Speedauge (GitHub)
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

// https://www.voidtools.com/support/everything/command_line_options/
$path_Everything = '@sys.prog\Everything\Everything.exe'
menu(title='Search Everything ...' where=path.exists(path_Everything) image=[\uE187, image.color2] image-sel=path_Everything
	tip=if(!path.exists(path_Everything), 'Requires Everything to be installed') vis=if(!path.exists(path_Everything), 'disable')) {
	item(title='Search in parent folder' type='file' 
		tip='Search within the folder containing this file'
		image cmd=path_Everything arg='-p @sel.parent(true)')
	item(title='Search in selected folder' type='~file' 
		tip='Search recursively within the selected folder and all subfolders'
		image cmd=path_Everything arg='-p @sel.path(true)')
	item(title='Search entire drive'
		tip='Search the entire drive where this item is located'
		image cmd=path_Everything arg='-p @quote(sel.root)' where=sel.path!=sel.root)
	item(title='Search folder contents only' type='~file' keys='flat'
		tip='Search only direct contents of folder, not subfolders'
		image cmd=path_Everything arg='-parent @sel.path(true)' where=len(path.files(sel, '*', 2))>0)
	item(title='Find files with same extension' type='file'
		tip='Find all files in parent folder with the same file extension'
		image cmd=path_Everything arg='-p @sel.parent(true) -search ext:@str.trim(sel.file.ext, '.')')
	separator()
	item(image=[\uE187, image.color2] title='Search file(s) contents...' keys='querying' type='~file'
		tip='Search inside files for specific text content'
		cmd=path_Everything arg='-p @sel.path(true) -search content:')
	item(image=[\uE187, image.color2] title='Recently accessed files' keys='querying' type='~file' 
		tip='Find files accessed within the last 24 hours'
		cmd=path_Everything arg='-p @sel.path(true) -search da:today')
	menu(image=[\uE187, image.color2] title='Filter by attributes' type='dir|back.dir|drive|back.drive|desktop') {
		item(title='Find read-only files' keys='querying'
			tip='Search for files with read-only attribute set'
			image=[\uE187, image.color2] cmd=path_Everything arg='-p @sel.path(true) -search attrib:r')
		item(title='Find hidden files' keys='querying'
			tip='Search for files and folders with hidden attribute'
			image=[\uE187, image.color2] cmd=path_Everything arg='-p @sel.path(true) -search attrib:h')
		item(title='Find system files' keys='querying'
			tip='Search for files with system attribute set'
			image=[\uE187, image.color2] cmd=path_Everything arg='-p @sel.path(true) -search attrib:s') }
	menu(image=[\uE187, image.color2] title='Filter by file type' type='dir|back.dir|drive|back.drive|desktop') {
		item(title='Folders only'
			tip='Show only folders and directories'
			image=[\uE187, image.color2] cmd=path_Everything arg='-p @sel.path(true) -search folder:')
		item(title='Documents only'
			tip='Filter for document files (PDF, DOC, TXT, etc.)'
			image=[\uE187, image.color2] cmd=path_Everything arg='-p @sel.path(true) -search doc:')
		item(title='Pictures only'
			tip='Filter for image files (JPG, PNG, GIF, etc.)'
			image=[\uE187, image.color2] cmd=path_Everything arg='-p @sel.path(true) -search pic:')
		item(title='Audio files only'
			tip='Filter for audio files (MP3, WAV, FLAC, etc.)'
			image=[\uE187, image.color2] cmd=path_Everything arg='-p @sel.path(true) -search audio:')
		item(title='Videos only'
			tip='Filter for video files (MP4, AVI, MKV, etc.)'
			image=[\uE187, image.color2] cmd=path_Everything arg='-p @sel.path(true) -search video:')
		item(title='Archives only'
			tip='Filter for compressed files (ZIP, RAR, 7Z, etc.)'
			image=[\uE187, image.color2] cmd=path_Everything arg='-p @sel.path(true) -search zip:')
		item(title='Executables only'
			tip='Filter for executable files (EXE, COM, BAT, etc.)'
			image=[\uE187, image.color2] cmd=path_Everything arg='-p @sel.path(true) -search exe:') }
	separator()
	item(image=\uE186 title='Find duplicate title' 
		tip='Search for files with the same name (excluding extension)'
		cmd=path_Everything arg='-search dupe:"@sel.title"')
	item(image=\uE186 title='Find duplicate filenames' where=sel.file.ext!=''
		tip='Search for files with the same name (including extension)'
		cmd=path_Everything arg='-search dupe:"@sel.name"')
	menu(image=\uE186 title='Search by date') {
		item(title='Modified today'
			tip='Find files modified or created today'
			image=\uE186 cmd=path_Everything arg='-search dm:today')
		item(title='Modified this week'
			tip='Find files modified or created within the current week'
			image=\uE186 cmd=path_Everything arg='-search dm:thisweek')
		item(title='Modified in last 7 days'
			tip='Find files modified or created in the past week'
			image=\uE186 cmd=path_Everything arg='-search dm:last7days')
		item(title='Modified this month'
			tip='Find files modified or created within the current month'
			image=\uE186 cmd=path_Everything arg='-search dm:thismonth')
		item(title='Modified this year'
			tip='Find files modified or created within the current year'
			image=\uE186 cmd=path_Everything arg='-search dm:thisyear') }
	menu(image=\uE186 title='Advanced searches') {
		item(title='Large files (>100MB)'
			tip='Find files larger than 100 megabytes'
			image=\uE186 cmd=path_Everything arg='-search size:>100mb')
		item(title='Very large files (>1GB)'
			tip='Find files larger than 1 gigabyte'
			image=\uE186 cmd=path_Everything arg='-search size:>1gb')
		item(title='Old files (>1 year)'
			tip='Find files not modified for over a year'
			image=\uE186 cmd=path_Everything arg='-search dm:<1year')
		item(title='Temporary files'
			tip='Find temporary and backup files (TMP, BAK, etc.)'
			image=\uE186 cmd=path_Everything arg='-search ext:tmp;temp;bak;~*') }
}

/* Everything.exe [filename] [-options]

	filename	Open the specified file list.

	-?	Show this help.
	-admin	Run "Everything" as Administrator.
	-admin-server-share-links	Use \\Server\C$ links for ETP connections.
	-app-data	Store data in application data.
	-bookmark <name>	Open a bookmark.
	-case	Enable case matching.
	-choose-language	Show the language selection page.
	-choose-volumes	Do not automatically index volumes.
	-close	Close the current search window.
	-config <filename>	The filename of the ini file.
	-connect <user:pass@host:port>	Connect to an ETP server.
	-console	Show the debugging console.
	-copyto <filename1> <...>	Show the multi-file renamer with the specified filenames.
	-create-file-list <filename> <path>	Create a file list of a path.
	-create-file-list-exclude-files <list>	exclude the semicolon delimited wildcard filter for files.
	-create-file-list-exclude-folders <list>	exclude the semicolon delimited wildcard filter for folders.
	-create-file-list-include-only-files <list>	include only the semicolon delimited wildcard filter for files.
	-create-usn-journal <volume> <max-size-bytes> <allocation-delta-bytes>
	-db <filename>	The filename of the database.
	-debug	Show the debugging console.
	-debug-log	Log debugging information to disk
	-delete-usn-journal <volume>	Delete a USN Journal.
	-details	Show results in detail view.
	-diacritics	Enable diacritics matching.
	-disable-run-as-admin	Disable run as administrator.
	-disable-update-notification	Disable update notification on startup.
	-drive-links	Use C: links for ETP connections.
	-edit <filename>	Open a file list with the file list editor.
	-enable-run-as-admin	Enable run as administrator.
	-enable-update-notification	Enable update notification on startup.
	-exit	Exit "Everything".
	-first-instance	Only run if this is the first instance of "Everything".
	-filelist <filename>	Open a file list.
	-filename <filename>	Search for a file or folder by filename.
	-filter <name>	Select a search filter.
	-focus-bottom-result	Focus the bottom result.
	-focus-last-run-result	Focus the last run result.
	-focus-most-run-result	Focus the most run result.
	-focus-results	Focus the result list.
	-focus-top-result	Focus the top result.
	-ftp-links	Use ftp://host/C: links for ETP connections.
	-fullscreen	Show the search window fullscreen.
	-h	Show this help.
	-help	Show this help.
	-home	Open the home search.
	-install <location>	Install "Everything" to a new location.
	-install-client-service	Install the "Everything" client as a service.
	-install-config <filename>	Install the specified ini file.
	-install-desktop-shortcut	Install desktop shortcut.
	-install-efu-association	Install EFU file association.
	-install-folder-context-menu	Install folder context menus.
	-install-quick-launch-shortcut	Install Quick Launch shortcut.
	-install-run-on-system-startup	Install "Everything" from the system startup.
	-install-service	Install and start the "Everything" service.
	-install-service-pipe-name <name>	Use the specified name for the "Everything" service pipe name.
	-install-service-security-descriptor	Specify the pipe security descriptor.
	-install-start-menu-shortcuts	Install "Everything" shortcuts from the Start menu.
	-install-url-protocol	Install URL Protocol.
	-instance <name>	The name of the "Everything" instance.
	-l	Load the local database.
	-language <langID>	Set the language to the specified language ID.
	-load-delay <milliseconds>	The delay in milliseconds before loading the database.
	-local	Load the local database.
	-matchpath	Enable full path matching.
	-maximized	Maximize the search window.
	-minimized	Minimize the search window.
	-moveto <filename1> <...>	Show the multi-file renamer with the specified filenames.
	-name-part <filename>	Search for the name part of a filename.
	-newwindow	Create a new search window.
	-noapp-data	Store data in executable location.
	-nocase	Disable case matching.
	-nodb	Do not save to or load from the "Everything" database file.
	-nodiacritics	Disable diacritics matching.
	-nofullscreen	Show the search window in a window.
	-nomatchpath	Disable full path matching.
	-nomaximized	Unmaximize the search window.
	-nominimized	Unminimize the search window.
	-nonewwindow	Show an existing search window.
	-noontop	Disable always ontop.
	-noregex	Disable Regex.
	-noverbose	Display only basic debug messages.
	-nowholeword	Disable match whole word.
	-noww	Disable match whole word.
	-ontop	Enable always ontop.
	-p <path>	Search for a path.
	-parent <path>	Search for files and folders in the specified folder.
	-parentpath <path>	Search for the parent of a path.
	-path <path>	Search for a path.
	-quit	Exit "Everything".
	-read-only	Loads the database in read-only mode.
	-regex	Enable Regex.
	-reindex	Force database rebuild.
	-rename <filename1> <...>	Show the multi-file renamer with the specified filenames.
	-rescan-all	Rescan all folder indexes.
	-s <text>	Set the search.
	-search <text>	Set the search.
	-search-file-list <filename>	Search the specified text file for a list of file names.
	-select <filename>	Focus and select the specified result.
	-server-share-links	Use \\Server\C: links for ETP connections.
	-service-pipe-name <name>	connect to the service pipe with the specified name.
	-sort <name>	Set the sort to the specified name.
	-sort-ascending	Sort ascending.
	-sort-descending	Sort descending.
	-start-client-service	Start the "Everything" client service.
	-start-service	Start the "Everything" service.
	-startup	Run "Everything" in the background.
	-stop-client-service	Stop the "Everything" client service.
	-stop-service	Stop the "Everything" service.
	-svc	Run "Everything" as a service.
	-svc-pipe-name <name>	Host the pipe server with the specified name.
	-svc-security-descriptor <sd>	Host the pipe server with the security descriptor.
	-thumbnail-size <size>	Specify the size of thumbnails in pixels.
	-thumbnails	Show results in thumbnail view.
	-toggle-window	Hides the current foreground search window or shows the search window.
	-uninstall [path]	Uninstall "Everything" from the specified path.
	-uninstall-client-service	Uninstall the "Everything" client service.
	-uninstall-desktop-shortcut	Uninstall desktop shortcut.
	-uninstall-efu-association	Uninstall EFU file association.
	-uninstall-folder-context-menu	Uninstall folder context menus.
	-uninstall-quick-launch-shortcut	Uninstall Quick Launch shortcut.
	-uninstall-run-on-system-startup	Remove "Everything" from the system startup.
	-uninstall-service	Uninstall the "Everything" service.
	-uninstall-start-menu-shortcuts	Uninstall "Everything" shortcuts from the Start menu.
	-uninstall-url-protocol	Uninstall URL Protocol.
	-uninstall-user	Uninstall user files.
	-update	Save the database to disk.
	-url <[es:]search>	Set the search from an ES: URL.
	-verbose	Display all debug messages.
	-wholeword	Enable match whole word.
	-ww	Enable match whole word.
*/