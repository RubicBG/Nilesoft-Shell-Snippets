// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

/* eanble/desable or reset the entries in the Run dialog box
	Settings > Privacy & security > General > Let Windows improve Start and search results by tracking app launches
	$enabel_tracking = reg.get('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced', 'Start_TrackProgs')
	*/
menu(title='Go To@"\t"RUN' type='*' mode=mode.multiple
	where=reg.exists('HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RunMRU', 'a') image=\uE14A) {
	$reg_path = 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RunMRU'
	$runO = null
	menu(title={ runO = reg.get(reg_path,'MRUList') } expanded='true') {
		// path.type corrently not working to determine file, dir, comand for better icons
		item(title=str.replace(reg.get(reg_path,runO[00]), '\1', '') where=reg.exists(reg_path, runO[00]) image cmd=sys.expand(this.title))
		item(title=str.replace(reg.get(reg_path,runO[01]), '\1', '') where=reg.exists(reg_path, runO[01]) image cmd=sys.expand(this.title))
		item(title=str.replace(reg.get(reg_path,runO[02]), '\1', '') where=reg.exists(reg_path, runO[02]) image cmd=sys.expand(this.title))
		item(title=str.replace(reg.get(reg_path,runO[03]), '\1', '') where=reg.exists(reg_path, runO[03]) image cmd=sys.expand(this.title))
		item(title=str.replace(reg.get(reg_path,runO[04]), '\1', '') where=reg.exists(reg_path, runO[04]) image cmd=sys.expand(this.title))
		item(title=str.replace(reg.get(reg_path,runO[05]), '\1', '') where=reg.exists(reg_path, runO[05]) image cmd=sys.expand(this.title))
		item(title=str.replace(reg.get(reg_path,runO[06]), '\1', '') where=reg.exists(reg_path, runO[06]) image cmd=sys.expand(this.title))
		item(title=str.replace(reg.get(reg_path,runO[07]), '\1', '') where=reg.exists(reg_path, runO[07]) image cmd=sys.expand(this.title))
		item(title=str.replace(reg.get(reg_path,runO[08]), '\1', '') where=reg.exists(reg_path, runO[08]) image cmd=sys.expand(this.title))
		item(title=str.replace(reg.get(reg_path,runO[09]), '\1', '') where=reg.exists(reg_path, runO[09]) image cmd=sys.expand(this.title))
		item(title=str.replace(reg.get(reg_path,runO[10]), '\1', '') where=reg.exists(reg_path, runO[10]) image cmd=sys.expand(this.title))
		item(title=str.replace(reg.get(reg_path,runO[11]), '\1', '') where=reg.exists(reg_path, runO[11]) image cmd=sys.expand(this.title))
		item(title=str.replace(reg.get(reg_path,runO[12]), '\1', '') where=reg.exists(reg_path, runO[12]) image cmd=sys.expand(this.title))
		item(title=str.replace(reg.get(reg_path,runO[13]), '\1', '') where=reg.exists(reg_path, runO[13]) image cmd=sys.expand(this.title))
		item(title=str.replace(reg.get(reg_path,runO[14]), '\1', '') where=reg.exists(reg_path, runO[14]) image cmd=sys.expand(this.title))
		item(title=str.replace(reg.get(reg_path,runO[15]), '\1', '') where=reg.exists(reg_path, runO[15]) image cmd=sys.expand(this.title)) } 
	item(title='Clear Run history' image=image.glyph(\uE0CE) sep='both' cmd=reg.delete(reg_path)) }
