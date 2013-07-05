AUI().use(
	'aui-base',
	function(A) {
		var WIN = A.getWin();

		var onScreenHelperNode = A.all('.on-screen-helper');

		var updateOnScreen = function() {
			var currentScrollPos = WIN.get('docScrollY');

			var winHeight = WIN.get('innerHeight');

			if (winHeight == undefined) {
				winHeight = document.documentElement.­clientHeight;
			}

			onScreenHelperNode.each(
				function(item, index, collection) {
					var topEdge = item.getY();

					var bottomEdge = topEdge + item.get('clientHeight');

					var screenBottom = topEdge - winHeight;

					if ((currentScrollPos > topEdge) && (currentScrollPos <= bottomEdge)) {
						item.addClass('on-screen-top');
					}
					else {
						item.removeClass('on-screen-top');
					}

					if ((currentScrollPos > screenBottom) && (currentScrollPos <= bottomEdge)) {
						item.addClass('on-screen-bottom');
					}
					else {
						item.removeClass('on-screen-bottom');
					}
				}
			);
		};

		if (!onScreenHelperNode.isEmpty()) {
			A.on('scroll', updateOnScreen);
			A.on('resize', updateOnScreen);

			updateOnScreen();
		}
	}
);