hack 024: Checking Shoes Samples: simple-control-sizes.rb
=========================================================

The simple-control-sizes.rb works fine with Raisins (Shoes-0.r1134), but didn't work well with Policeman (Shoes-0.r1403).


Error
-----

![error-simple-control-sizes.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/error-simple-control-sizes.png)

Can't launch simple-control-sizes.rb with Policeman.


Solution
--------

Not found the complete solution so far. :(

I noticed the following:

In case only one list_box on the Shoes app window, there is no problems.
But if add one more, this problem will occur. I don't know why...

If comment out [line 3592-3593 in ruby.c](http://github.com/ashbb/shoes/blob/master/shoes/ruby.c#L3593), 

	#else
	  #shoes_native_control_repaint(self_t->ref, &self_t->place, canvas, &place);

the build will run simple-control-sizes.rb with no error. But it can't repaint (redraw) list_box objects, so they can't move the position, i.e. can't scroll.


snapshot
--------

![snapshot-simple-control-sizes.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/snapshot-simple-control-sizes.png)
