// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

menu(title='Phrases' type='*' where=wnd.is_edit pos=indexof('select all', 1) image=image.fluent(\uF684) sep='both') {
	menu(title='examples' expanded='true' where=keys.shift()) {
		item(title='copy phrase, then paste' keys='clip' tip='Copy the phrase to clipboard and then paste it.'
			commands { cmd=command.copy(this.title) wait=1, cmd=keys.send(key.ctrl, 86) })
		item(title='type phrase' keys='1by1' tip='Insert the phrase character by character.'
			cmd-ps=`Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('@this.title');` window=cmd.hidden)
		/* Character - Escape Sequence
			+	{+}
			^	{^}
			%	{%}
			(	{(}
			)	{)}
			{	{{}
			}	{}}
			[	{[}
			]	{]}
			~	{~}
			!	{!}
			"	{"}
			'	{'} */
		item(title='(use escape sequence)' keys='1by1' tip='Escape Char is used to represent a character that is not printable or to represent a special character. It is preceded with { and followed with }.'
			cmd-ps=`Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('@str.replace(this.title, '(', '{(}').replace(')', '{)}')');` window=cmd.hidden)
		item(title='Unsupported phrase:' keys='1by1' tip='unsupported character will be skipped.'
			cmd-ps=`Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('@this.title');` window=cmd.hidden)
		separator() }

	item(title=sys.datetime.date keys='1by1'
		cmd-ps=`Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('@this.title');` window=cmd.hidden)
	item(title=sys.datetime("H.M") keys='1by1'
		cmd-ps=`Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('@this.title');` window=cmd.hidden)
	item(title='New Project' keys='1by1'
		cmd-ps=`Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('@this.title');` window=cmd.hidden)
	item(title='With Love for Nilesoft Shell' keys='1by1'
		cmd-ps=`Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('@this.title');` window=cmd.hidden)
}
item(title='Insert Emoji' keys='Win+;'  type='*' where=wnd.is_edit pos=indexof('Paste', 1) image=image.fluent(\uED54) cmd=key.send(key.win, 190))
item(title='Clipboard History' keys='Win+V'  type='*' where=wnd.is_edit pos=indexof('Paste', 1) image=image.fluent(\uF0E3) cmd=key.send(key.win, 86))
