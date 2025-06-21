// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

$svg_curl=image.svg('<svg width="800" height="800" viewBox="0 0 24 24">
  <path fill="@image.color2" d="m16.71 6.29-4-4a1 1 0 0 0-1.42 0l-4 4a1 1 0 1 0 1.42 1.42L11 5.41V16a1 1 0 0 0 2 0V5.41l2.29 2.3a1 1 0 0 0 1.42 0 1 1 0 0 0 0-1.42"/>
  <path fill="@image.color1" d="M18.86 22H5.14A2.08 2.08 0 0 1 3 20v-4a1 1 0 0 1 2 0v4h13.86a.22.22 0 0 0 .14 0v-4a1 1 0 0 1 2 0v4a2.08 2.08 0 0 1-2.14 2"/></svg>')
menu(title='uguu.se@"\t"cURL' mode='single' type='file' image=svg_curl) {
	item(title='Quick Upload for 3 hours' keys='SHIFT more info' tip='Current file size limit is 128MB.'
    	cmd-line='/k curl @if(key.shift(), '-i') -F files[]=@@"@sel.file.name" https://uguu.se/upload & echo. & pause & exit')
	separator()
	item(title='Service Info' tip='Open uguu.se in browser for more details' // https://pomf.se (RIP)
		cmd='https://uguu.se/')
}
