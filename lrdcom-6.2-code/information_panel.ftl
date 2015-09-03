<div class="block-container no-padding">
	<#list block.siblings as block>
		<#if block.data?has_content>
			<#assign block_attribute = block.data />
		<#else>
			<#assign block_attribute = "" />
		</#if>

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

		<div class="${block_attribute} ${color_class} info-panel panel-section-${block_index + 1} ${block.width.data}" ${background_image_selector}>
			<#if block.article_id.data?has_content && journal_article_local_service.hasArticle(groupId, block.article_id.data)>
				<#assign journal_content_util = staticUtil["com.liferay.portlet.journalcontent.util.JournalContentUtil"] />

				<#assign content_display = journal_content_util.getDisplay(groupId, block.article_id.data, "", locale, xmlRequest) />

				${content_display.getContent()}
			<#else>
				Please input an article id to have the content displayed.
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

	<#if css?? && css.data?has_content>
		${css.data}
	</#if>
</style>