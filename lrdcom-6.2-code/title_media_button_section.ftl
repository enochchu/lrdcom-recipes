<div class="block-justify-center block-container title-media-button-section">
	<#if title.data?has_content || subtitle.data?has_content>
		<div class="section-heading text-center">
			<#if title.data?has_content>
				<h2>${title.data}</h2>
			</#if>

			<#if subtitle.data?has_content>
				<p class="max-med">${subtitle.data}</p>
			</#if>
		</div>
	</#if>

	<div class="alt-font-color block-container">
		<#if block_title.siblings?size gt 5>
			<#assign block_width = 33 />
		<#else>
			<#assign block_width = 100 / block_title.siblings?size />
		</#if>

		<#list block_title.siblings as block>
			<div class="block media w${block_width?round}">
				<#if block.svg_code.data?has_content>
					<div class="media-object primary-color text-center">
						${block.svg_code.data}
					</div>
				</#if>

				<div class="media-body">
					<#if block.data?has_content>
						<h3>${block.data}</h3>
					</#if>

					<#if block.block_content.data?has_content>
						<p>${block.block_content.data}</p>
					</#if>
				</div>
			</div>
		</#list>
	</div>

	<#if button_text.data?has_content && button_text.button_link.data?has_content>
		<a class="btn" href="${button_text.button_link.data}">
			${button_text.data}

			<#if button_text.icon_svg_code.data?has_content>
				${button_text.icon_svg_code.data}
			</#if>
		</a>
	</#if>
</div>