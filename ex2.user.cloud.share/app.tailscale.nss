// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

remove(find='*Tailscale*')

item(title='Send with Tailscale...' type='file' image cmd='@sys.prog\Tailscale\tailscale-ipn.exe' args='/push @sel(true)')