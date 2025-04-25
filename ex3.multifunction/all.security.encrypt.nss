// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

menu(title='Encrypt, Decrypt' type='file|dir' tip='Encrypted File System (EFS)' mode='multiple' image=\uE0BA) {
	//> https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/cipher
	//> https://www.elevenforum.com/t/encrypt-or-decrypt-files-and-folders-with-efs-in-windows-11.9738/
	//+ https://winaero.com/decrypt-files-folders-efs-windows-10/
	//+ https://winaero.com/how-to-add-encrypt-and-decrypt-commands-in-windows-10-right-click-menu/
	//+ https://ss64.com/nt/cipher.html
	$isEncrypted=str.contains(io.meta(sel,'System.FileAttributes'), 'E')
	item(title='Encrypt' where=!isEncrypted image=\uE19A
		tip='Encrypt the selected file(s) using EFS'
		commands { cmd-line='/k cipher /e @sel(true) & pause & exit' wait=1, cmd=command.refresh })
	item(title='Encrypt@"\t"recursive' where=!isEncrypted type='dir' mode='single' image=\uE19A
		tip='Encrypt all files in the selected folder and its subfolders using EFS'
		commands { cmd-line='/k cipher /e /s:@sel(true) & pause & exit' wait=1, cmd=command.refresh })
	item(title='Decrypt' where=isEncrypted image=\uE19B
		tip='Decrypt the selected file(s) using EFS'
		commands { cmd-line='/k cipher /d @sel(true) & pause & exit' wait=1, cmd=command.refresh })
	item(title='Decrypt@"\t"recursive' where=isEncrypted type='dir' mode='single' image=\uE19B
		tip='Decrypt all files in the selected folder and its subfolders using EFS'
		commands { cmd-line='/k cipher /d /s:@sel(true) & pause & exit' wait=1, cmd=command.refresh })
	item(title='View EFS cert' image=\uE19C
		tip='Display the encryption certificate used for EFS'
		cmd-line='/k cipher /y & pause & exit')
	item(title='Copy EFS cert' image=\uE19C
		tip='Copy the encryption certificate thumbprint to the clipboard'
		cmd-line='/c cipher /y | findstr /r /c:"[0-9A-Fa-f] [0-9A-Fa-f]" | clip & exit' window='hidden') }