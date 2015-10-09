Miracle Pop
==============

[See it in action here](http://htmlpreview.github.io/?https://github.com/enochchu/lrdcom-recipes/blob/master/miracle-pop/miracle_pop_demo.html)

The pop that keeps on giving.

The goal of this function is to be able to easily create and customize pop ups when we need to. In order to use it, all you need to do is paste the js code onto the pages you wish to use it on. Then, any elements you want to make pop up, you give the class "pop-up". Inside the div labled with the pop-up class, you place a div with the class "pop-up-content" which contains everything you want inside the pop up.

That is the basic use of the pop, but you can also customize it by placing different data-attributes in either the js script or on the html elments you gave the class "pop-up" to.

In the js, there is a place where you write the html for the #pagePopUp. You can add a number of different data-attributes to this div in order to customize the outcome.
data-pop-up-position can be set to "target" and this will center the pop-up on the node that you clicked on to open it. If this field is left off, the default behavior is to center the pop up on the page.
data-pop-up-direction can be set to "top", "right", "bottom", or "left". This attribute works with the previous attribute and tells the pop up which direction it should go relative to the center of the target node. If you put this attribute on the #pagePopUp div in the script, it will be the default direction. If you put this attribute on the "pop-up" element it will overide the default for that individual pop-up.
data-overlay can be set to "true" and will create an overlay mask if data-pop-up-position is not set.

You can also give the individual "pop-up" elements specific ids (such as popUp1) and then if you add your id (#popUp1) to the end of the url it will automatically pop up that article and scroll to it. This allows you to give specific urls which automatically display pop-ups.