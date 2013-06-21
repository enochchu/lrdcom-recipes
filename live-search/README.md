[Example that you can taste!](http://htmlpreview.github.io/?https://raw.github.com/enochchu/lrdcom-recipes/master/live-search/livesearch.html)

```javascript
 AUI().use(
  'aui-live-search',
	function(A) {
		var search = new A.LiveSearch({
			//The specified search box node
			input: '#some-search-box',
			//The specified node will be used to toggle aui-hidden-helper 
			nodes: '#search-this-list li'
		});
	}
);
 ```
*As of June 21, 2013, The aui-live-search module is only for 1.7 and not at AUI 2.0*


For more information, check out the amazing documentation at the [aui-live-search](http://alloyui.com/versions/1.7.x/api/modules/aui-live-search.html) in in AlloyUI.com API Docs.
