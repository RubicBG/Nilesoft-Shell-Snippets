menu(title='PowerShell Archivator' mode='multiple' type='file|dir' image=[\uE0AA, image.color2]) {
	//> https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.archive/?view=powershell-7.4
	//+ https://www.elevenforum.com/t/unzip-extract-files-from-zip-folder-in-windows-11.8261/
	
	// path that contains double space or square brackets are not supported
	$path_ds = str.contains(sel.path, '  ')
	$path_sb = str.contains(sel.path, '[') or str.contains(sel.path, ']')
	$ps_dest = path.combine(sel.parent, if(key.shift(), str.guid, sel.path.title))
	item(title='Extract to "@sel.path.title\"' keys='SHIFT to guid' image=inherit
		mode='single' type='file' where=sel.file.ext=='.zip'
		tip='Extract the selected ZIP file to a folder with the same name. Use SHIFT key to create a folder with a GUID name.'
		vis=if(path_ds or path_sb, 'disable')
		cmd-ps=`Expand-Archive -LiteralPath '@sel.path(true)' -DestinationPath '@ps_dest' -Force`)
	item(title='Extract to "@sel.path.title\"' keys='SHIFT to guid' image=inherit
		mode='multiple'	type='file' where=sel.file.ext=='.zip'
		tip='Extract each selected ZIP file to single folder. Use SHIFT key to create a folder with a GUID name.'
		vis=if(path_ds or path_sb, 'disable')
		cmd-ps=`Get-Item -LiteralPath '@sel(0,"','")' | ForEach-Object { Expand-Archive -LiteralPath $_ -DestinationPath '@ps_dest' -Force }`)
	item(title='Extract each archive to separate folder' image=inherit
		mode='multiple'	type='file' where=sel.file.ext=='.zip' and sel.count>1
		tip='Extract each selected ZIP file to a separate folder with the same name.'
		vis=if(path_ds or path_sb, 'disable') 
		cmd-ps=`Get-Item -LiteralPath '@sel(0,"','")' | ForEach-Object { Expand-Archive -LiteralPath $_ -DestinationPath ".\$($_.BaseName)" -Force }`)
	item(title='Extract to "@sel.path.title\"' keys='silent' image=[\uE0AA,#ff0000]
		mode='single' type='file' where=sel.file.ext=='.zip'
		tip='Extract the selected ZIP file to a folder with the same name in the background.'
		vis=if(path_ds, 'disable')
		cmd-ps=`Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::ExtractToDirectory('@sel.path', '@sel.path.title')` window='hidden')
	separator()
	$ps_zipn = str.replace(path.combine(sel.parent, if(key.shift(), str.guid, sel.path.title)+'.zip'), '[', '`[').replace(']', '`]')
	item(title='Create "@(sel.path.title).zip" with selected item@if(sel.count>1,'s')' keys='SHIFT guid.zip' image=inherit
		tip='Create a ZIP archive with the selected item(s). Use SHIFT key to create a ZIP file with a GUID name.'
		vis=if(path_ds, 'disable')
		mode='multiple' type='file|dir'
		cmd-ps=`Get-Item -LiteralPath '@sel(0,"','")' | Compress-Archive -DestinationPath '@ps_zipn' -Force`)
	item(title='Create "@(sel.path.title).zip" with item@if(sel.count>1,'s') contents' keys='SHIFT guid.zip' image=inherit
		tip='Try to create a ZIP archive with the selected item(s) contents. Use SHIFT key to create a ZIP file with a GUID name.'
		vis=if(path_ds, 'disable')
		mode='multiple' type='file|dir' where=sel.file.ext!='.zip'
		cmd-ps=`Get-ChildItem -LiteralPath '@sel(0,"','")' | Compress-Archive -DestinationPath '@ps_zipn' -Force`)
	item(title='Create "@(sel.path.title).zip"' keys='silent' image=[\uE0AA,#ff0000]
		tip='Create a ZIP archive with the selected item in the background.'
		vis=if(path_ds, 'disable')
		mode='single' type='file|dir' where=sel.file.ext!='.zip'
		cmd-ps=`Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::CreateFromDirectory('@sel.path', '@(sel.path).zip')` window='hidden')
	
	separator()
	$iso_ps_part = `if (-not ([System.Management.Automation.PSTypeName]'ISOFile').Type) { Add-Type -TypeDefinition 'public class ISOFile { public static void Create(string Path, object Stream, int BlockSize, int TotalBlocks) { int bytes = 0; byte[] buf = new byte[BlockSize]; var ptr = System.Runtime.InteropServices.Marshal.AllocHGlobal(sizeof(int)); System.Runtime.InteropServices.Marshal.WriteInt32(ptr, bytes); var o = System.IO.File.OpenWrite(Path); var i = Stream as System.Runtime.InteropServices.ComTypes.IStream; if (o != null && i != null) { while (TotalBlocks-- > 0) { i.Read(buf, BlockSize, ptr); o.Write(buf, 0, System.Runtime.InteropServices.Marshal.ReadInt32(ptr)); } o.Flush(); o.Close(); } System.Runtime.InteropServices.Marshal.FreeHGlobal(ptr); } }' }; try { ($Image = New-Object -com IMAPI2FS.MsftFileSystemImage -Property @@{VolumeName=$Title}).ChooseImageDefaultsForMediaType($MediaIndex) } catch { Write-Host -ForegroundColor Yellow ($_.Exception.Message.Trim() + ' Try a different media type.'); break; }; if (!($Target = New-Item -Path $Path -ItemType File -Force:$Force -ErrorAction SilentlyContinue)) { Write-Host -ForegroundColor Yellow "Can not create file $Path"; break}; if ($Contents) { $Source = $Source | ForEach-Object { Get-ChildItem -LiteralPath $_ | Select-Object -ExpandProperty FullName } }; $Source | ForEach-Object { if ($item = Get-Item -LiteralPath $_) { Write-Host "Adding item to the target image: $($item.FullName)"; try { $Image.Root.AddTree($item.FullName, $true) } catch { Write-Host -ForegroundColor Yellow ($_.Exception.Message.Trim() + ' Try a different media type.') } } }; $Result = $Image.CreateResultImage(); [ISOFile]::Create($Target.FullName, $Result.ImageStream, $Result.BlockSize, $Result.TotalBlocks); Write-Host -ForegroundColor Green "Target image ($($Target.FullName)) has been created"`
	$iso_label = 'Optical Disc Image'
	//>  https://learn.microsoft.com/en-us/windows/win32/api/imapi2/ne-imapi2-imapi_media_physical_type
	$iso_media = 13
	$is_contents = sel.count==1 and sel.type==3
	item(title='Create "@(sel.path.title).iso"' mode='multiple' type='file|dir' image=icon.burn_disc_image commands {
		// optional: change label
		cmd=if(input('Nilesoft Shell', 'Add Media Tite'), { iso_label = input.result }),
		// optional: change media types supported by IMAPI
		cmd=if(input('Nilesoft Shell', "Medisa Type: 3 for 0.7 GB; 7 for 4.7 GB; 13 for 8.5 GB; 19 for >25 GB") and len(input.result)>0, { iso_media = input.result }),
		// Execute the command
		cmd-ps=`-noexit $Source='@sel(0,"','")'; $Path='@(sel.path.title).iso'; $MediaIndex='@iso_media'; $Title='@iso_label'; $Force=$true; $Contents=@is_contents; @iso_ps_part`
		})
}