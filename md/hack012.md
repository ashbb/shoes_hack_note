hack 012: Building Shoes for Windows: to play bloopsaphone
==========================================================

**Note**: Continued from [hack 011](http://github.com/ashbb/shoes_hack_note/tree/master/md/hack011.md).

I found that \_why had given his files to us Windows users.

There was nothing to edit Shoes code. Just only to put the files in place.

- copy the `bloops.so` file from `C:\Program Files\Common Files\Shoes\0.r1243\ruby\lib\i386-mswin32` to `C:\build\shoes\deps\ext\bloops`.

- copy the `portaudio_x86.dll` file from `C:\Program Files\Common Files\Shoes\0.r1243` to `C:\build\shoes\deps\ruby\bin` and rename to `portaudio.dll`.

Bloopsaphone worked very well on my latest Policeman (0.r1263)!!

**shoes-bloopsaphone-snapshot.png**

![shoes-bloopsaphone-snapshot.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/shoes-bloopsaphone-snapshot.png)

Click the song title. You can listen it with bloopsaphone. :)

Note
----

- I've not been successful to compile bloopsaphone source code with VC9 so far.
- A little Shoes app of the above snapshot is [here](http://github.com/ashbb/shoes_hack_note/blob/master/src/shoes_bloopsaphone_play_list.rb). Songs are [here](http://github.com/ashbb/shoes_hack_note/tree/master/src/songs/).
- **1901** was from [here](http://www.aanandprasad.com/1901).


