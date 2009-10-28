hack 014: Building Shoes for Windows: to save the manual to a directory as HTML
===============================================================================

**Note**: Continued from [hack 012](http://github.com/ashbb/shoes_hack_note/tree/master/md/hack012.md).


before
------

**error-manual-html.png**

![error-manual-html.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/error-manual-html.png)

I ran the command `.\shoes.exe --manual-html C:\build\tmp` under `C:\build\shoes\dist` directory on the Windows XP console window and got the above error with Shoes-0.r1263.


Step 0
------

At first, I noticed that Shoes-0.r1263 for Windows had no `.so` files for Hpricot. xx-P

So, tried to copy the files from \_why's Shoes-0.r1243 and re-build Shoes-0.r1263.

- Overwrite `C:\build\shoes\req\hpricot\lib` directory and under all files with `C:\Program Files\Common Files\Shoes\0.r1243\ruby\gems\1.9.1\gems\hpricot-0.8.1\lib` directory and under all files included `.so` files.

- Overwrite `C:\build\shoes\req\hpricot\gemspec` file with `C:\Program Files\Common Files\Shoes\0.r1243\ruby\gems\1.9.1\specifications\hpricot-0.8.1.gemspec` file as `gemspec`.

- Then re-build Shoes: run `rake` command on the WDK console window.

I ran the new (re-built) local Shoes-0.r1263, but got the below error:

**error-manual-html.png**

![error-manual-html.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/error-manual-html.png)

Okay, let's start hacking!


Step 1
------

Edited the line 243 of C:\build\shoes\dist\lib\shoes.rb like this:

	Shoes::Manual::PATH  -->  Shoes::Manual::path

Then re-ran the Shoes command on the Windows console. But OMG! Aborted!


Step 2
------

After reading some Shoes code and Hpricot code, I found the following solution. 

- Add this new line between line 160 and 161 of `tag.rb` file under `C:\build\shoes\dist\ruby\gems\1.9.1\gems\hpricot-0.8.1\lib\hpricot` directory.

	attr_accessor :target, :public_id, :system_id

Then re-ran the Shoes command on the Windows console. But got another error.

**error-manual-html-1.png**

![error-manual-html-1.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/error-manual-html-1.png)


Step 3
------

- Add this new line between line 41 and 42 of `tag.rb` file under `C:\build\shoes\dist\ruby\gems\1.9.1\gems\hpricot-0.8.1\lib\hpricot` directory.

	TITLES = {:title => :h1, :subtitle => :h2, :tagline => :h3, :caption => :h4}

Then re-ran the Shoes command on the Windows console. I got another error, but some html files appeared under `C:\build\tmp` directory!

**error-manual-html-2.png**

![error-manual-html-2.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/error-manual-html-2.png)



Step 4
------

- delete `.to_s` at the line 24 of `blankslate.rb` under `C:\build\shoes\dist\ruby\gems\1.9.1\gems\hpricot-0.8.1\lib\hpricot` directory.

Then re-ran the Shoes command on the Windows console. But got another error.

**error-manual-html-3.png**

![error-manual-html-3.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/error-manual-html-3.png)


Step 5
------

After quick reading `fast_xs.c`, I got a solution.

Edit `C:\build\shoes\dist\lib\builder.rb` like this:

- comment out line 2 : `#require 'fast_xs'`   
- delete all `.fast_xs` at line 50, 97, 102

Then re-ran the Shoes command on the Windows console.

At last, I got all HTML files completely under `C:\build\tmp` directory. Yay!

**error-manual-html-4.png**

![error-manual-html-4.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/error-manual-html-4.png)


Note
----

- These above codes are monkey-paches to only make `--manual-html` option work with Policeman. Not for Hpricot. And I'm not sure this issue occurs only on Windows.










