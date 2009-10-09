hack 011: Building Shoes for Windows: to show a button correctly
================================================================

**Note**: Continued from [hack 010](http://github.com/ashbb/shoes_hack_note/tree/master/md/hack010.md).


before
------

**sample33-bad.png**

![sample33-bad.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/sample33-bad.png)

I got the above bad look-and-feel buttons with my local Shoes-0.r1262 built by hack 010.


cut and try
-----------

Walk-through the following:

- `rb_define_method(cButton, ...)` in shoes/ruby.c
- `shoes_canvas_button()` in shoes/canvas.c
- `shoes_button_draw()` in shoes/ruby.c
- `shoes_native_button()` in native/window.c

I found Windows API: `CreateWindowExW()`. After googling, I found [this site](http://www.arcpit.co.jp/winapi/api_02/ap020203.htm) (in Japanese). At last, I got a solution luckily. :)

Edited code is [here](http://github.com/ashbb/shoes/commit/0c0ac02f445acecaeee3f6c410098a1146f3e2d5). Just one step.

after
-----

**sample33-good.png**

![sample33-good.png](http://github.com/ashbb/shoes_hack_note/raw/master/img/sample33-good.png)

Looks, good!!

note
----

The sample 33 is [here](http://shoes-tutorial-note.heroku.com/html/00518_Combination_of_image_objects_show_hide_and_mouse_hover_leave.html).


