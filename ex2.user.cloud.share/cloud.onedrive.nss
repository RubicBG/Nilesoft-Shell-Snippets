// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/
// To-Do: Currently i am using "Microsoft OneDrive Free Plan", need information about "OneDrive Basic/Personal/Family"

// Change the menu name of the "OneDrive" menu if you want
$menu_od_name = 'OneDrive'
$menu_od_external_mod = false
menu(title=menu_od_name mode='multiple' where=!menu_od_external_mod image=\uE09C) { }

$path_od_dll = reg.get('HKCU\Software\Microsoft\OneDrive', 'CurrentVersionPath') + '\FileSync.LocalizedResources.dll'
$path_od_exe = reg.get('HKCU\Software\Microsoft\OneDrive', 'OneDriveTrigger')
$path_od_dir = reg.get('HKCU\Software\Microsoft\OneDrive', 'UserFolder')
$path_od_vlt = reg.get('HKCU\Software\Microsoft\OneDrive\Accounts\Personal', 'VaultShortcutPath')

$svg_od_win = '<svg width="100" height="100" viewBox="-1.13 4.72 34.05 21.46">
	<path d="M12.202 11.193v-.001l6.718 4.024 4.003-1.685A6.477 6.477 0 0 1 25.5 13c.148 0 .294.007.439.016a10 10 0 0 0-18.041-3.013L8 10a7.96 7.96 0 0 1 4.202 1.193z" fill="#0364b8"/>
	<path d="M12.203 11.192A7.96 7.96 0 0 0 8 10l-.102.003a7.997 7.997 0 0 0-6.46 12.57L7.36 20.08l2.634-1.108 5.863-2.468 3.062-1.288z" fill="#0078d4"/>
	<path d="M25.939 13.016A6.577 6.577 0 0 0 25.5 13a6.477 6.477 0 0 0-2.576.532l-4.004 1.684 1.161.695 3.805 2.279 1.66.994 5.677 3.4a6.5 6.5 0 0 0-5.284-9.568z" fill="#1490df"/>
	<path d="M25.546 19.184l-1.66-.994-3.805-2.28-1.16-.694-3.063 1.288-5.863 2.468L7.36 20.08l-5.924 2.493A7.989 7.989 0 0 0 8 26h17.5a6.498 6.498 0 0 0 5.723-3.416z" fill="#28a8ea"/></svg>'
$ico_od_win = icon.res(path_od_exe, 0)

$is_obp = str.contains(sel, path_od_dir)
$is_obv = str.equals(sel, path_od_vlt)

modify(menu=menu_od_name image=icon.share where=!is_obp && this.title==
	// "&Share"
	eval(str.res(path_od_dll, -9622)))
modify(menu=menu_od_name image=svg_od_win where= is_obp && this.title(
	// "&Share"
	eval(str.res(path_od_dll, -9622)),
	// "Copy Link"
	eval(str.res(path_od_dll, -9649))
	))

modify(menu=menu_od_name image=svg_od_win where= this.title==
	// "&Move to OneDrive"
	eval(str.res(path_od_dll, -9643)))
modify(menu=menu_od_name image=svg_od_win where= is_obp && this.title(
	// "&Always keep on this device" - pinned
	eval(str.res(path_od_dll, -9637)), eval(str.res(path_od_dll, -9637).trimstart('&')),
	// "&Free up space"
	eval(str.res(path_od_dll, -9636)), eval(str.res(path_od_dll, -9636).trimstart('&')),
	// "&View online"
	eval(str.res(path_od_dll, -9618)),
	// "&Version history"
	eval(str.res(path_od_dll, -9642)),
	// "Manage access"
	eval(str.res(path_od_dll, -9650)),
	// "Manage OneDrive backup"
	eval(str.res(path_od_dll, -9645)),
	// "Settings"
	eval(str.res(path_od_dll, -9638)),
	// "Folder color"
	eval(str.res(path_od_dll, -53002))
	))
// Storage %d%% full - Upgrade (tested with english language only)
modify(menu=menu_od_name where= str.contains(this.title, eval(str.left(str.res(path_od_dll, -51550), str.find(str.res(path_od_dll, -51550), '%d%')))) and
	str.contains(this.title, eval(str.right(str.res(path_od_dll, -51550), str.len(str.res(path_od_dll, -51550)) - str.find(str.res(path_od_dll, -51550), '%d%') - 3))))
// "Lock %1"; "Unlock %1" (tested with english language only)
modify(menu=menu_od_name image=svg_od_win where= is_obv find='@str.replace(eval(str.res(path_od_dll, -9639)),'%1','*')||@str.replace(eval(str.res(path_od_dll, -9640)),'%1','*')')

/* information for further use
	o	9617, 	"&More OneDrive sharing options" (OneDrive Business)
	o	9618, 	"&View online"
		9619, 	"View sync &problems"
	+	9622, 	"&Share"
		9623, 	"Sync anyway"
	o	9630, 	"Share a OneDrive link"
	o	9631, 	"Choose OneDrive folders to sync"

		9648, 	"M&ove to OneDrive - Personal"
	+	9649, 	"Copy Link"
	+	9650, 	"Manage access"
		9651, 	"Stop Sync"

	+	9636, 	"&Free up space"
	+	9637, 	"&Always keep on this device"
	+	9638, 	"Settings"
	+	9639, 	"Lock %1"
	+	9640, 	"Unlock %1"
		9641, 	"&Preview with OneDrive"
	+	9642, 	"&Version history"
	+	9643, 	"&Move to OneDrive"
		9644, 	"OneDrive - Personal"
	+	9645, 	"Manage OneDrive backup"
		9646, 	"Remove shortcut" (https://support.microsoft.com/en-au/office/onedrive-sync-app-error-unable-to-sync-shortcut-aee9955f-f7de-4be8-bf5e-48375bad9dd3)
		9647, 	"&Move to %1"

		53002, 	"Folder color"

		10540	Storage %d%% full - Get more
		10541	Storage %d%% full - Manage storage
	+	51550	Storage %d%% full - Upgrade
		10542	Storage full - Get more
		10543	Storage full - Manage storage
		51551	Storage full - Upgrade
*/
