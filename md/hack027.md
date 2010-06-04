hack 027: Shoes Gem
===================

Install Helper
--------------

- gem update --system
- gem install jeweler
- git config --global github.user XXXXX
- git config --global github.token XXXXXXXXXXXXXXXXXXXXXXX


Build Shoes
-----------

Look at [hack019](http://github.com/ashbb/shoes_hack_note/blob/master/md/hack019.md)


Build Shoes Gem
---------------

- cd c:\
- git clone git://github.com/ashbb/shoesgem.git
- cd shoesgem
- mv c:\shoes_dev\sandbox\shoes\dist shoes
- edit VERSION file by hand
- rake gemspec
- rake build

You can build pkg/shoesgem-xx.xx.xx.gem.


Deploy Gem
----------

- cd c:\shoesgem\pkg
- gem push shoesgem-xx.xx.xx.gem

That's all. You can install ShoesGem like this:

- gem install shoesgem


Note
----

[shoesgem](http://rubygems.org/gems/shoesgem) on RubyGems.org

