hack 019: Building Shoes for Windows: Building Shoes with MinGW
===============================================================

- [A guide for building Shoes with MinGW](http://www.holymonkey.com/building-shoes-in-windows) by holymonkey.

About a year ago, I've attempted to follow this guide. But I didn't understand anything. So, I couldn't build Shoes with MinGW. xx-P

But now I realized **it works!** :-D


Install Ruby 1.9 [i386-mingw32]
-------------------------------

- download and execute [rubyinstaller-1.9.1-p243-rc1.exe](http://rubyforge.org/frs/download.php/66872/rubyinstaller-1.9.1-p243-rc1.exe)


Install MSysGit
---------------

- download and execute [msysGit-netinstall-1.6.4-preview20090730.exe](http://msysgit.googlecode.com/files/msysGit-netinstall-1.6.4-preview20090730.exe)


Creat c:\shoes_dev directory
----------------------------

- open Windows' console window
- cd c:\
- git clone git://github.com/ender672/rubyinstaller.git
- mv rubyinstaller shoes_dev


Creat c:\shoes_dev\sandbox directory
------------------------------------

- cd c:\shoes_dev
- mkdir downloads
- download [all files](http://www.rin-shun.com/shoes/MinGW/downloads/index-20100118.html) into c:\shoes_dev\downloads
- cd c:\shoes_dev
- rake


Build Shoes
-----------

- cd c:\shoes_dev\sandbox
- git clone git://github.com/ender672/shoes.git

- edit a little    
  c:\shoes_dev\sandbox\shoes\lib\shoes.rb line 117-119    
  add `Shoes::` before `Para`, `Link` and `LinkHover`   

- cd c:\shoes_dev
- rake interpreter:shoes:compile

That's it! The c:\shoes_dev\sandbox\shoes\dist\shoes-bin.exe is there. :-D


Snapshot
--------

![building-shoes-with-mingw.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/building-shoes-with-mingw.png)


Note
----
- add Shoes icon
- launch Shoes without Windows' console
- merge the latest Shoes code
- update dependencies

