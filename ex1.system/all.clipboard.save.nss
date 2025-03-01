// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

$svg_save = '<svg width="100" height="100" viewBox="0 0 52 52">
  <path fill="@image.color1" d="M37.1 4v13.6c0 1-.8 1.9-1.9 1.9H13.9c-1 0-1.9-.8-1.9-1.9V4H8C5.8 4 4 5.8 4 8v36c0 2.2 1.8 4 4 4h36c2.2 0 4-1.8 4-4V11.2L40.8 4zm7 38.1c0 1-.8 1.9-1.9 1.9H9.9c-1 0-1.9-.8-1.9-1.9V25.4c0-1 .8-1.9 1.9-1.9h32.3c1 0 1.9.8 1.9 1.9z"/>
  <path fill="@image.color2" d="M24.8 13.6c0 1 .8 1.9 1.9 1.9h4.6c1 0 1.9-.8 1.9-1.9V4h-8.3z"/></svg>'
item(title='Save Image' keys='.png' type='back.dir|back.drive|desktop' image=svg_save pos=indexof(str.replace(title.paste, '&', ''), 1) tip='Save the image to a file from the clipboard.'
	where=clipboard.is_bitmap commands {
	cmd-ps=`$filePath = '@path.combine(sel, sys.datetime("ymd-HMS") + '.png')'; Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; try { $image = [System.Windows.Forms.Clipboard]::GetImage(); $image.Save($filePath, [System.Drawing.Imaging.ImageFormat]::Png) } catch { Write-Host "Failed to save image to file: $_" }` window='hidden' wait=1,
	cmd=msg.beep, })