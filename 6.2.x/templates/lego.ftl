<#if css.getData() != "">
	<style type="text/css">
		${css.getData()}
	</style>
</#if>

<div class="lego-article ${article_class.getData()}" id="article-${.vars['reserved-article-id'].data}">
	<div class="lego-article-content">
		<#list section.getSiblings() as cur_section>
			<section class="block-container lego-section section-${cur_section_index + 1} ${cur_section.section_class.getData()}" ${cur_section.getData()}>
				<#list cur_section.block.getSiblings() as cur_block>
					<div class="block block-${cur_block_index + 1} content-column lego-block w${cur_block.width.getData()} ${cur_block.block_class.getData()}" ${cur_block.getData()}>
						<#list cur_block.element.getSiblings() as cur_element>
							<#assign cur_element_css_class = "lego-element ${cur_element.element_class.getData()}" />

							<#if cur_element.tag.getData() == "image">
								<img class="lego-img ${cur_element_css_class}" ${cur_element.getData()} src="${cur_element.content.getData()}" />
							<#else>
								<#if cur_element.tag.getData() == "">
									<#assign cur_element_tag = "div">
								<#else>
									<#assign cur_element_tag = cur_element.tag.getData()>
								</#if>

								<${cur_element_tag} class="${cur_element_css_class}" ${cur_element.getData()}>
									${cur_element.content.getData()}
								</${cur_element_tag}>
							</#if>
						</#list>
					</div>
				</#list>
			</section>
		</#list>
	</div>
</div>