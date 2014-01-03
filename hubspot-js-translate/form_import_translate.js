<style>
.loading {
	text-align: center;
}

.hbspt-form {
	display: none;
}
</style>
<div class="loading">
	<img src="https://www.liferay.com/osb-community-theme/images/progress_bar/loading_animation.gif" />
</div>
<div class="hubspot-form">
	<script charset="utf-8" src="//js.hsforms.net/forms/current.js"></script><script>
		hbspt.forms.create({
			portalId: '252686',
			submitButtonClass: 'btn',
			formId: '8d118a95-da54-452a-96a7-a6b8b9ff5d85'
		});
	</script>
</div>
<script>
	AUI().ready(
		function(A) {
			var count = 0;
			var limit = 5000;

			var toggleHubspotForm = function() {
				var hubspotForm = A.one('.hbspt-form');
				var loading = A.one('.loading');

				if (count < limit) {
					if (hubspotForm) {
						loading.toggle();

						hubspotForm.setStyle('display','block');

						return true;
					} else {
						count ++;
						return toggleHubspotForm();
					}
				} else {
					var error = 'Whoops! Something failed to load. Please try reloading the page or contact <a href="mailto:marketing-us@liferay.com">marketing-us@liferay.com.</div>';
					var hubspotformcontainer = A.one('.hubspot-form');

					loading.toggle();
					hubspotformcontainer.append(error);
					hubspotformcontainer.setStyle('display','block');

					return false;
				}
			}

			toggleHubspotForm();

			A.on(
				'load',
				function() {
					var isChinese = A.one('html').hasClass('zh_CN');
					var form = A.one('.hbspt-form');

					var firstName = form.one('.hs_firstname').one('label');
					var lastName = form.one('.hs_lastname').one('label');
					var email = form.one('.hs_email').one('label');
					var company = form.one('.hs_company').one('label');
					var country = form.one('.hs_lead_country__c').one('label');
					var job = form.one('.hs_job_role__c').one('label');
					var news = form.one('.hs_news_offerings');
					var product = form.one('.hs_product_bulletins');
					var pulse = form.one('.hs_pulse_newsletter');
					var events = form.one('.hs_upcoming_events');
					var training = form.one('.hs_upcoming_training');
					var submit = form.one('.hs_submit').one('input');

					if (isChinese) {
						firstName.setContent('名');
						lastName.setContent('姓');
						email.setContent('邮箱');
						company.setContent('公司名称');
						country.setContent('国家');
						job.setContent('职位');
						news.one('label').setContent('新闻&服务');
						news.one('.hs-field-desc').setContent('Liferay会定期地发布Liferay服务、通告和更新等新闻信息。');
						product.one('label').setContent('产品快报');
						product.one('.hs-field-desc').setContent('Liferay会定期地发布Liferay特色产品的更新与通告。');
						pulse.one('label').setContent('推介新闻');
						pulse.one('.hs-field-desc').setContent('推介新闻，每月会以摘要形式发布社区以及公司的亮点。Liferay社区推介每月发布一次。');
						events.one('label').setContent('近期活动');
						events.one('.hs-field-desc').setContent('活动新闻包括，Liferay最近参与的活动、包括社区活动、巡回推介、座谈会、培训和在线活动。活动新闻每月发布一次。');
						training.one('label').setContent('近期培训');
						training.one('.hs-field-desc').setContent('培训新闻，包括Liferay近期提供的培训项目。培训新闻每年发布6次。');
						submit.set('value', '提交');
					}
				}
			);
		}
	);
</script>