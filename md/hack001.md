hack 001: Anonymous Binding
===========================

	# hack001.rb
	class Shoes
	  def self.anonymous_binding
	    obj = Object.new
	    return \
	      class << obj
	        def self.to_s
	          "(shoes)"
	        end
	        binding
	      end
	  end
	end
	
	# a test snippet
	code =<<-EOS
	class Test
	  def initialize
	    puts 'hello'
	    @hi = 'hi'
	  end
	  attr_reader :hi
	end
	
	t = Test.new
	p t.class
	p t.hi
	
	p self
	p self.class
	EOS
	
	eval code
	puts
	eval code, Shoes.anonymous_binding
	

Output is:
----------
<pre>
>ruby hack001.rb
hello
Test
"hi"
main
Object

hello
#<Class:0x2b82250>::Test
"hi"
(shoes)
Class
>Exit code: 0
</pre>
