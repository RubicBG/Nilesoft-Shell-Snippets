// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

$svg_hide = '<svg width="100" height="100" viewBox="0 -16 544 544">
	<path fill="@icon.color1" d="m108 60 360 360-32 32-74-74q-41 22-90 22-64 0-118-39-55-39-90-105 15-27 38-54 22-28 42-42L76 92zm260 196q0-40-28-68t-68-28l-43-43q25-5 43-5 65 0 120 40 54 40 88 104-6 13-19 32t-27 34zm-96 96q27 0 50-14l-29-29q-10 3-21 3-23 0-39-16-17-17-17-40 0-9 4-20l-30-30q-14 23-14 50 0 40 28 68t68 28"/></svg>'
menu(title='Hide Drive Letter' type='drive|computer' image=image.svg(svg_hide) tip='Hide specific drives from the system. it requires a restart to take effect.') {
	// https://www.elevenforum.com/t/hide-specific-drives-in-windows-11.16124/
	$reg_path = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer'
	$reg_hex = reg.get(reg_path, 'NoDrives')
	$hex = null
	$result = null
	// what a struggle it was to find a way to convert hex
	$check = for(i=0, i>=0) {
		if(i==0, hex=1)
		if(i==0, result='|')
		$temp = (reg_hex / hex) % 2
		if(temp == 1, result += hex + '|' )
		hex = hex*2
		if(hex > reg_hex, break)
	}
	// use $restart = command.restart_explorer() to restart the explorer after changes
	$restart = if(msg('Do you want to restart the explorer to apply the changes?', 'NileSoft Shell', msg.warning|msg.yesno|msg.defbutton2)==msg.idyes, command.restart_explorer())
	menu(expanded='true' title={ check }) {
		item(title = "\xE10B" tip='Show all drives' sep='after' checked=len(result)<3 where=key.shift()
			commands { admin cmd-line='/c reg add "@reg_path" /v NoDrives /t REG_DWORD /d 0 /f & exit' window=0 wait=1, cmd=restart })
		item(vis=if(!path.exists('A:'),'disable') title = 'A:' checked=str.contains(result, '|1|') where=key.shift()
			commands { admin cmd-line='/c reg add "@reg_path" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|1|'), reg_hex - 1, reg_hex + 1) /f & exit' window=0 wait=1, cmd=restart })
		item(vis=if(!path.exists('B:'),'disable') title = 'B:' checked=str.contains(result, '|2|') where=key.shift()
			commands { admin cmd-line='/c reg add "@reg_path" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|2|'), reg_hex - 2, reg_hex + 2) /f & exit' window=0 wait=1, cmd=restart })
		item(vis=if(!path.exists('C:'),'disable') title = 'C:' checked=str.contains(result, '|4|')
			commands { admin cmd-line='/c reg add "@reg_path" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|4|'), reg_hex - 4, reg_hex + 4) /f & exit' window=0 wait=1, cmd=restart })
		item(vis=if(!path.exists('D:'),'disable') title = 'D:' checked=str.contains(result, '|8|')
			commands { admin cmd-line='/c reg add "@reg_path" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|8|'), reg_hex - 8, reg_hex + 8) /f & exit' window=0 wait=1, cmd=restart })  
		item(vis=if(!path.exists('E:'),'disable') title = 'E:' checked=str.contains(result, '|16|')
			commands { admin cmd-line='/c reg add "@reg_path" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|16|'), reg_hex - 16, reg_hex + 16) /f & exit' window=0 wait=1, cmd=restart })
		item(vis=if(!path.exists('F:'),'disable') title = 'F:' checked=str.contains(result, '|32|')
			commands { admin cmd-line='/c reg add "@reg_path" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|32|'), reg_hex - 32, reg_hex + 32) /f & exit' window=0 wait=1, cmd=restart })
		item(vis=if(!path.exists('G:'),'disable') title = 'G:' checked=str.contains(result, '|64|')
			commands { admin cmd-line='/c reg add "@reg_path" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|64|'), reg_hex - 64, reg_hex + 64) /f & exit' window=0 wait=1, cmd=restart })
		item(vis=if(!path.exists('H:'),'disable') title = 'H:' checked=str.contains(result, '|128|')
			commands { admin cmd-line='/c reg add "@reg_path" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|128|'), reg_hex - 128, reg_hex + 128) /f & exit' window=0 wait=1, cmd=restart })
		item(vis=if(!path.exists('I:'),'disable') title = 'I:' checked=str.contains(result, '|256|')
			commands { admin cmd-line='/c reg add "@reg_path" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|256|'), reg_hex - 256, reg_hex + 256) /f & exit' window=0 wait=1, cmd=restart })
		item(vis=if(!path.exists('J:'),'disable') title = 'J:' checked=str.contains(result, '|512|')
			commands { admin cmd-line='/c reg add "@reg_path" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|512|'), reg_hex - 512, reg_hex + 512) /f & exit' window=0 wait=1, cmd=restart })
		item(vis=if(!path.exists('K:'),'disable') title = 'K:' checked=str.contains(result, '|1024|')
			commands { admin cmd-line='/c reg add "@reg_path" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|1024|'), reg_hex - 1024, reg_hex + 1024) /f & exit' window=0 wait=1, cmd=restart })
		item(vis=if(!path.exists('L:'),'disable') title = 'L:' checked=str.contains(result, '|2048|')
			commands { admin cmd-line='/c reg add "@reg_path" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|2048|'), reg_hex - 2048, reg_hex + 2048) /f & exit' window=0 wait=1, cmd=restart })
		item(vis=if(!path.exists('M:'),'disable') title = 'M:' checked=str.contains(result, '|4096|')
			commands { admin cmd-line='/c reg add "@reg_path" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|4096|'), reg_hex - 4096, reg_hex + 4096) /f & exit' window=0 wait=1, cmd=restart })
		item(title = "\xE10A" tip='Hide all drives' sep='after' checked=str.contains(result, '|67108863|') where=key.shift() col
			commands { admin cmd-line='/c reg add "@reg_path" /v NoDrives /t REG_DWORD /d 67108863 /f & exit' window=0 wait=1, cmd=restart })
		item(vis=if(!path.exists('N:'),'disable') title = 'N:' checked=str.contains(result, '|8192|')
			commands { admin cmd-line='/c reg add "@reg_path" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|8192|'), reg_hex - 8192, reg_hex + 8192) /f & exit' window=0 wait=1, cmd=restart })
		item(vis=if(!path.exists('O:'),'disable') title = 'O:' checked=str.contains(result, '|16384|') col=!key.shift()
			commands { admin cmd-line='/c reg add "@reg_path" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|16384|'), reg_hex - 16384, reg_hex + 16384) /f & exit' window=0 wait=1, cmd=restart })
		item(vis=if(!path.exists('P:'),'disable') title = 'P:' checked=str.contains(result, '|32768|')
			commands { admin cmd-line='/c reg add "@reg_path" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|32768|'), reg_hex - 32768, reg_hex + 32768) /f & exit' window=0 wait=1, cmd=restart })
		item(vis=if(!path.exists('Q:'),'disable') title = 'Q:' checked=str.contains(result, '|65536|')
			commands { admin cmd-line='/c reg add "@reg_path" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|65536|'), reg_hex - 65536, reg_hex + 65536) /f & exit' window=0 wait=1, cmd=restart })
		item(vis=if(!path.exists('R:'),'disable') title = 'R:' checked=str.contains(result, '|131072|')
			commands { admin cmd-line='/c reg add "@reg_path" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|131072|'), reg_hex - 131072, reg_hex + 131072) /f & exit' window=0 wait=1, cmd=restart })
		item(vis=if(!path.exists('S:'),'disable') title = 'S:' checked=str.contains(result, '|262144|')
			commands { admin cmd-line='/c reg add "@reg_path" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|262144|'), reg_hex - 262144, reg_hex + 262144) /f & exit' window=0 wait=1, cmd=restart })
		item(vis=if(!path.exists('T:'),'disable') title = 'T:' checked=str.contains(result, '|524288|')
			commands { admin cmd-line='/c reg add "@reg_path" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|524288|'), reg_hex - 524288, reg_hex + 524288) /f & exit' window=0 wait=1, cmd=restart })
		item(vis=if(!path.exists('U:'),'disable') title = 'U:' checked=str.contains(result, '|1048576|')
			commands { admin cmd-line='/c reg add "@reg_path" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|1048576|'), reg_hex - 1048576, reg_hex + 1048576) /f & exit' window=0 wait=1, cmd=restart })
		item(vis=if(!path.exists('V:'),'disable') title = 'V:' checked=str.contains(result, '|2097152|')
			commands { admin cmd-line='/c reg add "@reg_path" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|2097152|'), reg_hex - 2097152, reg_hex + 2097152) /f & exit' window=0 wait=1, cmd=restart })
		item(vis=if(!path.exists('W:'),'disable') title = 'W:' checked=str.contains(result, '|4194304|')
			commands { admin cmd-line='/c reg add "@reg_path" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|4194304|'), reg_hex - 4194304, reg_hex + 4194304) /f & exit' window=0 wait=1, cmd=restart })
		item(vis=if(!path.exists('X:'),'disable') title = 'X:' checked=str.contains(result, '|8388608|')
			commands { admin cmd-line='/c reg add "@reg_path" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|8388608|'), reg_hex - 8388608, reg_hex + 8388608) /f & exit' window=0 wait=1, cmd=restart })
		item(vis=if(!path.exists('Y:'),'disable') title = 'Y:' checked=str.contains(result, '|16777216|')
			commands { admin cmd-line='/c reg add "@reg_path" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|16777216|'), reg_hex - 16777216, reg_hex + 16777216) /f & exit' window=0 wait=1, cmd=restart })
		item(vis=if(!path.exists('Z:'),'disable') title = 'Z:' checked=str.contains(result, '|33554432|')
			commands { admin cmd-line='/c reg add "@reg_path" /v NoDrives /t REG_DWORD /d @if(str.contains(result, '|33554432|'), reg_hex - 33554432, reg_hex + 33554432) /f & exit' window=0 wait=1, cmd=restart }) }
}