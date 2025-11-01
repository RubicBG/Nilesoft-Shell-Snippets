/*
DSOAL is a audio wrapper used in conjunction with OpenAL Soft to restore EAX functionality in older games on versions of Windows newer than Vista and modern sound devices.
link to latest DSOAL+OpenALsoft builds combined "https://github.com/kcat/dsoal/releases/download/latest-master/DSOAL.zip"
link to registry fix "https://github.com/ThreeDeeJay/DSWRP/releases/download/v1.2.0/DirectSound.wrapper.registry.patcher.v1.2.zip"
https://www.pcgamingwiki.com/wiki/Glossary:Sound_card#DirectSound_hardware_path
https://www.pcgamingwiki.com/wiki/Glossary:Surround_sound#Binaural_sound:_HRTF
https://satsun.org/audio/
*/
menu(title='Audio Wrappers' image=image.fluent(\uF0EE,13)){
    $dwnld_scr = 'if (!(Test-Path -LiteralPath $ExtractPath)) { New-Item -ItemType Directory -Path $ExtractPath -Force }; Invoke-WebRequest -Uri $DownloadURL -OutFile $TempZipPath; Expand-Archive -LiteralPath $TempZipPath -DestinationPath $ExtractPath -Force; Remove-Item -Path $TempZipPath -Force'
    $al_path = '@sys.prog32\Creative\ALchemy'
    $alexe_path = path.combine(al_path, 'ALchemy.exe')
    $alini_path = path.combine(al_path, 'ALchemy.ini')
    $ds_globcon = '@user.appdata\OpenAL\alsoft.ini'
    $ds_path = '@sys.prog\DSOALOpenALSoft'
    $al_dsound = io.meta('@sel.dir\dsound.dll', 'System.Software.ProductName')=='Creative ALchemy'
    $ds_dsound = io.meta('@sel.dir\dsound.dll', 'System.Software.ProductName')=='Wine'
    $oal_dest = if(path.exists('@sel.dir\dsound.dll'), chk_dsound, '@sel.dir\soft_oal.dll')
    $chk_dsound = if(al_dsound, '@sel.dir\soft_oal.dll', if(ds_dsound, sel.dir))          
    $ds_sftcopy = if(keys.shift(), io.copy('@ds_path\DSOAL\Win64\dsound.dll', sel.dir, 2), io.copy('@ds_path\DSOAL\Win32\dsound.dll', sel.dir, 2))
    $loc_exists= path.exists('@sel.dir\alsoft.ini')
    $rp_exists = path.exists('@ds_path\RegistryPatcher')
    $ad_cond = path.exists(@ds_path) && len(path.files(sel.dir, "*.exe", 3))>0 || sel.file.ext=='.exe'
    $iss_path = '@sys.temp\Alchemy\Creative_ALchemy_1.45.20\setup.iss'
    $iss_file = "[InstallShield Silent]\r\nVersion=v7.00\r\nFile=Response File\r\n[File Transfer]\r\nOverwrittenReadOnly=NoToAll\r\n[{12321490-F573-4815-B6CC-7ABEF18C9AC4}-DlgOrder]\r\nDlg0={12321490-F573-4815-B6CC-7ABEF18C9AC4}-LICENSE_DLG-0\r\nCount=3\r\nDlg1={12321490-F573-4815-B6CC-7ABEF18C9AC4}-SdAskDestPath-0\r\nDlg2={12321490-F573-4815-B6CC-7ABEF18C9AC4}-SdFinish-0\r\n[{12321490-F573-4815-B6CC-7ABEF18C9AC4}-LICENSE_DLG-0]\r\nResult=1\r\n[{12321490-F573-4815-B6CC-7ABEF18C9AC4}-SdAskDestPath-0]\r\nszDir=C:\\Program Files (x86)\\Creative\\ALchemy\r\nResult=1\r\n[Application]\r\nName=Creative ALchemy\r\nVersion=1.45\r\nCompany=Creative Tech\r\nLang=0009\r\n[{12321490-F573-4815-B6CC-7ABEF18C9AC4}-SdFinish-0]\r\nResult=1\r\nbOpt1=0\r\nbOpt2=0\r\n"
  

    item(title='Open Alchemy' where=path.exists(alexe_path) image cmd=alexe_path)

    item(title='Add @quote(@sel.file.title) to Alchemy' keys='Default' mode='single' type='file' image=alexe_path where=path.exists(alexe_path) || sel.file.ext=='.exe' tip='Adds Game to Alchemy with Default Settings'
    admin cmd= ini.get(alini_path, @sel.file.title, 'GamePath')=='@sel.dir' || str.contains(ini.get(alini_path, @sel.file.title, 'RegPath'), str.padding(@sel.file.title, '*'))  ? msg('Game is possibly already in Alchemy. Open Alchemy and set manually', 'Nilesoft Shell', msg.warning) : ini.set(alini_path, @sel.file.title, 'GamePath', sel.dir) & ini.set(alini_path, @sel.file.title, 'Preset', '1') & if(!path.exists('@sel.dir\dsound.ini'), io.file.create('@sel.dir\dsound.ini', "Buffers=4 \nDuration=25 \nMaxVoiceCount=128 \nDisableDirectMusic=0")) & io.copy('@al_path\dsound.dll', sel.dir, 2))
    // adds a game to Alchemy with stock settings just like if you added it without changing settings. It adds the game folder to Alchemy's ini, and copy's over the Alchemy dsound.dll & dsound.ini (also carrying over the stock settings) to the game dir.
    // only shows up when you right click the game .exe itself
    
    item(title='Download Alchemy' image=\uE0BD where=!path.exists(alexe_path) commands{
    admin cmd-ps=`$DownloadURL = 'https://archive.org/download/creative-alchemy-all-versions/ALchemy_1.45.20_Universal.zip'; $TempZipPath = '@sys.temp\ALchemy_1.45.20_Universal.zip'; $ExtractPath = '@sys.temp\Alchemy'; @dwnld_scr` wait=1, 
    admin cmd= io.delete(iss_path) & io.file.create(iss_path, '@iss_file') wait=1,
    admin cmd-ps=`$DestPath = '@al_path';  Start-Process -FilePath '@sys.temp\Alchemy\EAX4Unified_redist_4001.exe' -Wait; Start-Process -FilePath '@sys.temp\Alchemy\Creative_ALchemy_1.45.20\setup.exe' -ArgumentList '/s' -Wait; Copy-Item -Path '@sys.temp\Alchemy\GenericALchemyDerestrictor-1.0\ALchemyPatch.exe' -Destination $DestPath; Remove-Item -Path '@sys.temp\Alchemy' -Recurse -Force` wait=1,
    admin cmd='ALchemyPatch.exe' dir='@al_path' wait=1})
    // The alchemy installer needs to be silent because if someone does that default option of restarting after install then the commands don't finish and won't work.
    // The patcher doesn't work properly unless the directory is set for the command, otherwise it doesn't see Alchemy.exe and fails
    
    item(title=if(path.exists(@ds_path), 'Update DSOAL+OpenALsoft', 'Download DSOAL+OpenALsoft') sep=if(path.exists(alexe_path), 'before') tip='Downloads the latest builds of DSOAL and OpenALsoft from Github' image=\uE0BD commands{
    admin cmd-ps=`$DownloadURL = 'https://github.com/kcat/dsoal/releases/download/latest-master/DSOAL.zip'; $TempZipPath = '@sys.temp\\DSOAL.zip'; $ExtractPath = '@ds_path\\'; @dwnld_scr; $FindZip = ls -path $ExtractPath -Filter 'DSOAL*.zip' | select -exp FullName; Expand-Archive -Path $FindZip -DestinationPath $ExtractPath -Force; Remove-Item -Path $FindZip -Recurse -Force` wait=1,
    admin cmd-ps=`$releaseInfo = Invoke-RestMethod -Uri "https://api.github.com/repos/kcat/openal-soft/releases/latest"; $DownloadURL = ($releaseInfo.assets | Where-Object { $_.name -like '*.zip' }).browser_download_url; $TempZipPath = '@sys.temp\\OpenALSoft.zip'; $ExtractPath = '@ds_path\\'; @dwnld_scr; if(Test-Path -LiteralPath "$ExtractPath\\OpenALSoft"){Remove-Item -LiteralPath "$ExtractPath\\OpenALSoft" -Recurse -Force}; ls -Path $ExtractPath -Filter 'openal-soft*' -Directory | Rename-Item -NewName 'OpenALSoft' -Force` wait=1})
    // The wrappers themselves are mostly just from the DSOAL github since both wrappers are released together almost daily with the latest commits, the OpenAlSoft github download is get all the tools, resources, and Router dll's that aren't included with DSOAL builds.

    item(title='Download Registry Patcher Fix' image=\uE0BD where=!rp_exists
    admin cmd-ps=`$DownloadURL = 'https://github.com/ThreeDeeJay/DSWRP/releases/download/v1.2.0/DirectSound.wrapper.registry.patcher.v1.2.zip'; $TempZipPath = '@sys.temp\RegistryPatcher.zip'; $ExtractPath = '@ds_path\RegistryPatcher\\'; @dwnld_scr` wait=1)
    //https://www.indirectsound.com/registryIssues.html

    item(title='Download HRTF/Ambisonics Presets' image=\uE0BD keys='Global' tip='If you want to use HRTF or Ambisonic Speaker Configurations this adds them for use in configs.' where=path.exists(@ds_path) && !path.exists('@ds_globcon')|key.shift()
    admin cmd-ps=`$DownloadURL = 'https://archive.org/download/open-al-presets-hrtf/OpenAL.zip'; $TempZipPath = '@sys.temp\OpenAL.zip'; $ExtractPath = '@user.appdata'; @dwnld_scr; @if(!path.exists('@ds_globcon'), `Copy-Item -Path '@ds_path\DSOAL\Win32\alsoft.ini' -Destination '@user.appdata\OpenAL'`)` wait=1)
    // If setting up a global profile these presets are a necessity. The folder created is where the global config goes to. I've included the default config for further editing.

    sep()

    item(title='Add DSOAL+OpenalSoft wrappers to @quote(sel.path.title)' keys='Local' image=[\uE1D2, image.color2] type='directory|back.dir|file' where=ad_cond tip='Hold shift to add x64 version for compatible x64 apps'
    cmd=if(keys.shift(), io.copy('@ds_path\DSOAL\Win64\dsoal-aldrv.dll', sel.dir, 2) && io.copy('@ds_path\DSOAL\Win64\dsound.dll', sel.dir, 2), io.copy('@ds_path\DSOAL\Win32\dsoal-aldrv.dll', sel.dir, 2) & io.copy('@ds_path\DSOAL\Win32\dsound.dll', sel.dir, 2)))
    //automatically overwrites existing OpenAlSoft and Dsound files. Choosing this you are overwriting Alchemy dsound if it exists.

    item(title='Add DSOAL wrapper to @quote(sel.path.title)' keys='Local' image=[\uE1D2, image.color2] type='directory|back.dir|file' where=path.exists('@sel.dir\dsoal-aldrv.dll') && ad_cond tip='Hold shift to add x64 version for compatible x64 apps'
    admin cmd=if(al_dsound, if(msg('Creative ALchemy dsound.dll detected, overwrite it with DSOAL?', 'NileSoft Shell', msg.warning | msg.yesno)==msg.idyes, ds_sftcopy, io.rename('@sel.dir\dsoal-aldrv.dll', '@sel.dir\soft_oal.dll')), ds_sftcopy))
    // if you already have OpenAlSoft in the folder as 'dsoal-aldrv.dll' you just just add DSOAL dsound if it's missing. If Alchemy's dsound is there it will ask if you want to overwrite it, if yes then DSOAL is installed. If not then OpenalSoft is renamed to be compatible with Alchemy.

    item(title='Add OpenAL Soft wrapper to @quote(sel.path.title)' keys='Local' image=[\uE1D2, image.color2] type='directory|back.dir|file' where=ad_cond tip='Hold shift to add x64 version for compatible x64 apps' 
    admin cmd=if(keys.shift(), io.copy('@ds_path\DSOAL\Win64\dsoal-aldrv.dll', oal_dest, 2), io.copy('@ds_path\DSOAL\Win32\dsoal-aldrv.dll', oal_dest, 2)))
    // checks if DSOAL already exists, if it does Openal Soft will be named dsoal-aldrv.dll. It's named soft_oal.dll if there is no dsound.dll or if Alchemy's dsound.dll is present. Because alot of wrappers and mods use the dsound.dll name (might not even be audio related) I specifically check for the Alchemy and DSOAL ones and act accordingly. A more broad approach could cause problems for multiple things.

    item(title='Bypass OpenAL Router: Add OpenAL Soft wrapper to @quote(sel.path.title)' keys='Local' image=[[\uE283],[\uE27B]] type='directory|back.dir|file' where=ad_cond && key.shift()  tip='Hold shift to add x64 version for compatible x64 apps' 
    admin cmd=if(keys.shift(), io.copy('@ds_path\DSOAL\Win64\dsoal-aldrv.dll', '@sel.dir\OpenAL32.dll', 2), io.copy('@ds_path\DSOAL\Win32\dsoal-aldrv.dll', '@sel.dir\OpenAL32.dll', 2)))
    // this is for special cases where a game might act weird with a certain router or maybe the game has a included OpenAL32.dll acting weird. This only shows up with shift cause it's more of a special case
    sep()

    item(title='Add OpenAL Soft wrapper to Windows Directory' keys='Global' image=\uE0A9 where=path.exists(@ds_path) && !path.exists('@sys.bin32\soft_oal.dll')|!path.exists('@sys.bin\soft_oal.dll')|key.shift() tip='Hold shift to add x64 version for compatible x64 apps' 
    admin cmd=if(keys.shift(), io.copy('@ds_path\DSOAL\Win64\dsoal-aldrv.dll', '@sys.bin\soft_oal.dll', 2), io.copy('@ds_path\DSOAL\Win32\dsoal-aldrv.dll', '@sys.bin32\soft_oal.dll', 2)))
    // this item normally only shows up if you don't have OpenAlsoft in System32 or Syswow64 but if you got them in there already and want to update them with the latest dll's you recently updated with the 'Update DSOAL+OpenALsoft' you just need to hold shift while pulling up context menu and this item will show up and you can update them.

    item(title='Add OpenAL Soft router DLL to Windows Directory' keys='Global' image=\uE0A9 where=path.exists(@ds_path) && !path.exists('@sys.bin32\OpenAL32.dll')|!path.exists('@sys.bin\OpenAL32.dll')|key.shift() tip='Hold shift to add x64 version for compatible x64 apps'
    admin cmd=if(keys.shift(),io.copy('@ds_path\OpenALSoft\router\Win64\OpenAL32.dll', sys.bin, 2), io.copy('@ds_path\OpenALSoft\router\Win32\OpenAL32.dll', sys.bin32, 2)))
    // It's recommended to use this router whether you are using local or global settings, it's best for modern OS. 
    // If you installed Creative's router, you have a wrap_oal.dll which in most cases works fine with OpenAlSoft. Sometimes helps compatibility but there are some rare cases where it might also cause problems. Run the Uninstall Creative OpenAL Router item if you have problems, can always just add it back if you want then overwrite it with OpenAlSoft router while keeping wrap_oal.dll. Lots of options to try.
    // This only shows if you don't have a router in a Windows Directory or if you shift

    item(title='Add Creative OpenAL Router to Windows Directory' keys='Global' image=\uE0A9 where=path.exists(@ds_path) && !path.exists('@sys.bin32\OpenAL32.dll')|!path.exists('@sys.bin\OpenAL32.dll')|key.shift() tip='If you are on an older Windows like Vista or older, this might work better than the OpenAL Soft Router'
    admin cmd-ps=`$TempPath='@sys.temp\\OALInst.exe'; Invoke-WebRequest -Uri 'https://archive.org/download/oalinst_202510/OALInst.exe' -OutFile $TempPath; Start-Process -FilePath $TempPath -Wait; Remove-Item -Path $TempPath -Force`)
    // This is an alternate option to the OpenALSoft Router, some games might prefer this one sometimes. Older systems sometimes work better with this. Might be cases where you might wanna switch between the Routers or bypass them.
    // Same as the other router if routers are missing or you shift this will show

    item(title='Uninstall Creative OpenAL Router' image=\uE171 where=path.exists('@sys.prog32\OpenAL\OALInst.exe') && key.shift()  commands{
    admin cmd='@sys.prog32\OpenAL\OALInst.exe' args='/U' wait=1,
    admin cmd=io.delete('@sys.prog32\OpenAL\OALInst.exe')})
    // If you added Creatives OpenAL Router the installer is in Program Files x32 so you will only see this if it's installed and if you shift.
    // Use this if you want to get rid of wrap_oal.dll. You can keep this installed with OpenAlSoft's router if you wanted.
    
    sep()

    item(title='Add default DSOAL config to @quote(sel.path.title)' keys='Local' type='directory|back.dir|file' where= !loc_exists && ad_cond  image=[[\uE02C,image.color1],[\uE084, image.color2]] tip='Adds default config with HRTF, hold shift for without HRTF' admin cmd= if(keys.shift(), io.copy('@ds_path\DSOAL\Win32\alsoft.ini', sel.dir, 2), io.copy('@ds_path\DSOAL+HRTF\Win32\alsoft.ini', sel.dir, 2)))
    // Adds a config to game directory, will take priority over the global one

    item(title='Open @quote(sel.path.title) DSOAL Config' keys='Local' type='directory|back.dir|file' image=\uE0FA where=loc_exists && '@sel.dir'!='@user.appdata\OpenAL' && ad_cond cmd=path.combine(sel.dir, 'alsoft.ini'))
    // Opens the local config in current folder

    item(title='Open User DSOAL Config' keys='Global' where=path.exists(@ds_globcon) && path.exists(@ds_path) image=\uE0FE cmd='@ds_globcon')
    // Opens the global config

    item(title='Open Alsoft-Config Tool' where=path.exists(@ds_path) sep='before' tip='Tool to help you setup a personalized OpenAlSoft Global Config and much more' image=\uE0DD admin cmd-line='/c set "__COMPAT_LAYER=DpiUnaware" && "@sys.prog\\DSOALOpenALSoft\\OpenALSoft\\alsoft-config\\alsoft-config.exe"')
    // The tool isn't DPI Aware so it is shrunk and unusable if you have a high dpi display so I only set it DpiUnaware for process runtime to prevent any reg setting conflictions and unneccessary long code. If you have a lower dpi screen it might just look a little worse is all but still usable.@sys.prog\DSOALOpenALSoft\OpenALSoft\alsoft-config\alsoft-config.exe
    // Is a UI tool to easily configure a local or global config, just set it how you like and save the config where you want.

    item(title='View OpenAL-Info Tool' where=path.exists(@ds_path) image=[\uE0AD, image.color2] tip='Opens 32-bit version by default, hold shift for 64-bit version.' cmd-line=if(keys.shift(), '/k openal-info64.exe', '/k openal-info32.exe') dir='@sys.prog\DSOALOpenALSoft\OpenALSoft') 
    // Tool for problem solving. 32-bit version shows you your OpenAL-Info that affects 32-bit apps. 64-bit version for OpenAL-Info affecting 64-bit apps.

    item(title='Run Registry Patcher Fix' where=rp_exists image=\uE0F8 cmd='@sys.prog\DSOALOpenALSoft\RegistryPatcher\DirectSound Wrapper Registry Patcher.cmd')
    //https://www.indirectsound.com/registryIssues.html

}
 


/*
ini file default configs:

dsound.ini example:
Buffers=4
Duration=25
MaxVoiceCount=128
DisableDirectMusic=0

alchemy.ini example:
[Condemned]
RegPath=
GamePath=F:\SteamLibrary\steamapps\common\Condemned Criminal Origins
SubDir=
RootDirInstallOption=FALSE
Buffers=4
Duration=25
MaxVoiceCount=128
DisableDirectMusic=FALSE

Preset=1 Does all the same settings as the example above so I used that to simplify the process

To Do:
item(title='Download X3DAudio HRTF' image=\uE0BD where=!path.exists('@sys.prog\DSOALOpenALSoft\X3DAudio_HRTF')
admin cmd-ps=`$DownloadURL = 'https://github.com/ThreeDeeJay/x3daudio1_7_hrtf/releases/download/v2.4.1.0.28/xaudio_hrtf_2.4.1.0.28_Win32.7z'`)
item(title='Add X3DAudio HRTF to @quote(sel.path.title)')
*/
