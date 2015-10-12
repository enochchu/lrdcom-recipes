SVG
======
**general good practices**:

add `<title>...</title>` and `<desc>...</desc>` for accessibility

add `role="img"` attribute in the opening svg tag if the svg is purely graphical.
If the svg has interactive components, add the role attribute to define the interactive parts. For example: ``<a xlink:href="path" role="link">``

[read more...](http://www.sitepoint.com/tips-accessible-svg/)

**basics**:

_Canvas_: the infinite space that the svg is drawn. displayed relative to the vieport.

_Viewport_: determines the visible area of the svg. defined by width and height attributes.

`<svg width="800" height="600"> ... </svg>`

[SVG styling properties](http://www.w3.org/TR/SVG/styling.html#SVGStylingProperties)

Coordinate Systems:
-----
_viewport coordinate system_: based on the viewport. origin at top left corner. once specified with width and height attributes, it will create a _user coordinate system_.

_user coordinate system/ user space in use_: based on the canvas. specified using the `viewBox` attribute. If the user coordinate system has the same aspect ratio as the viewport coordinate system, it'll stretch to fill the latter. Otherwise, _`perserveAspectRatio`_ attribute will scale to fit and center (in both x and y direction) inside the viewport coordinate system.

`viewBox = <min-x> <min-y> <width> <height>`
where min-x and min-y define position of the new origin

`<svg width="800" height="600" viewbox="0 0 800 600">`

##### examples:
`<svg width="800" height="600" viewbox="0 0 400 300">`
meaning:
- the svg graphic is scaled/zoomed to fill the viewport
- same aspect ratio
- 1 user unit = 2 viewport units (1:2 ratio)
- anything drawn to the svg canvas will be drawn relative to the new user coordinate system

`<svg width="800" height="600" viewbox="100 100 200 150">`
meaning:
-   1:4 (user:viewport units)

[read more...](http://sarasoueidan.com/blog/svg-coordinate-systems/)

Useful Tags:
-----
#### `<use>...</use>`
for reusing elements by translating them to the new coordinates relative to the original element (_shadow host, where the content of which is hosted in a shadow document fragment_)

`<use x="100" y="100" xlink:href="#groupId" />`
or

`<use x="100" y="100" xlink:href="path/to/name.svg#groupId" />` (**this method of referencing external svg doesn't work in most IE**)

equivalent to `<use xlink:href="#bird" transform="translate(100, 100)" />`
- in other words, copying the original object, moving it 100 user units in the x and y direction from the current position.
- or that the new reused element is positioned relative to the original

#####limitations:
- cannot override styles of the original element on the copy (because the content lives in the shadow DOM)

**workaround** [**[read more...]**](http://tympanus.net/codrops/2015/07/16/styling-svg-use-content-css/):

```
use.class-name {
  fill: $secondaryColor;
}

svg path {
  fill: inherit;
}
```

in extreme cases, can reset all properties with (but proceed with caution):
```
path#myPath {
    all: inherit;
}
```

- only works for elements already rendered on the canvas

#### `<defs>...</defs>`
used to store elements without rendering them -- a way to have a hidden content that can be referenced and displayed by other SVG elements. (think of it as a template)

```
<svg>
    <defs>
        <linearGradient id="gradient">
            <stop offset="0%" style="stop-color: deepPink"></stop>
            <stop offset="100%" style="stop-color: #009966"></stop>
        </linearGradient>
    </defs>

    <rect stroke="#eee" stroke-width="5" fill="url(#gradient)"></rect>
</svg>
```

- position is set relative to the origin of the user coordinate system
- can use `<use>...</use>` on the elements defined in `<defs>...</defs>`, which is now positioned relative to the origin of the user coordinate system ^

#####limitations:
- if there are styles in the `<defs>...</defs>`, it cannot be overwritten.

#### `<symbol>...</symbol>`
- accepts the viewbox attribute
- see [SVG sprite](https://github.com/ryanschuhler/lrdcom-recipes/blob/master/notes/svg.md#svg-sprite)

##### other:

#### `<mask>...</mask>`
- defined by wrapping in `<defs>`. Use case: `<text font-size=“230” fill=“#000” mask=“url(#mask)”>`
- mask is white by default, therefore the color applied to mask will look transparent the closer it is to black and more opaque the closer it is to white.

[read more...](http://sarasoueidan.com/blog/structuring-grouping-referencing-in-svg/)

Responsive SVGs:
----
#### SVG embedded using `<img>` or `<object>`
- to make responsive, remove width and height but leave viewbox attribute.
- add
```
IE fix
img  {
      width: 100%;
}
```

#### SVG embedded using `<iframe>` or `<svg>`
- When setting padding in %, the % is calculated relative to the width of the element
- width automatically assumed to be 100% of its wrapping container, but height is set to be 150px by default in ie
- requires a wrapper for the ie hack
on the container:

```
.container {
    height: 0;             >> collapse the container's height
    width: width-value;    >> specify a percentage value
    padding-top: (svg height / svg width) * width-value;  >> in percentage
    position: relative;    >> set a position context for the svg
}
```
_the idea is to collapse the height and recreate it using padding while retaining the aspect ratio of the svg_

```
.svg {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
}
```
_svg doesn't need the width and height defined. but iframe does._

[read more...](http://tympanus.net/codrops/2014/08/19/making-svgs-responsive-with-css/)

SVG Sprite:
-----
```
<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
  <symbol id="beaker" viewBox="0 0 182.6 792">
    <title>...</title>
    <desc>...</desc>
    ...
  </symbol>

  <symbol id="icon" viewBox="0 0 182.6 792">
    <title>...</title>
    <desc>...</desc>
    ...
  </symbol>
</svg>
```
Reference via:
```
<svg class="icon">
  <use xlink:href="#shape-icon-1" />
</svg>
```
_don't need to wrap `<symbol>` in `<defs>`_
_the `display: none;` is necessary because while the svg defined in `<symbol>` won't render on page, it still occupies space._

Fallbacks:
-----
Mainly via js. Could use `<picture>` but poor browswer support at the moment. [read more...](http://sarasoueidan.com/blog/svg-picture/)

#### hover/clicking issue:
```
fill: none; || fill: transparent;
pointer-events: visible;
```
