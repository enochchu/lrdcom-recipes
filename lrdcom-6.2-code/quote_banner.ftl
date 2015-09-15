<div class="light-color quote-wrapper ${background_color.data}">
	<#if quote.data?has_content>
		<div class="max-med quote">
			${quote.data}

			<div class="triangle upper-left ${quote_color.data}"></div>
			<div class="triangle upper-left second-triangle ${quote_color.data}"></div>
			<div class="lower-right triangle ${quote_color.data}"></div>
			<div class="lower-right triangle second-triangle ${quote_color.data}"></div>
		</div>
	</#if>

	<div class="max-sm quote-source">
		<#if author.data?has_content>
			<div class="quote-author">
				${author.data}
			</div>
		</#if>

		<#if author_title.data?has_content || author_company?has_content>
			<div class="author-info">
				<#if author_title.data?has_content>
					<div class="author-title">
						${author_title.data}
					</div>
				</#if>

				<#if author_company.data?has_content>
					<div class="author-company">
						${author_company.data}
					</div>
				</#if>
			</div>
		</#if>
	</div>

	<#list triangle.siblings as triangle>
		<div class="triangle ${triangle.color.data} ${triangle.position.data}" style="border-width: ${triangle.data}; z-index: ${triangle.z_index.data};"></div>
	</#list>
</div>

<style type="text/css">
	.quote, .quote-wrapper {
		font-size: 1.25em;
		position: relative;
	}

	.quote, .quote-source {
		position: relative;
		z-index: 5;
	}

	.quote-wrapper {
		padding: 70px 20px;
	}

	.quote-wrapper .quote {
		padding: 1em 3em;
	}

	.quote-wrapper .quote-author {
		font-size: 1.5em;
	}

	.triangle {
		border: 16px solid transparent;
		content: "";
		position: absolute;
	}

	.quote .triangle.second-triangle.lower-right {
		right: 32px;
	}

	.quote .triangle.second-triangle.upper-left {
		left: 32px;
	}

	.triangle.upper-right {
		border-bottom-color: transparent !important;
		border-left-color: transparent !important;
		right: 0;
		top: 0;
	}

	.triangle.lower-right {
		border-left-color: transparent !important;
		border-top-color: transparent !important;
		bottom: 0;
		right: 0;
	}

	.triangle.lower-left {
		border-right-color: transparent !important;
		border-top-color: transparent !important;
		bottom: 0;
		left: 0;
	}

	.triangle.upper-left {
		border-bottom-color: transparent !important;
		border-right-color: transparent !important;
		left: 0;
		top: 0;
	}

	@media all and (max-width: 720px) {
		.quote-wrapper .quote {
			padding: 2em 1em;
		}

		.triangle {
			display: none;
		}

		.quote .triangle {
			display: block;
		}
	}
</style