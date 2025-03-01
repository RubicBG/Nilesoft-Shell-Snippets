// This code creates two menu items for renaming files and directories when their names exceed the maximum allowed length on Windows (259 characters for files and 248 characters for directories). When clicked, these menu items will automatically shorten the name to fit within the allowed length.

//> https://learn.microsoft.com/en-gb/windows/win32/fileio/naming-a-file#maximum-path-length-limitation
$maxFileLen = 259
item(title=title.rename keys='auto' type='file' where=sel.len>=maxFileLen 
    image=icon.rename(auto, color.greenyellow) pos=indexof(quote(str.replace(title.rename, '&', '')))
    tip='shorten the name by @(sel.len-(maxFileLen-1)) characters' vis=if(this.level!=1, 'disabled')
    cmd=io.rename(sel.path, path.combine(sel.parent, str.left(sel.file.title, maxFileLen-1-sel.parent.len-sel.file.ext.len) + sel.file.ext)))
$maxDirLen = 248
item(title=title.rename keys='auto' type='dir' where=sel.len>=maxDirLen 
    image=icon.rename(auto, color.greenyellow) pos=indexof(quote(str.replace(title.rename, '&', '')))
    tip='shorten the name by @(sel.len-(maxDirLen-1)) characters' vis=if(this.level!=1, 'disabled')
    cmd=io.rename(sel.path, path.combine(sel.parent, str.left(sel.path.name, maxDirLen-1-sel.parent.len))))