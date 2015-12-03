<#assign dl_file_entry_local_service_util = staticUtil["com.liferay.portlet.documentlibrary.service.DLFileEntryLocalServiceUtil"]>
<#assign journal_article_local_service_util = staticUtil["com.liferay.portlet.journal.service.JournalArticleLocalServiceUtil"] />
<#assign journal_content_util = staticUtil["com.liferay.portlet.journalcontent.util.JournalContentUtil"] />

<#assign service_context = objectUtil("com.liferay.portal.service.ServiceContextThreadLocal").getServiceContext() />
<#assign http_servlet_request = service_context.getRequest() />

<#assign folder_id = paramUtil.getLong(http_servlet_request, "folder_id") />
<#assign resource_id = paramUtil.getLong(http_servlet_request, "resource_id") />
<#assign title = paramUtil.getString(http_servlet_request, "title") />

<#--
<#assign article_title = "saint-gobain-case-studies" />
<#assign dl_title = "Test+Whitepaper" />
<#assign dl_folder = 13811 />
<#assign article_id = 18119 />
<#assign dl_id = 213730 />
 -->

<div class="resource-display">
	<#attempt>
		<#attempt>
			<#assign article = journal_article_local_service_util.getArticleByUrlTitle(groupId, title) />
			<#assign resource_id = article.getArticleId() />
		<#recover>
		</#attempt>

		${journal_content_util.getContent(groupId, resource_id?string, "", locale, xmlRequest)}
	<#recover>
		<#attempt>
			<#attempt>
				<#assign dl_file_entry = dl_file_entry_local_service_util.fetchFileEntry(groupId, folder_id, title) />
			<#recover>
				<#assign dl_file_entry = dl_file_entry_local_service_util.fetchDLFileEntry(resource_id) />
			</#attempt>

			<#assign dl_file_entry_url = "/documents/" + groupId + "/" + dl_file_entry.getFolderId() + "/" + httpUtil.encodeURL(htmlUtil.unescape(dl_file_entry.getTitle())) />

			<div class="align-center block-container justify-center">
				<img src='${dl_file_entry_url}?previewFileIndex=1' style="max-width:200px;" />

				<span class="title">${dl_file_entry.getTitle()}</span>
				<span class="description">${dl_file_entry.getDescription()}</span>
				<a class="btn" href="${dl_file_entry_url}">Download</a>
			</div>
		<#recover>
			Thank you for playing. Unfortunately you have chosen poorly and this marks then end of your "Choose Your Own Adventure" journey.
		</#attempt>
	</#attempt>
</div>