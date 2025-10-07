// Author: Rubic / RubicBG
// Enhanced Security and Permissions Menu for Nilesoft Shell
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/
// To-Do: Check "Fix Access Issues (Recommended)" one more time
// To-Do: Make "Restore from Backup" command
// To-Do: Check where to add more restrictions

menu(title='Security and Permissions' type='file|dir|back.dir' image=[\uE194,#f00]) {	
	//> https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/takeown
	//> https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/icacls
	//> https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/manage/understand-security-identifiers
	//> https://learn.microsoft.com/en-us/windows/win32/secauthz/well-known-sids
	//+ https://system32.eventsentry.com/codes/field/Well-known%20Security%20Identifiers%20(SIDs)
	//- https://codingfreaks.de/posh-acl/
	
	// Dynamic variables for better code reusability
	$icacls_switch = if(sel.type!=1 and keys.shift(), ' /t') + ' /c /l /q'
	// $icacls_switch_drrives = '@if(sel.type==1, ' /c /l')@if(sel.type==3, '@if(keys.shift(), ' /t') /c /l')@if(sel.type==5, '@if(keys.shift(), ' /t') /c /l')'
	$rec_info = if(sel.type!=1, 'SHIFT recursive')
	
	menu(title='Quick Actions'  type='file|dir|back.dir|drive' expanded=1) {
		/* Most common action - fixes 90% of permission issues
		item(keys=rec_info title='Fix Access Issues (Recommended)' image=[\uE192, #ff0000]
			tip='Complete fix: Takes ownership + grants admin access + enables inheritance@"\n"Solves most "Access Denied" problems'
			admin cmd-line='/k echo [1/3] Taking ownership of "@sel.name"... & takeown /f @sel.path(true) @if(sel.type!=1, '/r /d y') & echo [2/3] Granting admin permissions... & icacls @sel.path(true) /grant *S-1-5-32-544:F @icacls_switch & echo [3/3] Enabling inheritance... & icacls @sel.path(true) /inheritance:e & echo ✓ All fixes completed successfully! & pause & exit')
		*/
		// Quick ownership - simpler version
		//- https://winaero.com/add-take-ownership-context-menu-windows-10/
		//- https://www.majorgeeks.com/content/page/take_full_ownership_of_files_folders.html
		// Uses SID S-1-5-32-544 (Administrators) for reliable cross-language support
		item(keys=rec_info title='Grant Full Control' image=[\uE193, #ff0000]
			tip='Takes ownership and grants full control to Administrators group'
			// admin cmd args='/k takeown /f "@sel.path" @if(sel.type==1,null,"/r /d y") && icacls "@sel.path" /grant *S-1-5-32-544:F @if(sel.type==1,"/c /l","/t /c /l /q")')
			admin cmd-line='/k echo Taking ownership of "@sel.name"... && takeown /f @sel(true) @if(sel.type!=1, '/r /d y') && echo Granting permissions... && icacls @sel(true) /grant *S-1-5-32-544:F @if(sel.type!=1 and keys.shift(), '/t') /c /l /q && pause && exit')
		// Just take ownership
		item(title='Take Ownership Only' image=\uE100
			tip='Just takes ownership without changing permissions@"\n"Use when you only need to become the owner'
			admin cmd-line='/k echo Taking ownership of "@sel.name"... & takeown /f @sel.path(true) @if(sel.type!=1, '/r /d y') & echo ✓ Ownership transferred! & pause & exit')
		// Reset to Windows defaults
		// https://winaero.com/add-reset-permissions-context-menu-windows-10/
		item(keys=rec_info title='Reset to Windows Defaults' image=[[\uE094],[\uE002, color.red]]
			tip='Removes all custom permissions and restores Windows defaults@"\n"Use when permissions are completely broken'
			admin cmd-line='/k echo Resetting "@sel.name" to Windows defaults... & icacls @sel.path(true) /reset @icacls_switch & echo ✓ Reset to defaults completed! & pause & exit')
		// View permissions without changes
		item(title='View Current Permissions' image=\uE186
			tip='Shows who has what access to this item@"\n"Read-only operation - makes no changes'
			cmd-line='/k echo Current permissions for "@sel.name": & echo. & icacls @sel.path(true) & echo. & pause & exit') }
	separator()
	$svg_change_owner = image.svg('<svg viewBox="0 0 52 52">
  		<path fill="@image.color1" d="M27.3 37.6c-3-1.2-3.5-2.3-3.5-3.5s.8-2.3 1.8-3.2c1.8-1.5 2.6-3.9 2.6-6.4 0-4.7-2.9-8.5-8.3-8.5s-8.3 3.8-8.3 8.5c0 2.5.8 4.9 2.6 6.4 1 .9 1.8 2 1.8 3.2s-.5 2.3-3.5 3.5c-4.4 1.8-8.6 3.8-8.7 7.6C4 47.8 6 50 8.5 50h23c2.5 0 4.5-2.2 4.5-4.7-.1-3.8-4.3-5.9-8.7-7.7"/>
  		<path fill="@image.color2" d="M44.5 19c0-7.4-6.1-13.5-13.5-13.5V2l-6.8 5.5c-.3.3-.2.8.1 1.1L31 14v-3.5c4.7 0 8.5 3.8 8.5 8.5H36l5.5 6.8c.3.3.8.3 1.1 0L48 19z"/></svg>')
	menu(title='Change Owner' image=svg_change_owner type='file|dir|back.dir' 
		// Safety check - prevent changing ownership of critical system folders
		where=!str.contains('@sys.root\|@sys.users|@sys.prog|@sys.prog32|@sys.programdata|@sys.dir|@sys.bin|', sel.path+'|')) {
		// Most common ownership changes
		item(keys=rec_info title='Current User'
			tip='Makes you the owner of this item@"\n"Best choice for personal files and folders'
			admin cmd-line='/k echo Changing owner to %USERNAME%... & icacls @sel.path(true) /setowner "%USERNAME%" @icacls_switch & echo ✓ You are now the owner! & pause & exit')
		separator()
		item(keys=rec_info title='Administrators Group'
			tip='Makes the Administrators group the owner@"\n"Good for shared system files'
			admin cmd-line='/k echo Changing owner to Administrators... & icacls @sel.path(true) /setowner *S-1-5-32-544 @icacls_switch & echo ✓ Administrators now own this item! & pause & exit')
		item(keys=rec_info title='System Account'
			tip='NT AUTHORITY\SYSTEM - highest privilege account@"\n"Use for system-level files only'
			admin cmd-line='/k echo Changing owner to System... & icacls @sel.path(true) /setowner "System" @icacls_switch & echo ✓ System account is now owner! & pause & exit')
		item(keys=rec_info title='TrustedInstaller'
			tip='Windows component installer account@"\n"Used for core Windows files - use with extreme caution'
			admin cmd-line='/k echo Changing owner to TrustedInstaller... & icacls @sel.path(true) /setowner *S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464 @icacls_switch & echo ✓ TrustedInstaller is now owner! & pause & exit')
		separator()
		item(keys=rec_info title='Everyone Group'
			tip='WARNING: Makes Everyone the owner@"\n"Rarely recommended - use with caution!'
			admin cmd-line='/k echo WARNING: Setting owner to Everyone... & pause & icacls @sel.path(true) /setowner *S-1-1-0 @icacls_switch & echo ✓ Everyone group is now owner! & pause & exit')
		item(keys=rec_info title='Network Service'
			tip='For network-related services and applications'
			admin cmd-line='/k echo Changing owner to Network Service... & icacls @sel.path(true) /setowner *S-1-5-20 @icacls_switch & echo ✓ Network Service is now owner! & pause & exit') }
	menu(title='Manage Permissions' type='file|dir|back.dir' image=\uE195) {
		item(keys=rec_info title='Full Control to Current User' image=[\uE1D2, image.color2]
			tip='Gives you complete control over this item@"\n"Recommended for your own files'
			admin cmd-line='/k echo Granting full control to %USERNAME%... & icacls @sel.path(true) /grant "Users:F" @icacls_switch & echo ✓ Full control granted! & pause & exit')
		item(keys=rec_info title='Modify Access to Users' image=[\uE1D2, image.color2]
			tip='Lets all users read, write, and delete but not change permissions@"\n"Good for shared folders'
			admin cmd-line='/k echo Granting modify access to Users... & icacls @sel.path(true) /grant "Users:M" @icacls_switch & echo ✓ Modify access granted to Users! & pause & exit')
		item(keys=rec_info title='Read-Only to Everyone' image=[\uE1D2, image.color2]
			tip='Everyone can read and open but cannot modify@"\n"Safe for sharing documents'
			admin cmd-line='/k echo Granting read access to Everyone... & icacls @sel.path(true) /grant "Everyone:R" @icacls_switch & echo ✓ Read access granted to Everyone! & pause & exit')
		separator()
		item(keys=rec_info title='IIS Web Server Access' image=[\uE1D2, image.color1]
			tip='For web server files and folders@"\n"Needed for websites and web applications'
			admin cmd-line='/k echo Granting IIS access... & icacls @sel.path(true) /grant "IIS_IUSRS:M" @icacls_switch & echo ✓ IIS access granted! & pause & exit')
		separator()
		item(keys=rec_info title='Remove Users Access' image=[\uE1D3, #ff0000]
			tip='Removes all permissions for the Users group@"\n"Makes item accessible only to Administrators'
			admin cmd-line='/k echo Removing Users access... & icacls @sel.path(true) /remove "Users" @icacls_switch & echo ✓ Users access removed! & pause & exit')
		item(keys=rec_info title='Remove Everyone Access' image=[\uE1D3, #ff0000]
			tip='Removes access for Everyone group@"\n"Increases security by limiting access'
			admin cmd-line='/k echo Removing Everyone access... & icacls @sel.path(true) /remove "Everyone" @icacls_switch & echo ✓ Everyone access removed! & pause & exit') }
	menu(title='Inheritance Settings' image=\uE180) {
		// https://www.majorgeeks.com/content/page/how_to_add_inherited_permissions_context_menu.html
		item(title='Enable Inheritance (Recommended)' image=[\uE180, #00ff00]
			tip='Inherits permissions from parent folder@"\n"Usually what you want - maintains permission consistency'
			cmd-line='/k icacls @sel.path(true) /inheritance:e & pause & exit')
		item(title='Disable Inheritance (Keep Current)' image=[\uE180, #FFFF00]
			tip='Stops inheriting from parent but keeps current permissions@"\n"Use when you need custom permissions'
			cmd-line='/k icacls @sel.path(true) /inheritance:d & pause & exit')
		item(title='Remove Inheritance (Delete All)' image=[\uE180, #ff0000]
			tip='Stops inheriting AND removes inherited permissions@"\n"DANGEROUS - may lock you out!'
			cmd-line='/k echo WARNING: This will remove inherited permissions! & pause & icacls @sel.path(true) /inheritance:r & pause & exit') }
	separator()
	menu(title='Advanced Tools' image=\uE15E) {
		// Information and analysis
		item(title='Detailed Permission Report' image=\uE130
			tip='Comprehensive ownership and permission analysis@"\n"Shows all security details in PowerShell'
			cmd-ps=`-NoExit "Write-Host 'DETAILED PERMISSION REPORT for @sel.name' -ForegroundColor Cyan; $acl = Get-ACL '@sel.path'; Write-Host 'Owner:' $acl.Owner -ForegroundColor Yellow; Write-Host 'Group:' $acl.Group -ForegroundColor Yellow; Write-Host ''; Write-Host 'Access Rules:' -ForegroundColor Green; $acl.Access | Format-Table IdentityReference, FileSystemRights, AccessControlType, IsInherited -AutoSize"`)
		item(title='My Effective Permissions' image=\uE130
			tip='Shows exactly what permissions you have on this item@"\n"Helps understand why you can or cannot access something'
			cmd-ps=`-NoExit "Write-Host 'YOUR EFFECTIVE PERMISSIONS for @sel.name' -ForegroundColor Cyan; $acl = Get-ACL '@sel.path'; $myPerms = $acl.Access | Where-Object {$_.IdentityReference -like '*%USERNAME%*' -or $_.IdentityReference -like '*Users*' -or $_.IdentityReference -like '*Everyone*' -or $_.IdentityReference -like '*Authenticated Users*'}; if($myPerms) {$myPerms | Format-Table IdentityReference, FileSystemRights, AccessControlType -AutoSize} else {Write-Host 'No explicit permissions found for your account.' -ForegroundColor Yellow}"`)
		item(title='Security Descriptor (SDDL)' image=\uE130
			tip='Raw security descriptor in technical format@"\n"For advanced users and troubleshooting'
			cmd-ps=`-NoExit "Write-Host 'SECURITY DESCRIPTOR (SDDL) for @sel.name' -ForegroundColor Cyan; (Get-ACL '@sel.path').Sddl"`)
		separator()
		// Backup functionality
		item(title='Backup Permissions to File'
			tip='Saves current permissions to a text file@"\n"Allows you to restore permissions later if needed'
			cmd-line='/c icacls @sel.path(true) /save "@path.file.save_box(['Text files|*.txt'], user.desktop, '@(sel.name)_permissions_backup.txt')"' window='hidden')
		/* item(title='Restore Permissions from File'
			tip='Restores permissions from a previously saved file@"\n"Use with caution - overwrites current permissions'
			cmd-line='/c icacls @sel.path(true) /restore "@path.file.box('Text files|*.txt', user.desktop, '@(sel.name)_permissions_backup.txt')" & pause & exit') */ }
	menu(title='Troubleshooting' image=\uE0F6) {	
		item(keys=rec_info title='Complete Permission Repair'
			tip='Nuclear option: Fixes all common permission problems@"\n"Use when nothing else works'
			admin cmd-line='/k echo COMPLETE PERMISSION REPAIR for "@sel.name" & echo ====================================== & echo Step 1: Taking ownership... & takeown /f @sel.path(true) @if(sel.type!=1, '/r /d y') & echo Step 2: Granting full access... & icacls @sel.path(true) /grant *S-1-5-32-544:F @icacls_switch & echo Step 3: Enabling inheritance... & icacls @sel.path(true) /inheritance:e & echo Step 4: Resetting to defaults... & icacls @sel.path(true) /reset @icacls_switch & echo ✓ COMPLETE REPAIR FINISHED! & pause & exit')
		item(keys=rec_info title='Fix Broken Inheritance Chain'
			tip='Repairs inheritance when child folders have wrong permissions@"\n"Fixes cascading permission problems'
			admin cmd-line='/k echo Repairing inheritance chain... & icacls @sel.path(true) /reset @icacls_switch & icacls @sel.path(true) /inheritance:e & echo ✓ Inheritance chain repaired! & pause & exit')
		item(keys=rec_info title='Emergency Access Restore'
			tip='Last resort: Grants you access when completely locked out@"\n"Breaks glass emergency option'
			admin cmd-line='/k echo EMERGENCY ACCESS RESTORE & echo This will give you full control! & pause & takeown /f @sel.path(true) @if(sel.type!=1, '/r /d y') & icacls @sel.path(true) /grant "%USERNAME%:F" @icacls_switch & icacls @sel.path(true) /grant *S-1-5-32-544:F @icacls_switch & echo ✓ Emergency access granted! & pause & exit') }
}

// ===============================================================================
// QUICK REFERENCE GUIDE
// ===============================================================================
// 
// PERMISSION LEVELS:
// • F  = Full Control (everything)    • M  = Modify (read/write/delete)
// • RX = Read & Execute (run files)   • R  = Read Only (view only)
// • W  = Write (create/modify)        • D  = Delete (remove only)
//
// COMMON SWITCHES FOR ICACLS:
// • /T = Recursive (subdirectories)   • /C = Continue on errors  
// • /L = Work on links themselves     • /Q = Quiet mode (less output)
//
// SAFETY TIPS:
// • Always backup permissions first   • Test on non-critical files
// • Understand inheritance effects    • Be careful with system folders
// ===============================================================================