<div class="align-center block-container justify-center exhibit-group large-padding-vertical">
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

	<div class="align-baseline alt-font-color block-container justify-center">
		<#if block_title.siblings?size gt 5>
			<#assign block_width = 33 />
		<#else>
			<#assign block_width = 100 / block_title.siblings?size />
		</#if>

		<#list block_title.siblings as block>
			<#assign transition_css = "on-screen-helper slide-up" />

			<div class="block exhibit standard-padding ${transition_css} ${block.animation_delay.data} w${block_width?round}">
				<#if block.svg_code.data?has_content>
					<div class="exhibit-media primary-color text-center">
						${block.svg_code.data}
					</div>
				</#if>

				<div class="exhibit-body">
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