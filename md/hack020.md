hack 020: Building Shoes for Windows: to display Jpeg file
==========================================================

Note: Continued from [hack 019](http://github.com/ashbb/shoes_hack_note/tree/master/md/hack019.md).

The shoes-0.r1367 (built with MinGW) couldn't display Jpeg files. xx-P

After some debugging and googling, I found the problem:

- [libjpeg boolean size](http://d.hatena.ne.jp/SaitoAtsushi/20080727/1217162048) (in Japanese)
- [libjpeg problems...](http://forum.wiibrew.org/read.php?11,4315)


Build libjpeg
-------------

- Go to <http://www.ijg.org/>
- Download [jpegsrc.v8.tar.gz](http://www.ijg.org/files/jpegsrc.v8.tar.gz)
- Extract that into C:\tmp
- edit C:\tmp\jpeg-8b\jmorecfg.h line 236

<pre>
   #ifndef HAVE_BOOLEAN
   typedef unsigned char boolean;   /* typedef int boolean; */
   #endif
</pre>

- Open msysGit window
- cd /c/tmp/jpeg-8b
- ./configure --enable-static --enable-shared --prefix=/mingw
- make
- make install

Now packaged them as `libjpeg_v8_bin_lib_include.zip` and uploaded [here](http://www.rin-shun.com/shoes/MinGW/downloads/).


Snapshot
--------

![snapshot-jpegs.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/snapshot-jpegs.png)

Display lots of Jpeg files on the GangsClock. :)



