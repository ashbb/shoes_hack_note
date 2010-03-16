hack 022: Checking Shoes Samples: expert-funnies.rb
===================================================

The expert-funnies.rb works fine with Raisins (Shoes-0.r1134), but didn't work well with Policeman (Shoes-0.r1377).


Error 1
-------

![error-expert-funnies-1.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/error-expert-funnies-1.png)

Replaced from `c.latest_image.to_s` to `c.latest_image.first` at line 46, expert-funnies.rb.


Error 2
-------

At first clear `.shoes/+cache` directory and `.shoes/+data` file for SQLite3.

Then ran expert-funnies.rb with Policeman. It works well with no error.

But without clearing `.shoes/+cache` and `.shoes/+data`, 
ran expert-funnies.rb with Policeman, then got the following error:

![error-expert-funnies-1.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/error-expert-funnies-1.png)


Solution
--------

After some debugging and googling, I found a solution. Look at `lib/shoes/data.rb`

- line 17: replaced from `saved date` to `saved datetime`   
- line 28: replaced from `saved.ctime.to_i` to `Time.parse(saved.to_s).to_i`	

Okay now, Policeman can load cached image files. :)


snapshot
--------

![snapshot-expert-funnies.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/snapshot-expert-funnies.png)

