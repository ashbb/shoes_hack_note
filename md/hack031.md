hack 031: Compile ruby-gtk2 package and rcairo with Ruby 1.9.2 (i386-mingw32)
============================================================

I found [this post](http://www.ruby-forum.com/topic/192793). So, I just tried with Ruby 1.9.2. :)

Preparation
-----------

Download and install:

- [Ruby 1.9.2](http://rubyforge.org/frs/download.php/72170/rubyinstaller-1.9.2-p0.exe) to `c:\ruby`
- Add c:\ruby\bin to windows PATH

- [DevKit 4.5.0](http://github.com/downloads/oneclick/rubyinstaller/DevKit-4.5.0-20100819-1536-sfx.exe) to `c:\DevKit`
- cd c:\DevKit
- ruby dk.rb init
- ruby dk.rb install
- .\devkitvars.bat

- [gtk development library](http://ftp.acc.umu.se/pub/GNOME/binaries/win32/glade3/3.6/glade3-3.6.7-with-GTK+.exe) to `c:\gtk`
- Add c:\gtk\bin to windows PATH


Download and extract:

- [ruby-gtk2-0.19.4.tar.gz](http://sourceforge.net/projects/ruby-gnome2/files/ruby-gnome2/ruby-gnome2-0.19.4/ruby-gtk2-0.19.4.tar.gz/download) to `c:\tmp\ruby-gtk`
- [rcairo-1.8.5.tar.gz](http://cairographics.org/releases/rcairo-1.8.5.tar.gz) to `c:\tmp\rcairo`

Okay, now is the time to compile the following!

glib
----
- cd c:\tmp\ruby-gtk\glib
- ruby -rdevkit extconf.rb 
- Edit src\Makefile dldflags : --enable-auto-import,--out-implib=libruby-glib2.a $(DEFFILE)
- Add CPPFLAGS : -DHAVE_RB_THREAD_BLOCKING_REGION -DHAVE_RUBY_NATIVE_THREAD_P
- Add INCFLAGS : -IC:/gtk/include
- make
- make install

rcairo
------
- cd c:\tmp\rcairo-1.8.5
- ruby -rdevkit extconf.rb --with-pkg-config=c:\gtk\bin\pkg-config.exe
- Edit ext\cairo\Makefile dldflags : --enable-auto-import,--out-implib=libruby-cairo.a $(DEFFILE)
- Add INCFLAGS : -IC:/gtk/include/cairo
- Add LIBPATH  : -LC:/gtk/lib
- Replace devel/target/e1cabcfbab6c7ee30ed3ffc781169bba to gtk
- Replace devel/target/9e3dd352b1f391f5997da8a13802e83e to gtk
- Add CPPFLAGS : -DHAVE_RB_ERRINFO
- make
- make install

atk
---
- set CAIRO_PATH=C:/tmp/rcairo-1.8.5/ext/cairo
- cd c:\tmp\ruby-gtk\atk
- ruby -rdevkit extconf.rb
- Edit src\Makefile dldflags : --enable-auto-import,--out-implib=libruby-atk.a $(DEFFILE)
- make
- make install

pango
-----
- cd c:\tmp\ruby-gtk\pango
- ruby -rdevkit extconf.rb
- Edit src\Makefile dldflags : --enable-auto-import,--out-implib=libruby-pango.a $(DEFFILE)
- Add LIBPATH  : -LC:/tmp/rcairo-1.8.5/ext/cairo
- Replace tmp/rcairo-1.8.5/ext/cairo/src to tmp/rcairo-1.8.5/ext/cairo
- make
- make install

gtk
---
- cd c:\tmp\ruby-gtk\gtk
- ruby -rdevkit extconf.rb
- Edit src\Makefile dldflags : --enable-auto-import,--out-implib=libruby-gtk.a $(DEFFILE)
- Add LIBPATH  : -LC:/tmp/rcairo-1.8.5/ext/cairo
- Replace tmp/rcairo-1.8.5/ext/cairo/src to tmp/rcairo-1.8.5/ext/cairo
- Delete LIBS : -lruby-gtk2
- Delete src\gtk2.def : rbgtk_clipboard_get_type  rbgtk_get_clipboard rbgtk_get_tree_row_reference  rbgtk_make_clipboard  rbgtk_tree_row_reference_get_type 
- make
- make install

gdkpixbuf
---------
- cd c:\tmp\ruby-gtk\gdkpixbuf
- ruby -rdevkit extconf.rb
- Edit Makefile dldflags : --enable-auto-import,--out-implib=libruby-gdk_pixbuf2.a $(DEFFILE)
- Add LIBPATH  : -LC:/tmp/rcairo-1.8.5/ext/cairo
- Replace tmp/rcairo-1.8.5/ext/cairo/src to tmp/rcairo-1.8.5/ext/cairo
- make
- make install

Snapshot
---------
Got the same snapshot as [on Linux](http://github.com/ashbb/shoes_hack_note/blob/master/md/hack030.md).

![another-shoes-win.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/another-shoes-win.png)


References
----------

- [Ruby-GNOME2 Project Website](http://ruby-gnome2.sourceforge.jp/)
- [Ruby-Gnome 2 > Compile ruby with the rubyinstaller](http://www.ruby-forum.com/topic/192793)
