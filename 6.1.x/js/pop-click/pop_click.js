AUI().use(
	'aui-base',
	function(A) {
		var popClicks = A.all('.pop-click');

		var popClickHandle;

		var togglePopClick = function(event) {
			event.stopPropagation();

			var targetNode = event.target;

			if (targetNode.hasClass('pop-click-content') || targetNode.ancestor('.pop-click-content')) {
				return;
			}

			var activePopClick = A.one('.pop-click-active');

			if (activePopClick) {
				activePopClick.removeClass('pop-click-active');
			}

			var currentTargetNode = event.currentTarget;

			if (currentTargetNode.hasClass('pop-click') && (currentTargetNode != activePopClick)) {
				currentTargetNode.addClass('pop-click-active');
			}

			activePopClick = A.one('.pop-click-active');

			if (activePopClick && !popClickHandle) {
				popClickHandle = A.getDoc().on('click', togglePopClick);
			}
			else if (popClickHandle && !activePopClick) {
				popClickHandle.detach();

				popClickHandle = null;
			}
		};

		popClicks.on('click', togglePopClick);
	}
);