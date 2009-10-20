hack 013: Building Shoes for Windows: to display fonts beautifully
==================================================================

I've noticed that Shoes opening window's fonts are not so beautiful.

![shoes-opening-1.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/shoes-opening-1.png)

After some trial and error, I found a solution.

Look at [the line 110](http://github.com/shoes/shoes/blob/master/lib/shoes.rb#L110) of `lib/shoes.rb`.

This is the snapshot after replaced the font size from 13 to 14:

![shoes-opening-2.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/shoes-opening-2.png)

I'm not sure this problem happens on Windows only. :-P

