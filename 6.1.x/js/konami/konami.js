AUI().ready(
	function (A) {
		var onScreens = A.all('.on-screen-helper');
		var keys = [];
		var konami  = '38,38,40,40,37,39,37,39,66,65';

		var keystrokeListen = A.on (
			'keydown',
			function (e) {
				keys.push(e.keyCode);
				if (keys.toString().indexOf( konami ) >= 0 ){
					//do your action here
					console.log('konami');

					//this clears the recorded keys so it can listen again for the code
					keys = [];

					//uncomment this if you want the event listener to be detached after one use
					//keystrokeListen.detach();
				}
			}
		);
		keystrokeListen;
	}
);