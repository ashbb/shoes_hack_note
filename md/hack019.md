hack 019: Building Shoes for Windows: Building Shoes with MinGW
===============================================================

- [A guide for building Shoes with MinGW](http://www.holymonkey.com/building-shoes-in-windows) by holymonkey.

About a year ago, I've attempted to follow this guide. But I didn't understand anything. So, I couldn't build Shoes with MinGW. xx-P

But now I realized **it works!** :-D

**The following is the latest guide for Building Shoes with MinGW.**

The previous note is [here](http://github.com/ashbb/shoes_hack_note/tree/master/md/hack019_old.md).


Install Ruby 1.9 [i386-mingw32]
-------------------------------

- download and execute [rubyinstaller-1.9.1](http://rubyinstaller.org/downloads/) (Now [p430](http://rubyforge.org/frs/download.php/72075/rubyinstaller-1.9.1-p430.exe) is the latest)


Install MSysGit
---------------

- download and execute [msysGit](http://code.google.com/p/msysgit/downloads/list) ([Git-1.7.1-preview20100612.exe](http://code.google.com/p/msysgit/downloads/detail?name=Git-1.7.1-preview20100612.exe&can=2&q=) or [msysGit-netinstall-1.7.1-preview20100612.exe ](http://code.google.com/p/msysgit/downloads/detail?name=msysGit-netinstall-1.7.1-preview20100612.exe&can=2&q=))


Creat c:\shoes_dev directory
----------------------------

- open Windows' console window
- cd c:\
- git clone git://github.com/ashbb/rubyinstaller.git shoes_dev


Creat c:\shoes_dev\sandbox directory
------------------------------------

- cd c:\shoes_dev
- mkdir downloads
- download [all files](http://www.rin-shun.com/shoes/MinGW/downloads/) into c:\shoes_dev\downloads
- cd c:\shoes_dev
- rake

Note: Updated the above [dependencies list](http://www.rin-shun.com/shoes/MinGW/downloads/). Now you can build Shoes on both Windows XP and 7!

Creat c:\shoes_dev\sandbox\deps_cairo_1.8.10 directory
------------------------------------------------------

- cd c:\shoes_dev\sandbox
- mkdir deps_cairo_1.8.10
- download [deps_cairo_1.8.10.zip](http://www.rin-shun.com/shoes/MinGW/deps/) file and unzip that into c:\shoes_dev\sandbox\deps_cairo_1.8.10


Creat c:\shoes_dev\sandbox\deps_vlc_0.8 directory
------------------------------------------------------

- cd c:\shoes_dev\sandbox
- mkdir deps_vlc_0.8
- download [deps_vlc_0.8.zip](http://www.rin-shun.com/shoes/MinGW/deps/) file and unzip that into c:\shoes_dev\sandbox\deps_vlc_0.8

Note: If you have [deps-win32-1.6.4-1.20.5_vlc.zip](http://github.com/downloads/shoes/shoes/deps-win32-1.6.4-1.20.5_vlc.zip). The vlc subdirectory is the same as deps_vlc_0.8.


Build Shoes with Video support
------------------------------

- cd c:\shoes_dev\sandbox
- git clone git://github.com/ashbb/shoes.git
- cd c:\shoes_dev
- rake interpreter:shoes:compile VIDEO=1

That's it! The c:\shoes_dev\sandbox\shoes\dist\shoes.exe is there. :-D

**NOTE**: When you use Policeman with Video support on Windows XP, launch with `--nolayered` option like this: `shoes --nolayered`


Build Shoes without Video support
---------------------------------

- cd c:\shoes_dev\sandbox
- git clone git://github.com/ashbb/shoes.git
- cd c:\shoes_dev
- rake interpreter:shoes:compile

That's it! The c:\shoes_dev\sandbox\shoes\dist\shoes.exe is there. :-D


Package Shoes
-------------

- cd c:\shoes_dev\sandbox\shoes
- set NSIS=C:\Program Files\NSIS  (See also [this](http://github.com/ashbb/shoes_hack_note/tree/master/md/hack006.md))
- rake installer

That's it! The C:\shoes_dev\sandbox\shoes\pkg\shoes-0.r1488.exe is there.   
You can install Shoes just one click. ;-)


Snapshot
--------

![building-shoes-with-mingw.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/building-shoes-with-mingw-1.png)

<pre>
Shoes.app :title => 'Building Shoes with MinGW', 
  :width => 330, :height => 200 do
  
  background hotpink..orange, :angle => 90
  style Shoes::Caption, :stroke => white
  stack do
    caption strong("RELEASE_NAME: #{Shoes::RELEASE_NAME}")
    caption strong("RELEASE_ID: #{Shoes::RELEASE_ID}")
    caption strong("REVISION: #{Shoes::REVISION}")
    caption strong("RUBY_PLATFORM: #{Shoes::RUBY_PLATFORM}")
    caption strong("RUBY_VERSION: #{Shoes::RUBY_VERSION}")
  end
end
</pre>

Note
----
- add Shoes icon ... done!
- launch Shoes without Windows' console
- merge the latest Shoes code ... done!
- update dependencies ... done! (Ruby 1.9.1p378 and libjpeg v8, so far)
