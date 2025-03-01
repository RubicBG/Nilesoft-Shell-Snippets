menu(type="taskbar" vis=key.shift() or key.lbutton() pos=0 title=app.name image=\uE249)
{
	item(title="manager" tip='Open Nilesoft Shell Manager'
		image
		admin cmd=app.exe)
	item(title="directory" tip='Open Nilesoft Shell directory'
		image=\uE0E8
		cmd=app.dir)
	item(title="config" tip='Open Nilesoft Shell main configuration file'
		image=\uE10A
		cmd=app.cfg)
	item(title="nss preview" tip='Show .nss file preview in Preview Pane in File Explorer for a better user experience'
		image=\uE142
		vis=if(reg.exists('HKEY_CLASSES_ROOT\.nss\shellex\{8895b1c6-b41f-4c1c-a562-0d564250836f}'), 'disable')
		// admin cmd=reg.set('HKEY_CLASSES_ROOT\.nss\shellex\{8895b1c6-b41f-4c1c-a562-0d564250836f}', '', '{1531d583-8375-4d3f-b5fb-d23bbd169f22}', reg.sz))
		admin cmd args='/c reg.exe add "HKEY_CLASSES_ROOT\.nss\shellex\{8895b1c6-b41f-4c1c-a562-0d564250836f}" /ve /t REG_SZ /d "{1531d583-8375-4d3f-b5fb-d23bbd169f22}" /f' window=cmd.hidden)	
	item(title="updates" tip='Check for updates. If a new version is available, a download link will be provided. Click or Ctrl+Click to open the link and get the latest version.'
		image=\uE1AB
		cmd-ps=`try { 
				$response = Invoke-WebRequest -Uri 'https://nilesoft.org/download' -UseBasicParsing -TimeoutSec 5; 
				if ($response.StatusCode -eq 200) {
					if ($response.Content -match 'Shell version ([\d\.]+)') {
						$newVer = $matches[1];
						Write-Host "Latest available version: $($newVer)";
						Write-Host "$([System.Environment]::NewLine)"
						if ([version]$newVer -gt [version]'@app.ver') {
							$arch = (Get-CimInstance Win32_OperatingSystem).OSArchitecture; 
							$type = if ($arch -match '64-bit') {'x64'} elseif ($arch -match '32-bit') {'x86'} else {'arm64'};
							Write-Host "Installation Options:" -ForegroundColor Cyan
							Write-Host "------------------------" -ForegroundColor DarkGray

							# Manual Install
							Write-Host "$([System.Environment]::NewLine)"
							Write-Host "Manual Install:" -ForegroundColor Green
							Write-Host "---------------------" -ForegroundColor DarkGray
							Write-Host "https://nilesoft.org/download/shell/$newVer/setup-$type.msi" -ForegroundColor Yellow

							# Package Managers
							Write-Host "$([System.Environment]::NewLine)"
							Write-Host "Package Managers:" -ForegroundColor Green
							Write-Host "---------------------" -ForegroundColor DarkGray
							Write-Host "Winget: winget install nilesoft.shell" -ForegroundColor Yellow
							Write-Host "Scoop:  scoop install nilesoft-shell" -ForegroundColor Yellow
							Write-Host "Choco:  choco install nilesoft-shell" -ForegroundColor Yellow
						} else { 
							Write-Host "Nilesoft Shell framework is up to date" -ForegroundColor Cyan
						}
					} else {
						Write-Host "Unable to find version information on the website"
					}
				} else {
					Write-Host "Website returned error status: $($response.StatusCode)"
				}
			} catch { 
				Write-Host "Error accessing website. Please check your internet connection or try again later."
			};
			Write-Host "$([System.Environment]::NewLine)"
			Read-Host -Prompt '[Enter] to close'`)
			// Write-Host "Press any key to exit..." -NoNewline; 
			// $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');`)
	item(title="GitHub" tip='Open Nilesoft Shell GitHub page. Contributions and bug reports are welcome.'
		image=image.glyph(\uE22C, #4078C0) col=1
		cmd='https://github.com/moudey/Shell')
	$svg_discord='<svg width="100" height="100" viewBox="0 0 1024 1024"><circle cx="512" cy="512" r="512" style="fill:#5865f2"/><path d="M689.43 349a422.21 422.21 0 0 0-104.22-32.32 1.58 1.58 0 0 0-1.68.79 294.11 294.11 0 0 0-13 26.66 389.78 389.78 0 0 0-117.05 0 269.75 269.75 0 0 0-13.18-26.66 1.64 1.64 0 0 0-1.68-.79A421 421 0 0 0 334.44 349a1.49 1.49 0 0 0-.69.59c-66.37 99.17-84.55 195.9-75.63 291.41a1.76 1.76 0 0 0 .67 1.2 424.58 424.58 0 0 0 127.85 64.63 1.66 1.66 0 0 0 1.8-.59 303.45 303.45 0 0 0 26.15-42.54 1.62 1.62 0 0 0-.89-2.25 279.6 279.6 0 0 1-39.94-19 1.64 1.64 0 0 1-.16-2.72c2.68-2 5.37-4.1 7.93-6.22a1.58 1.58 0 0 1 1.65-.22c83.79 38.26 174.51 38.26 257.31 0a1.58 1.58 0 0 1 1.68.2c2.56 2.11 5.25 4.23 8 6.24a1.64 1.64 0 0 1-.14 2.72 262.37 262.37 0 0 1-40 19 1.63 1.63 0 0 0-.87 2.28 340.72 340.72 0 0 0 26.13 42.52 1.62 1.62 0 0 0 1.8.61 423.17 423.17 0 0 0 128-64.63 1.64 1.64 0 0 0 .67-1.18c10.68-110.44-17.88-206.38-75.7-291.42a1.3 1.3 0 0 0-.63-.63zM427.09 582.85c-25.23 0-46-23.16-46-51.6s20.38-51.6 46-51.6c25.83 0 46.42 23.36 46 51.6.02 28.44-20.37 51.6-46 51.6zm170.13 0c-25.23 0-46-23.16-46-51.6s20.38-51.6 46-51.6c25.83 0 46.42 23.36 46 51.6.01 28.44-20.17 51.6-46 51.6z" style="fill:#fff"/></svg>'
	item(title="Discord" tip='Join the Nilesoft Shell Discord server. It is the best place to get help and support.'
		image=image.svg(svg_discord)
		cmd='https://discord.com/channels/1106387012707168318/1106387015425069151')
	item(title="YouTube" tip='Subscribe to my YouTube channel.'
		image=image.glyph(\uE248, #FF0000)
		cmd='https://www.youtube.com/@"@"moudey')
	$svg_forum='<svg width="100" height="100" viewBox="0 0 16 16"><path fill="@image.color1" data-name="Path 101" d="M15.5 16a.48.48 0 0 1-.158-.026L13 15.193A5.971 5.971 0 0 1 10 16a6.006 6.006 0 0 1-6-6 6.006 6.006 0 0 1 6-6 6.006 6.006 0 0 1 6 6 5.976 5.976 0 0 1-.807 3l.782 2.345a.5.5 0 0 1-.121.512.5.5 0 0 1-.354.143ZM10 5a5.006 5.006 0 0 0-5 5 5.006 5.006 0 0 0 5 5 4.984 4.984 0 0 0 2.668-.777.5.5 0 0 1 .426-.052l1.616.538-.539-1.615a.5.5 0 0 1 .052-.426A4.982 4.982 0 0 0 15 10a5.006 5.006 0 0 0-5-5ZM.658 12.974l3-1a.5.5 0 0 0 .317-.632.5.5 0 0 0-.633-.316l-2.051.683L2.06 9.4a.5.5 0 0 0-.073-.454 4.96 4.96 0 0 1 .478-6.485A4.966 4.966 0 0 1 6 1a4.966 4.966 0 0 1 3.535 1.464.5.5 0 0 0 .707 0 .5.5 0 0 0 0-.707A5.959 5.959 0 0 0 6 0a5.959 5.959 0 0 0-4.242 1.757 5.948 5.948 0 0 0-.727 7.569L.025 12.342a.5.5 0 0 0 .121.512A.5.5 0 0 0 .5 13a.48.48 0 0 0 .158-.026Z"/></svg>'
	item(title="Reddit" tip='Follow Nilesoft Shell on Reddit.'
		image=image.glyph(\uE23D, #FF5700)
		cmd='https://www.reddit.com/r/nilesoft/')
	item(title="Forum" tip='The forum is no longer available. Please visit the archive.'
		image=image.svg(svg_forum) // vis='disable'
		cmd='https://web.archive.org/web/20240101000000*/https://nilesoft.org/forum/')
	item(title="version\t"+@app.ver vis=label col=1)
	item(title="docs" tip='If the site is not available, please visit the archive.'
		image=image.glyph(\uE1C4, #1E90FF) 
		cmd-ps=`try {
			if ((Invoke-WebRequest -Uri "https://nilesoft.org/docs" -UseBasicParsing -ErrorAction Stop).StatusCode -eq 200) {
				Start-Process "https://nilesoft.org/docs"
			} else {
				throw
			} } catch { Start-Process 'https://web.archive.org/web/@"*"/https://nilesoft.org' }`
		window='hidden')
	item(title="snippets" tip='Check out the snippets gallery.'
		image=image.glyph(\uE26D, #00ff62)
		cmd='https://github.com/RubicBG/Nilesoft-Shell-Snippets')
	item(title="donate" tip='Make a donation to support the project.'
		image=image.glyph(\uE1A7, #FF9900)
		cmd='https://nilesoft.org/donate')
	item(title="mail me" tip='Send me an email.'
		image=image.glyph(\uE15F, #FF4500) 
		cmd='mailto:support@"@"nilesoft.org?subject=Nilesoft Shell&body=Huge thanks for Nilesoft Shell')
}