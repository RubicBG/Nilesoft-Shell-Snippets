$GUIDs = @(
	"{323CA680-C24D-4099-B94D-446DD2D7249E}", #Favorites
	"{679F85CB-0220-4080-B29B-5540CC05AAB6}", #Quick access (Win10)
	"{f874310e-b6b7-47dc-bc84-b9e6b38f5903}", #Home (Win11)
	# "{3936E9E4-D92C-4EEE-A85A-BC16D5EA0819}", #Frequent Places Folder - delegate

	"{018D5C66-4533-4307-9B53-224DE2ED1FE6}", #One Drive 
	"{E31EA727-12ED-4702-820C-4B6445F28E1A}", #Dropbox
	"{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}", #Gallery
	# "{5A24B51A-1A53-4DCB-8BB4-B14EC2AAEB3B}", #Cross Device - dynamic generated
	"{59031a47-3f72-44a7-89c5-5595fe6b30ee}", #User Folder
	"{031E4825-7B94-4dc3-B131-E946B44C8DD5}", #Libraries

	"{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}", #Desktop
	"{f42ee2d3-909f-4907-8871-4c22fc0bf756}", #Local Documents
	"{FDD39AD0-238F-46AF-ADB4-6C85480369C7}", #Documents
	"{7d83ee9b-2244-4e70-b1f5-5393042af1e4}", #Local Downloads
	"{374DE290-123F-4565-9164-39C4925E467B}", #Downloads
	"{0ddd015d-b06c-45d5-8c4c-f59713854639}", #Local Pictures
	"{33E28130-4E1E-4676-835A-98395C3BC3BB}", #Pictures
	"{a0c69a99-21c8-4671-8703-7934162fcf1d}", #Local Music
	"{4BD8D571-6D19-48D3-BE97-422220080E43}", #Music
	"{35286a68-3c57-41a1-bbb1-0eae73d76c95}", #Local Videos

	"{20D04FE0-3AEA-1069-A2D8-08002B30309D}", #This PC 
	# "{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}", #Removable Drives - delegate
	"{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}", #Network 
	"{7007ACC7-3202-11D1-AAD2-00805FC1270E}", #Network Connections* 

	"{26EE0668-A00A-44D7-9371-BEB064C98683}", #Control Panel
	"{A8A91A66-3A7D-4424-8D24-04E180695C7A}", #Device Center
	"{2227A280-3AEA-1069-A2DE-08002B30309D}", #Printers
	"{B2B4A4D1-2754-4140-A2EB-9A76D9D7CDC6}", #Linux (WSL)
	"{645FF040-5081-101B-9F08-00AA002F954E}", #Recycle Bin

	"{445a2e0d-9142-4458-a84a-66dee0196d3c}", #c:\
	"{0525388b-89d9-4112-bf4d-2aaccb716a7f}", #d:\
	"{856360c3-1ba4-4732-b279-41a6d03fb99b}", #e:\
	"{1979a718-e483-4d99-bd12-78e74c13b73f}", #f:\

	"{00000000-0000-0000-8A32-11F3E2A9B4D0}",
	"{00000000-0000-0000-A12F-4478BC12EE89}",
	"{00000000-0000-0000-9C45-72F11D99A501}",
	"{00000000-0000-0000-B7E4-5560A3C8D2F7}",
	"{00000000-0000-0000-CE98-0F4435A1C6BB}",
	"{00000000-0000-0000-D221-19A8B55EE490}",
	"{00000000-0000-0000-EF10-8BC92A43F7C1}",
	"{00000000-0000-0000-F843-23DD7100A5E2}",
	"{00000000-0000-0000-82F1-44C9A77B9E32}",
	"{00000000-0000-0000-94AB-0F2C1137D5A4}",
	"{00000000-0000-0000-A7C4-6E5B88201F9D}",
	"{00000000-0000-0000-B3D0-514CC7E49128}",
	"{00000000-0000-0000-C8F9-7B22AA4DE013}",
	"{00000000-0000-0000-DB14-2AEF6C0B8AA5}",
	"{00000000-0000-0000-E0CE-9D5814420F7C}",
	"{00000000-0000-0000-F9A2-333771A8C4D1}"
)

