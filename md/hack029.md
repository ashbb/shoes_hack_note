hack 029: Chipmunk Physics on Shoes
===================================

I tweeted the following to [Bluebie](https://twitter.com/Bluebie) on twitter:

> If you find a nice feature, please let me know. I'd like to challenge to improve Shoes with your suggestions. :)

She replied:
  
> @ashbb Maybe Chipmunk Physics could be a standard component of shoes? :D

Oh, what is Chipmunk Physics? I didn't know that. So, I googled and found some videos like this: [Chipmunk 2D Physics Demos](http://www.youtube.com/watch?v=6stHi1u-pRg&NR=1) 

Awesome! I was very inspired. So, let me try to run Chipmunk Physics on Shoes!


Found
-----

- [chipmunk-physics](http://code.google.com/p/chipmunk-physics/) - homepage

- [beoran / chipmunk](http://github.com/beoran/chipmunk) - Cool Ruby Bindings on GitHub. 


Included chipmunk v4.1.0
------------------------

- Look at [the commit](http://github.com/ashbb/shoes/commit/a6048ab8b5d18652793e50bb1518bfeaa0eb0a1e).


Usage
-----

Look at this sample snippet. Very easy!

	# chipmunk_physics_on_shoes.rb
	require 'shoes/chipmunk'
	
	Shoes.app title: 'A Tiny Chipmunk Physics Demo' do
	  extend ChipMunk
	  space = cp_space
	  balls = []
	  
	  nofill
	  cp_line 0, 180, 200, 280, stroke: gold
	  cp_line 200, 280, 300, 270, stroke: gold
	  cp_line 250, 350, 350, 330
	  cp_line 170, 370, 220, 380
	  cp_line 100, 450, 300, 430, stroke: lightslategray
	  cp_line 300, 430, 500, 450, stroke: lightslategray
	
	  nostroke
	  oval(10, 30, 40, fill: blue).click{balls << cp_oval(30, 50, 20, stroke: blue, strokewidth: 2)}
	  oval(70, 40, 20, fill: green).click{balls << cp_oval(80, 50, 10, fill: green)}
	  oval(105, 45, 10, fill: red).click{balls << cp_oval(110, 50, 5, fill: red)}
	  
	  every do
	    6.times{space.step 1.0/60}
	    balls.each{|ball| ball.cp_move}
	  end
	end


A tiny online demo is [here](http://www.rin-shun.com/shoes/chipmunk.swf.html).


Snapshot
--------

![chipmunk-snapshot.png(http://github.com/ashbb/shoes_hack_note/raw/master/img/chipmunk-snapshot.png)


Note
----

If you want to use chipmunk without helper methods I wrote, you can include 'chipmunk' instead of 'shoes/chipmunk'.

