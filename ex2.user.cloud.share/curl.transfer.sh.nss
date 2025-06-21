// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

$svg_curl=image.svg('<svg width="800" height="800" viewBox="0 0 24 24">
  <path fill="@image.color2" d="m16.71 6.29-4-4a1 1 0 0 0-1.42 0l-4 4a1 1 0 1 0 1.42 1.42L11 5.41V16a1 1 0 0 0 2 0V5.41l2.29 2.3a1 1 0 0 0 1.42 0 1 1 0 0 0 0-1.42"/>
  <path fill="@image.color1" d="M18.86 22H5.14A2.08 2.08 0 0 1 3 20v-4a1 1 0 0 1 2 0v4h13.86a.22.22 0 0 0 .14 0v-4a1 1 0 0 1 2 0v4a2.08 2.08 0 0 1-2.14 2"/></svg>')
menu(title='Transfer.sh@"\t"cURL' mode='single' type='file' image=svg_curl) {
	$upload_single_link='https://transfer.sh/@str.replace(sel.file.name, " ", "_")'
	item(title='Upload to Transfer.sh for a day'
		cmd-line='/k curl @if(key.shift(), '-v') -H "Max-Days: 1" --upload-file @sel(true) @upload_single_link & echo. & pause & exit')
	item(title='Upload to Transfer.sh for 14 days'
		cmd-line='/k curl @if(key.shift(), '-v') --upload-file @sel(true) @upload_single_link & pause & exit')
	item(title='Upload to Transfer.sh for 1 Download'
		cmd-line='/k curl @if(key.shift(), '-v') -H "Max-Downloads: 1" --upload-file @sel(true) upload_single_link & pause & exit')
	separator()
	item(title='Upload to Transfer.sh for a day' keys='clipboard'
		cmd-line='/k curl --progress-bar -H "Max-Days: 1" --upload-file @sel(true) @upload_single_link | clip & exit')
	item(title='Upload to Transfer.sh for 14 days' keys='clipboard'
		cmd-line='/k curl --progress-bar --upload-file @sel(true) @upload_single_link | clip & exit')
	item(title='Upload to Transfer.sh for 1 Download' keys='clipboard'
		cmd-line='/k curl --progress-bar -H "Max-Downloads: 1" --upload-file @sel(true) upload_single_link | clip & exit')
	separator()
	item(title='Upload and Virusscan'
		cmd-line='/k curl @if(key.shift(), '-v') -X PUT --upload-file @sel(true) @upload_single_link/scan & echo. & pause & exit'	)
	separator()
	item(title='Service Info' tip='Open transfer.sh in browser for more details'
		cmd='https://transfer.sh/')
	item(title='Github Info' tip='Open github.com page in browser for more details'
		cmd='https://github.com/dutchcoders/transfer.sh/')
}