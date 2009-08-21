hack 004: Minimum Shoes
=======================

In the case of 0.r1243 on Windows without video, this is The Minimum Shoes.

- giflib4.dll
- jpeg62.dll
- libcairo-2.dll
- libglib-2.0-0.dll
- libgmodule-2.0-0.dll
- libgobject-2.0-0.dll
- libpango-1.0-0.dll
- libpangocairo-1.0-0.dll
- libpangowin32-1.0-0.dll
- libpng12-0.dll
- libshoes.dll
- shoes.exe
- shoes.rb

<pre>
<code>
# shoes.rb
class Shoes
  def self.run path
    [nil]
  end

  def self.args!
    Shoes.app do
      para 'Hello world!'
    end
  end
end
</code>
</pre>