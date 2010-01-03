hack 018: Building Shoes for Windows: to take a snapshot
========================================================

Just discovered a new feature `snapshot` hidden by _why.

**Sample snippet:**

<pre>
Shoes.app do
  para 'Hello!'
  _snapshot :filename => 'snapshot.pdf', :format => :pdf
end
</pre>

**Output:**

- a pdf file named 'snapshot.pdf'

You can also use `:ps` and `:svg` format. Although, there are two restrictions so far.

Restrictions:
- can't output any elements inside of stack() or flow()
- can't use with block


Snapshot
--------

This is the snapshot of my little Shoes app: Maze Hunter 2 r0.3b   
It's the solution for [RPCFN5](http://rubylearning.com/blog/2009/12/27/rpcfn-mazes-5/). The code is [this](http://github.com/gautamrege/RPCFN5solutions). *Note: will open after 20th Jan.*

![snapshot.pdf-2.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/snapshot.pdf-2.png)

But with r0.3a using stacks, it couldn't take a correct snapshot like this:


![snapshot.pdf-1.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/snapshot.pdf-1.png)


Commit and Build
----------------
- Shoes-0.r1288 is the available build for Windows. You can download from [here](http://shoes.heroku.com/downloads).
- the commit is [this](http://github.com/ashbb/shoes/commit/1ef10c4d38b9e1719165a716631d3a8722d04abe).
