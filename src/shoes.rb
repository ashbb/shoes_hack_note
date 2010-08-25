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
      x, y, w, h = widget.allocation.to_a
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