$output = "Windows Registry Editor Version 5.00`r`n"

foreach ($guid in $GUIDs) {
    # Get the friendly name if available
    $guidName = ""
    $folderDescBasePath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\$guid"
    try {
        if (Test-Path $folderDescBasePath) {
            $nameValue = Get-ItemProperty -Path $folderDescBasePath -Name "Name" -ErrorAction Stop
            if ($nameValue.Name) {
                $guidName = " - $($nameValue.Name)"
            }
        }
    } catch {}
    
    $output += "`r`n; ===== Processing $guid$guidName =====`r`n"
    
    # Check for PreferredFolder redirection
    $mainGuid = $guid
    $workingGuid = $guid
    $folderDescPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\$guid\PropertyBag"
    
    try {
        if (Test-Path $folderDescPath) {
            $preferredFolder = Get-ItemProperty -Path $folderDescPath -Name "PreferredFolder" -ErrorAction Stop
            if ($preferredFolder.PreferredFolder -match '\{[0-9A-F-]+\}') {
                $workingGuid = $matches[0]
                $output += "; Redirected to: $workingGuid`r`n"
            }
        }
    } catch {}
    
    $output += "`r`n"
    
    # CLSID - Delete then export
    $clsidPath = "HKCU:\Software\Classes\CLSID\$workingGuid"
    $output += "[-HKEY_CURRENT_USER\Software\Classes\CLSID\$workingGuid]`r`n`r`n"
    
    if (Test-Path $clsidPath) {
        $tempFile = [System.IO.Path]::GetTempFileName()
        reg export "HKCU\Software\Classes\CLSID\$workingGuid" $tempFile /y 2>$null | Out-Null
        if (Test-Path $tempFile) {
            $content = Get-Content $tempFile -Raw
            $output += ($content -split "`r`n", 2)[1]
            Remove-Item $tempFile -Force
            $output += "`r`n"
        }
    }
    
    # Desktop NameSpace - Delete then export
    $desktopPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\$workingGuid"
    $output += "[-HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\$workingGuid]`r`n`r`n"
    
    if (Test-Path $desktopPath) {
        $tempFile = [System.IO.Path]::GetTempFileName()
        reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\$workingGuid" $tempFile /y 2>$null | Out-Null
        if (Test-Path $tempFile) {
            $content = Get-Content $tempFile -Raw
            $output += ($content -split "`r`n", 2)[1]
            Remove-Item $tempFile -Force
            $output += "`r`n"
        }
    }
    
    # HideDesktopIcons - Check value
    $hidePath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"
    try {
        $value = Get-ItemProperty -Path $hidePath -Name $workingGuid -ErrorAction Stop
        if ($value.$workingGuid -eq 1) {
            $output += "[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel]`r`n"
            $output += "`"$workingGuid`"=dword:00000001`r`n"
        } else {
            $output += "[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel]`r`n"
            $output += "`"$workingGuid`"=-`r`n"
        }
    } catch {
        $output += "[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel]`r`n"
        $output += "`"$workingGuid`"=-`r`n"
    }
    $output += "`r`n"
    
    # MyComputer NameSpace - Check existence
    $myComputerPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\$workingGuid"
    if (Test-Path $myComputerPath) {
        $tempFile = [System.IO.Path]::GetTempFileName()
        reg export "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\$workingGuid" $tempFile /y 2>$null | Out-Null
        if (Test-Path $tempFile) {
            $content = Get-Content $tempFile -Raw
            $output += ($content -split "`r`n", 2)[1]
            Remove-Item $tempFile -Force
        }
    } else {
        $output += "[-HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\$workingGuid]`r`n"
    }
    $output += "`r`n"
}

[System.IO.File]::WriteAllText("$PSScriptRoot\exported_registry.reg", $output, [System.Text.Encoding]::Unicode)