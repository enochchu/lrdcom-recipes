<#assign liferay_ui = taglibLiferayHash["/WEB-INF/tld/liferay-ui.tld"] />

<#assign dl_file_entry_local_service_util = staticUtil["com.liferay.portlet.documentlibrary.service.DLFileEntryLocalServiceUtil"]>
<#assign journal_article_local_service_util = staticUtil["com.liferay.portlet.journal.service.JournalArticleLocalServiceUtil"] />

<style>
	.portlet-asset-publisher .portlet-body {
		display: flex;
	}

	.aui .link-tile a {
		background-size: contain;
	}
</style>

<#list entries as entry>
	<#assign entry = entry />

	<#attempt>
		<#assign dl_file_entry = dl_file_entry_local_service_util.fetchDLFileEntryByUuidAndGroupId(entry.getClassUuid(), entry.getGroupId()) >

		<#assign resource_id = dl_file_entry.getFileEntryId() />
		<#assign folder_id = dl_file_entry.getFolderId() />
	<#recover>
	</#attempt>

	<#attempt>
		<#assign article = journal_article_local_service_util.fetchArticleByUuidAndGroupId(entry.getClassUuid(), entry.getGroupId()) >

		<#assign resource_id = article.getArticleId() />
	<#recover>
	</#attempt>

	<#assign assetRenderer = entry.getAssetRenderer() />

	<#assign entryTitle = htmlUtil.escape(assetRenderer.getTitle(locale)) />

	<#assign viewURL = "/resource"/>

	<#if resource_id??>
		<#assign viewURL = "${viewURL}?resource_id=" + resource_id />
	</#if>

	<div class="link-tile standard-padding w33">
		<a href="${viewURL}" style="background-image:url(${assetRenderer.getURLImagePreview(renderRequest)});">
			<div class="link-tile-content">
				<#if entryTitle?? && entryTitle?has_content>
					<span class="asset-entry-title">${entryTitle}</span>
				</#if>

				<#if assetRenderer.getUrlTitle()?? && assetRenderer.getUrlTitle()?has_content>
					<span class="asset-entry-fact">${assetRenderer.getUrlTitle()}</span>
				</#if>

				<#if assetRenderer.getSummary(locale)?? && assetRenderer.getSummary(locale)?has_content>
					<span class="asset-entry-summary">${assetRenderer.getSummary(locale)}</span>
				</#if>
			</div>
		</a>
	</div>
</#list>

<#macro getMetadataField
	fieldName
>
	<#if stringUtil.split(metadataFields)?seq_contains(fieldName)>
		<span class="metadata-entry metadata-"${fieldName}">
			<#assign dateFormat = "dd MMM yyyy - HH:mm:ss" />

			<#if fieldName == "author">
				<@liferay.language key="by" /> ${portalUtil.getUserName(assetRenderer.getUserId(), assetRenderer.getUserName())}
			<#elseif fieldName == "categories">
				<@liferay_ui["asset-categories-summary"]
					className=entry.getClassName()
					classPK=entry.getClassPK()
					portletURL=renderResponse.createRenderURL()
				/>
			<#elseif fieldName == "create-date">
				${dateUtil.getDate(entry.getCreateDate(), dateFormat, locale)}
			<#elseif fieldName == "expiration-date">
				${dateUtil.getDate(entry.getExpirationDate(), dateFormat, locale)}
			<#elseif fieldName == "modified-date">
				${dateUtil.getDate(entry.getModifiedDate(), dateFormat, locale)}
			<#elseif fieldName == "priority">
				${entry.getPriority()}
			<#elseif fieldName == "publish-date">
				${dateUtil.getDate(entry.getPublishDate(), dateFormat, locale)}
			<#elseif fieldName == "tags">
				<@liferay_ui["asset-tags-summary"]
					className=entry.getClassName()
					classPK=entry.getClassPK()
					portletURL=renderResponse.createRenderURL()
				/>
			<#elseif fieldName == "view-count">
				<@liferay_ui["icon"]
					image="history"
				/>

				${entry.getViewCount()} <@liferay.language key="views" />
			<#else>
				${fieldName}
			</#if>
		</span>
	</#if>
</#macro>

<#if fileEntry??>
	<#assign fieldsMap = fileEntry.getFieldsMap(dlFileVersion.getFileVersionId()) />

	<#list fieldsMap?keys as structureKey>
		<p>File Entry ${fileEntry.getTitle()} has structure with key ${structureKey} with fields:<b>

		<table>
				<tr>
					<th>Name</th>
					<th>Type</th>
				</tr>
			<ul>
				<#list fieldsMap[structureKey].iterator() as field>
					 <tr>
						<td>${field.getName()}</td>
						<td>${field.getType()}</td>
					</tr>
				</#list>
			</ul>
		</table>
	</#list>
</#if>