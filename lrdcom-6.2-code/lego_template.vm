#if ($css.getData() != "")
	<style type="text/css">
		${css.getData()}
	</style>
#end

<div class="lego-article ${article_class.getData()}" id="article-${reserved-article-id.getData()}">
	<div class="lego-article-content">
		#foreach ($cur_section in $section.siblings)
			<section class="clearfix lego-section section-${velocityCount} ${cur_section.section_class.getData()}" ${cur_section.getData()}>
				#foreach ($cur_block in $cur_section.block.siblings)
					<div class="block-${velocityCount} lego-block span${cur_block.width.getData()} ${cur_block.block_class.getData()}" ${cur_block.getData()}>
						#foreach ($cur_element in $cur_block.element.siblings)
							#set ($cur_element_css_class = "lego-element ${cur_element.element_class.getData()}")

							#if ($cur_element.tag.getData() == "image")
								<img class="lego-img ${cur_element_css_class}" ${cur_element.getData()} src="${cur_element.content.getData()}" />
							#else
								#if ($cur_element.tag.getData() == "")
									#set ($cur_element_tag = "div")
								#else
									#set ($cur_element_tag = $cur_element.tag.getData())
								#end

								<${cur_element_tag} class="${cur_element_css_class}" ${cur_element.getData()}>
									${cur_element.content.getData()}
								</${cur_element_tag}>
							#end
						#end
					</div>
				#end
			</section>
		#end
	</div>
</div>