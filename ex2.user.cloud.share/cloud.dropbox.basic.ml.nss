// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/
// To-Do: Currently i am using "Microsoft OneDrive Free Plan", need information about "OneDrive Basic/Personal/Family"

// Change the menu name of the "Dropbox" menu if you want
$menu_db_name = 'Dropbox'
$menu_db_external_mod = false
menu(title=menu_db_name mode='multiple' where=!menu_db_external_mod image=\uE09C) { }

$path_db_dll = reg.get('HKCR\CLSID\{ECD97DE5-3C8F-4ACB-AEEE-CCAB78F7711C}\InprocServer32')
$path_db_dir = reg.get('HKCR\CLSID\{E31EA727-12ED-4702-820C-4B6445F28E1A}\Instance\InitPropertyBag','TargetFolderPath')

modify(menu=menu_db_name image=icon.res(path_db_dll, 0) where=this.title(
	// "Move to Dropbox"
	eval(str.res(path_db_dll, -224)),
	// "Move to Dropbox (Business)"
	eval(str.res(path_db_dll, -225)),
	// "Back up to Dropbox..."
	eval(str.res(path_db_dll, -232)),
	// "Copy Dropbox &link"
	eval(str.res(path_db_dll, -214)),
	// "Transfer a copy..." "Send with Dropbox Transfer"
	eval(str.res(path_db_dll, -226)),
	// "Transfer a copy (Business)" "Send with Dropbox Transfer (Business)"
	eval(str.res(path_db_dll, -227)),
	// "&Share..."
	eval(str.res(path_db_dll, -210)),
	// "Manage folder access"
	eval(str.res(path_db_dll, -249)),
	// "Manage file access"
	eval(str.res(path_db_dll, -248)),
	// "Manage hard drive space"
	eval(str.res(path_db_dll, -239)),
	// "View on &Dropbox.com" "View in &Dropbox"
	eval(str.res(path_db_dll, -212)),
	// "Send for signature"
	eval(str.res(path_db_dll, -231)),
	// "Request files..."
	eval(str.res(path_db_dll, -233)),
	// "Version history"
	eval(str.res(path_db_dll, -218)),
	// "Make available offline"
	eval(str.res(path_db_dll, -216)),
	// "Make online-only"
	eval(str.res(path_db_dll, -217)),
	//  "Don't sync to Dropbox.com" (https://help.dropbox.com/sync/ignored-files)
	eval(str.res(path_db_dll, -240)),
	// "Sync to Dropbox.com"
	eval(str.res(path_db_dll, -241))
))

