hack 008: Building Shoes for Windows: to use sqlite3-ruby with ruby 1.9.1
=========================================================================

**Note**: Continued from [hack 007](http://github.com/ashbb/shoes_hack_note/tree/master/md/hack007.md).

At the end of hack 007, I got the error: **no driver for sqlite3 found**

After a bit more hacking, I noticed that there is no `sqlite3_api.so` in the github repo, shoes/shoes commit/09d4d8c98c547362ba7cbc3c32719b7423c5a0e8.

Then I went to the [RubyForge SQLite-Ruby download site](http://rubyforge.org/frs/?group_id=254&release_id=37214) and I found no binary files for sqlite3-ruby 1.2.4. :(

So, I decided to try using sqlite3-ruby 1.2.5. :)


sqlite3-ruby 1.2.5
------------------

- download `sqlite3-ruby-1.2.5-x86-mswin32.gem` from [here](http://rubyforge.org/frs/?group_id=254&release_id=37214)

- `gem install sqlite3-ruby-1.2.5-x86-mswin32.gem --local`

- copy `C:/ruby-1.8.6/lib/ruby/gems/1.8/gems/sqlite3-ruby-1.2.5-x86-mswin32/ext` and `LICENSE`
  --> `C:/build/shoes/req/sqlite3/ext` and `LICENSE`

- copy `lib/sqlite3.rb` and `sqlite3`  --> `lib/sqlite3.rb` and `sqlite3`

- copy `ib/1.9/sqlite3_api.so`  --> `lib/sqlite3_api.so`

- copy `C:/ruby-1.8.6/lib/ruby/gems/1.8/specifications/sqlite3-ruby-1.2.5-x86-mswin32.gemspec` 
  --> `C:/build/shoes/req/sqlite3/gemspec`

- download `sqlitedll-3_6_18.zip` from [here](http://www.sqlite.org/download.html)

- unzip and move over `sqlitedll-3_6_18/sqlite3.dll` --> `deps/ruby/bin/sqlite3.dll`


Re-build Shoes
--------------

Okay, now is the time to re-build Shoes.

- open `x86 Free Build Environment` and `cd c:/build/shoes` and run `rake`


Execute the test snippet
------------------------

test snippet is:

	Shoes.app do
	  image "http://www.aoky.net/articles/why_poignant_guide_to_ruby/images/ad-weeizards.gif"
	end

Execute the test snippet: `C:/build/shoes/dist/shoes.exe`

Then I got `.shoes/+cache` directory and `.shoes/+data` file created by `sqlite3` via `salite3-ruby`.

**sqlite3-database.png**

![sqlite3-database.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/sqlite3-database.png)

Finally, sqlite3 worked!!

Although there was no data under the `.shoes/+cache` directory and my Shoes aborted at the end. 

Okay, I'm going to go ahead to download an image data via http protocol. Good luck to me! ;-)
