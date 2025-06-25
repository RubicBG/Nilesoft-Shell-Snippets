// Author: Rubic / RubicBG
// Based on: Nilesoft Shell original snippet
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

menu(title='Context Menu Mode' image=\uE0C5 vis=if(!sys.is11, 'disable')) {
	item(image=[\uE249, image.color2] title='Nilesoft Only' tip='Use only Nilesoft Shell context menu (removes Windows 11 "modern" context menu completely)'
		// admin cmd-ps=`& '@quote(app.exe)' '-s' '-u' '-t' '-restart'; & '@quote(app.exe)' '-s' '-r' '-t';`
		window='hidden' admin cmd-line=`/c call @quote(app.exe) -s -u -t -restart & call @quote(app.exe) -s -r -t`)
	$svg_hybrid = image.svg('<svg x="0px" y="0px" viewBox="0 0 512 512">
	  <path fill="@image.color2" d="M324.267,0c-87.951,0-161.765,60.484-182.142,142.124c14.602-3.645,29.879-5.591,45.609-5.591c103.682,0,187.733,84.052,187.733,187.733c0,15.732-1.946,31.007-5.591,45.609C451.516,349.498,512,275.685,512,187.733C512,84.052,427.948,0,324.267,0z"/>
	  <path fill="@image.color1" d="M324.267,375.467c-103.682,0-187.733-84.052-187.733-187.733c0-15.732,1.946-31.007,5.591-45.609C60.484,162.502,0,236.315,0,324.267C0,427.948,84.052,512,187.733,512c87.951,0,161.765-60.484,182.142-142.124C355.273,373.521,339.997,375.467,324.267,375.467z"/></svg>')
	item(image=svg_hybrid title='Hybrid Mode' tip='Combine Windows context menu with Nilesoft Shell via "Show more options" or Shift+Right-Click' commands {
		cmd = {	cfg_read = io.file.read(app.cfg)
				modified = regex.replace(cfg_read, '\s*(?:settings\.priority|priority)\s*=\s*(?:true|false|[01])', "\n")
				if(cfg_read!=modified, msg('Remove settings.priority from shell.nss', 'Nilesoft Shell', msg.warning) & io.delete(app.cfg) & io.file.create(app.cfg, modified)) } wait=1,
		// admin cmd-ps=`& '@quote(app.exe)' '-s' '-u' '-t' '-restart'; Sleep 2; & '@quote(app.exe)' '-s' '-r';`})
		window='hidden' admin cmd-line=`/c reg.exe delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f & call @quote(app.exe) -s -u -t -restart & timeout /t 2 /nobreak & call @quote(app.exe) -s -r` })
	separator()
	$svg_win = image.svg('<svg width="100" height="100" viewBox="-50 -50 612 612" >
	  <polygon style="fill:#90C300;" points="242.526,40.421 512,0 512,239.832 242.526,239.832 "/>
	  <polygon style="fill:#F8672C;" points="0,75.453 206.596,44.912 206.596,242.526 0,242.526 "/>
	  <polygon style="fill:#FFC400;" points="242.526,471.579 512,512 512,278.456 242.526,278.456 "/>
	  <polygon style="fill:#00B4F2;" points="0,436.547 206.596,467.088 206.596,278.456 0,278.456 "/></svg>')
	item(image=svg_win title='Windows Default' keys='SHIFT run' tip='Restore original Windows 11 context menu (disables Nilesoft Shell until manually re-enabled)' + "\n\n" + 'Hold SHIFT to run Nilesoft Shell afterwards.'  commands {
		cmd = {	cfg_read = io.file.read(app.cfg)
				modified = regex.replace(cfg_read, '\s*(?:settings\.priority|priority)\s*=\s*(?:true|false|[01])', "\n")
				if(cfg_read!=modified, msg('Remove settings.priority from shell.nss', 'Nilesoft Shell', msg.warning) & io.delete(app.cfg) & io.file.create(app.cfg, modified)) } wait=1, 
		// admin cmd-ps=`& '@quote(app.exe)' '-s' '-u' '-t' '-restart'; Sleep 2; & '@quote(app.exe)' '-s' '-r';`})
		window='hidden' admin cmd-line=`/c reg.exe delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f & call @quote(app.exe) -s -u -t -restart @if(key.shift(), '& call @quote(app.exe)')` })
}