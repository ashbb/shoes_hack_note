hack 026: Building Shoes for Linux: Building Shoes on VirtulBox
===============================================================

Laptop
------

- ThinkPad X40
- Windows XP SP3


Setup VirtualBox
----------------

- Download and install [VirtualBox 3.1.6 for Windows hosts](http://download.virtualbox.org/virtualbox/3.1.6/VirtualBox-3.1.6-59338-Win.exe)


Setup Ubunto: Ubuntu 10.04 LTS (Lucid Lynx)
-------------------------------------------

- Download [PC (Intel x86) alternate install CD](http://www.ftp.ne.jp/Linux/packages/ubuntu/releases-cd/lucid/ubuntu-10.04-alternate-i386.iso)

- Install Ubuntu Linux 2.6 as a guest OS on VirtualBox.


Build Ruby 1.9.1
----------------

Open terminal on Ubuntu Desktop and run the following commands.

- sudo apt-get install libssl-dev   
- sudo apt-get install zlib1g-dev   
- wget ftp://ftp.ruby-lang.org/pub/ruby/ruby-1.9.1-p378.tar.gz   
- tar xfvz ruby-1.9.1-p378.tar.gz   
- cd ruby-1.9.1-p378   
- ./configure   
- make   
- sudo make install   


Build Shoes
-----------

Open terminal on Ubuntu Desktop and run the following commands.

- sudo apt-get install git-core libcairo2-dev libpixman-1-dev libpango1.0-dev libungif4-dev libjpeg62-dev libgtk2.0-dev portaudio19-dev libsqlite3-dev libcurl4-openssl-dev ruby1.9-dev   
- git clone git://github.com/ashbb/shoes.git   
- cd shoes   
- rake   

That's it! You can find `dist/shoes`. Just do the following.

- cd dist   
- ./shoes   


Error
-----

But will get this error message so far.

![Screenshot-shoes-error-20100508.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/Screenshot-shoes-error-20100508.png)


Minimum Shoes
-------------

Replace `dist/lib/shoes.rb` with the following snippet. 

	# shoes.rb
	 class Shoes
	   def self.run path
	     [nil]
	   end
	
	   def self.args!
	    Shoes.app do
	      background hotpink..orange, angle: 90
	      stack do
	        para 'Hello world!'
	        para "RELEASE_NAME: #{Shoes::RELEASE_NAME}"
	        para "RELEASE_ID: #{Shoes::RELEASE_ID}"
	        para "REVISION: #{Shoes::REVISION}"
	        para "RUBY_PLATFORM: #{Shoes::RUBY_PLATFORM}"
	        para "RUBY_VERSION: #{Shoes::RUBY_VERSION}"
	      end
	    end
	  end
	 end

![Screenshot-Shoes-for-Linux.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/Screenshot-Shoes-for-Linux.png)

Then will get this snapshot! :)


Note
----

- [VirtualBox Download and Install](http://linux.owlnet.jp/virtualbox01.html) (in Japanese)

- [Install Ruby for Linux](http://ref.xaio.jp/ruby/install/linux) (in Japanese)
