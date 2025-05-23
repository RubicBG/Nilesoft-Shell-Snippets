// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

menu(title='Swap Drive Letter' image=\uE1A9 vis=if(!path.isroot(sel) or str.contains(sel, sys.root), 'disable')
	where=(io.meta(sel, 'System.ItemTypeText')=='Local Disk' or io.meta(sel, 'System.ItemTypeText')=='USB Drive')
		and !path.exists(ini.get('@sel\desktop.ini', 'Nilesoft', 'subst'))) {
	item(title = 'A:' vis=if(path.exists('A:'),'disable') where=key.shift()
		admin cmd-ps='-command Set-Partition -DriveLetter @str.left(@sel, 1) -NewDriveLetter A; Exit' window='hidden')
	item(title = 'B:' vis=if(path.exists('B:'),'disable') where=key.shift()
		admin cmd-ps='-command Set-Partition -DriveLetter @str.left(@sel, 1) -NewDriveLetter B; Exit' window='hidden')
	item(title = 'C:' vis=if(path.exists('C:'),'disable') col
		admin cmd-ps='-command Set-Partition -DriveLetter @str.left(@sel, 1) -NewDriveLetter C; Exit' window='hidden')
	item(title = 'D:' vis=if(path.exists('D:'),'disable')
		admin cmd-ps='-command Set-Partition -DriveLetter @str.left(@sel, 1) -NewDriveLetter D; Exit' window='hidden')
	item(title = 'E:' vis=if(path.exists('E:'),'disable')
		admin cmd-ps='-command Set-Partition -DriveLetter @str.left(@sel, 1) -NewDriveLetter E; Exit' window='hidden')
	item(title = 'F:' vis=if(path.exists('F:'),'disable')
		admin cmd-ps='-command Set-Partition -DriveLetter @str.left(@sel, 1) -NewDriveLetter F; Exit' window='hidden')
	item(title = 'G:' vis=if(path.exists('G:'),'disable')
		admin cmd-ps='-command Set-Partition -DriveLetter @str.left(@sel, 1) -NewDriveLetter G; Exit' window='hidden')
	item(title = 'H:' vis=if(path.exists('H:'),'disable')
		admin cmd-ps='-command Set-Partition -DriveLetter @str.left(@sel, 1) -NewDriveLetter H; Exit' window='hidden')
	item(title = 'I:' vis=if(path.exists('I:'),'disable') col
		admin cmd-ps='-command Set-Partition -DriveLetter @str.left(@sel, 1) -NewDriveLetter I; Exit' window='hidden')
	item(title = 'J:' vis=if(path.exists('J:'),'disable')
		admin cmd-ps='-command Set-Partition -DriveLetter @str.left(@sel, 1) -NewDriveLetter J; Exit' window='hidden')
	item(title = 'K:' vis=if(path.exists('K:'),'disable')
		admin cmd-ps='-command Set-Partition -DriveLetter @str.left(@sel, 1) -NewDriveLetter K; Exit' window='hidden')
	item(title = 'L:' vis=if(path.exists('L:'),'disable')
		admin cmd-ps='-command Set-Partition -DriveLetter @str.left(@sel, 1) -NewDriveLetter L; Exit' window='hidden')
	item(title = 'M:' vis=if(path.exists('M:'),'disable')
		admin cmd-ps='-command Set-Partition -DriveLetter @str.left(@sel, 1) -NewDriveLetter M; Exit' window='hidden')
	item(title = 'N:' vis=if(path.exists('N:'),'disable')
		admin cmd-ps='-command Set-Partition -DriveLetter @str.left(@sel, 1) -NewDriveLetter N; Exit' window='hidden')
	item(title = 'O:' vis=if(path.exists('O:'),'disable') col
		admin cmd-ps='-command Set-Partition -DriveLetter @str.left(@sel, 1) -NewDriveLetter O; Exit' window='hidden')
	item(title = 'P:' vis=if(path.exists('P:'),'disable')
		admin cmd-ps='-command Set-Partition -DriveLetter @str.left(@sel, 1) -NewDriveLetter P; Exit' window='hidden')
	item(title = 'Q:' vis=if(path.exists('Q:'),'disable')
		admin cmd-ps='-command Set-Partition -DriveLetter @str.left(@sel, 1) -NewDriveLetter Q; Exit' window='hidden')
	item(title = 'R:' vis=if(path.exists('R:'),'disable')
		admin cmd-ps='-command Set-Partition -DriveLetter @str.left(@sel, 1) -NewDriveLetter R; Exit' window='hidden')
	item(title = 'S:' vis=if(path.exists('S:'),'disable')
		admin cmd-ps='-command Set-Partition -DriveLetter @str.left(@sel, 1) -NewDriveLetter S; Exit' window='hidden')
	item(title = 'T:' vis=if(path.exists('T:'),'disable')
		admin cmd-ps='-command Set-Partition -DriveLetter @str.left(@sel, 1) -NewDriveLetter T; Exit' window='hidden')
	item(title = 'U:' vis=if(path.exists('U:'),'disable') col
		admin cmd-ps='-command Set-Partition -DriveLetter @str.left(@sel, 1) -NewDriveLetter U; Exit' window='hidden')
	item(title = 'V:' vis=if(path.exists('V:'),'disable')
		admin cmd-ps='-command Set-Partition -DriveLetter @str.left(@sel, 1) -NewDriveLetter V; Exit' window='hidden')
	item(title = 'W:' vis=if(path.exists('W:'),'disable')
		admin cmd-ps='-command Set-Partition -DriveLetter @str.left(@sel, 1) -NewDriveLetter W; Exit' window='hidden')
	item(title = 'X:' vis=if(path.exists('X:'),'disable')
		admin cmd-ps='-command Set-Partition -DriveLetter @str.left(@sel, 1) -NewDriveLetter X; Exit' window='hidden')
	item(title = 'Y:' vis=if(path.exists('Y:'),'disable')
		admin cmd-ps='-command Set-Partition -DriveLetter @str.left(@sel, 1) -NewDriveLetter Y; Exit' window='hidden')
	item(title = 'Z:' vis=if(path.exists('Z:'),'disable')
		admin cmd-ps='-command Set-Partition -DriveLetter @str.left(@sel, 1) -NewDriveLetter Z; Exit' window='hidden') }