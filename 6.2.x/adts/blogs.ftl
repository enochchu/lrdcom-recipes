<#assign aui = taglibLiferayHash["/WEB-INF/tld/aui.tld"] />
<#assign liferay_portlet = taglibLiferayHash["/WEB-INF/tld/liferay-portlet.tld"] />
<#assign liferay_ui = taglibLiferayHash["/WEB-INF/tld/liferay-ui.tld"] />

<#assign assetCategoryLocalService = serviceLocator.findService("com.liferay.portlet.asset.service.AssetCategoryLocalService")>
<#assign assetEntryLocalService = serviceLocator.findService("com.liferay.portlet.asset.service.AssetEntryLocalService")>
<#assign blogsEntryLocalService = serviceLocator.findService("com.liferay.portlet.blogs.service.BlogsEntryLocalService")>

<#assign portletURLUtil = objectUtil("com.liferay.portlet.PortletURLUtil") />
<#assign portletURLFactoryUtil = objectUtil("com.liferay.portlet.PortletURLFactoryUtil") />

<#assign orderByComparatorFactoryUtil = staticUtil["com.liferay.portal.kernel.util.OrderByComparatorFactoryUtil"]>

<#assign portlet_namespace = renderResponse.getNamespace()>

<#assign blogsVocabularyId = getterUtil.getLong(166994) />
<#assign assetCategoryId = paramUtil.getLong(request, "asset_category_id") />
<#assign assetEntryId = paramUtil.getLong(request, "asset_entry_id") />

<div id="blogs">
	<div class=" block-container nav-container no-padding">
		<div id="categoriesNav">
			<div class="blogs-menu">
				<h3>
					<@liferay_ui.message key="categories" /><span class="rss-icon"></span>
				</h3>
			</div>

			<ul class="categories-content">
				<#assign categoriesOrderBy = orderByComparatorFactoryUtil.create("AssetCategory", ["name", false])>
				<#assign assetCategories = assetCategoryLocalService.getVocabularyRootCategories(blogsVocabularyId, -1, -1, categoriesOrderBy) />

				<#list assetCategories as assetCategory>
					<li class="category parent-category">
						<a href="javascript:;" data-category-id="${assetCategory.getCategoryId()}" onclick="${portlet_namespace}getBlogEntries('${assetCategory.getCategoryId()}');">
							<h4>${assetCategory.getName()}</h4>
						</a>

						<ul>
							<#list assetCategoryLocalService.getChildCategories(assetCategory.getCategoryId()) as childAssetCategory>
								<li class="category child-category">
									<a href="javascript:;" data-category-id="${childAssetCategory.getCategoryId()}" onclick="${portlet_namespace}getBlogEntries('${childAssetCategory.getCategoryId()}');">${childAssetCategory.getName()}</a>
								</li>
							</#list>
						</ul>
					</li>
				</#list>
			</ul>

			<div class="social-nav">
				<span class="facebook social-img"><@liferay_ui.message key="facebook" /></span>
				<span class="linkedin social-img"><@liferay_ui.message key="linkedin" /></span>
				<span class="rss social-img"><@liferay_ui.message key="rss" /></span>
				<span class="social-img twitter"><@liferay_ui.message key="twitter" /></span>
				<span class="social-img youtube"><@liferay_ui.message key="youtube" /></span>
			</div>
		</div>

		<div id="blogsList">
			<div class="block-container blogs-menu justify-center">
				<a href="javascript:;" class="class-toggle" data-target-class="show-blogs-nav" data-target-nodes="#wrapper"><span>Toggle</span></a>

				<a href="javascript:;" data-target-nodes="#blogsList"><@liferay_ui.message key="highlighted" /></a>

				<a href="javascript:;" data-target-nodes="#blogsList"><@liferay_ui.message key="latest" /></a>
			</div>

			<div class="blogs-list-container">
				<ul class="blogs-list-content">
					<#assign assetEntries = assetEntryLocalService.getAssetCategoryAssetEntries(assetCategoryId) />

					<#list assetEntries as assetEntry>
						<#assign blogsEntry = blogsEntryLocalService.getBlogsEntryByUuidAndGroupId(assetEntry.getClassUuid(), assetEntry.getGroupId()) />

						<li class="blogs-list-item">
							<a href="javascript:;" onclick="${portlet_namespace}getBlogEntryContent('${assetEntry.getEntryId()}', '${assetCategoryId}')">
								<h4 class="blog-title">${htmlUtil.escape(assetEntry.getTitle())}</h4>
								<span class="blog-author">${htmlUtil.escape(assetEntry.getUserName())}</span>
								<time class="blog-date">${dateUtil.getDate(assetEntry.getPublishDate(), "MMM dd", locale)}</time>
							</a>
						</li>
					</#list>
				</ul>
			</div>
		</div>
	</div>

	<div id="blogsDisplay">
		<#if assetEntryId != 0>
			<#assign assetEntry = assetEntryLocalService.getEntry(assetEntryId) />
			<#assign blogsEntry = blogsEntryLocalService.getBlogsEntryByUuidAndGroupId(assetEntry.getClassUuid(), assetEntry.getGroupId()) />

			<div class="blog-entry" >
				<img src="${blogsEntry.getSmallImageURL()}">
				<h2 class="blog-title">${htmlUtil.escape(blogsEntry.getTitle())}</h2>
				<span class="blog-author">${htmlUtil.escape(blogsEntry.getUserName())}</span>
				<time class="blog-date">${dateUtil.getDate(blogsEntry.getCreateDate(), "MMM dd", locale)}</time>
				<div class="blog-content">${blogsEntry.getContent()}</div>

				</form>
					<@getDiscussion />

			</div>
		<#else>
			<#assign assetEntries = assetEntryLocalService.getAssetCategoryAssetEntries(assetCategoryId, 0, 5) />

			<#list assetEntries as assetEntry>
				<#assign blogsEntry = blogsEntryLocalService.getBlogsEntryByUuidAndGroupId(assetEntry.getClassUuid(), assetEntry.getGroupId()) />
				<#assign summary = blogsEntry.getDescription() />

				<#if (validator.isNull(summary))>
					<#assign summary = blogsEntry.getContent() />
				</#if>

				<a class="blog-preview standard-padding" href="javascript:;" onclick="${portlet_namespace}getBlogEntryContent('${assetEntry.getEntryId()}', '${assetCategoryId}')">
					<img src="${blogsEntry.getSmallImageURL()}">
					<h2 class="blog-title">${htmlUtil.escape(blogsEntry.getTitle())}</h2>
					<span class="blog-author">${htmlUtil.escape(blogsEntry.getUserName())}</span>
					<time class="blog-date">${dateUtil.getDate(blogsEntry.getCreateDate(), "MMM dd", locale)}</time>
					<div class="blog-summary">${stringUtil.shorten(htmlUtil.stripHtml(summary), 100)}</div>
				</a>

				<div class="separator"><!-- --></div>
			</#list>
		</#if>
	</div>
