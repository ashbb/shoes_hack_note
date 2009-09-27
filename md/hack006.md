hack 006: Building Shoes for Windows
====================================

Learning about building Shoes for Windows with Ruby 1.9.1 (mswin32) by trial and error.

Environment
-----------

**Windows Driver Kit Version 7.0.0 (WDK)**

Download site is [here](http://www.microsoft.com/downloads/details.aspx?FamilyID=2105564e-1a9a-4bf4-8d74-ec5b52da3d00&displaylang=en).


**Visual C++ 2008 Express Edition**

Download site is [here](http://www.microsoft.com/japan/msdn/vstudio/express/). (Japanese site)


**Ruby 1.9.1**

Download [Ruby 1.9.1-p243](http://www.ruby-lang.org/en/downloads/) and compile ruby from source. 

- [How to compile ruby from source on Windows?](http://madcoderspeak.blogspot.com/2009/06/how-to-compile-ruby-from-source-on.html)

Replace the following in the `Makefile` under `C:\ruby-build`

- PLATFORM = $(TARGET_OS)_90   -->   PLATFORM = $(TARGET_OS)
- RT = msvcr90   --> RT = msvcrt

*note: If your pc has the following path in the system environment, it'll not work well. Just delete that.*

- C:\Program Files\Git\bin


Then install it as `C:\ruby`

Download [openssl-0.9.8k-win32-bin_dynamic.zip](http://www.limber.jp/?plugin=attach&refer=Software%2FOpenSSL%20for%20Windows&openfile=openssl-0.9.8k-win32-bin_dynamic.zip) from [Software/OpenSSL for Windows - limber.jp](http://www.limber.jp/?Software%2FOpenSSL%20for%20Windows) (Japanese site)    
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
- copy `msvcrt-ruby191.dll` from `C:\ruby\bin` to `deps/ruby/bin` directory.
- move `sqlite3.dll` from `tmp/ruby/bin` to `deps/ruby/bin` directory.
- move `libeay32.dll` to `deps/ruby/bin` directory.


trial and error
---------------

**Open Windows XP Free Build Environment**

`Windows Driver Kits` --> `WDK 7600.16385.0` --> `Build Environments` --> `Windows XP` --> `x86 Free Build Environment`


**Do rake until building shoes.exe under dist directory by trial and error**

<pre>
C:\build\shoes>ls -la
total 16
drwxr-xr-x   13 WinDDK   Administ        0 Sep 20 15:23 .
drwxr-xr-x   10 WinDDK   Administ        0 Sep 20 15:21 ..
drwxr-xr-x    7 WinDDK   Administ        0 Sep 20 15:23 .git
-rw-r--r--    1 WinDDK   Administ       65 Sep 20 15:23 .gitignore
-rw-r--r--    1 WinDDK   Administ      601 Sep 20 15:23 CHANGELOG
-rw-r--r--    1 WinDDK   Administ     1431 Sep 20 15:23 COPYING
-rw-r--r--    1 WinDDK   Administ     4483 Sep 20 15:23 README
-rw-r--r--    1 WinDDK   Administ    20476 Sep 20 15:23 Rakefile
-rw-r--r--    1 WinDDK   Administ      146 Sep 20 15:23 app.yaml
drwxr-xr-x    2 WinDDK   Administ        0 Sep 20 15:23 bin
drwxr-xr-x    2 WinDDK   Administ        0 Sep 20 15:23 bugs
drwxr-xr-x    6 WinDDK   Administ        0 Sep 20 15:25 deps
drwxr-xr-x    2 WinDDK   Administ        0 Sep 20 15:23 fonts
drwxr-xr-x    3 WinDDK   Administ        0 Sep 20 15:23 lib
drwxr-xr-x    5 WinDDK   Administ        0 Sep 20 15:23 platform
drwxr-xr-x    9 WinDDK   Administ        0 Sep 20 15:23 req
drwxr-xr-x    2 WinDDK   Administ        0 Sep 20 15:23 samples
drwxr-xr-x    4 WinDDK   Administ        0 Sep 20 15:23 shoes
drwxr-xr-x    3 WinDDK   Administ        0 Sep 20 15:23 static
-rw-r--r--    1 WinDDK   Administ      499 Sep 20 15:23 use-deps
</pre>

**Step 001**

<pre>
C:\build\shoes>rake
(in C:/build/shoes)
cp platform/msw/shoes.ico shoes/appwin32.ico
mkdir -p dist/pkg
cl : Command line warning D9002 : ignoring unknown option '/ML'
app.c
.\shoes/app.h(14) : fatal error C1083: Cannot open include file: 'ruby.h': No su
ch file or directory
rake aborted!
Command failed with status (2): [cl /c /nologo /TP /Foshoes/app.obj /ML /DW...]

(See full trace by running task with --trace)
</pre>

Replace `/ML` to `/MT` at line 271 of `Rakefile`.

And simply add the path to `MSVC_CFLAGS` like this:

	/Ideps\\ruby\\lib\\ruby\\#{ruby_v}\\i386-mswin32
	/Ideps\\ruby\\include\\ruby-1.9.1                  #=> added this line
	/Ideps\\curl\\include



**Step 002**

<pre>
C:\build\shoes>rake
(in C:/build/shoes)
cp platform/msw/shoes.ico shoes/appwin32.ico
mkdir -p dist/pkg
app.c
c:\build\shoes\deps\ruby\include\ruby-1.9.1\ruby/ruby.h(25) : fatal error C1083:
 Cannot open include file: 'ruby/config.h': No such file or directory
rake aborted!
Command failed with status (2): [cl /c /nologo /TP /Foshoes/app.obj /MT /DW...]

(See full trace by running task with --trace)
</pre>

Needed to add one more path:

	/Ideps\\ruby\\include\\ruby-1.9.1\\i386-mswin32



**Step 003**

<pre>
C:\build\shoes>rake
(in C:/build/shoes)
cp platform/msw/shoes.ico shoes/appwin32.ico
mkdir -p dist/pkg
app.c
c:\build\shoes\deps\ruby\include\ruby-1.9.1\ruby/missing.h(157) : error C2375: '
vsnprintf' : redefinition; different linkage
        C:\WinDDK\7600.16385.0\inc\crt\stdio.h(310) : see declaration of 'vsnpri
ntf'
.\shoes/config.h(152) : fatal error C1083: Cannot open include file: 'win32/win3
2.h': No such file or directory
rake aborted!
Command failed with status (2): [cl /c /nologo /TP /Foshoes/app.obj /MT /DW...]

(See full trace by running task with --trace)
</pre>

Open `c:\build\shoes\deps\ruby\include\ruby-1.9.1\ruby/missing.h`

Comment out line 157 like this:

	//RUBY_EXTERN int vsnprintf(char *, size_t n, char const *, va_list);

Open `C:\build\shoes\shoes\config.h`

Replace `win32/win32.h` to `ruby/win32.h` at line 152.



**Step 004**

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
shoes/world.c(25) : warning C4273: 'shoes_world' : inconsistent dll linkage
        .\shoes/world.h(33) : see previous definition of 'shoes_world'
shoes/world.c(29) : warning C4273: 'shoes_world_alloc' : inconsistent dll linkag
e
        .\shoes/world.h(43) : see previous definition of 'shoes_world_alloc'
shoes/world.c(69) : warning C4273: 'shoes_world_free' : inconsistent dll linkage

        .\shoes/world.h(44) : see previous definition of 'shoes_world_free'
shoes/world.c(102) : warning C4273: 'shoes_init' : inconsistent dll linkage
        .\shoes/world.h(50) : see previous definition of 'shoes_init'
shoes/world.c(143) : warning C4273: 'shoes_load' : inconsistent dll linkage
        .\shoes/world.h(51) : see previous definition of 'shoes_load'
shoes/world.c(163) : warning C4273: 'shoes_set_argv' : inconsistent dll linkage
        .\shoes/world.h(56) : see previous definition of 'shoes_set_argv'
shoes/world.c(181) : warning C4273: 'shoes_start' : inconsistent dll linkage
        .\shoes/world.h(52) : see previous definition of 'shoes_start'
shoes/world.c(231) : warning C4273: 'shoes_final' : inconsistent dll linkage
        .\shoes/world.h(57) : see previous definition of 'shoes_final'
windows.c
shoes/native/windows.c(68) : warning C4273: 'shoes_win32_cmdvector' : inconsiste
nt dll linkage
        .\shoes/world.h(54) : see previous definition of 'shoes_win32_cmdvector'

c:\build\shoes\shoes\native\windows.c(978) : warning C4700: uninitialized local
variable 'msgs' used
winhttp.c
windownload.c
shoes/http/windownload.c(93) : error C2039: 'len' : is not a member of 'RArray'
        c:\build\shoes\deps\ruby\include\ruby-1.9.1\ruby/ruby.h(607) : see decla
ration of 'RArray'
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



**Step 005**

<pre>
C:\build\shoes>rake

   :
   :

windownload.c
LINK : fatal error LNK1181: cannot open input file 'msvcrt-ruby18.lib'
rake aborted!
Command failed with status (157): [link /NOLOGO /LIBPATH:C:\WinDDK\7600.16385...
]
</pre>

Oops, need to edit `Rakefile`:

<pre>
  #MSVC_LIBS = %[msvcrt-ruby18.lib pango-1.0.lib pangocairo-1.0.lib gobject-2.0.lib glib-2.0.lib cairo.lib giflib.lib jpeg.lib kernel32.lib user32.lib gdi32.lib comdlg32.lib shell32.lib comctl32.lib ole32.lib oleaut32.lib advapi32.lib oleacc.lib winhttp.lib]
  MSVC_LIBS = %[msvcrt-ruby191.lib pango-1.0.lib pangocairo-1.0.lib gobject-2.0.lib glib-2.0.lib cairo.lib giflib.lib jpeg.lib kernel32.lib user32.lib gdi32.lib comdlg32.lib shell32.lib comctl32.lib ole32.lib oleaut32.lib advapi32.lib oleacc.lib winhttp.lib]
</pre>


**Step 006**

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
cp -r deps/ruby/bin/msvcrt-ruby191.dll dist/
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
mv dist/nsis/shoes-0.r1252.exe pkg

C:\build\shoes>
</pre>

Done! Here are the log files: [rake_package_log.txt](http://github.com/ashbb/shoes_hack_note/tree/master/log/rake_package_log_090920.txt) and [all_rake_logs.txt](http://github.com/ashbb/shoes_hack_note/tree/master/log/all_rake_logs_090920.txt)

*Note: Looks like it finished to build dist and pkg perfectly, but shoes-0.r1252.exe has not open Shoes app window.... so far. Need one more step. :)*

To launch shoes-0.r1252
-----------------------

Open shoes/world.c

Replace `shoes_ruby_embed()` like this:

	#ifdef RUBY_1_9
	int
	shoes_ruby_embed()
	{
	  VALUE v;
	  char *argv[] = {"ruby", "-e", "1"};
	  int sysinit_argc = 0;                           // added three lines (1)
	  char**  sysinit_argv = NULL;                    //                   (2)
	  RUBY_INIT_STACK;
	  ruby_sysinit( &sysinit_argc, &sysinit_argv );   //                   (3)
	  ruby_init();
	  v = (VALUE)ruby_options(3, argv);
	  return !FIXNUM_P(v);
	}

At last, shoes-0.r1252 opened my tiny Shoes app. Look at [this](http://vgoff.blogspot.com/2009/09/success-building-shoes-for-windows-with.html). :-D


Note
----
- [old page](http://github.com/ashbb/shoes_hack_note/tree/master/md/hack006_old.md)
- shoes-0.r1252.exe works well for installing Shoes.
- Run `C:\Program Files\Common Files\Shoes\0.r1252\shoes.exe`. It open Shoes opening window. 
- You can select `Open an App`. The app will work well without image and video... so far.
- Built-in manual not work... so far.

