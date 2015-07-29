[Style Guide](http://htmlpreview.github.io/?https://github.com/ryanschuhler/lrdcom-recipes/blob/master/style-guide/style_guide.html)
======
## Best Practices
#### General Formatting
* Velocity variables are named_with_underscores (use underscores in structure element names as well)
* Javascript variables and CSS IDs are namedWithCamelCasing
* Css classes are named-with-dashes
* Use underscores in image_names
* Use `" "` in velocity and html
* Use `' '` in javascript
* Wrap velocity variable from user input with `$htmlUtil.escape()`

#### Web Content Naming Conventions
* Include friendly url in article title (e.g. `The Leading Open Source Portal for the Enterprise - /products/liferay-portal/overview`)

#### Lego Template Best Practices
**Do Not Use When:**
* Complex content that requires additional html
* Layout/view of content is repeated in many places
* Velocity/freemarker is required
* Avoid using `#article-$article-id.data` whenever possible

#### Where to Put CSS Styles
* Rule of thumb: put css as close to its referent as possible, but reuse styles as much as possible (i.e. in article if styles only apply to that article; at the bottom of the page if the styles are used across the page)
* Share style article with multiple pages if used on a few pages.
* Put in theme if the styles are used in a multitude of pages.

#### Where to Place JS
* If the script only used in a lego article, add it to the custom_content section
* If the script is used in multiple places on the page, place in an article at the bottom of the page

#### Image Etiquette
* Use relative URL
* Take off time stamp
* Use sprites whenever possible
* Optimize (svg) before use

#### Translations
* Make sure templates can be fully localized
* Utilize localization template (`article ID# 30798511`) for translations not committed in language.properties
* When updating content, make sure to check the existence of localizations. Note the ones missing and create tickets for stakeholders.

##Document Library Structure
	_icons (commonly used icons such as the play icons, X's, etc)
	ROOT PAGE
		SUB PAGE
		SUB PAGE (assets)
			_image
			_pdf
			_video
			_etc
	ROOT PAGE
		SUB PAGE
		SUB PAGE (assets)
			_image
				short_description.svg
			_pdf
			_video
			_etc
