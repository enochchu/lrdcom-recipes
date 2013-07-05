On Screen Helper
======

In order to use on screen helper all you need to do is add the class "on-screen-helper" to whatever element you desire. Then, when the element reaches the bottom of the visible screen the class "on-screen-bottom" will be added. When the element reaches the top of the screen the class "on-screen-top" will be added. After the element has completely left the visible screen both classes will be removed.

On screen helper allows you to add animations or transitions to elements which are triggered each time they enter the screen. You could add a css transition on .on-screen-bottom and then each time it entered the screen that transition would occur. This function can also be used for a paralax scrolling effect. Using the .on-screen-top class you could chang a div to position:fixed when it reaches the top of the screen, resulting in the allusion of paralax scrolling.

[See it in action here](http://htmlpreview.github.io/?https://github.com/enochchu/lrdcom-recipes/blob/master/on-screen-helper/on_screen_helper.html)
(to see the lazy load adding the classes you can inspect the elements and watch the classes being added and removed)
