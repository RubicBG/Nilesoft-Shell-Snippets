
menu(title='File Hash' mode='multiple' type='file' image=\uE25E) {
	// icon.res(path.combine(sys.bin, 'certmgr.dll'),-450) -450 or -447 \uE239 \uE25E
	item(title='Verify Checksum file' mode='single' find='.md2|.md4|.md5|.sha1|.sha256|.SHA384|.SHA512'
		cmd-line='/k echo off & (for /f "usebackq tokens=1,2 delims=*" %a in (@sel(true)) do (echo %a & echo %b & echo "@(sel.parent)\%b" ) & certutil -hashfile "@(sel.parent)\%b" @str.replace(sel.file.ext, '.', '') | findstr /i /c:%a >nul & if errorlevel 1 (echo File: %b - MD5 hash does not match.) else (echo File: %b - MD5 hash matches.) & echo.) & pause & exit')
	separator()
	menu(image=inherit mode='single' title='Copy') {
		item(image=inherit title='Copy MD2' where=key.Shift()
			commands { cmd-line='/k certutil -hashfile @sel(true) MD2 | findstr /r "^[0-9a-fA-F]*$" | clip & exit' window='minimized' wait=1, cmd=msg.beep })
		item(image=inherit title='Copy MD4' where=key.Shift()
			commands { cmd-line='/k certutil -hashfile @sel(true) MD4 | findstr /r "^[0-9a-fA-F]*$" | clip & exit' window='minimized' wait=1, cmd=msg.beep })
		item(image=inherit title='Copy MD5'
			commands { cmd-line='/k certutil -hashfile @sel(true) MD5 | findstr /r "^[0-9a-fA-F]*$" | clip & exit' window='minimized' wait=1, cmd=msg.beep })
		item(image=inherit title='Copy SHA1'
			commands { cmd-line='/k certutil -hashfile @sel(true) SHA1 | findstr /r "^[0-9a-fA-F]*$" | clip & exit' window='minimized' wait=1, cmd=msg.beep })
		item(image=inherit title='Copy SHA256'
			commands { cmd-line='/k certutil -hashfile @sel(true) SHA256 | findstr /r "^[0-9a-fA-F]*$" | clip & exit' window='minimized' wait=1, cmd=msg.beep })
		item(image=inherit title='Copy SHA384' where=key.Shift()
			commands { cmd-line='/k certutil -hashfile @sel(true) SHA384 | findstr /r "^[0-9a-fA-F]*$" | clip & exit' window='minimized' wait=1, cmd=msg.beep })
		item(image=inherit title='Copy SHA512' where=key.Shift()
			commands { cmd-line='/k certutil -hashfile @sel(true) SHA512 | findstr /r "^[0-9a-fA-F]*$" | clip & exit' window='minimized' wait=1, cmd=msg.beep }) }
	menu(image=inherit mode='single' title='Copy or Create') {
		item(image=inherit title='Copy MD2' keys='SHIFT to .md2' where=key.Shift()
			commands { cmd-line=`/k echo off & for /f "delims=" %i in ('certutil -hashfile @sel(true) MD2 ^| findstr /r "^[0-9a-fA-F]*$"') do @if(key.shift(), 'echo %i *@(sel.file)> "@(sel.path).md2"& exit', 'echo %i |clip & exit')` window='minimized' wait=1, cmd=msg.beep })
		item(image=inherit title='Copy MD4' keys='SHIFT to .md4' where=key.Shift()
			commands { cmd-line=`/k echo off & for /f "delims=" %i in ('certutil -hashfile @sel(true) MD4 ^| findstr /r "^[0-9a-fA-F]*$"') do @if(key.shift(), 'echo %i *@(sel.file)> "@(sel.path).md4"& exit', 'echo %i |clip & exit')` window='minimized' wait=1, cmd=msg.beep })
		item(image=inherit title='Copy MD5' keys='SHIFT to .md5'
			commands { cmd-line=`/k echo off & for /f "delims=" %i in ('certutil -hashfile @sel(true) MD5 ^| findstr /r "^[0-9a-fA-F]*$"') do @if(key.shift(), 'echo %i *@(sel.file)> "@(sel.path).md5"& exit', 'echo %i |clip & exit')` window='minimized' wait=1, cmd=msg.beep })
		item(image=inherit title='Copy SHA1' keys='SHIFT to .sha1'
			commands { cmd-line=`/k echo off & for /f "delims=" %i in ('certutil -hashfile @sel(true) SHA1 ^| findstr /r "^[0-9a-fA-F]*$"') do @if(key.shift(), 'echo %i *@(sel.file)> "@(sel.path).sha1"& exit', 'echo %i |clip & exit')` window='minimized' wait=1, cmd=msg.beep })
		item(image=inherit title='Copy SHA256' keys='SHIFT to .sha256'
			commands { cmd-line=`/k echo off & for /f "delims=" %i in ('certutil -hashfile @sel(true) SHA256 ^| findstr /r "^[0-9a-fA-F]*$"') do @if(key.shift(), 'echo %i *@(sel.file)> "@(sel.path).sha256"& exit', 'echo %i |clip & exit')` window='minimized' wait=1, cmd=msg.beep })
		item(image=inherit title='Copy SHA384' keys='SHIFT to .SHA384' where=key.Shift()
			commands { cmd-line=`/k echo off & for /f "delims=" %i in ('certutil -hashfile @sel(true) SHA384 ^| findstr /r "^[0-9a-fA-F]*$"') do @if(key.shift(), 'echo %i *@(sel.file)> "@(sel.path).SHA384"& exit', 'echo %i |clip & exit')` window='minimized' wait=1, cmd=msg.beep })
		item(image=inherit title='Copy SHA512' keys='SHIFT to .SHA512' where=key.Shift()
			commands { cmd-line=`/k echo off & for /f "delims=" %i in ('certutil -hashfile @sel(true) SHA512 ^| findstr /r "^[0-9a-fA-F]*$"') do @if(key.shift(), 'echo %i *@(sel.file)> "@(sel.path).SHA512"& exit', 'echo %i |clip & exit')` window='minimized' wait=1, cmd=msg.beep }) }
	menu(image=inherit mode='multiple' where=sel.count>1 title='View') {
		item(image=inherit title='View MD2' where=key.Shift()
			cmd-line='/k echo off & (for %a in (@sel(true)) do (certutil -hashfile %a MD2 | findstr /r "^[0-9a-fA-F]*$" & echo *%~a )) & pause & exit')
		item(image=inherit title='View MD4' where=key.Shift()
			cmd-line='/k echo off & (for %a in (@sel(true)) do (certutil -hashfile %a MD4 | findstr /r "^[0-9a-fA-F]*$" & echo *%~a )) & pause & exit')
		item(image=inherit title='View MD5'
			cmd-line='/k echo off & (for %a in (@sel(true)) do (certutil -hashfile %a MD5 | findstr /r "^[0-9a-fA-F]*$" & echo *%~a )) & pause & exit')
		item(image=inherit title='View SHA1'
			cmd-line='/k echo off & (for %a in (@sel(true)) do (certutil -hashfile %a SHA1 | findstr /r "^[0-9a-fA-F]*$" & echo *%~a )) & pause & exit')
		item(image=inherit title='View SHA256'
			cmd-line='/k echo off & (for %a in (@sel(true)) do (certutil -hashfile %a SHA256 | findstr /r "^[0-9a-fA-F]*$" & echo *%~a )) & pause & exit')
		item(image=inherit title='View SHA384' where=key.Shift()
			cmd-line='/k echo off & (for %a in (@sel(true)) do (certutil -hashfile %a SHA384 | findstr /r "^[0-9a-fA-F]*$" & echo *%~a )) & pause & exit')
		item(image=inherit title='View SHA512' where=key.Shift()
			cmd-line='/k echo off & (for %a in (@sel(true)) do (certutil -hashfile %a SHA512 | findstr /r "^[0-9a-fA-F]*$" & echo *%~a )) & pause & exit') }
	menu(image=inherit mode='single' title='View or Save') {
		item(image=inherit title='View MD2' keys='SHIFT to .txt' where=key.Shift()
			cmd-line='/k certutil -hashfile @sel(true) MD2 @if(key.shift(), '> "@(sel.path).txt"', '& pause') & exit')
		item(image=inherit title='View MD4' keys='SHIFT to .txt' where=key.Shift()
			cmd-line='/k certutil -hashfile @sel(true) MD4 @if(key.shift(), '> "@(sel.path).txt"', '& pause') & exit')
		item(image=inherit title='View MD5' keys='SHIFT to .txt'
			cmd-line='/k certutil -hashfile @sel(true) MD5 @if(key.shift(), '> "@(sel.path).txt"', '& pause') & exit')
		item(image=inherit title='View SHA1' keys='SHIFT to .txt'
			cmd-line='/k certutil -hashfile @sel(true) SHA1 @if(key.shift(), '> "@(sel.path).txt"', '& pause') & exit')
		item(image=inherit title='View SHA256' keys='SHIFT to .txt'
			cmd-line='/k certutil -hashfile @sel(true) SHA256 @if(key.shift(), '> "@(sel.path).txt"', '& pause') & exit')
		item(image=inherit title='View SHA384' keys='SHIFT to .txt' where=key.Shift()
			cmd-line='/k certutil -hashfile @sel(true) SHA384 @if(key.shift(), '> "@(sel.path).txt"', '& pause') & exit')
		item(image=inherit title='View SHA512' keys='SHIFT to .txt' where=key.Shift()
			cmd-line='/k certutil -hashfile @sel(true) SHA512 @if(key.shift(), '> "@(sel.path).txt"', '& pause') & exit') }
	separator()
	menu(image=inherit mode='single' title='Copy or Create') {
		//> https://github.com/anseki/hashfile-contextmenu
		item(image=inherit title='Copy MD2' keys='SHIFT to .md2' where=key.Shift()
			cmd-line=`/V:ON /c "echo off & for /f "delims=" %i in ('certutil -hashfile @sel(true) MD2^|findstr -v ":"') do set hash=%i & @if(key.shift(), '(echo !hash: =! *@sel.file)> "@(sel.path).md2"', 'set /p ="!hash: =!"<NUL|clip"')`)
		item(image=inherit title='Copy MD4' keys='SHIFT to .md4' where=key.Shift()
			cmd-line=`/V:ON /c "echo off & for /f "delims=" %i in ('certutil -hashfile @sel(true) MD4^|findstr -v ":"') do set hash=%i & @if(key.shift(), '(echo !hash: =! *@sel.file)> "@(sel.path).md4"', 'set /p ="!hash: =!"<NUL|clip"')`)
		item(image=inherit title='Copy MD5' keys='SHIFT to .md5'
			cmd-line=`/V:ON /c "echo off & for /f "delims=" %i in ('certutil -hashfile @sel(true) MD5^|findstr -v ":"') do set hash=%i & @if(key.shift(), '(echo !hash: =! *@sel.file)> "@(sel.path).md5"', 'set /p ="!hash: =!"<NUL|clip"')`)
		item(image=inherit title='Copy SHA1' keys='SHIFT to .sha1'
			cmd-line=`/V:ON /c "echo off & for /f "delims=" %i in ('certutil -hashfile @sel(true) SHA1^|findstr -v ":"') do set hash=%i & @if(key.shift(), '(echo !hash: =! *@sel.file)> "@(sel.path).sha1"', 'set /p ="!hash: =!"<NUL|clip"')`)
		item(image=inherit title='Copy SHA256' keys='SHIFT to .sha256'
			cmd-line=`/V:ON /c "echo off & for /f "delims=" %i in ('certutil -hashfile @sel(true) SHA256^|findstr -v ":"') do set hash=%i & @if(key.shift(), '(echo !hash: =! *@sel.file)> "@(sel.path).sha256"', 'set /p ="!hash: =!"<NUL|clip"')`)
		item(image=inherit title='Copy SHA384' keys='SHIFT to .SHA384' where=key.Shift()
			cmd-line=`/V:ON /c "echo off & for /f "delims=" %i in ('certutil -hashfile @sel(true) SHA384^|findstr -v ":"') do set hash=%i & @if(key.shift(), '(echo !hash: =! *@sel.file)> "@(sel.path).sha384"', 'set /p ="!hash: =!"<NUL|clip"')`)
		item(image=inherit title='Copy SHA512' keys='SHIFT to .SHA512' where=key.Shift()
			cmd-line=`/V:ON /c "echo off & for /f "delims=" %i in ('certutil -hashfile @sel(true) SHA512^|findstr -v ":"') do set hash=%i & @if(key.shift(), '(echo !hash: =! *@sel.file)> "@(sel.path).sha512"', 'set /p ="!hash: =!"<NUL|clip"')`) }
}
