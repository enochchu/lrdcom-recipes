<#assign aui = taglibLiferayHash["/WEB-INF/tld/aui.tld"] />
<#assign liferay_portlet = taglibLiferayHash["/WEB-INF/tld/liferay-portlet.tld"] />

<#assign assetCategoryLocalServiceUtil = objectUtil("com.liferay.portlet.asset.service.AssetCategoryLocalServiceUtil") />
<#assign assetVocabularyLocalServiceUtil = objectUtil("com.liferay.portlet.asset.service.AssetVocabularyLocalServiceUtil") />

<#assign portletURLUtil = objectUtil("com.liferay.portlet.PortletURLUtil") />
<#assign portletURLFactoryUtil = objectUtil("com.liferay.portlet.PortletURLFactoryUtil") />

<#assign allSelectedCategories = objectUtil("com.liferay.portal.kernel.util.UniqueList") />

<#assign portlet_namespace = renderResponse.getNamespace()>

<#assign service_context = objectUtil("com.liferay.portal.service.ServiceContextThreadLocal").getServiceContext() />
<#assign http_servlet_request = service_context.getRequest() />

<@liferay_portlet.renderURL varImpl="searchURL" />

<div class="categories-navigation" id="${portlet_namespace}categoriesNavigation">
	<@aui.form
		action="${searchURL}"
		method="get"
		name="${portlet_namespace}fm"
		useNamespace=false
	>
		<#if entries?has_content>
			<div class="align-center block-container justify-center navigation-inputs">
				<#list entries as curVocabulary>
					<#assign curVocabularyName = stringUtil.replace(curVocabulary.getName(), " ", "_")?lower_case />

					<#assign curVocabularyValue = paramUtil.getString(request, curVocabularyName) />

					<#if !curVocabularyValue?has_content>
						<#assign curVocabularyValue = paramUtil.getString(http_servlet_request, curVocabularyName) />
						<#assign curVocabularyValue = stringUtil.replace(curVocabularyValue, " ", "+") />
					</#if>

					<#assign curVocabularyArray = stringUtil.split(curVocabularyValue, "+") />

					<#assign selectedCategories = objectUtil("com.liferay.portal.kernel.util.UniqueList") />
					<#assign v = selectedCategories.addAll(curVocabularyArray) />
					<#assign v = allSelectedCategories.add(selectedCategories) />

					<@aui.input
						cssClass="hidden-select-field"
						id="${portlet_namespace + curVocabularyName}"
						name=curVocabularyName
						type="hidden"
						value=curVocabularyValue
					/>

					<@aui.select
						cssClass="select-box"
						id="${portlet_namespace + curVocabularyName}_select"
						label=""
						name="${curVocabularyName}_select"

						onChange="${portlet_namespace}filter('${curVocabularyName}', this.value);"
					>
						<@aui.option
							label=curVocabulary.getName()
							value=""
						/>

						<@aui.option
							label="clear-options"
							value="-1"
						/>

						<#assign categories = curVocabulary.getCategories() />

						<#if categories?has_content>
							<#list categories as category>
								<#assign category_css_class = "category-option" />

								<#if selectedCategories.contains(category.getCategoryId()?string)>
									<#assign category_css_class = "${category_css_class} selected" />
								</#if>

								<@aui.option
									cssClass=category_css_class
									label=category.getName()
									value=category.getCategoryId()
								/>
							</#list>
						</#if>
					</@aui.select>
				</#list>

				<@aui.a
					cssClass="navigation-reset"
					href="javascript:;"
					onclick="${portlet_namespace}reset()"
				>
					<svg xmlns="http://www.w3.org/2000/svg" height="18px" viewBox="0 0 18 18" width="18px"><style>.st0{fill:none;stroke:#4C4C4E;stroke-width:1.5;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;}</style><path class="st0" d="M11.7 1.5C14.8 2.6 17 5.5 17 9c0 3.3-2 6.1-4.8 7.3"/><path class="st0" d="M15.8 17.2l-3.6-.9.9-3.6M6.3 16.5C3.2 15.4 1 12.5 1 9c0-3.3 2-6.1 4.8-7.3"/><path class="st0" d="M2.2.8l3.6.9-.9 3.6"/></svg>

				</@aui.a>

				<@aui.input
					cssClass="navigation-search"
					ignoreRequestValue=true
					label=""
					name="searchBox"
				/>
			</div>
		</#if>

		<#if !allSelectedCategories.isEmpty()>
			<div class="align-center block-container justify-center navigation-categories">
				<#list allSelectedCategories as curCategoryIdsList>
					<#if !curCategoryIdsList.isEmpty()>
						<div class="category-container">
							<#assign vocabularyName = "" />

							<#if assetCategoryLocalServiceUtil.fetchAssetCategory(getterUtil.getLong(curCategoryIdsList?first))??>
								<#assign assetCategory = assetCategoryLocalServiceUtil.fetchAssetCategory(getterUtil.getLong(curCategoryIdsList?first)) />
								<#assign assetVocabulary = assetVocabularyLocalServiceUtil.fetchAssetVocabulary(assetCategory.getVocabularyId()) />
							</#if>

							<#if assetVocabulary?? && assetVocabulary?has_content>
								<#assign vocabularyName = stringUtil.replace(assetVocabulary.getName(), " ", "_")?lower_case />

								<span class="asset-vocabulary-title">${htmlUtil.escape(assetVocabulary.getTitle(locale))}</span>
							</#if>

							<#list curCategoryIdsList as curCategoryId>
								<#if assetCategoryLocalServiceUtil.fetchAssetCategory(getterUtil.getLong(curCategoryId))??>
									<#assign curAssetCategory = assetCategoryLocalServiceUtil.fetchAssetCategory(getterUtil.getLong(curCategoryId)) />

									<span class="asset-category-title">
										<#assign filterOnly = renderResponse.getNamespace() + "filter('" + vocabularyName + "', '" + curAssetCategory.getCategoryId() + "', 'only');" />

										<#assign remove = renderResponse.getNamespace() + "filter('" + vocabularyName + "', '" + curAssetCategory.getCategoryId() + "');" />

										<@aui.a
											href="javascript:;"
											onclick=filterOnly
											title="Filter Only"
										>
											${htmlUtil.escape(curAssetCategory.getTitle(locale))}
										</@aui.a>

										<@aui.a
											cssClass="remove"
											href="javascript:;"
											onclick=remove
											title="Remove"
										>
											x
										</@aui.a>
									</span>
								</#if>
							</#list>
						</div>
					</#if>
				</#list>
			</div>
		</#if>
	</@aui.form>
</div>

<@aui.script>
	function processAjaxData(response, urlPath) {
		window.history.pushState(response, '', urlPath);
	}

	window.onpopstate = function(e) {
		if (e.state) {
			${portlet_namespace}refreshPortlets(e.state);
		}
	};

	Liferay.provide(
		window,
		'${portlet_namespace}filter',
		function(param, value, filterType) {
			var A = AUI();

			var inputEl = A.one('#${portlet_namespace}' + param);

			if ((value == '') || (inputEl == null)) {
				return;
			}

			if (value == '-1') {
				inputEl.set('value', '');
			}
			else if ((inputEl.get('value') == '') || (filterType == "only")) {
				inputEl.set('value', value);
			}
			else {
				var values = inputEl.get('value');

				if (values.indexOf(value) != -1) {
					var newValues = values.split('+');

					newValues.splice(newValues.indexOf(value), 1);

					inputEl.set('value', newValues.join());
				}
				else {
					inputEl.set('value', values + '+' + value);
				}
			}

			${portlet_namespace}refreshPortlets();
		},
		['aui-base']
	);

	Liferay.provide(
		window,
		'${portlet_namespace}refreshPortlets',
		function(data) {
			var A = AUI();

			var assetPublisherNamespace = '';
			var assetPublisherPortlet = A.one('.portlet-asset-publisher');

			if (assetPublisherPortlet) {
				var assetPublisherId = Liferay.Util.getPortletId(assetPublisherPortlet.get('id'));
				assetPublisherNamespace = Liferay.Util.getPortletNamespace(assetPublisherId);
			}

			if (!data) {
				var push = true;

				var data = {};
				var url = '${themeDisplay.getURLCurrent()?split("?")[0]}';

				A.all('#${portlet_namespace}fm input[type=hidden]').each(
					function(item, index, collection) {
						var name = item.attr('name');
						var value = item.attr('value');
						var value = value.replace(',', '+');

						data['${portlet_namespace}' + name] = value;

						if ((value != '') && (name != 'formDate')) {
							if (!data[assetPublisherNamespace + 'categoryIds']) {
								data[assetPublisherNamespace + 'categoryIds'] = {};
							}

							var categoryIds = data[assetPublisherNamespace + 'categoryIds'];

							categoryIds[name] = value;

							var connector = '&';

							if (url.indexOf('?') == -1) {
								connector = '?';
							}

							url += connector + name + '=' + value;
						}
					}
				);

				data['url'] = url;
			}

			var refreshURL = '${portletURLUtil.getRefreshURL(request, themeDisplay)}';

			var params = {};

			if (refreshURL.split('?').length > 1) {
				var refreshURLPieces = refreshURL.split('?');

				params = A.QueryString.parse(refreshURLPieces[1]);

				refreshURL = refreshURLPieces[0];
			}

			Liferay.Portlet.addHTML(
				{
					data: A.mix(params, data, true),
					onComplete: function(portlet, portletId) {
						portlet.refreshURL = refreshURL;

						Liferay.fire(
							portlet.portletId + ':portletRefreshed',
							{
								portlet: portlet,
								portletId: portletId
							}
						);
					},
					placeHolder: A.one('#p_p_id${portlet_namespace}'),
					url: refreshURL
				}
			);

			Liferay.Portlet.refresh('#p_p_id' + assetPublisherNamespace, data);

			if (push) {
				processAjaxData(data, data['url']);
			}
		},
		['aui-base', 'querystring']
	);

	Liferay.provide(
		window,
		'${portlet_namespace}reset',
		function() {
			var A = AUI();

			A.all('#${portlet_namespace}fm .hidden-select-field').each(
				function(item) {
					item.set('value', '');
				}
			);

			${portlet_namespace}refreshPortlets();
		},
		['aui-base']
	);
</@aui.script>

<style type="text/css">
	.category-option:hover, .category-option.selected {
		background-color: #1C75B9;
		color: #FFF;
	}
</style>