hack 009: Building Shoes for Windows: to download and cache an image data via http protocol
===========================================================================================

**Note**: Continued from [hack 008](http://github.com/ashbb/shoes_hack_note/tree/master/md/hack008.md).

At the end of hack 008, there was no data under the `.shoes/+cache` directory and my Shoes aborted at the end.

After more hacking, I got an solution. Just needed to modify the following two files. :)

shoes/image.c
-------------

Shoes aborted at `fclose`. So, replaced `fopen` / `fread` / `fclose` to Win32APIs: `CreateFile` / `ReadFile ` / `CloseHandle`.

Here is the edited [code](http://github.com/ashbb/shoes/commit/4271b8035ca61cd9fd17042f75dc71c250bf8af6).


lib/shoes/data.rb
-----------------

Got this error message:

**error-undefined-for-date.png**

![error-undefined-for-date.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/error-undefined-for-date.png)


Here is the improved [code](http://github.com/ashbb/shoes/commit/c4621b904ea0a1f7f6236c7f407a632bf4973936) for using sqlite3-ruby 1.2.5

Finally, it downloaded and cached an image data via internet with `winhttp.lib`. Yay! :-D
