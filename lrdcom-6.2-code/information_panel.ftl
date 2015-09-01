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

		<#if block.data?has_content>
			<#assign instance_id = "${.vars['reserved-article-id'].data}_embed_${block.data}" />
		<#else>
			<#assign instance_id = "${.vars['reserved-article-id'].data}_null" />
		</#if>

		<div class="${color_class} info-panel panel-section-${block_index + 1} ${block.width.data}" ${background_image_selector}>
			<runtime-portlet name="56" instance="${instance_id}" queryString="" />
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