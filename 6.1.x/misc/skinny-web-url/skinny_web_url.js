<script>
var searchUrl = "http://www.liferay.com/skinny-web/api/jsonws/skinny/get-skinny-journal-articles?inst=welcomeContent&companyId=1&groupName=Guest&journalStructureId=27308142&locale=en_US%22";
var head = document.getElementsByTagName('head')[0];
var script = document.createElement('script');
script.type = 'text/javascript';
script.src = searchUrl;
head.appendChild(script);

var A = AUI();
A.on(
	'load',
	function(event) {
		var content = welcomeContent[0].dynamicElements.content;
		var myNode = A.one("#myNode");

		myNode.setContent(content);
	}
);
</script>

<div id="myNode">initial content</div>