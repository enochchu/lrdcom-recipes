<#assign wrapper_css_class = "case-study-tiles-wrapper" />

<#if custom_wrapper_class.data?has_content >
	<#assign wrapper_css_class = "${wrapper_css_class} ${custom_wrapper_class.data}" />
</#if>

<div class="${wrapper_css_class}">
	<#if title.data?has_content || subtitle.data?has_content>
		<div class="section-heading text-center">
			<#if title.data?has_content>
				<h2>
					${title.data}
				</h2>
			</#if>

			<#if subtitle.data?has_content>
				<p>${subtitle.data}</p>
			</#if>
		</div>
	</#if>

	<div class="align-center block-container justify-center tile-section">
		<#list tile.siblings as tile>
			<div class="block link-tile w33">
					<#if tile.tile_logo.data?starts_with("\lsvg") >
						<#assign anchor_attributes = 'class="logo-${tile_index + 1}" href="${tile.tile_link.data}" label="${tile.data}"'>
					<#else>
						<#assign anchor_attributes = 'class="logo-${tile_index + 1} lazy-load" data-src="${tile.tile_logo.data}" href="${tile.tile_link.data}" label="${tile.data}"'>
					</#if>

				<a ${anchor_attributes}>
					<#assign asset_entry_fact = "See Case Study" />

					<#if tile.tile_entry_fact.data?has_content>
						<#assign asset_entry_fact = tile.tile_entry_fact.data />
					</#if>

					<span class="asset-entry-fact">${asset_entry_fact}</span>
				</a>
			</div>
		</#list>
	</div>
</div>

<style>
	.link-tile {
		max-width: 300px;
	}

	<#list tile.siblings as tile_style_item>
		.aui .link-tile .logo-${tile_style_item_index + 1} {
			<#if tile_style_item.tile_logo.data?starts_with("\lsvg") >
				<#assign logo_url_escaped = htmlUtil.escapeURL(tile_style_item.tile_logo.data?replace("\"","\'"))>
				<#assign logo_url = 'data:image/svg+xml;charset=utf-8,${logo_url_escaped}'>
			<#else>
				<#assign logo_url = '${tile_style_item.tile_logo.data}'>
			</#if>

			background: url("${logo_url}") center no-repeat;
			background-size: contain;
		}
	</#list>

	<#if custom_css.data?has_content>
		${custom_css.data}
	</#if>
</style>