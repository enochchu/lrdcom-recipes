Lazy Load
======

In order to use lazy load all you need to do is add the class "lazy-load" to whatever element you desire. If you want to lazy load an image add the class and instead of placeing the img url into "src", place it in an attribute called "datasrc". This is useful for a number of things, whether it is speeding up initial load time by loading images when you scroll to them, or by adding a class when you scroll to something and utilizing that class to add transitions or animations to the respective element.

Lazy load will happen when the div reaches the bottome of the visible screen. It only happens once, so once it is loaded the class and loaded image will stay there until refresh.

[See it in action here](http://htmlpreview.github.io/?https://github.com/enochchu/lrdcom-recipes/blob/master/lazy-load/lazy_load.html)
(to see the lazy load adding the classes you can inspect and check the console, it prints out all the lazy-load elements onscroll, so you can see which elements have been loaded already)
