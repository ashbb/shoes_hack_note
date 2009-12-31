hack 017: Building Shoes for Windows: the edit_line and list_box crisis
=======================================================================

Two problems
------------

**First problem**

Whenk I ran the following snippet with Shoes-0.r1286 on my Windows XP laptop, 

<pre>
Shoes.app do
  list_box
  list_box
end
</pre>

I got an error.

![ListBox-error.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/ListBox-error.png)

One list_box is okay. But two or more have this error.

<br>

**Second problem**

<pre>
Shoes.app :height => 150 do
  5.times{edit_line}
end
</pre>

![EditLine-looks-bad.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/EditLine-looks-bad.png)

It works, but looks bad...

After some googling, I found [this site](http://lukewarm.s101.xrea.com/misc/Styles.htm) (in Japanese) and got a solution using `WS_EX_CLIENTEDGE` window style.   
I added WS_EX_CLIENTEDGEs into shoes_native_edit_line() and shoes_native_edit_box() like this:

<pre>
SHOES_CONTROL_REF ref = CreateWindowEx(WS_EX_CLIENTEDGE | WS_EX_TRANSPARENT, TEXT("EDIT"), .......
</pre>

Then I got a good looking face.

![EditLine-looks-good.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/EditLine-looks-good.png)

**But,...**

When I attempted the other snippet using both edit\_line and list\_box:

<pre>
Shoes.app :height => 150 do
  edit_line
  list_box :items => ['a', 'b', 'c'], :height => 30
end
</pre>

Strange,... the edit\_line area vanished...   
To be more exact, it only appeared while dropping down list_box items. (couldn't capture, though)

After some more googling, I found this article:

[WS_EX_COMPOSITED problem](http://www.programmersheaven.com/mb/windows/293205/293205/ws_ex_composited-problem/)

Then I know this is a VC9 problem and there is no good solutions.

<br>

Work Around
-----------

I wrote another `list_box` in Ruby. The code is [override.rb](http://github.com/ashbb/shoes/blob/master/lib/shoes/override.rb). Look at [this commit](http://github.com/ashbb/shoes/commit/6373c6d2491244cc9733f5db19fbc2da25dc63c4).

**Usage**

Just add `extend Override` in your Shoes.app block.

<pre>
Shoes.app :height => 300 do
  extend Override
  
  edit_line
  button 'ok'
  list_box :items => ['a', 'b', 'c'], :left => 0, :top => 50, :height => 30

  list_box :left => 250, :top => 50, :height => 30, :items => ['a', 'b', 'c', 'a', 'b', 'c']
end
</pre>

![a-new-ListBox-snapshot.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/a-new-ListBox-snapshot.png)

Looks not bad. Although there are two restrictions:

- can't use tabbing
- always need to add both :left and :top options explicitly
