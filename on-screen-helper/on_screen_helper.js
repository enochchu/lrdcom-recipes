AUI().use(
	'aui-base',
	function(A) {
		var WIN = A.getWin();

		var onScreenHelperNode = A.all('.on-screen-helper');

		var updateOnScreen = function() {
			var currentScrollPos = WIN.get('docScrollY');

			var winHeight = WIN.get('innerHeight');

			if (winHeight == undefined) {
				winHeight = document.documentElement.clientHeight;
			}

			onScreenHelperNode.each(
				function(item, index, collection) {
					var dataOffsetBottom = parseInt(item.attr('data-offset-bottom'));
					var dataOffsetTop = parseInt(item.attr('data-offset-top'));
					var dataRepeatBottom = item.attr('data-repeat-bottom');
					var dataRepeatTop = item.attr('data-repeat-top');

					var topEdge = item.getY();

					var topEdgeOffset = topEdge;

					if (dataOffsetTop) {
						topEdgeOffset = topEdgeOffset - dataOffsetTop;
					}

					var bottomEdge = topEdge + item.get('clientHeight');

					var screenBottom = topEdge - winHeight;

					if (dataOffsetBottom) {
						screenBottom = screenBottom + dataOffsetBottom;
					}

					if ((currentScrollPos > topEdgeOffset) && (currentScrollPos <= bottomEdge)) {
						item.addClass('on-screen-top');
					}
					else if (dataRepeatTop == "true") {
						item.removeClass('on-screen-top');
					}

					if ((currentScrollPos > screenBottom) && (currentScrollPos <= bottomEdge)) {
						item.addClass('on-screen-bottom');
					}
					else if (dataRepeatBottom == "true") {
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