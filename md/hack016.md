hack 016: Building Shoes for Windows: to open .shy file
=======================================================

After [hack 015](http://github.com/ashbb/shoes_hack_note/tree/master/md/hack015.md): rebuilt the deps files with Ruby 1.9.1p376 and add some extensions.

My local build for Windows became to be able to create .shy file with new packaging UI. Look at a tiny [note](http://shoes-tutorial-note.heroku.com/html/00613_new_packaging_UI_added.html).

But when I opened the .shy file, I got an error:

![shoes-shy-error.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/shoes-shy-error.png)


a monkey patch
--------------

I'm not sure this is a right solution. Just add an instance variable `@shy`. But it works:   

**lib/shoes.rb**

<pre>
  def self.visit(path)
    uri = Shoes.uri(path)

    case uri
    when URI::HTTP
      str = uri.read
      if str !~ /Shoes\.app/
        Shoes.app do
          eval(uri.read)
        end
      else
        eval(uri.read)
      end
    else
      path = File.expand_path(path.gsub(/\\/, "/"))
      if path =~ /\.shy$/
        @shy = true
        require 'shoes/shy'
        base = File.basename(path, ".shy")
        tmpdir = "%s/shoes-%s.%d" % [Dir.tmpdir, base, $$]
        shy = Shy.x(path, tmpdir)
        Dir.chdir(tmpdir)
        Shoes.debug "Loaded SHY: #{shy.name} #{shy.version} by #{shy.creator}"
        path = shy.launch
      else
        @shy = false
        Dir.chdir(File.dirname(path))
        path = File.basename(path)
      end

      $0.replace path
      Dir.chdir('D:/work/build/tmp')
      
      code = read_file(path)
      eval(code, TOPLEVEL_BINDING, path)
    end
  rescue SettingUp
  rescue Object => e
    error(e)
    show_log
  end

  def self.read_file path
    if RUBY_VERSION =~ /^1\.9/ and !@shy
      File.open(path, 'r:utf-8') { |f| f.read }
    else
      File.read(path)
    end
  end
</pre>

The lib/shoes/shy.rb uses 'b' option to open a file. Look at [line 60](http://github.com/shoes/shoes/blob/master/lib/shoes/shy.rb#L60).   
At first, I guessed this was the cause of the problem. But nothing was changed by removing 'b' option. xx-P

Need more hacking...


Note
----

The related discussion at Shoooes ML is [new packaging UI added](http://groups.google.com/group/shoooes/browse_thread/thread/e581a285c62ad6ad). 