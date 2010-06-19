hack 028: Building Hackety Hack for Windows
===========================================

[Hackety Hack](http://github.com/steveklabnik/hacketyhack) is a programming starter kit and also the biggest Shoes app!


Preparations
------------

Look at [hack 019: Building Shoes with MinGW](http://github.com/ashbb/shoes_hack_note/blob/master/md/hack019.md)

- Create shoes_dev
- Create shoes_dev/downloads
- Create shoes_dev/sandbox
- Create shoes_dev/sandbox/deps_cairo_1.8.10


Build Hackety Hack for Windows
------------------------------

- cd c:\shoes_dev\sandbox
- git clone git://github.com/ashbb/shoes.git
- git clone git://github.com/steveklabnik/hacketyhack.git
- cd c:\shoes_dev
- rake interpreter:shoes:compile APP=../hacketyhack

You can get `hacketyhack.exe` under c:\shoes_dev\sandbox\shoes\dist directory.


Modify a little
---------------

Modify the following two files:

- c:\shoes_dev\sandbox\shoes\dist\lib\shoes.rb

	  def self.args!
	    #if RUBY_PLATFORM !~ /darwin/ and ARGV.empty?
	    #  Shoes.splash
	    #end
	    #OPTS.parse! ARGV
	    #ARGV[0] or true
	    ARGV[0] = "app/h-ety-h.rb"
	  end


- c:\shoes_dev\sandbox\shoes\dist\app\h-ety-h.rb

	#Shoes.setup do gem 'ruby-debug' end
	#require 'ruby-debug'


Package Hackety Hack for Windows
------------------------------

- cd c:\shoes_dev\sandbox\shoes
- set NSIS=C:\Program Files\NSIS
- rake installer APP=../hacketyhack

Finally, you can get [hacketyhack-0.r1428.exe](http://www.rin-shun.com/shoes/hacketyhack-0.r1428.exe) under c:\shoes_dev\sandbox\shoes\pkg


Snapshots
---------

![snapshot-HH-1.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/snapshot-HH-1.png)

![snapshot-HH-2.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/snapshot-HH-2.png)

![snapshot-HH-3.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/snapshot-HH-3.png)

![snapshot-HH-4.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/snapshot-HH-4.png)


Trivial online demo
-------------------

Watch [a trivial online demo](http://www.rin-shun.com/shoes/hacketyhack_demo.swf.html).


Website
-------

- [Hackety Hack](http://hacketyhack.heroku.com/)
- [Shoes](http://shoes.heroku.com/)
