$dg_path = '@sys.prog\dgVoodoo2'
$dg_conf  = '@dg_path\dgVoodoo.conf'
$dg_exe = '@dg_path\dgVoodooCpl.exe'
$dg_exists = path.exists('@dg_exe')

menu(title='dgVoodoo2' image=if(dg_exists, '@dg_exe', \uE135)){
    $sel_Cpl = path.combine(sel.dir, 'dgVoodooCpl.exe')
    $if_shift= if(keys.shift(), '&& copy /y "@dg_exe" @sel.dir(true) && @if(path.exists(@dg_conf), 'copy /y "@dg_conf" @sel.dir(true)', 'copy nul "@path.combine(@sel, "dgVoodoo.conf")"') && "@sel_Cpl"')
    $shift_tip = 'Hold Shift to also copy dgVoodoo2Cpl and a fresh config to directory then open it for per-game settings.'
    // The shift function add's a dgVoodooCpl and a config(copy of global otherwise a blank one) to dir if a game has different needs than the global settings so you can make a config on a per game basis
    $dwnld_scr = 'if (!(Test-Path -LiteralPath $ExtractPath)) { New-Item -ItemType Directory -Path $ExtractPath -Force }; Invoke-WebRequest -Uri $DownloadURL -OutFile $TempZipPath; Expand-Archive -LiteralPath $TempZipPath -DestinationPath $ExtractPath -Force; Remove-Item -Path $TempZipPath -Force'

    item(title='Open the dgVoodoo2 Control Panel' keys='Global' where=dg_exists image=inherit cmd=dg_exe)
    item(title='Open the dgVoodoo2 Control Panel in @sel.path.title' keys='Local' where=path.exists(@sel_Cpl) tip='Open local dgVoodooCPL (for settings only applying to this folder), does not create or reset a config automatically' image=inherit cmd=sel_Cpl)
    separator()
    menu(type='directory|back.dir|file' title='Add x86 dgVoodoo2  wrappers to @sel.path.title' where=dg_exists && len(path.files(sel.dir, "*.exe", 3))>0 || sel.file.ext=='.exe' image=\uE1D2 tip='Verify the program is x86 based and this is the main folder with the EXE'){
        item(title='Direct Draw: ddraw.dll' tip='@shift_tip' admin cmd-line='/c copy /y "@dg_path\MS\x86\DDraw.dll" @sel.dir(true) @if_shift' window='hidden')
        item(title='Direct3D (V<=7.0): d3dimm.dll' tip='@shift_tip' admin cmd-line='/c copy /y "@dg_path\MS\x86\D3Dimm.dll" @sel.dir(true) @if_shift' window='hidden')
        item(title='Direct3D (V8/8.1): d3d8.dll' tip='@shift_tip' admin cmd-line='/c copy /y "@dg_path\MS\x86\D3D8.dll" @sel.dir(true) @if_shift' window='hidden')
        item(title='Direct3D x86 (V9/9.0c): d3d9.dll' tip='@shift_tip' admin cmd-line='/c copy /y "@dg_path\MS\x86\D3D9.dll" @sel.dir(true) @if_shift' window='hidden')
        item(title='Glide (V2.11/2.45/3.1)' tip='@shift_tip' admin cmd-line='/c xcopy /q /y "@dg_path\3Dfx\x86" @sel.dir(true) @if_shift' window='hidden')
        // The Glide wrappers above are safe to have altogether and sometimes even work in tandem so it's standard to copy & paste them all into directory
        item(title='Glide (3.1 Napalm) WARNING! Research 1st' tip='Only meant for games too slow with normal 3.1 dll, @shift_tip'
        admin cmd-line='/c cd @sel.dir(true) && del /q /f *glide*.dll && copy /y "@dg_path\3Dfx\x86\Napalm\Glide3x.dll" @sel.dir(true) @if_shift' window='hidden')}
        // GLide 3.1 Napalm isn't compatible with other Glide Wrappers so I have them all removed from directory before installation. It's only meant for 3.1 Glide games that don't perform well with normal wrappers.
    menu(type='directory|back.dir|file' title='Add x64 dgVoodoo2 wrappers to @sel.path.title' where=dg_exists && len(path.files(sel.dir, "*.exe", 3))>0 || sel.file.ext=='.exe' image=\uE1D2 tip='Verify the program is x64 based and this is the main folder with the EXE'){
        item(title='Direct3D x64 (V9/9.0c): d3d9.dll' tip='@shift_tip' admin cmd-line='/c copy /y "@dg_path\MS\x64\D3D9.dll" @sel.dir(true) @if_shift' window='hidden')
        item(title='Glide x64 (V2.11/2.45/3.1 for x64 Emulation only)' tip='These are for x64 versions of QEmu or Dosbox, @shift_tip' admin cmd-line='/c xcopy /q /y "@dg_path\3Dfx\x64" @sel.dir(true) @if_shift' window='hidden')}
        // Glide was never a native x64 api but there are some use cases in x64 versions of QEmu or Dosbox where using x64 Glide wrappers perform better
        // All x64 Wrappers use the x64 version of dgVoodooCpl
    item(title='DgVoodoo2 is missing, click to install' image=\uE130 where=!dg_exists admin cmd-ps=`$releaseInfo = Invoke-RestMethod -Uri "https://api.github.com/repos/dege-diosg/dgVoodoo2/releases/latest"; $DownloadURL = ($releaseInfo.assets | Where-Object { $_.name -like 'dgVoodoo2*.zip' -and $_.name -notlike 'dgVoodoo2*dbg.zip' }).browser_download_url; $TempZipPath = '@sys.temp\Dgvoodoo2.zip'; $ExtractPath = '@dg_path\\'; @dwnld_scr`)
    item(title='Update to latest release on Github' sep=before image=\uE22C where=dg_exists admin cmd-ps=`$releaseInfo = Invoke-RestMethod -Uri "https://api.github.com/repos/dege-diosg/dgVoodoo2/releases/latest"; $DownloadURL = ($releaseInfo.assets | Where-Object { $_.name -like 'dgVoodoo2*.zip' -and $_.name -notlike 'dgVoodoo2*dbg.zip' }).browser_download_url; $TempZipPath = '@sys.temp\Dgvoodoo2.zip'; $ExtractPath = '@sys.temp\Dgvoodoo2\\'; $DestPath = '@dg_path\\'; @dwnld_scr; Copy-Item "$ExtractPath*" $DestPath -Recurse -Force -Exclude 'dgVoodoo.conf'; Remove-Item -LiteralPath $ExtractPath -Recurse -Force`)}
    
/* Documentation:                        
https://dege.freeweb.hu/dgVoodoo2/ReadmeGeneral/
https://dege.freeweb.hu/dgVoodoo2/ReadmeGlide/
https://dege.freeweb.hu/dgVoodoo2/ReadmeDirectX/
*/