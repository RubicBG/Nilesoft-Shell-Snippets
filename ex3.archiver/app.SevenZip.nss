// Hide default menu
//remove(find='7-Zip')
// remove(clsid='{23170F69-40C1-278A-1000-000100020000}' where=!this.isuwp)

// Executable Paths
$cmd_7zipC = path.combine(sys.prog,'7-Zip','7z.exe')
$cmd_7zipG = path.combine(sys.prog,'7-Zip','7zG.exe')
$cmd_7zipA = path.combine(sys.prog,'7-Zip','7zFM.exe')
// Supported formats:: Packing / unpacking: 7z, XZ, BZIP2, GZIP, TAR, ZIP and WIM
$se7zP = '7z|xz|bz2|gz|tar|zip|wim'
// Supported formats: Unpacking only: APFS, AR, ARJ, CAB, CHM, CPIO, CramFS, DMG, EXT, FAT, GPT, HFS, IHEX, ISO, LZH, LZMA, MBR, MSI, NSIS, NTFS, QCOW2, RAR, RPM, SquashFS, UDF, UEFI, VDI, VHD, VHDX, VMDK, XAR and Z.
$se7zU = 'apfs|ar|arj|cab|chm|cpio|cramfs|dmg|ext|fat|gpt|hfs|ihex|iso|lzh|lzma|mbr|msi|nsis|ntfs|qcow2|rar|rpm|squashfs|udf|uefi|vdi|vhd|vhdx|vmdk|xar|z'
// Supported extension: checksum:
$se7zC = 'sha256|sha512|sha224|sha384|sha1|sha|md5|crc32|crc64|asc|cksum'
// Supported extension: ppmd:
$se7zM = 'txt|log|cfg|c|cpp|java|py|html|xml|ini|conf|yaml|json|bat|sh|ps1|csv|doc'