</div>

<#macro getDiscussion>
	<#assign discussionURL = renderResponse.createActionURL() />
	<#assign assetRenderer = assetEntry.getAssetRenderer() />

	<#if validator.isNotNull(assetRenderer.getDiscussionPath()) && (enableComments == "true")>
		<#assign void = discussionURL.setParameter("struts_action", "/blogs/" + assetRenderer.getDiscussionPath()) />

		<div class="blogs-comments">
			<@liferay_ui["discussion"]
				className=assetEntry.getClassName()
				classPK=assetEntry.getClassPK()
				formAction=discussionURL?string
				formName="fm2"
				ratingsEnabled=false
				redirect=themeDisplay.getURLCurrent()
				userId=assetEntry.getUserId()
			/>
		</div>
	</#if>
</#macro>

<style>
	h1 {
		font-size: 2em;
		margin: 0;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}

	#blogs h4 {
		font-size: 1.3em;
		font-weight: 500;
	}

	#blogs ul {
		margin: 0;
	}

	#blogs #blogsDisplay, #blogs #blogsList {
		min-height: 500px;
	}

	#blogs #blogsDisplay .blog-preview {
		text-decoration: none;
	}

	#blogs #blogsList {
		width: 300px;
	}

	#blogsDisplay {
		box-sizing: border-box;
		margin: 0 auto;
		max-width: 720px
		overflow: hidden;
	}

	#blogs #blogsList .blogs-menu {
		border-bottom: 1px solid #E3E4E5;
	}

	#blogs #blogsList .blogs-menu a {
		padding: 0 10px;
	}

	#blogs #blogsList .blogs-list-item a {
		border-bottom: 1px solid #E3E4E5;
		box-sizing: border-box;
		display: block;
		padding: 1em;
	}

	#blogs #blogsList .blogs-list-item:hover {
		background-color: #F5A11D;
	}

	#blogs #blogsList .blogs-list-item:hover .blog-author,
	#blogs #blogsList .blogs-list-item:hover .blog-date,
	#blogs #blogsList .blogs-list-item:hover .blog-title {
		color: #FFF;
	}

	#blogs #categoriesNav {
		background-color: #4C4C4E;
		box-sizing: border-box;
		color: #FFF;
		height: 100%;
		overflow-y: auto;
		width: 200px;
	}

	#blogs #categoriesNav a {
		color: #FFF;
		display: block;
		padding: .5em 1em;
	}

	#blogs #categoriesNav .child-category:hover {
		background-color: #1C75B9;
	}

	#blogs #categoriesNav .categories-content {
		bottom: 100px;
	}

	#blogs .blog-author {
		font-weight: bold;
	}

	#blogs .blog-author, #blogs .blog-date, #blogs .blog-summary {
		color: #909295;
	}

	#blogs .blog-title {
		color: #4C4C4E;
	}

	#blogs .loading {
		opacity: .1;
	}

	#blogs .nav-container {
		background-color: #FFF;
		border-right: 1px solid #E3E4E5;
		bottom: 0px;
		left: -200px;
		position: fixed;
		top: 100px;
		transition: left .5s;
	}

	#blogs .nav-container a {
		text-decoration: none;
	}

	#blogs .nav-container ul {
		list-style: none;
		padding: 0;
	}

	#blogs .nav-container .blogs-menu, #blogs .nav-container .parent-category {
		text-transform: uppercase;
	}

	#blogs .nav-container .blogs-menu {
		padding: .5em 1em;
	}

	.aui #main-content.columns-1, .aui footer.doc-footer {
		margin-left: 300px;
		transition: margin-left .5s;
	}

	.aui .show-blogs-nav #main-content.columns-1, .aui .show-blogs-nav footer.doc-footer {
		margin-left: 500px;
	}

	.rss {
		padding: 5px 0;
	}

	.show-blogs-nav #blogs .nav-container{
		left: 0;
	}
