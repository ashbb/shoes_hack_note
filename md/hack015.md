hack 015: Building Shoes for Windows: rebuilt the deps files with Ruby 1.9.1p376 and add some extensions
========================================================================================================

To use [Mechanize](http://mechanize.rubyforge.org/mechanize/) with Shoes for Windows.

Look at the discussion on Librelist Archive Browser.

- [Shoes, Ruby 1.9, Mechanize and Uninitialized constant Encoding::US_ASCII](http://librelist.com/browser/) Click shoes/ and Dec. 16th, 2009.


Step 0: Build Ruby 1.9.1p376 with Microsoft Visual C++ 2008 Express Edition
---------------------------------------------------------------------------

`C:\Temp` is my working directory.

- Download [ruby-1.9.1-p376.tar.gz](ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.1-p376.tar.gz) and do un-tar-gzip to `C:\Temp`.
- Open Visual Studio 2008 command prompt window.
- C:\Temp\ruby-1.9.1-p376> win32\configure.bat --prefix=C:/ruby
- Modify Makefile.

<pre>
  line  7: TARGET_OS = mswin32
  line 11: RT = msvcrt
</pre>

- C:\Temp\ruby-1.9.1-p376> nmake
- C:\Temp\ruby-1.9.1-p376> nmake install
- C:\Temp\ruby-1.9.1-p376> C:\ruby\bin\ruby -v

<pre>
  ruby 1.9.1p376 (2009-12-07 revision 26041) [i386-mswin32]
</pre>


Step 1: Build zlib
------------------

- Download [zlib-1.2.3.tar.gz](http://www.zlib.net/zlib-1.2.3.tar.gz) and do un-tar-gzip to `C:\Temp`.
- C:\Temp\zlib-1.2.3> nmake -f win32\Makefile.msc
- C:\Temp\zlib-1.2.3> mt -manifest zlib1.dll.manifest -outputresource:zlib1.dll;2
- Copy C:\Temp\zlib-1.2.3\zlib1.dll to C:\ruby\bin
- Move to C:\Temp\ruby-1.9.1-p376\ext\zlib
- C:\Temp\ruby-1.9.1-p376\ext\zlib> C:\ruby\bin\ruby.exe extconf.rb --with-zlib-include=C:\Temp\zlib-1.2.3 --with-zlib-lib=C:\Temp\zlib-1.2.3
- C:\Temp\ruby-1.9.1-p376\ext\zlib> nmake
- C:\Temp\ruby-1.9.1-p376\ext\zlib> nmake install


Step 2: Build openssl
---------------------

- Download [openssl-0.9.8k_WIN32.zip](http://openssl-for-windows.googlecode.com/files/openssl-0.9.8k_WIN32.zip) and do un-zip to `C:\Temp`.
- Copy C:\Temp\openssl-0.9.8k_WIN32\bin\libeay32.dll and ssleay32.dll to C:\ruby\bin
- Modify C:\Temp\openssl-0.9.8k_WIN32\include\openssl\x509.h (Add #undef X509_EXTENSIONS)

<pre>
  #ifdef OPENSSL_SYS_WIN32
  /* Under Win32 these are defined in wincrypt.h */
  #undef X509_NAME
  #undef X509_CERT_PAIR
  #undef X509_EXTENSIONS
  #endif
</pre>

- C:\Temp\ruby-1.9.1-p376\ext\openssl> C:\ruby\bin\ruby.exe extconf.rb --with-openssl-include=C:\Temp\openssl-0.9.8k_WIN32\include --with-openssl-lib=C:\Temp\openssl-0.9.8k_WIN32\lib
- C:\Temp\ruby-1.9.1-p376\ext\openssl> nmake
- C:\Temp\ruby-1.9.1-p376\ext\openssl> nmake install


Step 3: Build iconv
-------------------

- Download [iconv-1.8.win32.zip](http://www.meadowy.org/meadow/dists/snapshot/old/iconv-1.8.win32.zip) and do un-zip to `C:\Temp`.
- Copy C:\Temp\iconv-1.8.win32\lib\iconv.dll to C:\ruby\bin
- C:\Temp\ruby-1.9.1-p376\ext\iconv> C:\ruby\bin\ruby.exe extconf.rb --with-iconv-include=C:\Temp\iconv-1.8.win32\include --with-iconv-lib=C:\Temp\openssl-0.9.8k_WIN32\lib
- C:\Temp\ruby-1.9.1-p376\ext\iconv> nmake
- C:\Temp\ruby-1.9.1-p376\ext\iconv> nmake install


Step 4: Install Mechanize
-------------------------

- gem install Mechanize


Step 5: Remake the deps files for Shoes
---------------------------------------

- Download [deps-win32-1.9.1-p243-091011.zip](http://www.rin-shun.com/shoes/deps-win32-1.9.1-p243-091011.zip) and un-zip to `C:\Temp`.
- Evacuate two dlls, sqlite3.dll and portaudio.dll, from C:\Temp\deps\ruby\bin
- Delete C:\Temp\deps\ruby
- Copy C:\ruby to C:\Temp\deps
- Restore sqlite3.dll and portaudio.dll to C:\Temp\deps\ruby\bin


Step 6: Monkey patch
--------------------

- Edited C:\Temp\deps\ruby\lib\ruby\1.9.1\uri\common.rb line 226

<pre>
  end.force_encoding('US-ASCII')
</pre>

- Edited C:\Temp\deps\ruby\lib\ruby\1.9.1\win32\registry.rb line 340 and 342

<pre>
  msg = "\0".force_encoding('ASCII-8BIT') * 1024
  len = FormatMessageA.call(0x1200, 0, code, 0, msg, 1024, 0)
  msg = msg[0, len].force_encoding('ASCII-8BIT')
</pre>


Step 7: Build Shoes for Windows
-------------------------------

`C:\build` is my working directory for building Shoes.

- Open Git Bash console window.
- cd /c/build
- git clone git://github.com/ashbb/shoes.git
- Move C:\Temp\deps to C:\build\shoes
- Add the following between line 157 and 158 in C:\build\shoes\Rakefile

<pre>
    cp_r "deps/ruby/lib/ruby/site_ruby/1.9.1/openssl", "dist/ruby/lib"
    cp_r "deps/ruby/lib/ruby/site_ruby/1.9.1/openssl.rb", "dist/ruby/lib/"
</pre>

- Edit C:\build\shoes\lib\shoes.rb line 116 and 117 for Windows.

<pre>
    Shoes.app :width => 400, :height => 325, :resizable => false do  
      style(Para, :align => "center", :weight => "bold", :font => "Lacuna Regular", :size => 14)
</pre>

- Open the WDK (Windows Driver Kits) console window (Windows XP x86 Free Build Environment).
- C:\build\shoes> rake


Step 8: Package Shoes for Windows
-------------------------------

- Copy the following files by hand.   
  C:\build\shoes\deps\ruby\lib\ruby\gems\1.9.1\gems\mechanize-0.9.3 and nokogiri-1.4.1-x86-mswin32   
  to C:\build\shoes\dist\ruby\gems\1.9.1\gems\mechanize-0.9.3 and nokogiri-1.4.1-x86-mswin32

- Copy the following files by hand.   
  C:\build\shoes\deps\ruby\lib\ruby\gems\1.9.1\specifications\mechanize-0.9.3.gemspec and nokogiri-1.4.1-x86-mswin32.gemspec   
  to C:\build\shoes\dist\ruby\gems\1.9.1\specifications\mechanize-0.9.3.gemspec and nokogiri-1.4.1-x86-mswin32.gemspec

- C:\build\shoes> set NSIS=C:\Program Files\NSIS
- C:\build\shoes> rake package

Got the Shoes-0.r1279.exe under C:\build\shoes\pkg directory. Done!

- [deps-win32-1.9.1-p376-091219.zip](http://www.rin-shun.com/shoes/deps-win32-1.9.1-p376-091219.zip)
- [shoes-0.r1279.exe](http://www.rin-shun.com/shoes/shoes-0.r1279.exe)


Snapshot
--------

	# hack005.rb
	require 'mechanize'
	
	Shoes.app do
	  Agent = WWW::Mechanize.new
	  page = Agent.get('http://www.rubylearning.org/class/')
	  para page.body
	end

![mechanize_on_shoes.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/mechanize_on_shoes.png)


References
----------

- [Built Ruby 1.9.1-p0 with VC++ 2008 Express Edition](http://kazuwe.tdiary.net/20090131.html#p01) (in Japanese)
- [Install Ruby 1.9.1 to Windows](http://www.atmarkit.co.jp/fcoding/articles/ruby191/ruby191a.html) (in Japanese)


TODO
----

To avoide Monkey patches, I guess I have to consider the following:

- Have a clear distinction between the role of the deps and the req directories.
- Change the structure under C:\build\shoes\dist\ruby to work Ruby 1.9 correctly.
- Then need to revise the Rakefile.