/* information for further use
	https://gist.github.com/midrare/f10f230c4c78d15fec120741d1def8fa

	remove(clsid='
		{ECD97DE5-3C8F-4ACB-AEEE-CCAB78F7711C}| // ContextMenuHandler
		{FBC9D74C-AF55-4309-9FB2-C426E071637F}| // DropboxCopyHook

		DropboxExt: .binder .dbx-backup .dbx-external-drive .dbx-passwords .dbx-vault .paper .papert
		{FB314ED9-A251-47B7-93E1-CDD82E34AF8B}|
		{FB314EDA-A251-47B7-93E1-CDD82E34AF8B}|
		{FB314EDB-A251-47B7-93E1-CDD82E34AF8B}|
		{FB314EDC-A251-47B7-93E1-CDD82E34AF8B}|
		{FB314EDD-A251-47B7-93E1-CDD82E34AF8B}|
		{FB314EDE-A251-47B7-93E1-CDD82E34AF8B}|
		{FB314EDF-A251-47B7-93E1-CDD82E34AF8B}|
		{FB314EE0-A251-47B7-93E1-CDD82E34AF8B}|
		{FB314EE1-A251-47B7-93E1-CDD82E34AF8B}|
		{FB314EE2-A251-47B7-93E1-CDD82E34AF8B}|

		desktop3:Verb
		{F3BC3DAF-431B-4F0E-B105-E9BB76335840}|	// <desktop3:Verb Id="Dropbox01UpgradeCommand"/>
		{7F4C5B83-2680-40AF-9AE9-2161AA759EF2}|	// <desktop3:Verb Id="Dropbox02ShareCommand"/>			"&Share..."
		{5B08737B-ABBA-47F5-B30E-F09D24936792}|	// <desktop3:Verb Id="Dropbox03BrowseCommand"/>			"View in &Dropbox"
		{3340B3D7-438C-4FC9-81BF-8D9D81B05730}|	// <desktop3:Verb Id="Dropbox04CopyLinkCommand"/> 		"Copy Dropbox &link"
		{E6903B9A-4B63-4E3F-AA55-7F3A10DBB0CD}|	// <desktop3:Verb Id="Dropbox05RecallCommand"/>
		{0430E2DE-632B-4AD1-8F62-A53D61AE9C63}|	// <desktop3:Verb Id="Dropbox06EvictCommand"/>
		{C36518B0-11CD-40D6-B932-170857D4372B}|	// <desktop3:Verb Id="Dropbox07SyncNowCommand"/>
		{6B1D84A8-94F1-402C-99A4-11A124C8D9C9}|	// <desktop3:Verb Id="Dropbox08HistoryCommand"/>		"Version history"
		{4A44CAD7-6868-443B-9CFB-5F559C6A9493}|	// <desktop3:Verb Id="Dropbox09LockCommand"/>
		{3BE3580D-276A-4304-B39F-C64A32CE5D4E}|	// <desktop3:Verb Id="Dropbox10UnlockCommand"/>
		{DF6BE21B-3501-4D6D-A3C8-3BE1F15C501F}|	// <desktop3:Verb Id="Dropbox11LockVaultCommand"/>
		{69CCED92-A3BF-44C6-9C54-BC0D6D3EF212}|	// <desktop3:Verb Id="Dropbox12UnlockVaultCommand"/>
		{014C361B-BA8A-4D2F-A281-8EB837002EC1}|	// <desktop3:Verb Id="Dropbox13SignCommand"/>			"Send for signature"
		{EC4F2D9F-847C-4923-898C-073AAB74EFE0}|	// <desktop3:Verb Id="Dropbox14RequestFilesCommand"/>
		{28C8436D-F17B-4388-B097-B5F8C3681D1B}|	// <desktop3:Verb Id="Dropbox15ManageBackupCommand"/>
		{419D5796-E6AB-4761-AA5B-185C4B26DE74}|	// <desktop3:Verb Id="Dropbox16PauseBackupCommand"/>
		{84D423F5-D599-4F0C-8DDD-93BF146EF6AF}|	// <desktop3:Verb Id="Dropbox17ResumeBackupCommand"/>
		{89370F74-CECE-4591-899F-43F2C99D4F13}|	// <desktop3:Verb Id="Dropbox18IgnoreCommand"/>
		{A8B20E50-2D95-43C6-BDAC-1B00C4721A2F}|	// <desktop3:Verb Id="Dropbox19UnignoreCommand"/>

		desktop4:Verb Type="*"
		{95C5E6AC-93FA-4234-8301-1B3D5424AA6B}|	// <desktop4:Verb Id="Dropbox1MoveCommand"/>			dub "Move to Dropbox"
		{646E22C5-CD0B-44CE-9570-82165CCDA505}|	// <desktop4:Verb Id="Dropbox1MoveWorkCommand"/>		dub "Move to Dropbox (Business)"
		{8BAA20BD-6EE8-40B6-A512-8B2C8A1B2935}|	// <desktop4:Verb Id="Dropbox2TransferCommand"/>		dub "Send with Dropbox Transfer"
		{B165B4C7-D18D-4C23-B46C-380E219BA5B9}|	// <desktop4:Verb Id="Dropbox2TransferWorkCommand"/>	dub "Send with Dropbox Transfer (Business)"
		{67CA84CB-DE8C-47EE-9F3B-48123B1C634C}|	// <desktop4:Verb Id="Dropbox3SetupBackupCommand"/>		dub

		desktop5:Verb Type="Directory"
		{95C5E6AC-93FA-4234-8301-1B3D5424AA6B}|	// <desktop5:Verb Id="Dropbox1MoveCommand"/>			dub "Move to Dropbox"
		{646E22C5-CD0B-44CE-9570-82165CCDA505}|	// <desktop5:Verb Id="Dropbox1MoveWorkCommand"/>		dub "Move to Dropbox (Business)"
		{8BAA20BD-6EE8-40B6-A512-8B2C8A1B2935}|	// <desktop5:Verb Id="Dropbox2TransferCommand"/>		dub "Send with Dropbox Transfer"
		{B165B4C7-D18D-4C23-B46C-380E219BA5B9}|	// <desktop5:Verb Id="Dropbox2TransferWorkCommand"/>	dub "Send with Dropbox Transfer (Business)"
		{67CA84CB-DE8C-47EE-9F3B-48123B1C634C}|	// <desktop5:Verb Id="Dropbox3SetupBackupCommand"/>		dub

		{F2E24DC6-8D56-48C4-A2D2-0F47209B7959}|	// <desktop3:ThumbnailProviderHandler/> Thumbnail Provider
		{67233DFC-D70F-4D8E-A068-6877D86826BC}|	// <com:SurrogateServer
		{19F019BC-DF27-48C0-B4FF-DC13D7F97540}|	// <com:Class/> Copy Hook
	' where=this.isuwp)

	// Dropbox help-menu to display command titles and their indexes, if needed to add new item index
	menu(menu=menu_db_name title='Helper' where=str.contains(sel, path_db_dir) pos='bottom' vis=0) {
		item(tip=100 title=eval(str.res(path_db_dll, -100)) where=len(eval(str.res(path_db_dll, -100)))>0)
		sep
		item(tip=210 title=eval(str.res(path_db_dll, -210)) where=len(eval(str.res(path_db_dll, -210)))>0)
		item(tip=211 title=eval(str.res(path_db_dll, -211)) where=len(eval(str.res(path_db_dll, -211)))>0 vis=0) // tip
		item(tip=212 title=eval(str.res(path_db_dll, -212)) where=len(eval(str.res(path_db_dll, -212)))>0)
		item(tip=213 title=eval(str.res(path_db_dll, -213)) where=len(eval(str.res(path_db_dll, -213)))>0 vis=0) // tip
		item(tip=214 title=eval(str.res(path_db_dll, -214)) where=len(eval(str.res(path_db_dll, -214)))>0)
		item(tip=215 title=eval(str.res(path_db_dll, -215)) where=len(eval(str.res(path_db_dll, -215)))>0 vis=0) // tip
		item(tip=216 title=eval(str.res(path_db_dll, -216)) where=len(eval(str.res(path_db_dll, -216)))>0)
		item(tip=217 title=eval(str.res(path_db_dll, -217)) where=len(eval(str.res(path_db_dll, -217)))>0)
		item(tip=218 title=eval(str.res(path_db_dll, -218)) where=len(eval(str.res(path_db_dll, -218)))>0)
		item(tip=219 title=eval(str.res(path_db_dll, -219)) where=len(eval(str.res(path_db_dll, -219)))>0 vis=0) // tip
		item(tip=220 title=eval(str.res(path_db_dll, -220)) where=len(eval(str.res(path_db_dll, -220)))>0)
		item(tip=221 title=eval(str.res(path_db_dll, -221)) where=len(eval(str.res(path_db_dll, -221)))>0)
		item(tip=222 title=eval(str.res(path_db_dll, -222)) where=len(eval(str.res(path_db_dll, -222)))>0)
		item(tip=223 title=eval(str.res(path_db_dll, -223)) where=len(eval(str.res(path_db_dll, -223)))>0)
		sep
		item(tip=224 title=eval(str.res(path_db_dll, -224)) where=len(eval(str.res(path_db_dll, -224)))>0)
		item(tip=225 title=eval(str.res(path_db_dll, -225)) where=len(eval(str.res(path_db_dll, -225)))>0)
		item(tip=226 title=eval(str.res(path_db_dll, -226)) where=len(eval(str.res(path_db_dll, -226)))>0)
		item(tip=227 title=eval(str.res(path_db_dll, -227)) where=len(eval(str.res(path_db_dll, -227)))>0)
		item(tip=228 title=eval(str.res(path_db_dll, -228)) where=len(eval(str.res(path_db_dll, -228)))>0)
		item(tip=229 title=eval(str.res(path_db_dll, -229)) where=len(eval(str.res(path_db_dll, -229)))>0)
		item(tip=230 title=eval(str.res(path_db_dll, -230)) where=len(eval(str.res(path_db_dll, -230)))>0)
		item(tip=231 title=eval(str.res(path_db_dll, -231)) where=len(eval(str.res(path_db_dll, -231)))>0)
		item(tip=232 title=eval(str.res(path_db_dll, -232)) where=len(eval(str.res(path_db_dll, -232)))>0)
		item(tip=233 title=eval(str.res(path_db_dll, -233)) where=len(eval(str.res(path_db_dll, -233)))>0)
		item(tip=234 title=eval(str.res(path_db_dll, -234)) where=len(eval(str.res(path_db_dll, -234)))>0)
		item(tip=235 title=eval(str.res(path_db_dll, -235)) where=len(eval(str.res(path_db_dll, -235)))>0)
		item(tip=236 title=eval(str.res(path_db_dll, -236)) where=len(eval(str.res(path_db_dll, -236)))>0)
		item(tip=237 title=eval(str.res(path_db_dll, -237)) where=len(eval(str.res(path_db_dll, -237)))>0)
		item(tip=238 title=eval(str.res(path_db_dll, -238)) where=len(eval(str.res(path_db_dll, -238)))>0)
		item(tip=239 title=eval(str.res(path_db_dll, -239)) where=len(eval(str.res(path_db_dll, -239)))>0)
		sep
		item(tip=240 title=eval(str.res(path_db_dll, -240)) where=len(eval(str.res(path_db_dll, -240)))>0 vis=0) // dub
		item(tip=241 title=eval(str.res(path_db_dll, -241)) where=len(eval(str.res(path_db_dll, -241)))>0 vis=0) // dub
		item(tip=242 title=eval(str.res(path_db_dll, -242)) where=len(eval(str.res(path_db_dll, -242)))>0 vis=0) // dub
		item(tip=243 title=eval(str.res(path_db_dll, -243)) where=len(eval(str.res(path_db_dll, -243)))>0 vis=0) // dub
		item(tip=244 title=eval(str.res(path_db_dll, -244)) where=len(eval(str.res(path_db_dll, -244)))>0)
		item(tip=245 title=eval(str.res(path_db_dll, -245)) where=len(eval(str.res(path_db_dll, -245)))>0)
		item(tip=246 title=eval(str.res(path_db_dll, -246)) where=len(eval(str.res(path_db_dll, -246)))>0)
		item(tip=247 title=eval(str.res(path_db_dll, -247)) where=len(eval(str.res(path_db_dll, -247)))>0)
		item(tip=248 title=eval(str.res(path_db_dll, -248)) where=len(eval(str.res(path_db_dll, -248)))>0)
		item(tip=249 title=eval(str.res(path_db_dll, -249)) where=len(eval(str.res(path_db_dll, -249)))>0)
		item(tip=250 title=eval(str.res(path_db_dll, -250)) where=len(eval(str.res(path_db_dll, -250)))>0)
		item(tip=251 title=eval(str.res(path_db_dll, -251)) where=len(eval(str.res(path_db_dll, -251)))>0)} 

*/