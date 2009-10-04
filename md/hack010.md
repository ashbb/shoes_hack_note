hack 010: Building Shoes for Windows: to open built-in manual
=============================================================

**Note**: Continued from [hack 009](http://github.com/ashbb/shoes_hack_note/tree/master/md/hack009.md).

**error-open-manual.png**

![error-open-manual.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/error-open-manual.png)

I got the above error with my local Shoes-0.r1259 built by hack 009.


Compile ftsearchrt
------------------

I read [req/ftsearch/README](http://github.com/ashbb/shoes/blob/master/req/ftsearch/README). Then I did the following:

- open Visual Studio 2008 command prompt window
- cd c:\build\shoes\req\ftsearch\ext\ftsearchrt
- ruby extconf.rb
- nmake

Here is the [log](http://github.com/ashbb/shoes_hack_note/tree/master/log/compile_ftsearchrt_091004.log).

I got the `ftsearchrt.so` file.

Add ftsearchrt.so under deps
----------------------------

I read Rakefile and did the following:

- creat `ftsearchrt` directory under `deps` directory.
- move `ftsearchrt.so` to `ftsearchrt`.

rake (rebuild Shoes) and execute
--------------------------------

I could build Shoes. The build showed opening window and I clicked `Read the Manual.` to open built-in manual. But,... Shoes aborted. xx-P


Just one step
-------------

After sniffing some code, I found the code where it aborted.

So, I just attempted to omit the line. Look at [this](http://github.com/ashbb/shoes/commit/23a5d6c71b1653a9eb83d291bed5774033f7c044).

Then,.... Wow! Lucky for me. Built-in Shoes manual opened with my Policeman!!

The search function also worked well. Fantastic!


**manual_was_opened.png**

![manual-was-opened.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/manual-was-opened.png)


Conclusion
----------

**"This is far from finished." by\_why**

It's difficult to improve Shoes with ftsearch for me now.

So, I dicided to take back deps directory (delete deps/ftsearchrt) and to leave the comment out (#require 'ftsearchrt' : line 3 in lib/shoes/search.rb).

