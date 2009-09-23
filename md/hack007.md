hack 007: Building Shoes for Windows: to use both VC6 DLLs and VC9 DLLs
=======================================================================

**Note**: Continued from [hack 006](http://github.com/ashbb/shoes_hack_note/tree/master/md/hack006.md).

In the hack 006, my first shoes-0.r1252 became to open [a tiny Shoes app](http://vgoff.blogspot.com/2009/09/success-building-shoes-for-windows-with.html).

It also worked well loading GIF files correctly but PNG and JPG files didn't work. :(

So, in this time, I tried to dive into **shoes/image.c**

<br>

The Problem
-----------

After some hacking \_why's code, I noticed my first shoes-0.r1252 aborted at fclose() in the shoes/image.c.

Thanks to googling, I understood [the problem](http://social.msdn.microsoft.com/Forums/ja-JP/vcexpressja/thread/4f3b8929-b226-46f9-afcc-eda22aebb7f4) and found [a solution](http://www.geocities.jp/ky_webid/win32c/050.html). (both in Japanese)

<br>

A Solution
----------

To mix both VC6 DLLs and VC9 DLLs in one app, use Win32APIs: CreateFile / ReadFile / CloseHandle directly instead of C standard APIs: fopen / fread / fclose.

*Note: \_why uses VC6. I uses VC9.*

<br>

Modified The Code
-----------------

Look at [this commit](http://github.com/ashbb/shoes/commit/9946155097f828a8b4372e216fec42e70ed039dc) on my github repo.

<br>

Result
------

My second build [shoes-0.r1252](http://www.rin-shun.com/shoes/index.html) (packed at 2009.9.23) became to load GIF and PNG and JPG files correctly. :-D

![policeman\_1252\_2nd\_build\_snapshot.png](http://4.bp.blogspot.com/_IiD1Gq7uM-I/SroYLbMa2aI/AAAAAAAAANQ/CSTo-gUBxQM/s1600/policeman_1252_2nd_build_snapshot.png)

Although from local disk only, so far.

![error\_r1152\_loading\_image\_file\_with\_url.png](http://2.bp.blogspot.com/_IiD1Gq7uM-I/SroYUQ88V1I/AAAAAAAAANY/Y0krEmYwwUM/s1600/error_r1152_loading_image_file_with_url.png)

I need to hack the loading-image-files-with-URL feature. ;-)
