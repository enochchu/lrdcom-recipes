Pop Click
======

In order to use pop click all you need to do is add the class "pop-click" to whatever element you desire. When an element with the class "pop-click" is clicked on the class "pop-click-active" is added to that element. The class will then be removed on any click that is outside of an element containing the class "pop-click-content".

Pop Click's easiest implementation is for drop down menus. You can add the class "pop-click" to the lis and the class "pop-click-content" to the menu ul or div inside of that li. Simply hide the submenu in css and thene is display it again when the class "pop-click-active" is present. It could also be used for anything that you want to do with css that occurs on click and is removed when the user clicks somewhere else on the screen.

A simple example would be:
\<div class="pop-click"\>
	\<span class="pop-click-content"\>popped!\</span\>
\</div\>

[See it in action here](http://htmlpreview.github.io/?https://github.com/enochchu/lrdcom-recipes/blob/master/pop-click/pop_click.html)
