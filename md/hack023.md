hack 023: Checking Shoes Samples: expert-definr.rb
==================================================

The expert-definr.rb works both with Raisins (Shoes-0.r1134) and Policeman (Shoes-0.r1403). But I realized enter key problem in Policeman.


Error
-----

![error-expert-definr.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/error-expert-definr.png)

When I pressed enter key in the edit_line, Policeman crashed and displayed this error window.


Solution
--------

Add just one line:

	def Shoes.hook; end

Now can work around the enter key press problem.


A little more improvement
-------------------------

Add a little bit of code, you can use enter key rather than `Go` button. ;-)

	# hack023.rb
	# Improved samples/expert-definr.rb to accept enter key (also to work around the crash)
	
	def Shoes.hook
	  $app.instance_eval{@go_definr.call}
	end
	
	$app = Shoes.app :title => "Dictionary, powered by Definr", :width => 370, :height => 320 do
	  stack do
	    background red, :height => 60
	    flow :margin => 20 do
	      caption "Define: ", :stroke => white
	      @lookup = edit_line
	      @go_definr = proc do
	        download "http://definr.com/definr/show/#{@lookup.text.strip.split.first}" do |dl|
	          doc = dl.response.body.gsub('&nbsp;', ' ').
	              gsub(%r!(</a>|<br />|<a href.+?>)!, '').
	              gsub(%r!\(http://.+?\)!, '').strip
	          title, doc = doc.split(/\n+/, 2)
	          @deft.replace title
	          @defn.replace doc
	        end
	      end
	      button("Go"){@go_definr.call}
	    end
	    stack :margin => 20 do
	      @deft = subtitle "", :margin => 10
	      @defn = para ""
	    end
	  end
	end


snapshot
--------

![snapshot-expert-definr.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/snapshot-expert-definr.png)


Note
----

Refer to a tiny note: [recognize the enter-key pressed in the edit_line area](http://shoes-tutorial-note.heroku.com/html/00544_recognize_the_enter-key_pressed_in_the_edit_line_area.html).
