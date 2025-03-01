menu(title='Mozilla Firefox' type='file' find='.lnk' mode='single' where=str.end(path.lnktarget(sel), 'firefox.exe') pos=indexof(quote(str.replace(title.open, '&', '')), 1) image=image.res(path.lnktarget(sel)))
{
	// https://wiki.mozilla.org/Firefox/CommandLineOptions
	// %AppData%\Mozilla\Firefox\profiles.ini
	item(title='Firefox Private Browsing' tip='Opens a new private browsing window in an existing instance of Firefox.'
		image=image.res(path.lnktarget(sel), 4) cmd=path.lnktarget(sel) args='-private-window')
	item(title='Start External Profile' tip='Start with the profile with the given path.' vis=0
		image cmd=path.lnktarget(sel) args='-profile "@path.dir.box()"')
	separator()
	item(title='Profile Mananger' tip='Start with profile manager.'
		image=\uE0FE cmd=path.lnktarget(sel) args='-ProfileManager')
	item(title='Create New Profile' keys='SHIFT Path' tip='Create a new profile in the default directory, but do not start the application. The profile will be named profile_name in the profile manager, the profile_name must not contain spaces ( ).'
		image=\uE104 cmd=if(input("Nilesoft", "Profile Name:"), path.lnktarget(sel)) args='-CreateProfile "@input.result@if(keys.shift(), ' '+path.dir.box()+input.result+'-profile')"')
	
	separator()
	$profile0=ini.get('@sys.appdata\Mozilla\Firefox\profiles.ini', 'Profile0', 'Name')
	item(title='Profile: @profile0' where=len(profile0)>0 tip='Bypass profile manager and launch application with the profile named "@Profile0". Useful for dealing with multiple profiles.'
		image=[[\uE105, color.orangered]] keys=if(ini.get('@sys.appdata\Mozilla\Firefox\profiles.ini', 'Profile0', 'Default'), 'default')
		cmd=path.lnktarget(sel) args='-P "@profile0"')
	$profile1=ini.get('@sys.appdata\Mozilla\Firefox\profiles.ini', 'profile1', 'Name')
	item(title='Profile: @profile1' where=len(profile1)>0 tip='Bypass profile manager and launch application with the profile named "@profile1". Useful for dealing with multiple profiles.'
		image=[[\uE105, color.orangered]] keys=if(ini.get('@sys.appdata\Mozilla\Firefox\profiles.ini', 'Profile1', 'Default'), 'default')
		cmd=path.lnktarget(sel) args='-P "@profile1"')
	$profile2=ini.get('@sys.appdata\Mozilla\Firefox\profiles.ini', 'profile2', 'Name')
	item(title='Profile: @profile2' where=len(profile2)>0 tip='Bypass profile manager and launch application with the profile named "@profile2". Useful for dealing with multiple profiles.'
		image=[[\uE105, color.orangered]] keys=if(ini.get('@sys.appdata\Mozilla\Firefox\profiles.ini', 'Profile2', 'Default'), 'default')
		cmd=path.lnktarget(sel) args='-P "@profile2"')
	$profile3=ini.get('@sys.appdata\Mozilla\Firefox\profiles.ini', 'profile3', 'Name')
	item(title='Profile: @profile3' where=len(profile3)>0 tip='Bypass profile manager and launch application with the profile named "@profile3". Useful for dealing with multiple profiles.'
		image=[[\uE105, color.orangered]] keys=if(ini.get('@sys.appdata\Mozilla\Firefox\profiles.ini', 'Profile3', 'Default'), 'default')
		cmd=path.lnktarget(sel) args='-P "@profile3"')
	$profile4=ini.get('@sys.appdata\Mozilla\Firefox\profiles.ini', 'profile4', 'Name')
	item(title='Profile: @profile4' where=len(profile4)>0 tip='Bypass profile manager and launch application with the profile named "@profile4". Useful for dealing with multiple profiles.'
		image=[[\uE105, color.orangered]] keys=if(ini.get('@sys.appdata\Mozilla\Firefox\profiles.ini', 'Profile4', 'Default'), 'default')
		cmd=path.lnktarget(sel) args='-P "@profile4"')						

	separator()
	$path0=if(ini.get('@sys.appdata\Mozilla\Firefox\profiles.ini', 'Profile0', 'IsRelative')==1, '@sys.appdata\Mozilla\Firefox\') + path.separator(ini.get('@sys.appdata\Mozilla\Firefox\profiles.ini', 'Profile0', 'Path'), '\')
	item(title='Backup Profile: @profile0' where=len(profile0)>0
		admin cmd=io.copy(path0, path.dir.box()+profile0))
	$path1=if(ini.get('@sys.appdata\Mozilla\Firefox\profiles.ini', 'Profile1', 'IsRelative')==1, '@sys.appdata\Mozilla\Firefox\') + path.separator(ini.get('@sys.appdata\Mozilla\Firefox\profiles.ini', 'Profile1', 'Path'), '\')
	item(title='Backup Profile: @profile1' where=len(profile1)>0
		admin cmd=io.copy(path1, path.dir.box()+profile1))
	$path2=if(ini.get('@sys.appdata\Mozilla\Firefox\profiles.ini', 'Profile2', 'IsRelative')==1, '@sys.appdata\Mozilla\Firefox\') + path.separator(ini.get('@sys.appdata\Mozilla\Firefox\profiles.ini', 'Profile2', 'Path'), '\')
	item(title='Backup Profile: @Profile2' where=len(profile2)>0
		admin cmd=io.copy(path2, path.dir.box()+Profile2))
	$path3=if(ini.get('@sys.appdata\Mozilla\Firefox\profiles.ini', 'Profile3', 'IsRelative')==1, '@sys.appdata\Mozilla\Firefox\') + path.separator(ini.get('@sys.appdata\Mozilla\Firefox\profiles.ini', 'Profile3', 'Path'), '\')
	item(title='Backup Profile: @Profile3' where=len(profile3)>0
		admin cmd=io.copy(path3, path.dir.box()+Profile3))
	$path4=if(ini.get('@sys.appdata\Mozilla\Firefox\profiles.ini', 'Profile4', 'IsRelative')==1, '@sys.appdata\Mozilla\Firefox\') + path.separator(ini.get('@sys.appdata\Mozilla\Firefox\profiles.ini', 'Profile4', 'Path'), '\')
	item(title='Backup Profile: @Profile4' where=len(profile4)>0
		admin cmd=io.copy(path4, path.dir.box()+Profile4))
	
	separator()
	// close firefox.exe
	item(title='Import Wizard' vis=key.shift() where=!process.is_started('firefox.exe') tip='Start with import wizard.'
		image=\uE0F0 cmd=path.lnktarget(sel) args='-migration')
	item(title='Set Default Browser' vis=key.shift() tip='Set the application as the default browser.'
		image=\uE0F0 cmd=path.lnktarget(sel) args='-setDefaultBrowser')
	item(title='Settings' vis=key.shift() tip='Open options/preferences window.'
		image=\uE0F0 cmd=path.lnktarget(sel) args='-preferences')
}