// SVG
$svg_7z_archive = image.svg('<svg height="100" width="100" viewBox="0 0 512 512">
	<path style="fill:@image.color2" d="M501.801 213.023H298.977V10.199h-85.954v202.824H10.199v85.954h202.824v202.824h85.954V298.977h202.824z"/>
	<path style="fill:#000000" d="M298.978 512h-85.956c-5.632 0-10.199-4.566-10.199-10.199V309.177H10.199C4.567 309.177 0 304.61 0 298.977v-85.956c0-5.633 4.567-10.199 10.199-10.199h192.623V10.199c0-5.633 4.568-10.199 10.2-10.199h85.956c5.632 0 10.199 4.566 10.199 10.199v192.623h192.624c5.632 0 10.199 4.566 10.199 10.199v85.956c0 5.633-4.567 10.199-10.199 10.199H309.178V501.8c0 5.634-4.568 10.2-10.2 10.2zm-75.757-20.398h65.557V298.977c0-5.633 4.567-10.199 10.199-10.199h192.624v-65.557H298.978c-5.632 0-10.199-4.566-10.199-10.199V20.398h-65.557v192.623c0 5.633-4.567 10.199-10.199 10.199H20.398v65.557h192.623c5.632 0 10.199 4.566 10.199 10.199v192.626z"/></svg>')
$svg_7z_extract = image.svg('<svg height="100" width="100" viewBox="0 0 512 512">
	<path style="fill:@image.color2" d="M10.199 213.021h491.602v85.959H10.199z"/>
	<path style="fill:#000000" d="M501.801 309.177H10.199C4.566 309.177 0 304.61 0 298.977v-85.955c0-5.633 4.566-10.199 10.199-10.199h491.602c5.632 0 10.199 4.566 10.199 10.199v85.955c0 5.633-4.567 10.2-10.199 10.2zM20.398 288.778h471.203v-65.556H20.398v65.556z"/></svg>')
$svg_7z_test	= image.svg('<svg height="100" width="100" viewBox="0 0 512 512">
	<path style="fill:@image.color2" d="m501.801 120.455-60.754-60.754-271.09 271.089-99.003-99.003-60.755 60.754 159.758 159.758z"/>
	<path style="fill:#000000" d="M169.957 462.498c-2.61 0-5.22-.995-7.212-2.987L2.987 299.753c-3.983-3.983-3.983-10.441 0-14.425l60.754-60.754a10.2 10.2 0 0 1 14.424 0l91.793 91.793L433.835 52.489c3.982-3.983 10.441-3.983 14.424 0l60.754 60.755c3.983 3.983 3.983 10.441 0 14.424L177.169 459.51a10.166 10.166 0 0 1-7.212 2.988zM24.623 292.541l145.335 145.334 317.42-317.42-46.33-46.33-263.879 263.878c-3.983 3.983-10.442 3.983-14.424 0L70.953 246.21l-46.33 46.331z"/></svg>')
$svg_7z_Info	= image.svg('<svg width="100" height="100" viewBox="-160 0 512 512">
	<path style="fill:@image.color2" d="M20 424.229h20V279.771H20c-11.046 0-20-8.954-20-20V212c0-11.046 8.954-20 20-20h112c11.046 0 20 8.954 20 20v212.229h20c11.046 0 20 8.954 20 20V492c0 11.046-8.954 20-20 20H20c-11.046 0-20-8.954-20-20v-47.771c0-11.046 8.954-20 20-20zM96 0C56.235 0 24 32.235 24 72s32.235 72 72 72 72-32.235 72-72S135.764 0 96 0z"/></svg>')

// Main
menu(title='7-Zip' mode='multiple' type='file|dir|drive|back' image=cmd_7zipA vis=if(!path.exists(cmd_7zipC), 'disable') tip=if(!path.exists(cmd_7zipC), 'requires 7-Zip to be installed')) {
	$is_se7z1=if(keys.shift(), '', str.replace('."'+se7zP+'|'+se7zU+'"', '|', '"|."'))
	$is_se7z2=if(keys.shift(), '', str.replace('."'+se7zC+'"', '|', '"|."'))
	$is_se7z3=str.replace('."'+se7zM+'"', '|', '"|."')
	item(title='Browse with 7-Zip...'	mode='single' type='dir|drive|back'	 image=inherit cmd=cmd_7zipA args=sel(true))
	item(title='Open with 7-Zip...'		mode='single' type='file' find=is_se7z1 image=inherit cmd=cmd_7zipA args=sel(true))
	menu(title='Open like...'			mode='single' type='file' where=keys.shift() image=inherit) {
		item(title='*'		tip='Opens only one top level archive'
			cmd=cmd_7zipA	args='@sel(true) -t*')
		item(title='#'		tip='Opens file in Parser mode, and ignores full archives.'
			cmd=cmd_7zipA	args='@sel(true) -t#')
		item(title='#:e'	tip='Opens file in Parser mode and checks all byte positions as start of archive.'
			cmd=cmd_7zipA	args='@sel(true) -t#:e')
		item(title='7z'		cmd=cmd_7zipA	args='@sel(true) -t7z')
		item(title='zip'	cmd=cmd_7zipA	args='@sel(true) -tzip')
		item(title='cab'	cmd=cmd_7zipA	args='@sel(true) -tcab')
		item(title='rar'	cmd=cmd_7zipA	args='@sel(true) -trar') }
	$sel_air = str.replace('"-air!@sel(false, '" "-air!')#', '" "-air#', '" -an')
	menu(title='Extract...' type='file' find=is_se7z1 image=svg_7z_extract expanded=1) {
		separator
		item(title='Extract...' keys='with manager' image=inherit tip=sel_air
			cmd=cmd_7zipG args='x @sel_air -ad -o*\')
		menu(title='Extract...' where=keys.shift() image=inherit) {
			item(title='Extract files...' keys='single' mode='single' image=inherit
				cmd=cmd_7zipG args='x @sel(true) -o@sel.path.title\ -ad')
			item(title='Extract to "@sel.title\", delete' mode='single' image=inherit commands {
				cmd=cmd_7zipG args='x @sel(true) -o*\' wait = 1,
				cmd=io.delete(sel) wait = 1,
				cmd=command.refresh} )
			item(title='Extract to Folders, delete' mode='multiple' where=sel.count>1 image=inherit commands {
				cmd=cmd_7zipG args='x @sel_air -o*\ -spe' wait = 1,
				cmd-line = '/c del /F /Q @sel(true)' wait = 1, // window='hidden'
				cmd=command.refresh} )
			item(title='Extract to "@sel.title\", ask to delete' mode='single' image=inherit commands {
				cmd=cmd_7zipG args='x @sel(true) -o*\' wait = 1,
				cmd=if(msg('Are you sure you want to delete the archive file?', 'NileSoft Shell', msg.warning | msg.yesno)==msg.idyes, io.delete(sel)) wait = 1,
				cmd=command.refresh} ) }
		item(title='Extract Here' image=inherit
			cmd=cmd_7zipG args='x @sel_air -spe')
		item(title='Extract'+if(sel.count==1, ' to "@sel.title\"', ' each archive to separate folder') image=inherit
			cmd=cmd_7zipG args='x @sel_air -o*\ -spe') }
	menu(title='Archive...' type='file|dir|drive|back' image=svg_7z_archive expanded=1) {
		separator
		item(title='Add to...' keys='with manager' image=inherit
			cmd=cmd_7zipG args='a "@sel.title" -ad -sae -- @sel(true)')
		// revove where=keys.shift() and the menu will be visible all the time
		menu(title='Add to...' where=keys.shift() image=inherit) {
			item(title='Add to "@(sel.title).7z" with password' keys='Shift in secret' image=inherit
				tip='in secret: Encrypts file headers, hiding file names, sizes, and metadata inside the archive. Only accessible with the correct password. Without this, file names are visible even if the contents are encrypted.'
				cmd=if(input('NileSoft Shell', 'Enter password for archive') and len(input.result)>0, cmd_7zipG)
				args='a @(sel.title).7z -t7z -p@input.result @if(keys.shift(), '-mhe') -sae -- @sel(true)')
			item(title='Add to "@(sel.title).zip" with password' image=inherit
				cmd=if(input('NileSoft Shell', 'Enter password for archive') and len(input.result)>0, cmd_7zipG)
				args='a @(sel.title).zip -tzip -p@input.result -sae -- @sel(true)')
			separator()
			item(title='Add to "@(sel.title).7z" and delete' keys='SHIFT to .zip' image=inherit
				tip='Deletes source files after successful compression.'
				cmd=cmd_7zipG args='a "@(sel.title)@if(!keys.shift(), '.7z" -t7z', '.zip" -tzip') -sdel -sae -- @sel(true)')
			separator()
			item(title='Add to...' keys='SHIFT to mail' image=inherit
				cmd=cmd_7zipG args='a "@sel.title" -ad @if(keys.shift(), '-seml.') -sae -- @sel(true)')
			item( title='Add to "@(sel.title).7z"' keys='SHIFT to mail' image=inherit
				cmd=cmd_7zipG args='a @(sel.title).7z -t7z @if(keys.shift(), '-seml.') -sae -- @sel(true)')
			item(title='Add to "@(sel.title).zip"' keys='SHIFT to mail' image=inherit
				cmd=cmd_7zipG args='a @(sel.title).zip -tzip @if(keys.shift(), '-seml.') -sae -- @sel(true)') }
		item(title='Add to "@(sel.title).7z"' keys='SHIFT to .zip' image=inherit
			cmd=cmd_7zipG args='a "@(sel.title)@if(!keys.shift(), '.7z" -t7z', '.zip" -tzip') -sae -- @sel(true)')
		item(title='Add to "@(sel.title).ppmd.7z" ' keys='SHIFT to .zip' find=is_se7z3
			tip='PPMd compression is particularly effective for compressing text files that have a lot of repetitive patterns and structured content' image=inherit
			cmd=cmd_7zipG args='a @(sel.title).ppmd@if(!keys.shift(), '.7z -t7z', '.zip -tzip') -m0=PPMd -sae -- @sel(true)')
		item( title='Add to "@(sel.title).sfx.exe"' keys='SHIFT no GUI' image=inherit
			cmd=cmd_7zipG args='a @(sel.title).sfx.exe @if(!keys.shift(), '-sfx7z.sfx', '-sfx7zCon.sfx') -sae -- @sel(true)')
		item(title='Generate a file checksum ' image=inherit
			cmd=cmd_7zipG args='a @(sel.name).sha256 -thash -sae -- @sel(true)') }
	menu(title='Test...' type='file' image=svg_7z_test expanded=1) {
		separator
		item(title='Test archive@if(sel.count>1,'s')' find=is_se7z1 image=inherit
			cmd=cmd_7zipG args='t @sel_air')
		item(title='Test and list...' find=is_se7z1 image=inherit
			tip='Test the integrity of the archive and list the files afterwards.'
			cmd-line='/k @path.short(cmd_7zipC) l @sel_air & pause & exit')
		item(title='Test Checksum' find=is_se7z2 image=inherit
			cmd=cmd_7zipG args='t @sel_air -thash')
		menu(title='Checksum' type='file|dir' where=keys.shift() image=inherit) {
			item(title='CRC 32'		cmd=cmd_7zipG args='h -scrcCRC32	@sel(true)')
			item(title='CRC 64'		cmd=cmd_7zipG args='h -scrcCRC64	@sel(true)')
			item(title='SHA 1'		cmd=cmd_7zipG args='h -scrcSHA1		@sel(true)')
			item(title='SHA 256'	cmd=cmd_7zipG args='h -scrcSHA256	@sel(true)')
			item(title='*'			cmd=cmd_7zipG args='h -scrc*		@sel(true)') } }
	menu(title='7-Zip Info' type='file|dir|drive|back' where=key.shift() sep='before' image=svg_7z_Info) {
		item(title='Homepage...'								image=\uE11E cmd='https://7-zip.org/')
		item(title='Documentation...'							image=inherit cmd=path.combine(sys.prog,'7-Zip','7-zip.chm'))
		item(title='Supported Formats Info...'					image=inherit cmd-line='/k @path.short(cmd_7zipC) i & pause & exit')
		sep()
		item(title='Command Line Version User@"'"s Guide...'	image=\uE11E cmd='https://7-zip.opensource.jp/chm/cmdline/')
		item(title='Bugaco@"'"s 7-Zip manual'					image=\uE11E cmd='https://7zip.bugaco.com/7zip/MANUAL/general/index.htm')
		item(title='Documentation.help'							image=\uE11E cmd='https://documentation.help/7-Zip/')
	}
}

/*
	PPMd compression is particularly effective for compressing text files that have a lot of repetitive patterns and structured content. Some common file types and extensions for which PPMd compression can be beneficial include:
		Plain Text Files: Regular text files that contain human-readable text without any formatting. These can include files with extensions like
			.txt, .log, .cfg, etc.
		Source Code Files: Programming source code files, which often have a lot of repeated keywords, symbols, and structures. Examples include
			.c, .cpp, .java, .py, etc.
		Markup Languages: Text-based markup languages that define structure and formatting, such as HTML, XML, LaTeX, etc. Examples include
			.html, .xml, .tex, etc.
		Configuration Files: Various configuration files used by software applications or operating systems. Examples include
			.ini, .conf, .yaml, .json, etc.
		Script Files: Script files used for automation or scripting purposes. Examples include
			.bat, .sh, .ps1, etc.
		Data Files: Certain types of data files that contain structured information. Examples include
			.csv, .tsv, .json, etc.
		Documentation Files: Documentation files that contain technical documentation, manuals, or other explanatory text. Examples include
			.doc, .pdf, .md, etc. (though these may contain non-text elements as well).
		Log Files: Log files generated by software applications to record events or actions. Examples include
			.log, .event, etc.
		Configuration Files: Files that store configuration settings for applications or systems. Examples include
			.config, .cfg, .ini, etc.
	It's important to note that while PPMd compression can be effective for these types of files, the actual compression ratio achieved depends on the specific content and patterns within each file. Not all text files will benefit equally from PPMd compression, and in some cases, other compression algorithms may perform better.
*/