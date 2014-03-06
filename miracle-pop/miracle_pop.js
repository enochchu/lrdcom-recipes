<style type="text/css">
#closePopUp {
	background: url(/documents/32293462/32314376/close-pop-up.png/98401a14-9fcf-4f9a-8f1d-4fdcb7ff0207) no-repeat;
	cursor: pointer;
	float: right;
	height: 60px;
	width: 60px;
}

#pagePopUp {
	background: rgba(255,255,255,.95);
	border: 1px solid #CCC;
	position: absolute;
	width: 95%;
	z-index: 2000;
}

#pagePopUp .pop-up-content {
	padding: 50px 35px 30px;
}

#pagePopUp .pop-up-content .speaker-company, #pagePopUp .pop-up-content .speaker-name, #pagePopUp .pop-up-content .speaker-title {
	display: block;
}

#pagePopUp .speaker-company {
	font-style: italic;
}

#pagePopUp .speaker-name {
	color: #3AA0D5;
	font-size: 1.2em;
	margin: 5px 0;
}

#pagePopUp .speaker-title, #pagePopUp .speaker-company {
	font-weight: bold;
}

.ie7 #pagePopUp, .ie8 #pagePopUp {
	background: #FFF;
}

.ie8 #heading .company-title .logo {
	background-color: #F5FAFD;
}

.ie8.show-nav #navigation {
	background: #F5FAFD;
}

@media all and (min-width: 720px) {
	#pagePopUp {
		width: 440px;
	}

	#pagePopUp:after, #pagePopUp:before {
		border: 30px solid transparent;
		content: "";
		display: block;
		margin: -30px;
		position: absolute;
	}

	#pagePopUp.bottom:after {
		border-top-color: #FFF;
		bottom: -29px;
		right: 50%;
	}

	#pagePopUp.bottom:before {
		border-top-color: #CCC;
		bottom: -30px;
		right: 50%;
	}

	#pagePopUp.left:after {
		border-left-color: #FFF;
		right: -29px;
		top: 50%;
	}

	#pagePopUp.left:before {
		border-left-color: #CCC;
		right: -30px;
		top: 50%;
	}

	#pagePopUp.right:after {
		border-right-color: #FFF;
		left: -29px;
		top: 50%;
	}

	#pagePopUp.right:before {
		border-right-color: #CCC;
		left: -30px;
		top: 50%;
	}

	#pagePopUp.top:after {
		border-bottom-color: #FFF;
		right: 50%;
		top: -29px;
	}

	#pagePopUp.top:before {
		border-bottom-color: #CCC;
		right: 50%;
		top: -30px;
	}
}
</style>

