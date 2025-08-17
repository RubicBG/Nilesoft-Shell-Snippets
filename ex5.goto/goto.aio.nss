// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

menu(expanded='true' where=keys.shift() and wnd.instance!='comdlg32.dll' type='back')
{
	separator()
	import if(path.exists('goto.temp.nss'), 'goto.temp.nss')
	import if(path.exists('goto.temp.nss'), 'goto.temp.nss')
	import if(path.exists('goto.temp.nss'), 'goto.temp.nss')
	separator()
	import if(path.exists('goto.reg.nss'), 'goto.reg.nss')
	import if(path.exists('goto.run.nss'), 'goto.run.nss')
	import if(path.exists('goto.address.nss'), 'goto.address.nss')
	import if(path.exists('goto.v2.nss'), 'goto.v2.nss')
	separator()
}

