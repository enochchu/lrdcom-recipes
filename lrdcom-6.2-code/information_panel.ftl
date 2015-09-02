<div class="block-container no-padding">
	<#list block.siblings as block>
		<#if block.background_color.data?has_content>
			<#assign color_class = block.background_color.data />
		<#else>
			<#assign color_class = "" />
		</#if>

		<#if block.background_image.data?has_content>
			<#assign background_image_selector = "style='background-image: url(${block.background_image.data});'" />
		<#else>
			<#assign background_image_selector = "" />
		</#if>

		<#assign journal_article_local_service = serviceLocator.findService("com.liferay.portlet.journal.service.JournalArticleLocalService") />

		<div class="${color_class} info-panel panel-section-${block_index + 1} ${block.width.data}" ${background_image_selector}>
			<#if block.data?has_content && journal_article_local_service.hasArticle(groupId, block.data)>
				<#assign journal_content_util = staticUtil["com.liferay.portlet.journalcontent.util.JournalContentUtil"] />

				<#assign content_display = journal_content_util.getDisplay(groupId, block.data, "", locale, xmlRequest) />

				${content_display.getContent()}
			<#else>
				Please input an article id.
			</#if>
		</div>
	</#list>
</div>

<style type="text/css">
	.aui .info-panel {
		background-position: center;
		background-size: cover;
		min-height: 400px;
	}
</style>