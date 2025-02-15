// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

/* eanble/desable or reset the entries in the Address Bar
	Settings > Privacy & security > General > Let Windows improve Start and search results by tracking app launches
	$enabel_tracking = reg.get('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced', 'Start_TrackProgs')
	*/
menu(title='Go To@"\t"Address Bar' where=reg.exists('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\TypedPaths', 'url1') image=\uE14A) {
	$reg_path = 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\TypedPaths'
	$p01=null
	$p02=null
	$p03=null
	$p04=null
	$p05=null
	$p06=null
	$p07=null
	$p08=null
	$p09=null
	$p10=null
	$p11=null
	$p12=null
	$p13=null
	$p14=null
	$p15=null
	$p16=null
	$p17=null
	$p18=null
	$p19=null
	$p20=null
	$p21=null
	$p22=null
	$p23=null
	$p24=null
	$p25=null
	$p26=null
	menu(expanded='true' title={
		p01=reg.get(reg_path, 'url1')
		p02=reg.get(reg_path, 'url2')
		p03=reg.get(reg_path, 'url3')
		p04=reg.get(reg_path, 'url4')
		p05=reg.get(reg_path, 'url5')
		p06=reg.get(reg_path, 'url6')
		p07=reg.get(reg_path, 'url7')
		p08=reg.get(reg_path, 'url8')
		p09=reg.get(reg_path, 'url9')
		p10=reg.get(reg_path, 'url10')
		p11=reg.get(reg_path, 'url11')
		p12=reg.get(reg_path, 'url12')
		p13=reg.get(reg_path, 'url13')
		p14=reg.get(reg_path, 'url14')
		p15=reg.get(reg_path, 'url15')
		p16=reg.get(reg_path, 'url16')
		p17=reg.get(reg_path, 'url17')
		p18=reg.get(reg_path, 'url18')
		p19=reg.get(reg_path, 'url19')
		p20=reg.get(reg_path, 'url20')
		p21=reg.get(reg_path, 'url21')
		p22=reg.get(reg_path, 'url22')
		p23=reg.get(reg_path, 'url23')
		p24=reg.get(reg_path, 'url24')
		p25=reg.get(reg_path, 'url25')
		p26=reg.get(reg_path, 'url26')
	}) {
		item(title=if(len(path.location.name(p01))==1, p01, '...\@path.location.name(p01)\@path.title(p01)') where=path.exists(p01) image=\uE1F4 tip=p01 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p01), p01))
		item(title=if(len(path.location.name(p02))==1, p02, '...\@path.location.name(p02)\@path.title(p02)') where=path.exists(p02) image=\uE1F4 tip=p02 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p02), p02))
		item(title=if(len(path.location.name(p03))==1, p03, '...\@path.location.name(p03)\@path.title(p03)') where=path.exists(p03) image=\uE1F4 tip=p03 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p03), p03))
		item(title=if(len(path.location.name(p04))==1, p04, '...\@path.location.name(p04)\@path.title(p04)') where=path.exists(p04) image=\uE1F4 tip=p04 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p04), p04))
		item(title=if(len(path.location.name(p05))==1, p05, '...\@path.location.name(p05)\@path.title(p05)') where=path.exists(p05) image=\uE1F4 tip=p05 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p05), p05))
		item(title=if(len(path.location.name(p06))==1, p06, '...\@path.location.name(p06)\@path.title(p06)') where=path.exists(p06) image=\uE1F4 tip=p06 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p06), p06))
		item(title=if(len(path.location.name(p07))==1, p07, '...\@path.location.name(p07)\@path.title(p07)') where=path.exists(p07) image=\uE1F4 tip=p07 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p07), p07))
		item(title=if(len(path.location.name(p08))==1, p08, '...\@path.location.name(p08)\@path.title(p08)') where=path.exists(p08) image=\uE1F4 tip=p08 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p08), p08))
		item(title=if(len(path.location.name(p09))==1, p09, '...\@path.location.name(p09)\@path.title(p09)') where=path.exists(p09) image=\uE1F4 tip=p09 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p09), p09))
		item(title=if(len(path.location.name(p10))==1, p10, '...\@path.location.name(p10)\@path.title(p10)') where=path.exists(p10) image=\uE1F4 tip=p10 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p10), p10))
		item(title=if(len(path.location.name(p11))==1, p11, '...\@path.location.name(p11)\@path.title(p11)') where=path.exists(p11) image=\uE1F4 tip=p11 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p11), p11))
		item(title=if(len(path.location.name(p12))==1, p12, '...\@path.location.name(p12)\@path.title(p12)') where=path.exists(p12) image=\uE1F4 tip=p12 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p12), p12))
		item(title=if(len(path.location.name(p13))==1, p13, '...\@path.location.name(p13)\@path.title(p13)') where=path.exists(p13) image=\uE1F4 tip=p13 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p13), p13))
		item(title=if(len(path.location.name(p14))==1, p14, '...\@path.location.name(p14)\@path.title(p14)') where=path.exists(p14) image=\uE1F4 tip=p14 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p14), p14))
		item(title=if(len(path.location.name(p15))==1, p15, '...\@path.location.name(p15)\@path.title(p15)') where=path.exists(p15) image=\uE1F4 tip=p15 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p15), p15))
		item(title=if(len(path.location.name(p16))==1, p16, '...\@path.location.name(p16)\@path.title(p16)') where=path.exists(p16) image=\uE1F4 tip=p16 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p16), p16))
		item(title=if(len(path.location.name(p17))==1, p17, '...\@path.location.name(p17)\@path.title(p17)') where=path.exists(p17) image=\uE1F4 tip=p17 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p17), p17))
		item(title=if(len(path.location.name(p18))==1, p18, '...\@path.location.name(p18)\@path.title(p18)') where=path.exists(p18) image=\uE1F4 tip=p18 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p18), p18))
		item(title=if(len(path.location.name(p19))==1, p19, '...\@path.location.name(p19)\@path.title(p19)') where=path.exists(p19) image=\uE1F4 tip=p19 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p19), p19))
		item(title=if(len(path.location.name(p20))==1, p20, '...\@path.location.name(p20)\@path.title(p20)') where=path.exists(p20) image=\uE1F4 tip=p20 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p20), p20))
		item(title=if(len(path.location.name(p21))==1, p21, '...\@path.location.name(p21)\@path.title(p21)') where=path.exists(p21) image=\uE1F4 tip=p21 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p21), p21))
		item(title=if(len(path.location.name(p22))==1, p22, '...\@path.location.name(p22)\@path.title(p22)') where=path.exists(p22) image=\uE1F4 tip=p22 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p22), p22))
		item(title=if(len(path.location.name(p23))==1, p23, '...\@path.location.name(p23)\@path.title(p23)') where=path.exists(p23) image=\uE1F4 tip=p23 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p23), p23))
		item(title=if(len(path.location.name(p24))==1, p24, '...\@path.location.name(p24)\@path.title(p24)') where=path.exists(p24) image=\uE1F4 tip=p24 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p24), p24))
		item(title=if(len(path.location.name(p25))==1, p25, '...\@path.location.name(p25)\@path.title(p25)') where=path.exists(p25) image=\uE1F4 tip=p25 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p25), p25))
		item(title=if(len(path.location.name(p26))==1, p26, '...\@path.location.name(p26)\@path.title(p26)') where=path.exists(p26) image=\uE1F4 tip=p26 cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(p26), p26))	
	}
	item(title='Clear Address Bar history' image=image.glyph(\uE0CE) sep='both' cmd=reg.delete(reg_path))
}