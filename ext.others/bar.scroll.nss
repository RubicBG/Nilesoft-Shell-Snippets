$svg_triple_up = '<svg viewBox="0 0 24 24" width="100" height="100">
  <path style="fill:none;stroke:@image.color1;" d="m5 10 7-7 7 7"/>
  <path style="fill:none;stroke:@image.color2;" d="m19 15.5-7-7-7 7"/>
  <path style="fill:none;stroke:@image.color3;" d="m19 21-7-7-7 7"/></svg>'
$svg_triple_down = '<svg viewBox="0 0 24 24" width="100" height="100">
  <path style="fill:none;stroke:@image.color1;" d="m19 14-7 7-7-7"/>
  <path style="fill:none;stroke:@image.color2;" d="m5 8.5 7 7 7-7"/>
  <path style="fill:none;stroke:@image.color3;" d="m5 3 7 7 7-7"/></svg>'
$svg_triple_left = '<svg viewBox="0 0 24 24" width="100" height="100">
  <path style="fill:none;stroke:@image.color1;" d="m10 19-7-7 7-7"/>
  <path style="fill:none;stroke:@image.color2;" d="m15.5 5-7 7 7 7"/>
  <path style="fill:none;stroke:@image.color3;" d="m21 5-7 7 7 7"/></svg>'
$svg_triple_right = '<svg viewBox="0 0 24 24" width="100" height="100">
  <path style="fill:none;stroke:@image.color1;" d="m14 5 7 7-7 7"/>
  <path style="fill:none;stroke:@image.color2;" d="m8.5 19 7-7-7-7"/>
  <path style="fill:none;stroke:@image.color3;" d="m3 19 7-7-7-7"/></svg>'

modify(type='*' where=wnd.parent.name=='DirectUIHWND' && this.title=='Scroll Here'	image=[[\uE170, image.color1],[\uE16E, image.color2]])
modify(type='*' where=wnd.parent.name=='DirectUIHWND' && this.title=='Top'			image=image.svg(str.replace(svg_triple_up, '@image.color1', '@image.color2').replace('@image.color3', '@image.color2')))
modify(type='*' where=wnd.parent.name=='DirectUIHWND' && this.title=='Page Up'		image=image.svg(str.replace(svg_triple_up, '@image.color3', '@image.color2')))
modify(type='*' where=wnd.parent.name=='DirectUIHWND' && this.title=='Scroll Up'	image=image.svg(str.replace(svg_triple_up, '@image.color2', '@image.color1').replace('@image.color3', '@image.color2')))
modify(type='*' where=wnd.parent.name=='DirectUIHWND' && this.title=='Bottom'		image=image.svg(str.replace(svg_triple_down, '@image.color1', '@image.color2').replace('@image.color3', '@image.color2')))
modify(type='*' where=wnd.parent.name=='DirectUIHWND' && this.title=='Page Down'	image=image.svg(str.replace(svg_triple_down, '@image.color3', '@image.color2')))
modify(type='*' where=wnd.parent.name=='DirectUIHWND' && this.title=='Scroll Down'	image=image.svg(str.replace(svg_triple_down, '@image.color2', '@image.color1').replace('@image.color3', '@image.color2')))
modify(type='*' where=wnd.parent.name=='DirectUIHWND' && this.title=='Left Edge'	image=image.svg(str.replace(svg_triple_left, '@image.color1', '@image.color2').replace('@image.color3', '@image.color2')))
modify(type='*' where=wnd.parent.name=='DirectUIHWND' && this.title=='Page Left'	image=image.svg(str.replace(svg_triple_left, '@image.color3', '@image.color2')))
modify(type='*' where=wnd.parent.name=='DirectUIHWND' && this.title=='Scroll Left'	image=image.svg(str.replace(svg_triple_left, '@image.color2', '@image.color1').replace('@image.color3', '@image.color2')))
modify(type='*' where=wnd.parent.name=='DirectUIHWND' && this.title=='Right Edge'	image=image.svg(str.replace(svg_triple_right, '@image.color1', '@image.color2').replace('@image.color3', '@image.color2')))
modify(type='*' where=wnd.parent.name=='DirectUIHWND' && this.title=='Page Right'	image=image.svg(str.replace(svg_triple_right, '@image.color3', '@image.color2')))
modify(type='*' where=wnd.parent.name=='DirectUIHWND' && this.title=='Scroll Right'	image=image.svg(str.replace(svg_triple_right, '@image.color2', '@image.color1').replace('@image.color3', '@image.color2')))