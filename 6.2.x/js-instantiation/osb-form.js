<script>
AUI().ready(
	'osb-form',
	function(A) {
		new A.OSBForm(
			{
				customRules: {
					testRuleName: function(val, node, ruleValue) {
						return (val.length <= ruleValue);
					}
				},
				fieldStrings: {
					name: {
						required: Liferay.Language.get('this-field-is-required')
					}
				},
				rules: {
					email: {
						testRuleName: 5
					},
					name: {
						required: true
					},
					state: {
						conditional: {
							fieldname: "country",
							values: ['united-states', 'canada']
						},
						custom: true
					}
				}
			}
		).render();
	}
);
</script>