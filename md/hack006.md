hack 006: Building Shoes for Windows
====================================

Learning about building Shoes for Windows with Ruby 1.9.1 (mswin32) by trial and error.

Environment
-----------

**Windows Server 2003 DDK (Driver Development Kit)**

It seems to be no longer supported. Look at [the Windows Driver Kit (WDK)](http://www.microsoft.com/whdc/DevTools/ddk/default.mspx).


**Visual C++ 2008 Express Edition**

Download site is [here](http://www.microsoft.com/japan/msdn/vstudio/express/). (Japanese site)


**Ruby 1.9.1**

Download [Ruby 1.9.1-p243](http://www.ruby-lang.org/en/downloads/) and compile ruby from source. Then install it as `C:\ruby`

- [How to compile ruby from source on Windows?](http://madcoderspeak.blogspot.com/2009/06/how-to-compile-ruby-from-source-on.html)

Download **openssl-0.9.8k-win32-bin_dynamic.zip** from [Software/OpenSSL for Windows - limber.jp](http://www.limber.jp/?Software%2FOpenSSL%20for%20Windows) (Japanese site)    
Unzip and get `libeay32.dll`


Shoes directory
---------------

**check out**

	$ git clone git://github.com/shoes/shoes.git


**make deps directory**

- make `deps` directory under `shoes` directory.
- download the win32 dependencies (**deps\-win32\-1.6.4\-1.20.5+vlc**) from [here](http://wiki.github.com/shoes/shoes/buildingshoes).
- unzip that at `tmp` directory.
- move `cairo`, `pango` and `winhttp` from `tmp` to `deps` directory.
- make `ruby` directory under `deps` directory.
- copy `include`, `lib` and `man` from `C:\ruby` to `deps/ruby` directory.
- make `bin` directory under `deps/ruby` directory.
- copy `msvcr90-ruby191.dll` from `C:\ruby\bin` to `deps/ruby/bin` directory.
- move `sqlite3.dll` from `tmp/ruby/bin` to `deps/ruby/bin` directory.
- move `libeay32.dll` to `deps/ruby/bin` directory.


trial and error
---------------

**Open Windows XP Free Build Environment**

- Look at [this](http://github.com/ashbb/shoes_tutorial_html/blob/master/mdowns/00608_Building_Shoes_with_Windows_DDK.mdown).

**Do rake until building shoes.exe under dist directory by trial and error**

**Step 001**

<pre>
C:\build\shoes>dir

2009/09/05  10:09    <DIR>          .
2009/09/05  10:09    <DIR>          ..
2009/09/05  09:59    <DIR>          .git
2009/09/05  09:59                65 .gitignore
2009/09/05  09:59               146 app.yaml
2009/09/05  09:59    <DIR>          bin
2009/09/05  09:59    <DIR>          bugs
2009/09/05  09:59               601 CHANGELOG
2009/09/05  09:59             1,431 COPYING
2009/09/05  10:10    <DIR>          deps
2009/09/05  09:59    <DIR>          fonts
2009/09/05  09:59    <DIR>          lib
2009/09/05  09:59    <DIR>          platform
2009/09/05  09:59            20,396 Rakefile
2009/09/05  09:59             4,483 README
2009/09/05  09:59    <DIR>          req
2009/09/05  09:59    <DIR>          samples
2009/09/05  09:59    <DIR>          shoes
2009/09/05  09:59    <DIR>          static
2009/09/05  09:59               499 use-deps


C:\build\shoes>rake
(in C:/build/shoes)
rake aborted!
No such file or directory - git rev-list HEAD
c:/ruby/lib/ruby/1.9.1/rake.rb:2342:in `raw_load_rakefile'
(See full trace by running task with --trace)

</pre>

Look at this [Note 1 and 2](http://github.com/ashbb/shoes_tutorial_html/blob/master/mdowns/00608_Building_Shoes_with_Windows_DDK.mdown)

This is the problem caused by my environment. You may not get this trouble. I edited `Rakefile` a bit like this:

	#REVISION = (`#{GIT} rev-list HEAD`.split.length + 1).to_s
	REVISION = '1251'


**Step 002**

<pre>
C:\build\shoes>rake
(in C:/build/shoes)
cp platform/msw/shoes.ico shoes/appwin32.ico
mkdir -p dist/pkg
app.c
shoes\app.h(14) : fatal error C1083: Cannot open include file: 'ruby.h': No such
 file or directory
rake aborted!
Command failed with status (2): [cl /c /nologo /TP /Foshoes/app.obj /ML /DW...]

(See full trace by running task with --trace)
</pre>

Simply added the path to `MSVC_CFLAGS` like this:

	/Ideps\\ruby\\lib\\ruby\\#{ruby_v}\\i386-mswin32
	/Ideps\\ruby\\include\\ruby-1.9.1                  #=> added this line
	/Ideps\\curl\\include


**Step 003**

<pre>

C:\build\shoes>rake
(in C:/build/shoes)
cp platform/msw/shoes.ico shoes/appwin32.ico
mkdir -p dist/pkg
app.c
c:\build\shoes\deps\ruby\include\ruby-1.9.1\ruby\ruby.h(25) : fatal error C1083:
 Cannot open include file: 'ruby/config.h': No such file or directory
rake aborted!
Command failed with status (2): [cl /c /nologo /TP /Foshoes/app.obj /ML /DW...]

(See full trace by running task with --trace)
</pre>

Needed to add one more path:

	/Ideps\\ruby\\include\\ruby-1.9.1\\i386-mswin32_90


**Step 004**

<pre>
C:\build\shoes>rake
(in C:/build/shoes)
cp platform/msw/shoes.ico shoes/appwin32.ico
mkdir -p dist/pkg
app.c
deps\ruby\include\ruby-1.9.1\i386-mswin32_90\ruby\config.h(2) : fatal error C118
9: #error :  MSC version unmatch: _MSC_VER: 1500 is expected.
rake aborted!
Command failed with status (2): [cl /c /nologo /TP /Foshoes/app.obj /ML /DW...]

(See full trace by running task with --trace)
</pre>

I'm using Visual C++ 9.0 (Visual Studio 2008). So why not 1500?...   
I tried the following:
<pre>
C:\build\shoes>set _MSC_VER=1500

C:\build\shoes>irb
irb(main):001:0> ENV['_MSC_VER']
=> "1500"
</pre>

But `rake` showed the same error.... So, I did the following in the mean time.

**config.h** : comment out first 3 lines.

<pre>
//#if _MSC_VER != 1500
//#error MSC version unmatch: _MSC_VER: 1500 is expected.
//#endif
</pre>


**Step 005**

<pre>
C:\build\shoes>rake
(in C:/build/shoes)
cp platform/msw/shoes.ico shoes/appwin32.ico
mkdir -p dist/pkg
app.c
shoes\config.h(152) : fatal error C1083: Cannot open include file: 'win32/win32.
h': No such file or directory
rake aborted!
Command failed with status (2): [cl /c /nologo /TP /Foshoes/app.obj /ML /DW...]

(See full trace by running task with --trace)
</pre>

**shoes/config.h**: replaced from `win32/win32` to `ruby/win32`

<pre>
//#include "win32/win32.h"
#include "ruby/win32.h"
</pre>


**Step 006**

<pre>
C:\build\shoes>rake
(in C:/build/shoes)
cp platform/msw/shoes.ico shoes/appwin32.ico
mkdir -p dist/pkg
app.c
canvas.c
effects.c
image.c
internal.c
ruby.c
world.c
shoes\world.c(25) : warning C4273: 'shoes_world' : inconsistent dll linkage
shoes\world.c(29) : warning C4273: 'shoes_world_alloc' : inconsistent dll linkage
shoes\world.c(69) : warning C4273: 'shoes_world_free' : inconsistent dll linkage

shoes\world.c(102) : warning C4273: 'shoes_init' : inconsistent dll linkage
shoes\world.c(143) : warning C4273: 'shoes_load' : inconsistent dll linkage
shoes\world.c(163) : warning C4273: 'shoes_set_argv' : inconsistent dll linkage
shoes\world.c(181) : warning C4273: 'shoes_start' : inconsistent dll linkage
shoes\world.c(231) : warning C4273: 'shoes_final' : inconsistent dll linkage windows.c
shoes\native\windows.c(68) : warning C4273: 'shoes_win32_cmdvector' : inconsiste nt dll linkage
c:\build\shoes\shoes\native\windows.c(978) : warning C4700: local variable 'msgs' used without having been initialized
winhttp.c
windownload.c
shoes\http\windownload.c(93) : error C2039: 'len' : is not a member of 'RArray'
        c:\build\shoes\deps\ruby\include\ruby-1.9.1\ruby\ruby.h(607) : see decla ration of 'RArray'
rake aborted!
Command failed with status (2): [cl /c /nologo /TP /Foshoes/http/windownloa...]

(See full trace by running task with --trace)
</pre>

Look at ruby.h(607):

	struct RArray {
	    struct RBasic basic;
	    union {
		struct {
		    long len;
		    union {
			long capa;
			VALUE shared;
		    } aux;
		    VALUE *ptr;
		} heap;
		VALUE ary[RARRAY_EMBED_LEN_MAX];
 	   } as;
	};


I see. Then I edited `shoes/http/windownload.c` at line number 93:

	//for (i = 0; i < RARRAY(keys)->len; i++ )
	for (i = 0; i < RARRAY(keys)->as.heap.len; i++ )



**Step 007**

<pre>
C:\build\shoes>rake

   :
   :

windownload.c
LINK : fatal error LNK1181: cannot open input file 'msvcrt-ruby18.lib'
rake aborted!
Command failed with status (157): [link /NOLOGO /LIBPATH:C:\WINDDK\3790~1.183...]

</pre>

Oops, need to edit `Rakefile`:

<pre>
  #MSVC_LIBS = %[msvcrt-ruby18.lib pango-1.0.lib pangocairo-1.0.lib gobject-2.0.lib glib-2.0.lib cairo.lib giflib.lib jpeg.lib kernel32.lib user32.lib gdi32.lib comdlg32.lib shell32.lib comctl32.lib ole32.lib oleaut32.lib advapi32.lib oleacc.lib winhttp.lib]
  MSVC_LIBS = %[msvcr90-ruby191.lib pango-1.0.lib pangocairo-1.0.lib gobject-2.0.lib glib-2.0.lib cairo.lib giflib.lib jpeg.lib kernel32.lib user32.lib gdi32.lib comdlg32.lib shell32.lib comctl32.lib ole32.lib oleaut32.lib advapi32.lib oleacc.lib winhttp.lib]
</pre>


**Step 008**

Downloaded [NSIS](http://nsis.sourceforge.net/Download) and installed before the following:

<pre>
C:\build\shoes>set NSIS=C:\Program Files\NSIS

C:\build\shoes>rake package > rake_package_log.txt
cp platform/msw/shoes.ico shoes/appwin32.ico
mkdir -p dist/pkg
rm -f dist/shoes.exe
mkdir -p dist/ruby
cp -r deps/ruby/lib/ruby/1.9.1 dist/ruby/lib
rm -rf dist/ruby/lib/soap
rm -rf dist/ruby/lib/wsdl
rm -rf dist/ruby/lib/xsd
cp -r req/rubygems/rbconfig dist/ruby/lib
cp -r req/rubygems/rubygems dist/ruby/lib
cp -r req/rubygems/rubygems.rb dist/ruby/lib
cp -r req/rubygems/ubygems.rb dist/ruby/lib
cp -r req/ftsearch/lib/ftsearch dist/ruby/lib
mkdir -p dist/ruby/gems/1.9.1/specifications
mkdir -p dist/ruby/gems/1.9.1/gems/hpricot-0.8.1/lib
cp -r req/hpricot/lib/hpricot dist/ruby/gems/1.9.1/gems/hpricot-0.8.1/lib
cp -r req/hpricot/lib/hpricot.rb dist/ruby/gems/1.9.1/gems/hpricot-0.8.1/lib
mkdir -p dist/ruby/gems/1.9.1/gems/hpricot-0.8.1/lib
cp req/hpricot/gemspec dist/ruby/gems/1.9.1/specifications/hpricot-0.8.1.gemspec

mkdir -p dist/ruby/gems/1.9.1/specifications
mkdir -p dist/ruby/gems/1.9.1/gems/json-shoes-1.1.3/lib
cp -r req/json/lib/json dist/ruby/gems/1.9.1/gems/json-shoes-1.1.3/lib
cp -r req/json/lib/json.rb dist/ruby/gems/1.9.1/gems/json-shoes-1.1.3/lib
mkdir -p dist/ruby/gems/1.9.1/gems/json-shoes-1.1.3/lib/json/ext
cp req/json/gemspec dist/ruby/gems/1.9.1/specifications/json-shoes-1.1.3.gemspec

mkdir -p dist/ruby/gems/1.9.1/specifications
mkdir -p dist/ruby/gems/1.9.1/gems/sqlite3-ruby-1.2.4/lib
cp -r req/sqlite3/lib/sqlite3 dist/ruby/gems/1.9.1/gems/sqlite3-ruby-1.2.4/lib
cp -r req/sqlite3/lib/sqlite3.rb dist/ruby/gems/1.9.1/gems/sqlite3-ruby-1.2.4/li
b
mkdir -p dist/ruby/gems/1.9.1/gems/sqlite3-ruby-1.2.4/lib
cp req/sqlite3/gemspec dist/ruby/gems/1.9.1/specifications/sqlite3-ruby-1.2.4.ge
mspec
cp -r deps/ruby/bin/libeay32.dll dist/
cp -r deps/ruby/bin/msvcr90-ruby191.dll dist/
cp -r deps/ruby/bin/sqlite3.dll dist/
cp -r deps/cairo/bin/giflib4.dll dist/
cp -r deps/cairo/bin/jpeg62.dll dist/
cp -r deps/cairo/bin/libcairo-2.dll dist/
cp -r deps/cairo/bin/libpng12-0.dll dist/
cp -r deps/pango/bin/iconv.dll dist/
cp -r deps/pango/bin/intl.dll dist/
cp -r deps/pango/bin/libglib-2.0-0.dll dist/
cp -r deps/pango/bin/libgmodule-2.0-0.dll dist/
cp -r deps/pango/bin/libgobject-2.0-0.dll dist/
cp -r deps/pango/bin/libpango-1.0-0.dll dist/
cp -r deps/pango/bin/libpangocairo-1.0-0.dll dist/
cp -r deps/pango/bin/libpangowin32-1.0-0.dll dist/
cp -r deps/pango/bin/zlib1.dll dist/
cp -r fonts dist/fonts
cp -r lib dist/lib
cp -r samples dist/samples
cp -r static dist/static
cp README dist/README.txt
cp CHANGELOG dist/CHANGELOG.txt
cp COPYING dist/COPYING.txt
cp platform/msw/shoes.exe.manifest dist/shoes.exe.manifest
cp dist/zlib1.dll dist/zlib.dll
mkdir -p pkg
rm -rf dist/nsis
cp -r platform/msw dist/nsis
cp platform/msw/shoes.ico dist/nsis/setup.ico
mv dist/nsis/shoes-0.r1251.exe pkg

C:\build\shoes>
</pre>

Done! Here is the log file: [rake_package_log.txt](http://github.com/ashbb/shoes_hack_note/tree/master/log/rake_package_log_090905.txt)

*Note: Looks like to build dist and pkg perfectly, but shoes-0.r1251.exe has never open Shoes app window....* **Need more hacking deeply!** xx-P


