AUI().use(
	'anim',
	function(A) {
		A.on(
			'load',
			function(event) {
				A.all('.animate-scroll').on(
					'click',
					function(event) {
						event.preventDefault();

						var section = A.one(event.currentTarget.get('hash'));
						var scrollTo = section.get('offsetTop');

						new A.Anim(
							{
								duration: 0.5,
								easing: 'easeBoth',
								node: 'win',
								to: {
									scroll: [0, scrollTo]
								}
							}
						).run();
					}
				);
			}
		);
	}
);