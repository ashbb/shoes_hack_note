hack 021: Checking Shoes Samples: expert-irb.rb
===============================================

The expert-irb.rb works fine with Raisins (Shoes-0.r1134), but didn't work well with Policeman (Shoes-0.r1377).

After some debugging, I found there was a difference of behavior between Ruby 1.8.6 and 1.9.1.

This is a test snippet:

	# hack021.rb
	require 'irb/ruby-lex'
	require 'stringio'
	
	STDOUT.sync = true
	
	class MimickIRB < RubyLex
	  def initialize
	    super
	    set_input StringIO.new
	  end
	
	  def run str
	    @io << str
	    @io.rewind
	    l = lex
	    eval l, TOPLEVEL_BINDING
	  end
	end
	
	IRBalike = MimickIRB.new
	$stdout = StringIO.new
	
	STDOUT.puts IRBalike.run("a = 1;")
	STDOUT.puts IRBalike.run("b")


With ruby 1.8.6:
<pre>
>ruby irb.rb
1
irb.rb:16:in `eval': undefined local variable or method `b' for main:Object (NameError)
</pre>

With ruby 1.9.1:
<pre>
>ruby irb.rb
1
**** no response! ****
</pre>


workaround
----------

Add `;` at the end of `@cmd`.

<pre>
out, obj = IRBalike.run(@cmd + ';')
</pre>

snapshot
--------

![snapshot-expert-irb.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/snapshot-expert-irb.png)
