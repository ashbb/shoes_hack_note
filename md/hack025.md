hack 025: Checking Shoes Samples: simple-rubygems.rb
====================================================

The simple-rubygems.rb works fine with Raisins (Shoes-0.r1134), but didn't work well with Policeman (Shoes-0.r1405).

I've not tried to debug this problem yet. But I noticed if you add doing the following preparation steps beforehand, it works well with Policeman.


Advance Preparation
-------------------

- Clean up .shoes directory under your home directory. (Just delete .shoes directory.)

- Confirm Shoes version

<pre>
C:\tmp> shoes -v
</pre>

![shoes-v.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/shoes-v.png)

- Install gems into Shoes working directory (.shoes). For example:

<pre>
C:\tmp> shoes -g install bluecloth --version '=2.0.6' --no-rdoc --no-ri
C:\tmp> shoes -g install metaid
</pre>

![shoes-g.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/shoes-g.png)


Snapshot
--------

![snapshot-simple-rubygems.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/snapshot-simple-rubygems.png)

Now, the simple-rubygems.rb works fine with Policeman. :)


Note
----

- The original simple-rubygems.png was using `RedCloth`. But it seems not available for now. So, replaced to `BlueCloth`.

- Why `Total Gems: 6` ?   
  Because you installed `bluecloth` and `retaid`, Policeman has also included `hpricot`, `json` and `sqlite3`. You can find them under this directory:

<pre>
C:\Program Files\Common Files\Shoes\0.r1405\ruby\gems\1.9.1\gems
</pre>





