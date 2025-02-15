// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

menu(title='Go To@"\t"Temporary' type='*' mode=mode.multiple image=\uE14A) {
	// default order
	$do='0123456789'
	// next item
	$ni = 0
	// item paths
	$ip = ''

	item(title='Add current path' keys=ni+'/'+len(do) type='drive|dir|back.drive|back.dir|Desktop' 
		vis=if(len(do)<=ni or str.contains(str.join(ip,'|')+'|', sel+'|'), 'disable', 'normal') sep='both' image=icon.new_folder
		cmd={ ip=[  if(ni==0, sel, ip[0]), if(ni==1, sel, ip[1]), if(ni==2, sel, ip[2]), if(ni==3, sel, ip[3]), if(ni==4, sel, ip[4]), 
					if(ni==5, sel, ip[5]), if(ni==6, sel, ip[6]), if(ni==7, sel, ip[7]), if(ni==8, sel, ip[8]), if(ni==9, sel, ip[9])] ni+=1 })
	item(title=ip[toint(do[0])] where=path.exists(ip[toint(do[0])]) image=\uE1F4 commands{
		cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(this.title), this.title),
		/*no need to change the order*/})
	item(title=ip[toint(do[1])] where=path.exists(ip[toint(do[1])]) image=\uE1F4 commands{
		cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(this.title), this.title), 
		cmd={ do=str.get(do, 1)+str.remove(do, 1, 1) }})
	item(title=ip[toint(do[2])] where=path.exists(ip[toint(do[2])]) image=\uE1F4 commands{
		cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(this.title), this.title), 
		cmd={ do=str.get(do, 2)+str.remove(do, 2, 1) }})
	item(title=ip[toint(do[3])] where=path.exists(ip[toint(do[3])]) image=\uE1F4 commands{
		cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(this.title), this.title),
		cmd={ do=str.get(do, 3)+str.remove(do, 3, 1) }})
	item(title=ip[toint(do[4])] where=path.exists(ip[toint(do[4])]) image=\uE1F4 commands{
		cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(this.title), this.title),
		cmd={ do=str.get(do, 4)+str.remove(do, 4, 1) }})
	item(title=ip[toint(do[5])] where=path.exists(ip[toint(do[5])]) image=\uE1F4 commands{
		cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(this.title), this.title),
		cmd={ do=str.get(do, 5)+str.remove(do, 5, 1) }})
	item(title=ip[toint(do[6])] where=path.exists(ip[toint(do[6])]) image=\uE1F4 commands{
		cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(this.title), this.title),
		cmd={ do=str.get(do, 6)+str.remove(do, 6, 1) }})
	item(title=ip[toint(do[7])] where=path.exists(ip[toint(do[7])]) image=\uE1F4 commands{
		cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(this.title), this.title),
		cmd={ do=str.get(do, 7)+str.remove(do, 7, 1) }})
	item(title=ip[toint(do[8])] where=path.exists(ip[toint(do[8])]) image=\uE1F4 commands{
		cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(this.title), this.title),
		cmd={ do=str.get(do, 8)+str.remove(do, 8, 1) }})
	item(title=ip[toint(do[9])] where=path.exists(ip[toint(do[9])]) image=\uE1F4 commands{
		cmd=if(window.name=='CabinetWClass' and !keys.shift(), command.navigate(this.title), this.title),
		cmd={ do=str.get(do, 9)+str.remove(do, 9, 1) }})
	item(title='Clear' where=ni>0 image=image.glyph(\uE0CE) sep='both' cmd={ do='0123456789' ni=0 ip='' })
	// where=keys.shift()
	item(title='Set NS sys...'  image=image.glyph(\uE0F9) cmd={ do='0123456789' ip=[user.desktop, user.downloads, user.documents, user.pictures] ni=len(ip) })
	item(title='Set NS user...' image=image.glyph(\uE0F9) cmd={ do='01234'      ip=['sys.dir', sys.bin, sys.prog, sys.prog32, sys.users] ni=len(ip) })
	item(title='Set Example...' image=image.glyph(\uE0F9) cmd={ do='0123456789' ip=['C:', user.desktop, '%temp%', sys.prog, sys.bin, '@user.localappdata\Programs\Microsoft VS Code'] ni=len(ip) }) }