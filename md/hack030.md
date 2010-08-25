hack 030: Another Shoes with rcairo and Ruby/GTK2 and Ruby/Pango
===================================================

I was inspired by QtShoes approaches.

- [fela/qtshoes](http://github.com/fela/qtshoes)
- [steveklabnik/shoes/tree/qtruby](http://github.com/steveklabnik/shoes/tree/qtruby)

I've never used [QtRuby](http://www.darshancomputing.com/qt4-qtruby-tutorial/).

But I know Shoes is using cairo and pango in C.  After some googling, I found the following three are available on Linux with Ruby 1.9.1.

- sudo gem install cairo
- sudo gem install pango
- sudo gem install gtk2

So, I wrote a tiny code and run on VirtualBox Linux on Windows 7 and got the following snapshot. ;-)

I'm not sure this is a good way for Shoes WalkAbout. I don't know it's possible to rewrite whole Shoes. 
I don't know it's available on all platforms (Linux, OSX, Windows). But, ... rewriting Shoes in Ruby is fun! :-D


Test snippet
------------

	require 'shoes'
	
	Shoes.app width: 300, height: 300 do
		para 'Hello World'
		image 'shoes-icon.png', left: 100, top: 100
	end


Snapshot
---------

![another-shoes.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/another-shoes.png)


Another Shoes
--------------

	require 'cairo'
	require 'pango'
	require 'gtk2'
	
	module Shoes
	  def self.app args = {}, &blk
	    args[:width] ||= 600
	    args[:height] ||= 500
	    window = Gtk::Window.new
	    window.set_default_size(args[:width], args[:height])
	    window.signal_connect "destroy" do
	      Gtk.main_quit
	    end
	    
	    drawing_area = Gtk::DrawingArea.new
	    drawing_area.signal_connect "expose-event" do |widget, event|
	      @context = widget.window.create_cairo_context
	      instance_eval &blk
	    end
	    
	    window.add drawing_area
	    window.show_all
	    
	    Gtk.main
	  end
	  
	  def self.para msg
	    layout = @context.create_pango_layout
	    layout.text = msg
	    @context.show_pango_layout layout
	    @context.show_page
	  end
	  
	  def self.image name, args = {}
	    args[:left] ||= 0
	    args[:top] ||= 0
	    pixbuf = Gdk::Pixbuf.new name
	    @context.set_source_pixbuf pixbuf, args[:left], args[:top]
	    @context.paint
	  end
	end


Note
-----

- [rcairo](http://cairographics.org/rcairo/)
- [Ruby-GNOME2](http://ruby-gnome2.sourceforge.jp/)
- Ruby/Pango is included ruby-gtk2 package.
