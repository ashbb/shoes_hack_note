# md2html.rb

mfile = '../README.md'
hfile = 'README.html'

require 'BlueCloth'
b = BlueCloth.new IO.read(mfile)
open(hfile, 'w'){|f| f.puts b.to_html}
