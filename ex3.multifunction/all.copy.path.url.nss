// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

menu(image=icon.copy_path title='Copy &url path' mode='single' type='file' where=sel.file.ext=='.url') {
	$url=io.meta(sel,'System.Link.TargetParsingPath')
	//https://en.wikipedia.org/wiki/List_of_URI_schemes
	$url_scheme=regex.matches(url, '^([a-zA-Z0-9]+):(\/\/)?')
	$url_domain=regex.matches(url, '^([a-zA-Z0-9]+):(\/\/)?(www\.)?([a-zA-Z0-9._\[\]:+-]+)@?([a-zA-Z0-9._-]+)?')
	
	item(title=url keys='SHIFT launch' cmd=if(keys.shift(), this.title, command.copy(this.title)))
	item(title=str.replace(url, url_scheme[0],'') cmd=command.copy(this.title))
	separator()
	item(title=url_domain[0] keys='SHIFT launch' cmd=if(keys.shift(), this.title, command.copy(this.title)))
	item(title=str.replace(url_domain[0], url_scheme[0], '') cmd=command.copy(this.title))
	separator()
	item(title=str.remove(url_domain[0], 0, 1+str.find(url_domain[0], '@')) cmd=command.copy(this.title) where=str.contains(url_domain[0], '@'))
	item(title=url_scheme[0] cmd=command.copy(this.title)) }
