<#if image.data?has_content>
	<#assign style = "style='background-image: url(${image.data});'" />
<#else>
	<#assign style = "" />
</#if>

<#assign font_color = "light-color" />

<#if opacity.data?has_content>
	<#assign opacity_color = opacity.data />
	<#assign opacity_overlay = "opacity-overlay" />

	<#if opacity_color == "#FFF">
		<#assign font_color = "font-color" />
	</#if>
<#else>
	<#assign opacity_color = "" />
	<#assign opacity_overlay = "" />
</#if>

<div class="align-center block-container justify-center main-banner ${opacity_overlay} ${position.data}" ${style}>
	<div class="block ${font_color} main-banner-content max-med">
		<#if heading.data?has_content>
			<div class="page-heading">
				<h1>${heading.data}</h1>

				<#if sub_heading.data?has_content>
					<p class="${font_color}">${sub_heading.data}</p>
				</#if>
			</div>
		</#if>

	</div>
</div>

<#assign min_height = "400px" />

<#if height?? && height.data?has_content>
	<#assign min_height = height.data />
</#if>

<style type="text/css">
	.aui .main-banner {
		background-position: center;
		background-size: cover;
		min-height: ${min_height};
		overflow: hidden;
		position: relative;
	}

	.aui .main-banner .main-banner-content {
		margin: 30px 10%;
		position: relative;
		z-index: 5;
	}

	.main-banner.opacity-overlay .main-banner-content:after {
		background-color: ${opacity_color};
		bottom: -200%;
		content: "";
		display: block;
		left: -200%;
		opacity: .75;
		position: absolute;
		right: -200%;
		top: -200%;
		z-index: -1;
		-ms-transform: skew(135deg);
		-webkit-transform: skew(135deg);
		-moz-transform: skew(135deg);
		-o-transform: skew(135deg);
		transform: skew(135deg);
		transform-origin: center;
	}

	.main-banner.lower-left, .main-banner.upper-left {
		justify-content: flex-start;
	}

	.main-banner.upper-left .main-banner-content:after {
		right: -25%;
	}

	.main-banner.lower-left .main-banner-content:after {
		right: -25%;
		-ms-transform: skew(45deg);
		-webkit-transform: skew(45deg);
		-moz-transform: skew(45deg);
		-o-transform: skew(45deg);
		transform: skew(45deg);
	}

	.main-banner.lower-right, .main-banner.upper-right {
		justify-content: flex-end;
	}

	.main-banner.upper-right .main-banner-content:after {
		left: -25%;
	}

	.main-banner.lower-right .main-banner-content:after {
		left: -25%;
		-ms-transform: skew(45deg);
		-webkit-transform: skew(45deg);
		-moz-transform: skew(45deg);
		-o-transform: skew(45deg);
		transform: skew(45deg);
	}

	@media (max-width: 720px) {
		.responsive .main-banner.opacity-overlay .main-banner-content:after {
			left: -200%;
			right: -200%;
		}
	}

	<#if css?? && css.data?has_content>
			${css.data}
	</#if>
</style>