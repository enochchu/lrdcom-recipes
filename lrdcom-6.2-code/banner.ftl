<#if image.data?has_content>
	<#assign style = "style='background-image: url(${image.data});'" />
<#else>
	<#assign style = "" />
</#if>

<#if opacity.data?has_content>
	<#assign opacity_overlay = "opacity-overlay" />
	<#assign opacity_color = opacity.data />
<#else>
	<#assign opacity_overlay = "" />
	<#assign opacity_color = "" />
</#if>

<div class="block-container main-banner ${opacity_overlay} ${position.data}" ${style}>
	<div class="block light-color main-banner-content max-med">
		<#if heading.data?has_content>
			<h1>${heading.data}</h1>
		</#if>

		<#if sub_heading.data?has_content>
			<p class="light-color sub-heading">${sub_heading.data}</p>
		</#if>
	</div>
</div>

<style type="text/css">
	.aui .main-banner {
		background-position: center;
		background-size: cover;
		align-items: center;
		justify-content: center;
		min-height: 400px;
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
</style>
