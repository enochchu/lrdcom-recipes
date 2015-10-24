<#assign ClassResolverUtil = staticUtil["com.liferay.portal.kernel.util.ClassResolverUtil"]>
<#assign DLFileEntryLocalServiceUtil = staticUtil["com.liferay.portlet.documentlibrary.service.DLFileEntryLocalServiceUtil"]>
<#assign DynamicQueryFactoryUtil = staticUtil["com.liferay.portal.kernel.dao.orm.DynamicQueryFactoryUtil"]>
<#assign OrderFactoryUtil = staticUtil["com.liferay.portal.kernel.dao.orm.OrderFactoryUtil"]>
<#assign PropertyFactoryUtil = staticUtil["com.liferay.portal.kernel.dao.orm.PropertyFactoryUtil"]>
<#assign RestrictionsFactoryUtil = staticUtil["com.liferay.portal.kernel.dao.orm.RestrictionsFactoryUtil"]>
<#assign StorageEngineUtil = staticUtil["com.liferay.portlet.dynamicdatamapping.storage.StorageEngineUtil"]>

<#assign dlFileEntryClass = ClassResolverUtil.resolveByPortalClassLoader("com.liferay.portlet.documentlibrary.model.DLFileEntry") />

<#assign dynamicQuery = DynamicQueryFactoryUtil.forClass(dlFileEntryClass) />

<#assign folderId = getterUtil.getLong(189699) />

<#assign void = dynamicQuery.add(RestrictionsFactoryUtil.eq("folderId", folderId)) />

<#assign order = OrderFactoryUtil.asc("title") />

<#assign void = dynamicQuery.addOrder(order) />

<#assign keyword = "map%" />

<#-- <#assign void = dynamicQuery.add(RestrictionsFactoryUtil.like("title", keyword)) /> -->

<#assign svgs = DLFileEntryLocalServiceUtil.dynamicQuery(dynamicQuery) />

<section>
	<h2>Search your SVG here...</h2>

	<form action="">
		<label>
			<input class="svg-search" role="search" type="text">
		</label>
	</form>
</section>

<section>
	<#list svgs as svg>
		<div class="svg-item">
			<img src='${themeDisplay.getPortalURL() + themeDisplay.getPathContext() + "/documents/" + themeDisplay.getScopeGroupId() + "/" + svg.getFolderId() + "/" + httpUtil.encodeURL(htmlUtil.unescape(svg.getTitle()))}' />

			<span class="title">${svg.getTitle()}</span>
			<span class="description">${svg.getDescription()}</span>

			<#assign fieldsMap = svg.getFieldsMap(svg.getFileVersion().getFileVersionId()) />

			<#list fieldsMap.values() as field>
				<span class="svg-code">${field.get("svg_code").getValue()}</span>
				<span class="svg-type">${field.get("type").getValue()}</span>
			</#list>
		</div>
	</#list>
</section>

<#assign dlFileEntryLocalServiceUtil = objectUtil("com.liferay.portlet.documentlibrary.service.DLFileEntryLocalServiceUtil") />
<#assign orderByComparatorFactoryUtil = staticUtil["com.liferay.portal.kernel.util.OrderByComparatorFactoryUtil"]>

<#assign dlFileEntriesCount = dlFileEntryLocalServiceUtil.getFileEntriesCount(10182, 16960) />
<#assign categoriesOrderBy = orderByComparatorFactoryUtil.create("DLFileEntry", ["name", false])>

<#assign dlFileEntries = dlFileEntryLocalServiceUtil.getFileEntries(10182, 16960, 0, dlFileEntriesCount, categoriesOrderBy) />

<#list dlFileEntries as dlFileEntry>
<div>
${dlFileEntry.getTitle()}
</div>
</#list>