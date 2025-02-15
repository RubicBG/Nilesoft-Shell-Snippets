// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

menu(title='Go To@"\t"Registry' mode=mode.multiple image=\uE14A) {
	$reg_path = 'HKEY_CURRENT_USER\Software\Nilesoft\Shell\GoTo'
	$dir_max = 9
	$counter = len(reg.values(reg_path))
	$p00=null
	$p01=null
	$p02=null
	$p03=null
	$p04=null
	$p05=null
	$p06=null
	$p07=null
	$p08=null
	$p09=null
	menu(expanded='true' title={
		p00=reg.get(reg_path, 0)
		p01=reg.get(reg_path, 1)
		p02=reg.get(reg_path, 2)
		p03=reg.get(reg_path, 3)
		p04=reg.get(reg_path, 4)
		p05=reg.get(reg_path, 5)
		p06=reg.get(reg_path, 6)
		p07=reg.get(reg_path, 7)
		p08=reg.get(reg_path, 8)
		p09=reg.get(reg_path, 9)
	}) {
		item(title='Add current path' keys=counter+'/'+ toint(dir_max+1)
			type='drive|dir|back.drive|back.dir|desktop' image=icon.new_folder sep='both'
			vis=if(counter>=dir_max or sel==p00 or sel==p01 or sel==p02 and p03 or sel==p04 or sel==p05 or sel==p06 or sel==p07 or sel==p08 or sel==p09, 'disable')
			cmd=reg.set(reg_path, counter, sel, reg.sz))
	}
	item(title=if(len(path.location.name(p00))==1, p00, '...\@path.location.name(p00)\@path.title(p00)') where=path.exists(p00) image=\uE1F4 tip=p00 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p00), p00))
	item(title=if(len(path.location.name(p01))==1, p01, '...\@path.location.name(p01)\@path.title(p01)') where=path.exists(p01) image=\uE1F4 tip=p01 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p01), p01))
	item(title=if(len(path.location.name(p02))==1, p02, '...\@path.location.name(p02)\@path.title(p02)') where=path.exists(p02) image=\uE1F4 tip=p02 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p02), p02))
	item(title=if(len(path.location.name(p03))==1, p03, '...\@path.location.name(p03)\@path.title(p03)') where=path.exists(p03) image=\uE1F4 tip=p03 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p03), p03))
	item(title=if(len(path.location.name(p04))==1, p04, '...\@path.location.name(p04)\@path.title(p04)') where=path.exists(p04) image=\uE1F4 tip=p04 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p04), p04))
	item(title=if(len(path.location.name(p05))==1, p05, '...\@path.location.name(p05)\@path.title(p05)') where=path.exists(p05) image=\uE1F4 tip=p05 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p05), p05))
	item(title=if(len(path.location.name(p06))==1, p06, '...\@path.location.name(p06)\@path.title(p06)') where=path.exists(p06) image=\uE1F4 tip=p06 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p06), p06))
	item(title=if(len(path.location.name(p07))==1, p07, '...\@path.location.name(p07)\@path.title(p07)') where=path.exists(p07) image=\uE1F4 tip=p07 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p07), p07))
	item(title=if(len(path.location.name(p08))==1, p08, '...\@path.location.name(p08)\@path.title(p08)') where=path.exists(p08) image=\uE1F4 tip=p08 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p08), p09))
	item(title=if(len(path.location.name(p09))==1, p09, '...\@path.location.name(p09)\@path.title(p09)') where=path.exists(p09) image=\uE1F4 tip=p09 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p09), p09))
	item(title='Clear' where=counter>0 image=\uE0CE sep='both' cmd=reg.delete(reg_path) )
}