</style>

<@aui.script>
	var A = AUI();

	function processAjaxData(data, url) {
		window.history.pushState(data, '', url);
	}

	window.onpopstate = function(event) {
		if (event.state) {
			${portlet_namespace}refreshPortlets(event.state);
		}
	};

	Liferay.provide(
		window,
		'${portlet_namespace}getBlogEntries',
		function(assetCategoryId) {
			var data = {${portlet_namespace}asset_category_id: assetCategoryId};

			${portlet_namespace}refreshPortlets(data);
		},
		['aui-base']
	);

	Liferay.provide(
		window,
		'${portlet_namespace}getBlogEntryContent',
		function(assetEntryId, assetCategoryId) {
			var data = {
				${portlet_namespace}asset_category_id: assetCategoryId,
				${portlet_namespace}asset_entry_id: assetEntryId
			};

			${portlet_namespace}refreshPortlets(data);
		},
		['aui-base']
	);

	Liferay.provide(
		window,
		'${portlet_namespace}refreshPortlets',
		function(data) {
			if (!data) {
				data = {};
			}

			var params = {};

			var url = '${themeDisplay.getURLCurrent()?split("?")[0]}';

			data['url'] = url;

			var blogsListContainer = A.one('#blogsList .blogs-list-container');
			var blogsDisplay = A.one('#blogsDisplay');

			blogsListContainer.hide();
			blogsDisplay.hide();
			blogsListContainer.placeAfter(A.Node.create('<div class="loading-animation" />'));
			blogsDisplay.placeAfter(A.Node.create('<div class="loading-animation" />'));

<#-- 			blogsListContainer.remove();
			blogsDisplay.remove(); -->

			var refreshURL = '${portletURLUtil.getRefreshURL(request, themeDisplay)}';

			Liferay.Portlet.addHTML(
				{
					data: A.mix({}, data, true),
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

			processAjaxData(data, data['url']);
console.log("data: ", data);
		},
		['aui-base', 'querystring']
	);
</@aui.script>