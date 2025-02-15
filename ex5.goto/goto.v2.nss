// Author: Rubic / RubicBG
// Based on: Nilesoft Shell original snippet
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

menu(type='*' where=window.is_taskbar||sel.count mode=mode.multiple title=title.go_to+"\t"+'v2.0' image=\uE14A)
{
	menu(title='Folder' image=\uE1F4)
	{
		item(image=inherit title='Windows' cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(sys.dir), sys.dir))
		item(image=inherit title='System' cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(sys.bin), sys.bin))
		item(image=inherit title='Program Files' cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(sys.prog), sys.prog))
		item(image=inherit title='Program Files x86' cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(sys.prog32), sys.prog32))
		item(image=inherit title='ProgramData' cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(sys.programdata), sys.programdata))
		item(image=inherit title='Applications' cmd='shell:appsfolder')
		item(image=inherit title='Users' cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(sys.users), sys.users))
		separator
		//item(title='@user.name@@@sys.name' vis=label)
		item(image=inherit title='Desktop' cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(user.desktop), user.desktop))
		item(image=inherit title='Downloads' cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(user.downloads), user.downloads))
		item(image=inherit title='Pictures' cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(user.pictures), user.pictures))
		item(image=inherit title='Documents' cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(user.documents), user.documents))
		item(image=inherit title='Startmenu' cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(user.startmenu), user.startmenu))
		item(image=inherit title='Profile' cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(user.dir), user.dir))
		item(image=inherit title='AppData' cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(user.appdata), user.appdata))
		item(image=inherit title='Temp' cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(user.temp), user.temp))
	}
	item(image=\uE0F3 title=title.control_panel cmd='shell:::{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}')
	item(image=\uE0F3 title='All Control Panel Items' cmd='shell:::{ED7BA470-8E54-465E-825C-99712043E01C}')
	item(image=\uE14B title=title.run cmd='shell:::{2559a1f3-21d7-11d4-bdaf-00c04f60b9f0}')
	menu(image=\uE0F3 where=sys.ver.major >= 10 title=title.settings sep=sep.before)
	{
		// https://docs.microsoft.com/en-us/windows/uwp/launch-resume/launch-settings-app
		item(image=inherit title='system' cmd='ms-settings:')
		item(image=inherit title='about' cmd='ms-settings:about')
		item(image=inherit title='your-info' cmd='ms-settings:yourinfo')
		item(image=inherit title='system-info' cmd-line='/K systeminfo')
		item(image=inherit title='search' cmd='search-ms:')
		item(image=inherit title='usb' cmd='ms-settings:usb')
		item(image=inherit title='windows-update' cmd='ms-settings:windowsupdate')
		item(image=inherit title='windows-defender' cmd='ms-settings:windowsdefender')
		menu(image=inherit title='apps')
		{
			item(image=inherit title='apps-features' cmd='ms-settings:appsfeatures')
			item(image=inherit title='default-apps' cmd='ms-settings:defaultapps')
			item(image=inherit title='optional-features' cmd='ms-settings:optionalfeatures')
			item(image=inherit title='startup' cmd='ms-settings:startupapps')
		}
		menu(image=inherit title='personalization')
		{
			item(image=inherit title='personalization' cmd='ms-settings:personalization')
			item(image=inherit title='lockscreen' cmd='ms-settings:lockscreen')
			item(image=inherit title='background' cmd='ms-settings:personalization-background')
			item(image=inherit title='colors' cmd='ms-settings:colors')
			item(image=inherit title='themes' cmd='ms-settings:themes')
			item(image=inherit title='start' cmd='ms-settings:personalization-start')
			item(image=inherit title='taskbar' cmd='ms-settings:taskbar')
		}
		menu(image=inherit title='network')
		{
			item(image=inherit title='status' cmd='ms-settings:network-status')
			item(image=inherit title='ethernet' cmd='ms-settings:network-ethernet')
			item(image=inherit title='connections' cmd='shell:::{7007ACC7-3202-11D1-AAD2-00805FC1270E}')
		}
	}
}