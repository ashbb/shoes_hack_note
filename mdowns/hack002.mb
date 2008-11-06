# hack 002

## String#gsub with block

Browsing lib/shoes.rb and Ruby files under lib/shoes is a lot of fun!

I can't understand what the codes are doing, but I can find lots of curious Ruby programming tips. See the following snippet. This is one of them. 

I didn't know that String#gsub has a block... xx-P

	# hack002.rb
	file = 'C:/rubyprograms/shoes/shoes_hack_note/0.r1057/lib/shoes.rb'
	
	# No.1
	IO.read(file).each do |line|
	  puts line if /^(class|def|module) / =~ line.strip
	end
	
	# No.2
	IO.read(file).each do |line|
	  line.strip.gsub(/^(class|def|module) /){print line}
	end

The above snippet picks up the classe, module and method that are defined in the lib/shoes.rb. No.1 and No.2 display the same outputs. Cool!

Enjoy,
ashbb

