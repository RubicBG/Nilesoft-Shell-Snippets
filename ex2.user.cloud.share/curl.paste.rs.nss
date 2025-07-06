// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

$paste_rs_check_file_extensions = str.contains('.nss|.adp|.applescript|.as|.asa|.asp|.bash|.bat|.bib|.bsh|.build|.builder|.c|.c++|.cc|.cgi|.cl|.clisp|.clj|.cls|.cmd|.cp|.cpp|.cpy|.cs|.css|.css.erb|.css.liquid|.csx|.cxx|.d|.ddl|.di|.diff|.dml|.dot|.dpr|.dtml|.el|.erb|.erbsql|.erl|.fasl|.fcgi|.fish|.gemspec|.go|.gradle|.groovy|.gv|.gvy|.gyp|.gypi|.h|.h++|.haml|.hh|.hpp|.hrl|.hs|.htc|.htm|.html|.html.erb|.hxx|.inc|.inl|.ipp|.irbrc|.java|.jbuilder|.js|.js.erb|.json|.jsp|.l|.lhs|.lisp|.lsp|.ltx|.lua|.m|.mak|.make|.markdn|.markdown|.matlab|.md|.mdown|.mk|.ml|.mli|.mll|.mly|.mm|.mud|.opml|.p|.pas|.patch|.php|.php3|.php4|.php5|.php7|.phps|.phpt|.phtml|.pl|.pm|.pod|.podspec|.prawn|.properties|.pxd|.pxd.in|.pxi|.pxi.in|.py|.py3|.pyi|.pyw|.pyx|.pyx.in|.r|.rabl|.rails|.rake|.rb|.rbx|.rd|.re|.rest|.rhtml|.rjs|.rpy|.rs|.rss|.rst|.rxml|.s|.sass|.sbt|.scala|.scm|.sh|.shtml|.simplecov|.sql|.sql.erb|.ss|.sty|.svg|.t|.tcl|.tex|.textile|.thor|.tld|.tmpl|.tpl|.txt|.xhtml|.xml|.xsd|.xslt|.yaml|.yaws|.yml|.zsh|', sel.file.ext+'|')
$paste_rs_check_special_filenames = str.contains('|Appfile|Appraisals|Berksfile|Brewfile|C|Cheffile|DOT|Deliverfile|Emakefile|Fastfile|GNUmakefile|Gemfile|Guardfile|M|Makefile|OCamlMakefile|PL|R|Rakefile|Rantfile|Rprofile|S|SConscript|SConstruct|Scanfile|Snakefile|Snapfile|Thorfile|Vagrantfile|Capfile|config.ru|rails|simplecov|wscript|', '|'+sel.file.title+'|')

menu(title='paste.rs@"\t"cURL' type='file' image=[\uE114, image.color2]) {
	item(title='Quick Upload' keys='SHIFT more info' tip='no restrictions specified'
		mode='single' type='file' where=paste_rs_check_file_extensions or paste_rs_check_special_filenames
		cmd-line='/k curl @if(key.shift(), '-i') -F file=@@"@sel.file.name" https://paste.rs/ & echo @str.replace(sel.file.ext, '.nss', '.js') & echo. & pause & exit')
	item(title='Delete Upload' mode='single' tip='Delete upload based on url'
		 cmd-line='/k @if(input('Nilesoft Shell', 'Enter full url') and len(input.result)>0, 'curl -X DELETE @input.result', 'echo no url') & echo. & pause & exit')
	separator()
	item(title='Manual Upload' tip='Open paste.rs in browser and upload text manually'
		cmd='https://paste.rs/web/')
	separator()
	item(title='Service Info' tip='Open paste.rs in browser for more details'
		cmd='https://paste.rs/')
	// https://clbin.com/ is shutting down
}