<script>
AUI().ready(
	'aui-overlay-mask',
	'node',
	function(A) {
		var WIN = A.getWin();

		var pagePopUp = A.one('#pagePopUp');

		if (!pagePopUp) {
			A.one('#wrapper').append('<div class="aui-helper-hidden" id="pagePopUp" data-pop-up-position="target" data-pop-up-direction="top"><div id="closePopUp"></div></div>')

			pagePopUp = A.one('#pagePopUp');
		};

		var centerOnPage = function(node) {
			var currentScrollPos = WIN.get('docScrollY');

			var winHeight = WIN.get('innerHeight');

			if (winHeight == undefined) {
				winHeight = document.documentElement.clientHeight;
			}

			var contentWidth = A.one('#content').get('clientWidth');

			var nodeHeight = node.get('clientHeight');
			var nodeWidth = node.get('clientWidth');

			xCenter = (contentWidth / 2) - (nodeWidth / 2);
			yCenter = ((winHeight / 2) - (nodeHeight / 2)) + currentScrollPos;

			node.setStyle('left', 'auto');
			node.setStyle('right', xCenter);
			node.setStyle('top', yCenter);

			if (node.getAttribute('data-overlay')) {
				createOverlayMask();
			}
		};

		var centerOnTarget = function(node) {
			var targetNode = A.one('#' + node.getAttribute('data-target-node-id'));

			if (!targetNode) {
				return
			}

			var targetNodeCenterX = targetNode.getX() + (targetNode.get('clientWidth') / 2);
			var targetNodeCenterY = targetNode.getY() + (targetNode.get('clientHeight') / 2);

			var nodeHeight = node.get('clientHeight');
			var nodeWidth = node.get('clientWidth');

			var nodeCenterX = (nodeWidth / 2);
			var nodeCenterY = (nodeHeight / 2);

			var nodeClass = 'middle';

			var nodeLeft = targetNodeCenterX - nodeCenterX;
			var nodeTop = targetNodeCenterY - nodeCenterY;

			var popUpDirection = node.getAttribute('data-pop-up-direction');

			if (targetNode.getAttribute('data-pop-up-direction')) {
				popUpDirection = targetNode.getAttribute('data-pop-up-direction');
			}

			var popUpOffset = parseInt(node.getAttribute('data-pop-up-offset'));

			if (!popUpOffset) {
				popUpOffset = 30;
			}

			if (popUpDirection == 'bottom') {
				nodeClass = 'bottom';
				nodeTop = targetNodeCenterY - nodeHeight - popUpOffset;
			} else if (popUpDirection == 'left') {
				nodeClass = 'left';
				nodeLeft = targetNodeCenterX - nodeWidth - popUpOffset;
			} else if (popUpDirection == 'right') {
				nodeClass = 'right';
				nodeLeft = targetNodeCenterX + popUpOffset;
			} else if (popUpDirection == 'top') {
				nodeClass = 'top';
				nodeTop = targetNodeCenterY + popUpOffset;
			}

			if (nodeLeft < 0) {
				nodeClass += ' repositioned';

				nodeLeft = 2;
			}

			if (nodeLeft + nodeWidth > WIN.get('innerWidth')) {
				nodeClass += ' repositioned';

				nodeLeft =  WIN.get('innerWidth') - nodeWidth - 18;
			}

			if (nodeTop < 0) {
				nodeClass += ' repositioned';

				nodeTop = 2;
			}

			node.removeClass('bottom');
			node.removeClass('left');
			node.removeClass('middle');
			node.removeClass('repositioned');
			node.removeClass('right');
			node.removeClass('top');

			node.addClass(nodeClass);
			node.setStyle('left', nodeLeft);
			node.setStyle('top', nodeTop);
		};

		var copyToPopUp = function(node) {
			var newPopUpContent = node.one('.pop-up-content');

			var oldPopUpContent = pagePopUp.one('.pop-up-content');

			if (!newPopUpContent) {
				return
			}

			if (oldPopUpContent) {
				oldPopUpContent.remove();
			}

			pagePopUp.append(newPopUpContent.cloneNode(true));
			pagePopUp.removeClass('aui-helper-hidden');

			pagePopUp.setAttribute('data-target-node-id', node.generateID());

			positionPopUp(pagePopUp);

			var popUpContent = pagePopUp.one('.pop-up-content')

			popUpContent.on(
				'clickoutside',
				function(event) {
					var overlayMask = A.one('.aui-overlaymask');

					if (overlayMask) {
						overlayMask.remove();
					}

					pagePopUp.addClass('aui-helper-hidden');

					popUpContent.detach('clickoutside');
					popUpContent.remove();
				}
			);
		};

		var createOverlayMask = function() {
			var bindUI = function() {
				var overlayMask = A.one('.aui-overlaymask');

				if (overlayMask) {
					overlayMask.on(
						'click',
						function() {
							overlayMask.remove(true);
						}
					);
				}
			}

			var init = function() {
				if (A.one('.aui-overlaymask')) {
					return
				}

				var overlay = new A.OverlayMask().render();

				overlay.set('z-index', 20);
				overlay.show();

				bindUI();
			}

			return init();
		}

		var positionPopUp = function(node) {
			if (node.hasClass('aui-helper-hidden')) {
				return
			}

			var popUpCentered = true;

			if ((node.getAttribute('data-pop-up-position') == "target") && (WIN.get('innerWidth') > 720)) {
				popUpCentered = false;
			}

			if (popUpCentered) {
				centerOnPage(node);
			} else {
				centerOnTarget(node);
			}
		};

		A.on(
			'load',
			function() {
				var url = document.URL;

				var popUpId = url.substring(url.indexOf('popUp'));

				var popUp = A.one('#' + popUpId);

				if (popUp) {
					copyToPopUp(popUp);
				}
			}
		);

		var iOS = /iPad/i.test(navigator.userAgent) || /iPhone/i.test(navigator.userAgent);
		var mouseEvent = 'click';

		if (iOS) {
			mouseEvent = 'mousemove';
		}

		A.all('.pop-up').on(
			mouseEvent,
			function(event) {
				event.stopPropagation();

				copyToPopUp(event.currentTarget);
			}
		);

		A.on(
			'resize',
			function() {
				positionPopUp(pagePopUp);
			}
		);
	}
);
</script>