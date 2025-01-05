// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

modify(type='*' where=wnd.name=='CabinetWClass' and wnd.parent.name=='msctls_progress32' find='Copy address' image=icon.copy_path)
modify(type='*' where=wnd.name=='CabinetWClass' and wnd.parent.name=='msctls_progress32' find='Edit address' image=icon.rename)
modify(type='*' where=wnd.name=='CabinetWClass' and wnd.parent.name=='msctls_progress32' find='Delete history' image=icon.delete sep='both')

// Open Classic File Explorer with Ribbon in Windows 11 to test the menu
// https://www.elevenforum.com/t/restore-classic-file-explorer-with-ribbon-in-wnds-11.620/