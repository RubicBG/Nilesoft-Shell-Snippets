// Require Everything to be installed !
// https://www.voidtools.com/downloads/


menu(title='Everything' image=\uE28C)
{
// Folders, drives, folder background
  item(
    image =\uE28C
    type='dir|back.dir|drive|file'
    title='Search by name'
    cmd=@if(
      path.exists('C:\Program Files\Everything\Everything.exe'),
      'C:\Program Files\Everything\Everything.exe',
      'C:\Program Files (x86)\Everything\Everything.exe'
    )
    args='-newwindow -search "@sel.directory.quote "'
    invoke='multiple'
  )

// Folders, drives, folder background
  item(
    image =\uE28C
    type='dir|back.dir|drive|file'
    title='Search by content'
    cmd=@if(
      path.exists('C:\Program Files\Everything\Everything.exe'),
      'C:\Program Files\Everything\Everything.exe',
      'C:\Program Files (x86)\Everything\Everything.exe'
    )
    args='-newwindow -search "@sel.directory.quote content:"'
    invoke='multiple'
  )
}
