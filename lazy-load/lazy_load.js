AUI().use(
	'aui-base',
	function(A) {
		var WIN = A.getWin();

		var lazyLoadNode = A.all('.lazy-load');

		var lazyLoad = function() {
			var currentScrollPos = WIN.get('docScrollY');

			var winHeight = WIN.get('innerHeight');

			if (winHeight == undefined) {
				winHeight = document.documentElement.­clientHeight;
			}

			lazyLoadNode.each(
				function(item, index, collection) {
					if (!item.hasClass('lazy-loaded')) {
						var loadPos = item.getY() - winHeight;

						if (currentScrollPos > loadPos) {
							var datasrc = item.attr('datasrc');
							var src = item.attr('src');

							if (src != datasrc) {
								item.attr('src', datasrc);
							}

							item.addClass('lazy-loaded');
						}
					}
				}
			);
		};

		if (!lazyLoadNode.isEmpty()) {
			A.on('scroll', lazyLoad);
			A.on('resize', lazyLoad);

			lazyLoad();
		}
	}
);