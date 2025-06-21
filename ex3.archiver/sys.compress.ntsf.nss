// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/
// To-Do: add new/update tips, 

menu(title='NTFS Compression' mode='multiple' type='file|dir' image=[\uE1B0, image.color2] vis=if(io.meta(sel.root, 'System.Volume.FileSystem')!='NTFS', 'disable')
	tip='NTFS compression reduces file size on disk while maintaining full transparency to applications. Files are compressed/decompressed automatically by the filesystem. Only works on NTFS volumes.') {
	// https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-xp/bb490884(v=technet.10)?redirectedfrom=MSDN
	// https://www.elevenforum.com/t/compress-or-uncompress-files-and-folders-in-windows-11.8775/
	$isCompressed=io.attribute.compressed(io.attributes(sel.path))
	$isAvaliable=sys.ver.build>='15063'
	$refresh=wnd.command(28931)
	$selected='/s:@sel(1, '|').trimend('|').replace('|', ' /s:')'
	item(image=[\uE1B0, image.color2] keys='SHIFT info' title='Standard Compression'
		tip='Uses LZNT1 algorithm (traditional NTFS compression) - fastest compression/decompression with moderate space savings (30-50% typical). Best for: frequently accessed files, older systems, maximum compatibility. Files show blue overlay icon when compressed. CPU overhead is minimal during file access.'
		commands { cmd-line='/c compact /c @sel(true) /i /f @if(keys.shift(), '& pause & exit')' window=if(!keys.shift(), 'hidden') wait=true, cmd=refresh })
	item(image=[\uE1B0, image.color2] keys='SHIFT info' type='dir' title='Standard Recursive Compression' tip='Recursively compress folder and its contents silently'
		tip='Recursively compresses entire folder structure using LZNT1. All existing files and new files added to compressed folders will automatically be compressed. Warning: Large directories may take considerable time to process. Use Shift+Click to monitor progress.'
		commands { cmd-line='/c compact /c @selected /i /f @if(keys.shift(), '& pause & exit')' window=if(!keys.shift(), 'hidden') wait=true, cmd=refresh })
	menu(image=[\uE1B0, image.color2] mode='single' type='file' title='Modern Compression' vis=if(!isAvaliable, 'disable')
		tip='Windows Overlay Filter compression - uses advanced algorithms for better compression ratios (40-70% savings). Higher CPU usage but better space efficiency. Ideal for: infrequently accessed files, SSDs, storage-constrained systems.') {
		item(image=inharit title='XPRESS 4K' keys='SHIFT info'
			tip='XPRESS algorithm with 4KB blocks - balanced compression speed and ratio. Good for: general purpose files, documents, moderate compression needs. Faster than LZX but lower compression ratio than 8K/16K variants.'
			commands { cmd-line='/c compact /c /exe:XPRESS4K @sel(true) /i /f @if(keys.shift(), '& pause & exit')' window=if(!keys.shift(), 'hidden') wait=true, cmd=refresh })
		item(image=inharit  title='XPRESS 8K' keys='SHIFT info'
			tip='XPRESS algorithm with 8KB blocks - better compression than 4K with slightly more CPU usage. Recommended for: text files, source code, logs, documents. Good balance between compression ratio and performance.'
			commands { cmd-line='/c compact /c /exe:XPRESS8K @sel(true) /i /f @if(keys.shift(), '& pause & exit')' window=if(!keys.shift(), 'hidden') wait=true, cmd=refresh })
		item(image=inharit title='XPRESS 16K' keys='SHIFT info'
			tip='XPRESS algorithm with 16KB blocks - highest compression ratio in XPRESS family but slower. Best for: large text files, databases, archives. Provides excellent compression for repetitive data patterns.'
			commands { cmd-line='/c compact /c /exe:XPRESS16K @sel(true) /i /f @if(keys.shift(), '& pause & exit')' window=if(!keys.shift(), 'hidden') wait=true, cmd=refresh })
		item(image=inharit title='LZX' keys='SHIFT info'
			tip='LZX algorithm - strongest compression available in Windows (up to 70-80% space savings). Highest CPU usage for compression/decompression. Best for: rarely accessed files, archival storage, maximum space savings needed. Based on LZ77 + Huffman coding.'
			commands { cmd-line='/c compact /c /exe:LZX @sel(true) /i /f @if(keys.shift(), '& pause & exit')' window=if(!keys.shift(), 'hidden') wait=true, cmd=refresh }) }
	menu(image=[\uE1B0, image.color2] type='dir' title='Modern Smart Recursive Compression'
		tip='Intelligently compresses folder contents while skipping already-compressed file types (images, videos, archives, Office docs). Prevents double-compression inefficiency and wasted processing time. Uses PowerShell for selective file filtering.') {
		/* exceptions for "smart" compression
			Executables & Installers	.dl_, .xap, .cab, .dmg, .onepkg, .lzx
			Archives & Compression		.zip, .rar, .7z, .tar, .gz, .bz2, .tgz, .lz, .xz, .txz
			Images						.gif, .jpg, .jpeg, .png, .wmf
			Videos						.mkv, .mp4, .wmv, .avi, .bk2, .flv, .ogg, .mpg, .m2v, .m4v, .vob
			Audio						.mp3, .aac, .wma, .flac (.ogg)
			Documents (Office)			.docx, .xlsx, .pptx, .vssx, .vstx */
		$skip_ext = '.dl_|.xap|.cab|.dmg|.onepkg|.lzx|.zip|.rar|.7z|.tar|.gz|.bz2|.tgz|.lz|.xz|.txz|.gif|.jpg|.jpeg|.png|.wmf|.mkv|.mp4|.wmv|.avi|.bk2|.flv|.ogg|.mpg|.m2v|.m4v|.vob|.mp3|.aac|.wma|.flac|.docx|.xlsx|.pptx|.vssx|.vstx'
		$skip_ftr = str.end(sel.files.ext+'|', $skip_ext+'|')
		item(image=inharit title='XPRESS 4K' keys='with info'
			tip='Compresses files using XPRESS 4K. Skips media files, archives, and modern Office documents that are already compressed. Processes files recursively while showing progress.'
			commands { cmd-ps=`-noexit Get-ChildItem -LiteralPath '@sel(true)' -Recurse -File | Where-Object {$_.Extension -notmatch '@skip_ext'} | ForEach-Object { Write-Host "Compressing $($_.FullName)"; compact /c /exe:XPRESS4K /i /f "\"$($_.FullName)\"" }` wait=true, cmd=refresh })
		item(image=inharit title='XPRESS 8K' keys='with info'
			tip='Compresses files using XPRESS 8K. Skips media files, archives, and modern Office documents that are already compressed. Better compression than 4K variant with minimal performance impact. Processes files recursively while showing progress.'
			commands { cmd-ps=`-noexit Get-ChildItem -LiteralPath '@sel(true)' -Recurse -File | Where-Object {$_.Extension -notmatch '@skip_ext'} | ForEach-Object { Write-Host "Compressing $($_.FullName)"; compact /c /exe:XPRESS8K /i /f "\"$($_.FullName)\"" }` wait=true, cmd=refresh })
		item(image=inharit title='XPRESS 16K' keys='with info'
			tip='Compresses files using XPRESS 16K. Highest compression ratio in XPRESS family while avoiding double-compression. Ideal for folders with mixed content types. Processes files recursively while showing progress.'
			commands { cmd-ps=`-noexit Get-ChildItem -LiteralPath '@sel(true)' -Recurse -File | Where-Object {$_.Extension -notmatch '@skip_ext'} | ForEach-Object { Write-Host "Compressing $($_.FullName)"; compact /c /exe:XPRESS16K /i /f "\"$($_.FullName)\"" }` wait=true, cmd=refresh })
		item(image=inharit title='LZX' keys='with info'
			tip='Compresses files using LZX (maximum compression). Skips already compressed formats to prevent wasted processing. Best for archival folders with mixed content requiring maximum space savings. Processes files recursively while showing progress.'
			commands { cmd-ps=`-noexit Get-ChildItem -LiteralPath '@sel(true)' -Recurse -File | Where-Object {$_.Extension -notmatch '@skip_ext'} | ForEach-Object { Write-Host "Compressing $($_.FullName)"; compact /c /exe:LZX /i /f "\"$($_.FullName)\"" }` wait=true, cmd=refresh }) }
	separator()
	item(image=[\uE1B1, image.color1] keys='SHIFT info' title='UnCompression' tip='Uncompress all selected files/folders'
		tip='Removes NTFS compression from selected files/folders. Restores files to normal uncompressed state. File size will increase to original size but access speed may improve slightly. Blue overlay icons will disappear.'
		commands { cmd-line='/c compact /u @sel(true) /i /f @if(keys.shift(), '& pause & exit')' window=if(!keys.shift(), 'hidden') wait=true, cmd=refresh })
	item(image=[\uE1B1, image.color1] keys='SHIFT info' type='dir' title='Recursive UnCompression' tip='Recursively uncompress folder and its contents'
		tip='Recursively uncompresses entire folder structure and all contained files. Removes all compression attributes from the directory tree. Warning: Files will expand to full size - ensure adequate disk space before proceeding. Blue overlay icons will disappear.'
		commands { cmd-line='/c compact /u @selected /i /f @if(keys.shift(), '& pause & exit')' window=if(!keys.shift(), 'hidden') wait=true, cmd=refresh })
	item(image=[\uE1B1, image.color1] keys='SHIFT info' mode='single' type='file' title='Modern UnCompression' tip='Uncompress all selected files' vis=if(!isAvaliable, 'disable') where=0
		tip='Removes Windows Overlay Filter compression (XPRESS/LZX algorithms). Use this for files compressed with modern algorithms. Regular uncompress may not work for WOF-compressed files.' vis=if(!isAvaliable, 'disable') where=0
		commands { cmd-line='/c compact /u /exe @sel(true) /i /f @if(keys.shift(), '& pause & exit')' window=if(!keys.shift(), 'hidden') wait=true, cmd=refresh })
	separator()
	item(title='Status' image=\uE133 tip='Show compression status of selected file(s)'
		tip='Shows detailed compression status including: current compression state, algorithm used, compression ratio, and space savings. Displays statistics for selected files without making changes.'
		cmd-line='/k compact @sel(true) & pause & exit')
	// https://superuser.com/a/1720517/2335560
	$wof = `if (-not ([System.Type]::GetType('Wofutil.Wof'))) { Add-Type -Name 'Wof' -Namespace 'Wofutil' -MemberDefinition 'public struct ExternalFileInfo { public uint algorithm; public uint flags; } [System.Runtime.InteropServices.DllImport(\"Wofutil.dll\")] public static extern int WofIsExternalFile([System.Runtime.InteropServices.MarshalAs(System.Runtime.InteropServices.UnmanagedType.LPWStr)] string Filepath, out int IsExternalFile, out uint Provider, out ExternalFileInfo Info, ref uint BufferLength);' }; enum Algorithms { NO_COMPRESSION = -2; LZNT1 = -1; XPRESS4K = 0; LZX = 1; XPRESS8K = 2; XPRESS16K = 3 }; class CompressionInfo { [string]$FileName; [Algorithms]$Algorithm };`
	item(title='Check Compression Type (WOF)' image=\uE130 vis=if(!isAvaliable, 'disable')
		tip='Identifies exact compression algorithm used for each file: LZNT1 (standard), XPRESS4K/8K/16K, LZX, or no compression. Uses Windows Overlay Filter API to detect modern compression types that compact.exe cannot identify.' vis=if(!isAvaliable, 'disable')
		cmd-ps=`-noexit $fileList = '@sel(1,"|")' -split '\|'; @wof; foreach ($fileName in $fileList) { $f = Get-Item -LiteralPath $fileName; if (($f.Attributes -band [IO.FileAttributes]::Compressed) -ne 0) { [CompressionInfo]@@{ FileName = $f.FullName; Algorithm = 'LZNT1' } } else { [int]$isExternalFile = 0; [uint32]$provider = 0; $fileInfo = New-Object Wofutil.Wof+ExternalFileInfo; [uint32]$length = 8; [void][Wofutil.Wof]::WofIsExternalFile($f.FullName, [ref]$isExternalFile, [ref]$provider, [ref]$fileInfo, [ref]$length); if ($isExternalFile -ne 0) { [CompressionInfo]@@{ FileName = $f.FullName; Algorithm = [Algorithms]$fileInfo.algorithm } } else { [CompressionInfo]@@{ FileName = $f.FullName; Algorithm = 'NO_COMPRESSION' } } } }`)
	item(title='Check Recursive Compression File(s) Type (WOF)' image=\uE130 type='dir' vis=if(!isAvaliable, 'disable')
		tip='Opens help explaining: which files benefit from compression, performance impacts, when to use different algorithms, and best practices for NTFS compression usage.'
		cmd-ps=`-noexit $fileList = '@sel(1,"|")' -split '\|'; @wof; function Get-FileCompressionInfo($path) { $f = Get-Item -LiteralPath $path -Force; if (($f.Attributes -band [IO.FileAttributes]::Compressed) -ne 0) { [CompressionInfo]@@{ FileName = $f.FullName; Algorithm = 'LZNT1' } } else { [int]$isExternalFile = 0; [uint32]$provider = 0; $fileInfo = New-Object Wofutil.Wof+ExternalFileInfo; [uint32]$length = 8; [void][Wofutil.Wof]::WofIsExternalFile($f.FullName, [ref]$isExternalFile, [ref]$provider, [ref]$fileInfo, [ref]$length); if ($isExternalFile -ne 0) { [CompressionInfo]@@{ FileName = $f.FullName; Algorithm = [Algorithms]$fileInfo.algorithm } } else { [CompressionInfo]@@{ FileName = $f.FullName; Algorithm = 'NO_COMPRESSION' } } } }; foreach ($path in $fileList) { if (Test-Path -LiteralPath $path -PathType Container) { Get-ChildItem -LiteralPath $path -Recurse -Force -File | ForEach-Object { Get-FileCompressionInfo $_.FullName } } else { Get-FileCompressionInfo $path } }`)
}