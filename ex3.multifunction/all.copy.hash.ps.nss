menu(title='Hash' mode='multiple' type='file|dir|back.dir' image=\uE239) {
	// icon.res(path.combine(sys.bin, 'certmgr.dll'),-450) -450 or -447 \uE239 \uE25E
	//> https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-filehash?view=powershell-7.4
	//> https://turbosfv.com/Features/Hash-Types
	item(title='Verify Checksum file' mode='single' find='.md5|.sha1|.sha256|.SHA384|.SHA512'
		cmd-ps=`-Command "$hashFile = '@sel'; $files = Get-Content -LiteralPath $hashFile; foreach ($file in $files) { $fileParts = $file -split ' *\*'; $hash = $fileParts[0]; $filename = $fileParts[1]; if ($filename -like '*:*') { $fullPath = $filename } else { $fullPath = Join-Path (Split-Path $hashFile) $filename }; $hashType = $hashFile -split '\.' | Select-Object -Last 1; $computedHash = Get-FileHash -LiteralPath $fullPath -Algorithm $hashType | Select-Object -ExpandProperty Hash; if ($computedHash -eq $hash) { Write-Output ('Hash match: ' + $hash + ' ' + $fullPath) } else { Write-Host ('Hash does not match: ' + $hash + ' ' + $fullPath) -ForegroundColor Red }; }; Read-Host -Prompt '[Enter] to close'"`)
	separator()
	menu(image=inherit title='Copy Hash' mode='single' type='file') {
		item(image=inherit title='Copy MD5'
			commands { cmd-ps=`(get-filehash -literalpath '@sel(true)' -algorithm MD5).Hash | Set-Clipboard` window='minimized' wait=1, cmd=msg.beep })
		item(image=inherit title='Copy SHA1'
			commands { cmd-ps=`(get-filehash -literalpath '@sel(true)' -algorithm SHA1).Hash | Set-Clipboard` window='minimized' wait=1, cmd=msg.beep })
		item(image=inherit title='Copy SHA256'
			commands { cmd-ps=`(get-filehash -literalpath '@sel(true)' -algorithm SHA256).Hash | Set-Clipboard` window='minimized' wait=1, cmd=msg.beep })
		item(image=inherit title='Copy SHA384' where=key.Shift()
			commands { cmd-ps=`(get-filehash -literalpath '@sel(true)' -algorithm SHA384).Hash | Set-Clipboard` window='minimized' wait=1, cmd=msg.beep })
		item(image=inherit title='Copy SHA512' where=key.Shift()
			commands { cmd-ps=`(get-filehash -literalpath '@sel(true)' -algorithm SHA512).Hash | Set-Clipboard` window='minimized' wait=1, cmd=msg.beep })
		item(image=inherit title='Copy MACTripleDES' where=key.Shift()
			commands { cmd-ps=`(get-filehash -literalpath '@sel(true)' -algorithm MACTripleDES).Hash | Set-Clipboard` window='minimized' wait=1, cmd=msg.beep })
		item(image=inherit title='Copy RIPEMD160' where=key.Shift()
			commands { cmd-ps=`(get-filehash -literalpath '@sel(true)' -algorithm RIPEMD160).Hash | Set-Clipboard` window='minimized' wait=1, cmd=msg.beep })
	}
	menu(image=inherit title='View Hash' mode='single' type='file') {
		item(image=inherit title='View MD5'
			cmd-ps=`-noexit get-filehash -literalpath '@sel(true)' -algorithm MD5 | format-list`)
		item(image=inherit title='View SHA1'
			cmd-ps=`-noexit get-filehash -literalpath '@sel(true)' -algorithm SHA1 | format-list`)
		item(image=inherit title='View SHA256'
			cmd-ps=`-noexit get-filehash -literalpath '@sel(true)' -algorithm SHA256 | format-list`)
		item(image=inherit title='View SHA384' where=key.Shift()
			cmd-ps=`-noexit get-filehash -literalpath '@sel(true)' -algorithm SHA384 | format-list`)
		item(image=inherit title='View SHA512' where=key.Shift()
			cmd-ps=`-noexit get-filehash -literalpath '@sel(true)' -algorithm SHA512 | format-list`)
		item(image=inherit title='View MACTripleDES' where=key.Shift()
			cmd-ps=`-noexit get-filehash -literalpath '@sel(true)' -algorithm MACTripleDES | format-list`)
		item(image=inherit title='View RIPEMD160' where=key.Shift()
			cmd-ps=`-noexit get-filehash -literalpath '@sel(true)' -algorithm RIPEMD160 | format-list`)
	}
	item(title='Hash Multi Verifier' mode='single' type='file' image=\uE23A tip='Compare with MD5, SHA1, SHA256, SHA384, or SHA512'
		cmd-ps=if(input('Nilesoft Shell', 'Add hash value for verification'), 
			`$file = Get-Item -LiteralPath '@sel.file'; $hash = '@input.result'; try { (Get-FileHash -LiteralPath $file -Algorithm $(switch($hash.Length){32{'MD5'};40{'SHA1'};64{'SHA256'};96{'SHA384'};128{'SHA512'};default{throw "Invalid hash length: $($hash.Length). Expected: 32(MD5), 40(SHA1), 64(SHA256), 96(SHA384), or 128(SHA512)"}})).Hash -eq $hash } catch { Write-Host $_.Exception.Message; $false }; Read-Host -Prompt '[Enter] to close'`,
			msg('Abort')))
	menu(image=inherit title='Hash Verifier' mode='single' type='file') {
		item(image=inherit title='Compare with MD5'				cmd-ps=if(input('Nilesoft Shell', 'Add MD5 hash value for verification'),  if(regex.match(input.result, '^[0-9a-fA-F]{32}$'), 
				`-noexit $hash1 = (get-filehash -literalpath '@sel.get(0)' -algorithm MD5).Hash; if ($hash1 -eq '@input.result') { write-output 'Match' } else { write-output 'No Match' }`,
				msg('Input string was not in a correct format')), msg('Abort')))
		item(image=inherit title='Compare with SHA1'			cmd-ps=if(input('Nilesoft Shell', 'Add MD5 hash value for verification'),  if(regex.match(input.result, '^[0-9a-fA-F]{40}$'), 
				`-noexit $hash1 = (get-filehash -literalpath '@sel.get(0)' -algorithm SHA1).Hash; if ($hash1 -eq '@input.result') { write-output 'Match' } else { write-output 'No Match' }`,
				msg('Input string was not in a correct format')), msg('Abort')))
		item(image=inherit title='Compare with SHA256'			cmd-ps=if(input('Nilesoft Shell', 'Add MD5 hash value for verification'),  if(regex.match(input.result, '^[0-9a-fA-F]{64}$'), 
				`-noexit $hash1 = (get-filehash -literalpath '@sel.get(0)' -algorithm SHA256).Hash; if ($hash1 -eq '@input.result') { write-output 'Match' } else { write-output 'No Match' }`,
				msg('Input string was not in a correct format')), msg('Abort')))
		item(image=inherit title='Compare with SHA384'			where=key.Shift() cmd-ps=if(input('Nilesoft Shell', 'Add MD5 hash value for verification'),  if(regex.match(input.result, '^[0-9a-fA-F]{96}$'), 
				`-noexit $hash1 = (get-filehash -literalpath '@sel.get(0)' -algorithm SHA384).Hash; if ($hash1 -eq '@input.result') { write-output 'Match' } else { write-output 'No Match' }`,
				msg('Input string was not in a correct format')), msg('Abort')))
		item(image=inherit title='Compare with SHA512'			where=key.Shift() cmd-ps=if(input('Nilesoft Shell', 'Add MD5 hash value for verification'),  if(regex.match(input.result, '^[0-9a-fA-F]{128}$'), 
				`-noexit $hash1 = (get-filehash -literalpath '@sel.get(0)' -algorithm SHA512).Hash; if ($hash1 -eq '@input.result') { write-output 'Match' } else { write-output 'No Match' }`,
				msg('Input string was not in a correct format')), msg('Abort')))
		item(image=inherit title='Compare with MACTripleDES'	where=key.Shift() cmd-ps=if(input('Nilesoft Shell', 'Add MD5 hash value for verification'),  if(regex.match(input.result, '^[0-9a-fA-F]{42}$'), 
				`-noexit $hash1 = (get-filehash -literalpath '@sel.get(0)' -algorithm MACTripleDES).Hash; if ($hash1 -eq '@input.result') { write-output 'Match' } else { write-output 'No Match' }`,
				msg('Input string was not in a correct format')), msg('Abort')))
		item(image=inherit title='Compare with RIPEMD160'		where=key.Shift() cmd-ps=if(input('Nilesoft Shell', 'Add MD5 hash value for verification'),  if(regex.match(input.result, '^[0-9a-fA-F]{40}$'), 
				`-noexit $hash1 = (get-filehash -literalpath '@sel.get(0)' -algorithm RIPEMD160).Hash; if ($hash1 -eq '@input.result') { write-output 'Match' } else { write-output 'No Match' }`,
				msg('Input string was not in a correct format')), msg('Abort')))
	}
	menu(image=inherit title='Compare Two Files' mode='multiple' where=sel.count==2 type='file') {
		item(image=inherit title='Compare with MD5'
			cmd-ps=`-noexit $hash1 = (get-filehash -literalpath '@sel.get(0)' -algorithm MD5).Hash; $hash2 = (get-filehash -literalpath '@sel.get(1)' -algorithm MD5).Hash; if ($hash1 -eq $hash2) { write-output 'Match' } else { write-output 'No Match' }`)
		item(image=inherit title='Compare with SHA1'
			cmd-ps=`-noexit $hash1 = (get-filehash -literalpath '@sel.get(0)' -algorithm SHA1).Hash; $hash2 = (get-filehash -literalpath '@sel.get(1)' -algorithm SHA1).Hash; if ($hash1 -eq $hash2) { write-output 'Match' } else { write-output 'No Match' }`)
		item(image=inherit title='Compare with SHA256'
			cmd-ps=`-noexit $hash1 = (get-filehash -literalpath '@sel.get(0)' -algorithm SHA256).Hash; $hash2 = (get-filehash -literalpath '@sel.get(1)' -algorithm SHA256).Hash; if ($hash1 -eq $hash2) { write-output 'Match' } else { write-output 'No Match' }`)
		item(image=inherit title='Compare with SHA384' where=key.Shift()
			cmd-ps=`-noexit $hash1 = (get-filehash -literalpath '@sel.get(0)' -algorithm SHA384).Hash; $hash2 = (get-filehash -literalpath '@sel.get(1)' -algorithm SHA384).Hash; if ($hash1 -eq $hash2) { write-output 'Match' } else { write-output 'No Match' }`)
		item(image=inherit title='Compare with SHA512' where=key.Shift()
			cmd-ps=`-noexit $hash1 = (get-filehash -literalpath '@sel.get(0)' -algorithm SHA512).Hash; $hash2 = (get-filehash -literalpath '@sel.get(1)' -algorithm SHA512).Hash; if ($hash1 -eq $hash2) { write-output 'Match' } else { write-output 'No Match' }`)
		item(image=inherit title='Compare with MACTripleDES' where=key.Shift()
			cmd-ps=`-noexit $hash1 = (get-filehash -literalpath '@sel.get(0)' -algorithm MACTripleDES).Hash; $hash2 = (get-filehash -literalpath '@sel.get(1)' -algorithm MACTripleDES).Hash; if ($hash1 -eq $hash2) { write-output 'Match' } else { write-output 'No Match' }`)
		item(image=inherit title='Compare with RIPEMD160' where=key.Shift()
			cmd-ps=`-noexit $hash1 = (get-filehash -literalpath '@sel.get(0)' -algorithm RIPEMD160).Hash; $hash2 = (get-filehash -literalpath '@sel.get(1)' -algorithm RIPEMD160).Hash; if ($hash1 -eq $hash2) { write-output 'Match' } else { write-output 'No Match' }`)
	}
	menu(image=inherit title='Create Checksums File' mode='multiple' type='file|dir|back.dir') {
		$recursive = keys.Shift()
		$ps_crate_part = `$selected = (@sel(2,',')); if ($selected -is 'Array') { $path = Split-Path $selected[0] } else { if (Test-Path -Path $selected -PathType Container) { $path = $selected } else { $path = Split-Path $selected } }; $checksumsFile = Join-Path -Path $path -ChildPath ('checksums.' + $hashType); if (@recursive) { Write-Host 'recursive on'; $files = Get-ChildItem -LiteralPath $selected -File -Recurse } else { Write-Host 'recursive off'; $files = Get-ChildItem -LiteralPath $selected -File }; foreach ($file in $files) { $checksum = Get-FileHash -LiteralPath $file.FullName -Algorithm $hashType; $file_name = $file.FullName.Substring($path.Length + 1); Add-Content -LiteralPath $checksumsFile -Value (\"{0} *{1}\" -f $checksum.Hash, $file_name) };`
		// item(image=inherit title='Test MD5' cmd-ps=`$hashType='MD5'; @ps_crate_part; Read-Host -Prompt '[Enter] to close'`)
		item(image=inherit title='Create MD5'				keys='SHIFT recursive'
			commands { cmd-ps=`$hashType='MD5';				@ps_crate_part` window='minimized' wait=1, cmd=msg.beep })
		item(image=inherit title='Create SHA1'				keys='SHIFT recursive'
			commands { cmd-ps=`$hashType='SHA1';			@ps_crate_part` window='minimized' wait=1, cmd=msg.beep })
		item(image=inherit title='Create SHA256'			keys='SHIFT recursive'
			commands { cmd-ps=`$hashType='SHA256';			@ps_crate_part` window='minimized' wait=1, cmd=msg.beep })
		item(image=inherit title='Create SHA384'			keys='SHIFT recursive' where=key.Shift()
			commands { cmd-ps=`$hashType='SHA384';			@ps_crate_part` window='minimized' wait=1, cmd=msg.beep })
		item(image=inherit title='Create SHA512'			keys='SHIFT recursive' where=key.Shift()
			commands { cmd-ps=`$hashType='SHA512';			@ps_crate_part` window='minimized' wait=1, cmd=msg.beep })
		item(image=inherit title='Create MACTripleDES'		keys='SHIFT recursive' where=key.Shift()
			commands { cmd-ps=`$hashType='MACTripleDES';	@ps_crate_part` window='minimized' wait=1, cmd=msg.beep })
		item(image=inherit title='Create RIPEMD160'			keys='SHIFT recursive' where=key.Shift()
			commands { cmd-ps=`$hashType='RIPEMD160';		@ps_crate_part` window='minimized' wait=1, cmd=msg.beep })
	}
	separator()
	menu(image=inherit title='View Hash' mode='single' type='file') {
		$ps_end = "write-output $hashResult.Path; write-output ' '; write-output $hashResult.Hash; Write-Output ' '; Read-Host -Prompt '[Enter] to close'"
		item(image=inherit title='View MD5'
			cmd-ps=`New-Variable -Name 'hashResult' -Visibility Public -Value (Get-FileHash -LiteralPath '@sel(true)' -Algorithm 'MD5'); @ps_end`)
		item(image=inherit title='View SHA1'
			cmd-ps=`New-Variable -Name 'hashResult' -Visibility Public -Value (Get-FileHash -LiteralPath '@sel(true)' -Algorithm 'SHA1'); @ps_end`)
		item(image=inherit title='View SHA256'
			cmd-ps=`New-Variable -Name 'hashResult' -Visibility Public -Value (Get-FileHash -LiteralPath '@sel(true)' -Algorithm 'SHA256'); @ps_end`)
		item(image=inherit title='View SHA384' where=key.Shift()
			cmd-ps=`New-Variable -Name 'hashResult' -Visibility Public -Value (Get-FileHash -LiteralPath '@sel(true)' -Algorithm 'SHA384'); @ps_end`)
		item(image=inherit title='View SHA512' where=key.Shift()
			cmd-ps=`New-Variable -Name 'hashResult' -Visibility Public -Value (Get-FileHash -LiteralPath '@sel(true)' -Algorithm 'SHA512'); @ps_end`)
		item(image=inherit title='View MACTripleDES' where=key.Shift()
			cmd-ps=`New-Variable -Name 'hashResult' -Visibility Public -Value (Get-FileHash -LiteralPath '@sel(true)' -Algorithm 'MACTripleDES'); @ps_end`)
		item(image=inherit title='View RIPEMD160' where=key.Shift()
			cmd-ps=`New-Variable -Name 'hashResult' -Visibility Public -Value (Get-FileHash -LiteralPath '@sel(true)' -Algorithm 'RIPEMD160'); @ps_end`)
	}
}