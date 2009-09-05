hack 006: Building Shoes for Windows
====================================

Learning about building Shoes for Windows with Ruby 1.9.1 (mswin32) by trial and error.

Environment
-----------

**Windows Server 2003 DDK (Driver Development Kit)**

It seems to be no longer supported. Look at [the Windows Driver Kit (WDK)](http://www.microsoft.com/whdc/DevTools/ddk/default.mspx).


**Visual C++ 2008 Express Edition**

Download site is [here](http://www.microsoft.com/japan/msdn/vstudio/express/). (Japanese site)


**Ruby 1.9.1**

Download [Ruby 1.9.1-p243](http://www.ruby-lang.org/en/downloads/) and compile ruby from source.

- [How to compile ruby from source on Windows?](http://madcoderspeak.blogspot.com/2009/06/how-to-compile-ruby-from-source-on.html)


Shoes
-----

**check out**

	$ git clone git://github.com/shoes/shoes.git


**make deps directory**

- make `deps` directory under `shoes` directory.
- download the win32 dependencies (**deps\-win32\-1.6.4\-1.20.5+vlc**) from [here](http://wiki.github.com/shoes/shoes/buildingshoes).
- unzip
- move `cairo`, `pango` and `winhttp` to under `deps` directory.

