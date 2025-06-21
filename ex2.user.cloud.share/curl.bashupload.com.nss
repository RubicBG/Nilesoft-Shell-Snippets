// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

$svg_curl=image.svg('<svg width="800" height="800" viewBox="0 0 24 24">
  <path fill="@image.color2" d="m16.71 6.29-4-4a1 1 0 0 0-1.42 0l-4 4a1 1 0 1 0 1.42 1.42L11 5.41V16a1 1 0 0 0 2 0V5.41l2.29 2.3a1 1 0 0 0 1.42 0 1 1 0 0 0 0-1.42"/>
  <path fill="@image.color1" d="M18.86 22H5.14A2.08 2.08 0 0 1 3 20v-4a1 1 0 0 1 2 0v4h13.86a.22.22 0 0 0 .14 0v-4a1 1 0 0 1 2 0v4a2.08 2.08 0 0 1-2.14 2"/></svg>')
menu(title='bashupload.com@"\t"cURL' mode='multiple' type='file' image=svg_curl) {
	item(title='Quick Upload' mode='single' tip='Upload file with original name. 50GB max, stored 3 days, single download.'
		 cmd-line='/k curl -T "@sel.file" https://bashupload.com/ & echo. & pause & exit')
	item(title='Upload with custom name' mode='single' tip='Upload file with a custom filename on the server'
		 cmd-line='/k @if(input('Nilesoft Shell', 'Enter custom name') and len(input.result)>0, 'curl --data-binary @@"@sel.file" "https://bashupload.com/@input.result"', 'echo no custom name') & echo. & pause & exit')
	$multi_correct_str=null
	item(title='Upload as Form Data' mode='multiple' tip='Upload using multipart form data method' commands{
		cmd={ multi_correct_str=null files = str.split(sel(false, "\n"), "\n") for(i=0, i<len(files)) { file=` -F file@(@i+1)=@@"@files[i]"` multi_correct_str+=file } }, 
		cmd-line='/k curl @multi_correct_str https://bashupload.com/ & pause & exit'} )
	separator()
	item(title='Service Info' tip='Open bashupload.com in browser for more details'
		 cmd='https://bashupload.com/')
}