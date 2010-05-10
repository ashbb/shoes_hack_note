hack 026: Building Shoes for Linux: Building Shoes on VirtualBox
================================================================

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
- ./configure --enable-shared   
- make   
- sudo make install   


Build Shoes
-----------

Open terminal on Ubuntu Desktop and run the following commands.

- sudo apt-get install git-core libcairo2-dev libpixman-1-dev libpango1.0-dev libungif4-dev libjpeg62-dev libgtk2.0-dev portaudio19-dev libsqlite3-dev libcurl4-openssl-dev   
- git clone git://github.com/ashbb/shoes.git   
- cd shoes   
- rake   

That's it! You can find `dist/shoes`. Just do the following.

- cd dist   
- ./shoes   


Package Shoes
-------------

- wget http://megastep.org/makeself/makeself.run
- chmod 755 makeself.run
- ./makeself.run
- sudo ln -s /home/ashbb/work/makeself-2.1.5/makeself.sh /usr/local/bin/makeself
- sudo ln -s /home/ashbb/work/makeself-2.1.5/makeself-header.sh /usr/local/bin/makeself-header.sh
- cd shoes
- rake installer

You can find `pkg/shoes-0.r1416.run`.


Snapshot 1
----------

Opening window.

![Screenshot-Shoes-opening.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/Screenshot-Shoes-opening.png)


Snapshot 2
----------

Manual window.

![Screenshot-manual.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/Screenshot-manual.png)


Snapshot 3
----------


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


![Screenshot-Shoes-for-Linux-1.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/Screenshot-Shoes-for-Linux-1.png)


Snapshot 4
----------

The `shoes_app_launcher.shy` can be launched!! This is a shy file created by Policeman for Windows.

![Screenshot-Shoes-app-launcher.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/Screenshot-Shoes-app-launcher.png)


Note
----

- [VirtualBox Download and Install](http://linux.owlnet.jp/virtualbox01.html) (in Japanese)

- [Install Ruby for Linux](http://ref.xaio.jp/ruby/install/linux) (in Japanese)
