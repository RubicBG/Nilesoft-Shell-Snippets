// Author: Rubic / RubicBG
// Based on: Inasnum's idea (Discord)
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

menu(title='DirectX Compatibility' image='dxdiag.exe') {
	item(title='DirectX Diagnostic Tool' image tip='Useful for solving hardware and DirectX related issues' 
		admin cmd='DXDiag')
	separator()
	$isDXCpl = path.exists('@sys.bin\DXCpl.exe')
	item(title='install DirectX Compatibility' image=inherit
		tip='Click to automatically download needed Graphic Tools features and install them'
		vis=!isDXCpl
		admin cmd-line='/c DISM /online /add-capability /capabilityname:tools.graphics.directx' window=0)
	item(title='DirectX Control Panel' image=inherit
		tip='Tool to specifically set DirectX flags, feature levels, and use WARP - Very useful for slightly out of date Hardware'
		vis=if(!isDXCpl, 'disable')
		admin cmd='DXCpl')
	$isD3dcg = path.exists('@sys.bin\d3dconfig.exe')
	$runDXCpl = if(keys.shift(), ' & DXCpl.exe')

	$d3d_keys = reg.keys('HKCU\Software\Microsoft\Direct3D')
	$d3d_paths = null
	$d3d_gets = for(i=0, i<length(d3d_keys)) { 
		if(i==0, d3d_paths = '|')
		if(not(str.start(d3d_keys[i], 'Application')), continue)
		d3d_paths+=reg.get('HKCU\Software\Microsoft\Direct3D\'+d3d_keys[i], 'Name') + '|'}
	menu(expanded=1 where=sel.file.ext=='.exe' or sel.type==3 or sel.back  title={ d3d_gets } tip=d3d_paths)
	{
		$isIn = str.contains(d3d_paths, '|'+sel+if(sel.type==3, '\')+'|')
		item(title='Add to DirectX Control Panel' keys='SHIFT run DXCpl' image=\uE1D2
			tip='Add @sel.name to the DirectX Control Panel list for adjustments. Use SHIFT to open DirectX Control Panel afterwards'
			vis=if(!isD3dcg or isIn, 'disable')
			admin cmd-line='/c (d3dconfig apps --add "@sel@if(sel.type==3, '\\')") @runDXCpl' window=0)
		item(title='Remove @sel.name from DirectX Control Panel' keys='SHIFT run DXCpl' image=\uE1D3
			tip='Remove @sel.name from the DirectX Control Panel list. Use SHIFT to open DirectX Control Panel afterwards'
			vis=if(!isD3dcg or !isIn, 'disable')
			admin cmd-line='/c (d3dconfig apps --remove "@sel@if(sel.type==3, '\\')") @runDXCpl' window=0)
	}
	item(title='Reset the DirectX Control Panel App/Directory list' keys='SHIFT run DXCpl' image=\uE12A
		tip='Remove ALL entries from the DirectX Control Panel list. Use SHIFT to open DirectX Control Panel afterwards'
		vis=if(!isD3dcg, 'disable')
		admin cmd-line='/c (d3dconfig apps --clear) @runDXCpl' window=0)
}