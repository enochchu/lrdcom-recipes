<#assign aui = taglibLiferayHash["/WEB-INF/tld/aui.tld"] />
<#assign liferay_portlet = taglibLiferayHash["/WEB-INF/tld/liferay-portlet.tld"] />
<#assign liferay_ui = taglibLiferayHash["/WEB-INF/tld/liferay-ui.tld"] />

<#assign asset_category_local_service = serviceLocator.findService("com.liferay.portlet.asset.service.AssetCategoryLocalService")>
<#assign asset_entry_local_service = serviceLocator.findService("com.liferay.portlet.asset.service.AssetEntryLocalService")>
<#assign blogs_entry_local_service = serviceLocator.findService("com.liferay.portlet.blogs.service.BlogsEntryLocalService")>

<#assign portlet_URL_util = objectUtil("com.liferay.portlet.PortletURLUtil") />

<#assign order_by_comparator_factory_util = staticUtil["com.liferay.portal.kernel.util.OrderByComparatorFactoryUtil"]>

<#assign portlet_namespace = renderResponse.getNamespace()>

<#assign blogs_vocabulary_Id = getterUtil.getLong(166994) />
<#assign asset_category_id = paramUtil.getLong(request, "asset_category_id") />
<#assign asset_entry_id = paramUtil.getLong(request, "asset_entry_id") />

<div id="blogs">
	<div class=" block-container nav-container no-padding">
		<div id="categoriesNav">
			<div class="blogs-menu">
				<h3>
					<@liferay_ui.message key="categories" /><span class="rss-icon"></span>
				</h3>
			</div>

			<ul class="categories-content">
				<#assign categories_order_by = order_by_comparator_factory_util.create("AssetCategory", ["name", false])>
				<#assign asset_categories = asset_category_local_service.getVocabularyRootCategories(blogs_vocabulary_Id, -1, -1, categories_order_by) />

				<#list asset_categories as asset_category>
					<li class="category parent-category">
						<a href="javascript:;" data-category-id="${asset_category.getCategoryId()}" onclick="${portlet_namespace}getBlogEntries('${asset_category.getCategoryId()}');">
							<h4>${asset_category.getName()}</h4>
						</a>

						<ul>
							<#list asset_category_local_service.getChildCategories(asset_category.getCategoryId()) as child_asset_category>
								<li class="category child-category">
									<a href="javascript:;" data-category-id="${child_asset_category.getCategoryId()}" onclick="${portlet_namespace}getBlogEntries('${child_asset_category.getCategoryId()}');">${child_asset_category.getName()}</a>
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
					<#assign asset_entries = asset_entry_local_service.getAssetCategoryAssetEntries(asset_category_id) />

					<#list asset_entries as asset_entry>
						<#assign blogsEntry = blogs_entry_local_service.getBlogsEntryByUuidAndGroupId(asset_entry.getClassUuid(), asset_entry.getGroupId()) />

						<li class="blogs-list-item">
							<a href="javascript:;" onclick="${portlet_namespace}getBlogEntryContent('${asset_entry.getEntryId()}', '${asset_category_id}')">
								<h4 class="blog-title">${htmlUtil.escape(asset_entry.getTitle())}</h4>
								<span class="blog-author">${htmlUtil.escape(asset_entry.getUserName())}</span>
								<time class="blog-date">${dateUtil.getDate(asset_entry.getPublishDate(), "MMM dd", locale)}</time>
							</a>
						</li>
					</#list>
				</ul>
			</div>
		</div>
	</div>

	<div id="blogsDisplay">
		<#if asset_entry_id != 0>
			<#assign asset_entry = asset_entry_local_service.getEntry(asset_entry_id) />
			<#assign blogs_entry = blogs_entry_local_service.getBlogsEntryByUuidAndGroupId(asset_entry.getClassUuid(), asset_entry.getGroupId()) />

			<div class="blog-entry" >
				<img src="${blogs_entry.getSmallImageURL()}">
				<h2 class="blog-title">${htmlUtil.escape(blogs_entry.getTitle())}</h2>
				<span class="blog-author">${htmlUtil.escape(blogs_entry.getUserName())}</span>
				<time class="blog-date">${dateUtil.getDate(blogs_entry.getCreateDate(), "MMM dd", locale)}</time>
				<div class="blog-content">${blogs_entry.getContent()}</div>

				</form>
					<@get_discussion />

			</div>
		<#else>
			<#assign asset_entries = asset_entry_local_service.getAssetCategoryAssetEntries(asset_category_id, 0, 5) />

			<#list asset_entries as asset_entry>
				<#assign blogs_entry = blogs_entry_local_service.getBlogsEntryByUuidAndGroupId(asset_entry.getClassUuid(), asset_entry.getGroupId()) />
				<#assign summary = blogs_entry.getDescription() />

				<#if (validator.isNull(summary))>
					<#assign summary = blogs_entry.getContent() />
				</#if>

				<a class="blog-preview standard-padding" href="javascript:;" onclick="${portlet_namespace}getBlogEntryContent('${asset_entry.getEntryId()}', '${asset_category_id}')">
					<img src="${blogs_entry.getSmallImageURL()}">
					<h2 class="blog-title">${htmlUtil.escape(blogs_entry.getTitle())}</h2>
					<span class="blog-author">${htmlUtil.escape(blogs_entry.getUserName())}</span>
					<time class="blog-date">${dateUtil.getDate(blogs_entry.getCreateDate(), "MMM dd", locale)}</time>
					<div class="blog-summary">${stringUtil.shorten(htmlUtil.stripHtml(summary), 100)}</div>
				</a>

				<div class="separator"><!-- --></div>
			</#list>
		</#if>
	</div>
</div>

<#macro get_discussion>
	<#assign discussion_URL = renderResponse.createActionURL() />
	<#assign asset_renderer = asset_entry.getAssetRenderer() />

	<#if validator.isNotNull(asset_renderer.getDiscussionPath()) && (enableComments == "true")>
		<#assign void = discussion_URL.setParameter("struts_action", "/blogs/" + asset_renderer.getDiscussionPath()) />

		<div class="blogs-comments">
			<@liferay_ui["discussion"]
				className=asset_entry.getClassName()
				classPK=asset_entry.getClassPK()
				formAction=discussion_URL?string
				formName="fm2"
				ratingsEnabled=false
				redirect=themeDisplay.getURLCurrent()
				userId=asset_entry.getUserId()
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
		function(asset_category_id) {
			var data = {${portlet_namespace}asset_category_id: asset_category_id};

			${portlet_namespace}refreshPortlets(data);
		},
		['aui-base']
	);

	Liferay.provide(
		window,
		'${portlet_namespace}getBlogEntryContent',
		function(asset_entry_id, asset_category_id) {
			var data = {
				${portlet_namespace}asset_category_id: asset_category_id,
				${portlet_namespace}asset_entry_id: asset_entry_id
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

			var refreshURL = '${portlet_URL_util.getRefreshURL(request, themeDisplay)}';

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