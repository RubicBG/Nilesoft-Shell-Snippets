$dg_path='@sys.prog\dgVoodoo2'
$dg_conf='@sys.prog\dgVoodoo2\dgVoodoo.conf'
$dg_exe86='@sys.prog\dgVoodoo2\dgVoodooCpl.exe'
$dg_exe64='@sys.prog\dgVoodoo2\Cpl\x64\dgVoodooCpl.exe'
$sel_Cpl='@path.combine(@sel, "dgVoodooCpl.exe")'
$if_shift86='@if(keys.shift(), '&& copy /y "@dg_exe86" @sel(true) && @if(path.exists(@dg_conf), 'copy /y "@dg_conf" @sel(true)', 'copy nul "@path.combine(@sel, "dgVoodoo.conf")"') && "@sel_Cpl"')'
$if_shift64='@if(keys.shift(), '&& copy /y "@dg_exe64" @sel(true) && @if(path.exists(@dg_conf), 'copy /y "@dg_conf" @sel(true)', 'copy nul "@path.combine(@sel, "dgVoodoo.conf")"') && "@sel_Cpl"')'
$shift_tip='Hold Shift to also copy dgVoodoo2Cpl and a fresh config to directory then open it for per-game settings.'

menu(title='dgVoodoo2' image='@dg_exe86'){
    item(title='Open the dgVoodoo2 Control Panel (Global Settings)' image=inherit cmd='@dg_exe86')
    item(title='Open the dgVoodoo2 Control Panel (@sel.name Local Settings)' vis=path.exists(@sel_Cpl) tip='Open local dgVoodooCPL (for settings only applying to this folder), does not create or reset a config automatically' image=inherit cmd='"@sel_Cpl"')
    separator()
    menu(type='directory|back.dir' title='Add dgVoodoo2 wrappers to @sel.name (x86 Wrappers)' image=\uE1D2 tip='Verify the program is x86 based and this is the main folder with the EXE'){
        item(title='Direct Draw: ddraw.dll' tip='@shift_tip' admin cmd-line='/c copy /y "@dg_path\MS\x86\DDraw.dll" @sel(true) @if_shift86' window='hidden')
        item(title='Direct3D (V<=7.0): d3dimm.dll' tip='@shift_tip' admin cmd-line='/c copy /y "@dg_path\MS\x86\D3Dimm.dll" @sel(true) @if_shift86' window='hidden')
        item(title='Direct3D (V8/8.1): d3d8.dll' tip='@shift_tip' admin cmd-line='/c copy /y "@dg_path\MS\x86\D3D8.dll" @sel(true) @if_shift86' window='hidden')
        item(title='Direct3D x86 (V9/9.0c): d3d9.dll' tip='@shift_tip' admin cmd-line='/c copy /y "@dg_path\MS\x86\D3D9.dll" @sel(true) @if_shift86' window='hidden')
        item(title='Glide (V2.11/2.45/3.1)' tip='@shift_tip' admin cmd-line='/c xcopy /q /y "@dg_path\3Dfx\x86" @sel(true) @if_shift86' window='hidden')
        // The Glide wrappers above are safe to have altogether and sometimes even work in tandem so it's standard to copy & paste them all into directory
        item(title='Glide (3.1 Napalm) WARNING! Research 1st' tip='Only meant for games too slow with normal 3.1 dll, @shift_tip'
        admin cmd-line='/c cd @sel(true) && del /q /f *glide*.dll && copy /y "@dg_path\3Dfx\x86\Napalm\Glide3x.dll" @sel(true)  @if_shift86' window='hidden')}
        // GLide 3.1 Napalm isn't compatible with other Glide Wrappers so I have them all removed from directory before installation. It's only meant for 3.1 Glide games that don't perform well with normal wrappers.
    menu(type='directory|back.dir' title='Add dgVoodoo2 wrappers to @sel.name (x64 Wrappers)' image=\uE1D2 tip='Verify the program is x64 based and this is the main folder with the EXE'){
        item(title='Direct3D x64 (V9/9.0c): d3d9.dll' tip='@shift_tip' admin cmd-line='/c copy /y "@dg_path\MS\x64\D3D9.dll" @sel(true) @if_shift64' window='hidden')
        item(title='Glide x64 (V2.11/2.45/3.1 for x64 Emulation only)' tip='These are for x64 versions of QEmu or Dosbox, @shift_tip' admin cmd-line='/c xcopy /q /y "@dg_path\3Dfx\x64" @sel(true) @if_shift64' window='hidden')}
        // Glide was never a native x64 api but there are some use cases in x64 versions of QEmu or Dosbox where using x64 Glide wrappers perform better
        // All x64 Wrappers use the x64 version of dgVoodooCpl
    separator()
    item(title='Check latest release on Github' image=\uE22C cmd='start https://www.github.com/dege-diosg/dgVoodoo2/releases/latest')}

// The shift function add's a dgVoodooCpl and a config(copy of global otherwise a blank one) to dir if a game has different needs than the global settings so you can make a config on a per game basis
/* Documentation:
https://dege.freeweb.hu/dgVoodoo2/ReadmeGeneral/
https://dege.freeweb.hu/dgVoodoo2/ReadmeGlide/
https://dege.freeweb.hu/dgVoodoo2/ReadmeDirectX/
*/