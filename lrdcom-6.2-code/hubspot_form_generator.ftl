<#function clean_up string>
	<#assign string = stringUtil.replace(string, "[", "") />
	<#assign string = stringUtil.replace(string, "]", "") />
	<#assign string = stringUtil.replace(string, '"', '') />

	<#if string == "_blank">
		<#assign string = "" />
	</#if>

	<#return string>
</#function>

<#function get_options field>
	<#if localization_map?has_content>
		<#assign localized_field_name = "" />

		<#assign localized_field_name = "$field.getString('name')" + "_" + "$locale.toString().toLowerCase()" />

		<#return localization_map.get(localized_field_name).get("options")>
	</#if>

	<#return field.getJSONArray('options')>
</#function>

<#assign portlet_bean_locator = objectUtil("com.liferay.portal.kernel.bean.PortletBeanLocatorUtil") />
<#assign hs_contact_local_service = portlet_bean_locator.locate("hubspot-portlet", "com.liferay.hubspot.service.HSContactLocalService.velocity") />
<#assign hs_form_local_service = portlet_bean_locator.locate("hubspot-portlet", "com.liferay.hubspot.service.HSFormLocalService.velocity") />

## Testing Hubspot Account
<#assign hs_account_id = "299703" />

## Production Hubspot Account
## <#assign hs_account_id = "252686" />

<#if request.lifecycle == 'RENDER_PHASE'>
	<#-- <#assign ip_geocoder_util = objectUtil("com.liferay.ipgeocoder.util.IPGeocoderUtil") />
	<#assign ip_info = ip_geocoder_util.getIPInfo(request.attributes.OSB_REMOTE_ADDRESS) />
	<#assign country_from_ip = "" />

	<#if ip_info>
		<#assign country_from_ip = ip_info.getCountryName() />
	</#if> -->

	<#assign number_of_fields_displayed = getterUtil.getInteger(number_of_fields.data) />

	<#-- <#list number_of_fields.override_key.siblings as key>
		<#list key.override_value.siblings as value>
			<#if hs_url_map.get(key.data) == value.data || hs_default_map.get(key.data) == value.data>
				<#assign number_of_fields_displayed = getterUtil.getInteger(value.num_of_fields.data) />
				<#assign fields_to_skip = value.fields_to_skip.data />

				<#assign break = true />
				#break
			</#if>
		</#list>

		<#if break>
			#break
		</#if>
	</#list> -->

	## Create a state to country map

	<#assign state_country_map = {"Armed Forces Americas": "United States","Armed Forces Europe": "United States","Alaska": "United States","Alabama": "United States","Armed Forces Pacific": "United States","Arkansas": "United States","American Samoa": "United States","Arizona": "United States","California": "United States","Colorado": "United States","Connecticut": "United States","District of Columbia": "United States","Delaware": "United States","Florida": "United States","Federated Micronesia": "United States","Georgia": "United States","Guam": "United States","Hawaii": "United States","Iowa": "United States","Idaho": "United States","Illinois": "United States","Indiana": "United States","Kansas": "United States","Kentucky": "United States","Louisiana": "United States","Massachusetts": "United States","Maryland": "United States","Maine": "United States","Marshall Islands": "United States","Michigan": "United States","Minnesota": "United States","Missouri": "United States","Northern Mariana Islands": "United States","Mississippi": "United States","Montana": "United States","North Carolina": "United States","North Dakota": "United States","Nebraska": "United States","New Hampshire": "United States","New Jersey": "United States","New Mexico": "United States","Nevada": "United States","New York": "United States","Ohio": "United States","Oklahoma": "United States","Oregon": "United States","Pennsylvania": "United States","Puerto Rico": "United States","Palau": "United States","Rhode Island": "United States","South Carolina": "United States","South Dakota": "United States","Tennessee": "United States","Texas": "United States","United States Minor Outlying Islands": "United States","Utah": "United States","Virginia": "United States","US Virgin Islands": "United States","Vermont": "United States","Washington": "United States","Wisconsin": "United States","West Virginia": "United States","Wyoming": "United States","Australian Capital Territory": "Australia","New South Wales": "Australia","Northern Territory": "Australia","Queensland": "Australia","South Australia": "Australia","Tasmania": "Australia","Victoria": "Australia","Western Australia": "Australia","Acre": "Brazil","Alagoas": "Brazil","Amazonas": "Brazil","Amapá": "Brazil","Bahia": "Brazil","Ceará": "Brazil","Distrito Federal": "Brazil","Espírito Santo": "Brazil","Goiás": "Brazil","Maranhão": "Brazil","Minas Gerais": "Brazil","Mato Grosso do Sul": "Brazil","Mato Grosso": "Brazil","Pará": "Brazil","Paraíba": "Brazil","Pernambuco": "Brazil","Piauí": "Brazil","Paraná": "Brazil","Rio de Janeiro": "Brazil","Rio Grande do Norte": "Brazil","Rondônia": "Brazil","Roraima": "Brazil","Rio Grande do Sul": "Brazil","Santa Catarina": "Brazil","Sergipe": "Brazil","São Paulo": "Brazil","Tocantins": "Brazil","Alberta": "Canada","British Columbia": "Canada","Manitoba": "Canada","New Brunswick": "Canada","Newfoundland and Labrador": "Canada","Nova Scotia": "Canada","Northwest Territories": "Canada","Nunavut": "Canada","Ontario": "Canada","Prince Edward Island": "Canada","Quebec": "Canada","Saskatchewan": "Canada","Yukon Territories": "Canada","Beijing": "China","Tianjin": "China","Hebei": "China","Shanxi": "China","Nei Mongol": "China","Liaoning": "China","Jilin": "China","Heilongjiang": "China","Shanghai": "China","Jiangsu": "China","Zhejiang": "China","Anhui": "China","Fujian": "China","Jiangxi": "China","Shandong": "China","Henan": "China","Hubei": "China","Hunan": "China","Guangdong": "China","Guangxi": "China","Hainan": "China","Chongqing": "China","Sichuan": "China","Guizhou": "China","Yunnan": "China","Xizang": "China","Shaanxi": "China","Gansu": "China","Qinghai": "China","Ningxia": "China","Xinjiang": "China","Chinese Taipei": "China","Hong Kong": "China","Macao": "China","Clare": "Ireland","Cavan": "Ireland","Cork": "Ireland","Carlow": "Ireland","Dublin": "Ireland","Donegal": "Ireland","Galway": "Ireland","Kildare": "Ireland","Kilkenny": "Ireland","Kerry": "Ireland","Longford": "Ireland","Louth": "Ireland","Limerick": "Ireland","Leitrim": "Ireland","Laois": "Ireland","Meath": "Ireland","Monaghan": "Ireland","Mayo": "Ireland","Offaly": "Ireland","Roscommon": "Ireland","Sligo": "Ireland","Tipperary": "Ireland","Waterford": "Ireland","Westmeath": "Ireland","Wicklow": "Ireland","Wexford": "Ireland","Andaman and Nicobar Islands": "India","Andhra Pradesh": "India","Arunachal Pradesh": "India","Assam": "India","Bihar": "India","Chandigarh": "India","Chhattisgarh": "India","Daman and Diu": "India","Delhi": "India","Dadra and Nagar Haveli": "India","Goa": "India","Gujarat": "India","Himachal Pradesh": "India","Haryana": "India","Jharkhand": "India","Jammu and Kashmir": "India","Karnataka": "India","Kerala": "India","Lakshadweep": "India","Maharashtra": "India","Meghalaya": "India","Manipur": "India","Madhya Pradesh": "India","Mizoram": "India","Nagaland": "India","Odisha": "India","Punjab": "India","Puducherry": "India","Rajasthan": "India","Sikkim": "India","Tamil Nadu": "India","Tripura": "India","Uttar Pradesh": "India","Uttarakhand": "India","West Bengal": "India","Agrigento": "Italy","Alessandria": "Italy","Ancona": "Italy","Aosta": "Italy","Ascoli Piceno": "Italy","L&#039;Aquila": "Italy","Arezzo": "Italy","Asti": "Italy","Avellino": "Italy","Bari": "Italy","Bergamo": "Italy","Biella": "Italy","Belluno": "Italy","Benevento": "Italy","Bologna": "Italy","Brindisi": "Italy","Brescia": "Italy","Barletta-Andria-Trani": "Italy","Bolzano": "Italy","Cagliari": "Italy","Campobasso": "Italy","Caserta": "Italy","Chieti": "Italy","Carbonia-Iglesias": "Italy","Caltanissetta": "Italy","Cuneo": "Italy","Como": "Italy","Cremona": "Italy","Cosenza": "Italy","Catania": "Italy","Catanzaro": "Italy","Enna": "Italy","Forlì-Cesena": "Italy","Ferrara": "Italy","Foggia": "Italy","Florence": "Italy","Fermo": "Italy","Frosinone": "Italy","Genoa": "Italy","Gorizia": "Italy","Grosseto": "Italy","Imperia": "Italy","Isernia": "Italy","Crotone": "Italy","Lecco": "Italy","Lecce": "Italy","Livorno": "Italy","Lodi": "Italy","Latina": "Italy","Lucca": "Italy","Monza and Brianza": "Italy","Macerata": "Italy","Messina": "Italy","Milan": "Italy","Mantua": "Italy","Modena": "Italy","Massa and Carrara": "Italy","Matera": "Italy","Naples": "Italy","Novara": "Italy","Nuoro": "Italy","Ogliastra": "Italy","Oristano": "Italy","Olbia-Tempio": "Italy","Palermo": "Italy","Piacenza": "Italy","Padua": "Italy","Pescara": "Italy","Perugia": "Italy","Pisa": "Italy","Pordenone": "Italy","Prato": "Italy","Parma": "Italy","Pistoia": "Italy","Pesaro and Urbino": "Italy","Pavia": "Italy","Potenza": "Italy","Ravenna": "Italy","Reggio Calabria": "Italy","Reggio Emilia": "Italy","Ragusa": "Italy","Rieti": "Italy","Rome": "Italy","Rimini": "Italy","Rovigo": "Italy","Salerno": "Italy","Siena": "Italy","Sondrio": "Italy","La Spezia": "Italy","Syracuse": "Italy","Sassari": "Italy","Savona": "Italy","Taranto": "Italy","Teramo": "Italy","Trento": "Italy","Turin": "Italy","Trapani": "Italy","Terni": "Italy","Trieste": "Italy","Treviso": "Italy","Udine": "Italy","Varese": "Italy","Verbano-Cusio-Ossola": "Italy","Vercelli": "Italy","Venice": "Italy","Vicenza": "Italy","Verona": "Italy","Medio Campidano": "Italy","Viterbo": "Italy","Vibo Valentia": "Italy","Aguascalientes": "Mexico","Baja California": "Mexico","Baja California Sur": "Mexico","Chihuahua": "Mexico","Colima": "Mexico","Campeche": "Mexico","Coahuila": "Mexico","Chiapas": "Mexico","Federal District": "Mexico","Durango": "Mexico","Guerrero": "Mexico","Guanajuato": "Mexico","Hidalgo": "Mexico","Jalisco": "Mexico","Mexico State": "Mexico","Michoacán": "Mexico","Morelos": "Mexico","Nayarit": "Mexico","Nuevo León": "Mexico","Oaxaca": "Mexico","Puebla": "Mexico","Querétaro": "Mexico","Quintana Roo": "Mexico","Sinaloa": "Mexico","San Luis Potosí": "Mexico","Sonora": "Mexico","Tabasco": "Mexico","Tlaxcala": "Mexico","Tamaulipas": "Mexico","Veracruz": "Mexico","Yucatán": "Mexico","Zacatecas": "Mexico"} />

	## Generate Hubspot form

	<#assign article_namespace = "article${.vars['reserved-article-title'].data}" />

	<#assign namespace = request["portlet-namespace"]>

	<#-- <#assign hsutk = request.attributes.OSB_HUBSPOT_UTK /> -->

	<#if hsutk?has_content>
		<#assign hs_contact = hs_contact_local_service.fetchHSContactByUserToken(hsutk) />
	</#if>

	<#if hs_contact?has_content>
		<#assign hs_contact_object = hs_contact.getHSContactJSONObject().getJSONObject("properties") />
	</#if>

	<#-- <#if locale != "en_US">
		## Testing Localization Form
		## <#assign localization_form = hs_form_local_service.fetchHSFormByGUID("72293d1f-6e98-4655-a0f5-e57ac01a7060") />

		## Production Localization Form
		<#assign localization_form = hs_form_local_service.fetchHSFormByGUID("6e0954fa-8f47-44a7-996d-e47c6f298f05") />

		<#if localization_form.getHSFormJSONObject().getJSONArray("fields")>
			<#assign localization_form_fields = localization_form.getHSFormJSONObject().getJSONArray("fields") />
			<#assign localization_map = "freemarker.template.SimpleHash"?new() />

			<#assign localization_form_start = 0 />
			<#assign localization_form_end = localization_form_fields.length() - 1 />
			<#assign localization_form_range = localization_form_start..localization_form_end />

			<#list localization_form_range as i>
				<#assign localization_form_field = localization_form_fields.getJSONObject(i) />

				<#assign field_map = "freemarker.template.SimpleHash"?new() />

				<#assign VOID = field_map.put("label", localization_form_field.getString("label")) />
				<#assign VOID = field_map.put("options", localization_form_field.getJSONArray("options")) />

				<#assign VOID = localization_map.put(localization_form_field.getString("name"), field_map) />
			</#list>
		</#if>
	</#if> -->

	<#assign hs_form = hs_form_local_service.fetchHSFormByGUID(hs_form_id.data) />

	<#assign submit_params = "'#${article_namespace}fm'" />

	<#if record_id?has_content && record_id != "">
		<#assign submit_params = "${submit_params}, this.getAttribute('data-tactic-url-fields')" />
	</#if>

	<#assign submit_params = "${submit_params}, this.getAttribute('data-tactic-item-fields')" />

	<#if hs_form?has_content>
		<#assign hs_form_fields = hs_form.getHSFormJSONObject().getJSONArray("fields") />
		<#assign form_rules_json = jsonFactoryUtil.createJSONObject() />

		<#assign article_field_names_json = jsonFactoryUtil.createJSONObject() />
		<#assign form_field_strings_json = jsonFactoryUtil.createJSONObject() />

		<#list field_name.siblings as name>
			<#assign article_field_values_json = jsonFactoryUtil.createJSONObject() />

			<#if name.label.data != "">
				<#assign void = article_field_values_json.put("label", name.label.data) />
				<#assign void = article_field_values_json.put("description", name.description.data) />

				<#assign void = article_field_names_json.put(name.data, article_field_values_json) />
			</#if>

			<#if name.required_message.data != "">
				<#assign form_field_string = jsonFactoryUtil.createJSONObject() />
				<#assign void = form_field_string.put("required", name.required_message.data) />
				<#assign void = form_field_strings_json.put(name.data, form_field_string) />
			</#if>
		</#list>

		<div class="hbspt-form">
			<div id="${article_namespace}msg"></div>

			<form action="https://forms.hubspot.com/uploads/form/v2/${hs_account_id}/${hs_form_id.data}" data-asset-new-tab="true" data-tactic-url-fields="" data-tactic-item-fields='' id="${article_namespace}fm" method="POST" onsubmit="submitHSForm${.vars['reserved-article-title'].data}(${submit_params}); return false;">
				<#assign field_count = 0 />
				<#assign start = 0 />
				<#assign end = hs_form_fields.length() - 1 />
				<#assign range = start..end />

				<div class="form-col form-col-1">
					<#list range as i>
						<#assign item = hs_form_fields.getJSONObject(i) />

						<#assign label_text = "" />
						<#assign field_description = "" />

						<#if article_field_names_json.has(item.getString("name"))>
							<#assign article_field_name_value = article_field_names_json.getJSONObject(item.getString("name")) />

							<#assign label_text = article_field_name_value.getString("label") />
							<#assign field_description = article_field_name_value.getString("description") />
						</#if>

						<#if label_text == "">
							<#assign label_text = item.getString("label") />
						</#if>

						<#if field_description == "">
							<#assign field_description = item.getString("description") />
						</#if>

						<#assign hidden = getterUtil.getBoolean(item.getString("hidden")) />
						<#assign hs_smart_field = getterUtil.getBoolean(item.getString("isSmartField")) />
						<#assign hs_value = "" />
						<#assign required = "" />
						<#assign value = "" />

						<#assign field_type = item.getString("fieldType") />

						<#if item.getString("defaultValue")?has_content>
							<#assign value = item.getString("defaultValue") />
						</#if>

						<#if item.getJSONArray("selectedOptions")?has_content>
							<#assign value = clean_up(item.getJSONArray("selectedOptions").toString()) />

							<#if hidden && field_type == "checkbox">
								<#assign value = stringUtil.replace(value, ",", ";") />

								<#if hs_contact_object?? && hs_contact_object.getJSONObject("item.getString('name')")>
									<#assign hs_value = hs_contact_object.getJSONObject("item.getString('name')").getString("value") />

									<#if hs_value.contains(value)>
										<#assign value = hs_value />
									<#else>
										<#assign value = "${value};${hs_value}" />
									</#if>
								</#if>
							</#if>
						</#if>

						<#if !hidden && hs_contact_object?has_content && hs_contact_object.getJSONObject("item.getString('name')")>
							<#assign hs_value = hs_contact_object.getJSONObject("${item.getString('name')}").getString("value") />
							<#assign value = hs_value />
						</#if>

						<#assign field_css_class = "aui-field aui-field-${field_type}" />
						<#assign field_input_css_class = "aui-field-input aui-field-input-${field_type}" />

						<#if value != "">
							<#assign field_css_class = "${field_css_class} field-filled" />
						</#if>

						<#if hidden || (hs_smart_field && (hs_value != ""))>
							<#assign field_css_class = "${field_css_class} aui-helper-hidden" />
							<#assign field_input_css_class = "$field_input_css_class hidden-field" />
						<#elseif fields_to_skip?has_content && fields_to_skip.contains(item.getString("name"))>
							##skip
						<#else>
							<#assign field_count = field_count + 1 />
						</#if>

						<#assign field_css_class = "${field_css_class} field-${field_count}" />

						<#if item.getString("required") == "true">
							<#assign field_css_class = "field_css_class field-required" />
							<#assign field_input_css_class = "${field_input_css_class} aui-field-required" />
							<#assign required = "" />
							<#assign label_text = "${label_text} *" />

							<#assign form_rule = jsonFactoryUtil.createJSONObject() />
							<#assign void = form_rule.put("required", true) />
							<#assign void = form_rules_json.put(item.getString("name"), form_rule) />
						</#if>

						<#if item.getString("name") == "state">
							<#assign field_css_class = "aui-helper-hidden ${field_css_class} state" />
						</#if>

						<#if ((number_of_fields_displayed?has_content && number_of_fields_displayed != 0) && (field_count > number_of_fields_displayed) && !hidden) || (hs_smart_field && (value != "")) || (fields_to_skip?has_content && fields_to_skip.contains(item.getString("name")))>
							##skip
						<#else>
							<div class="${field_css_class}" id="article${.vars['reserved-article-title'].data}field${i}">
								<#if label_text != "" && (field_type != "richtext") && (field_type != "booleancheckbox")>
									<label class="aui-field-label" for="${item.getString('name')}">${label_text}</label>
								</#if>

								<#if hidden>
									<input class="${field_input_css_class}" type="hidden" name="${item.getString('name')}" value="${value}"/>
								<#elseif field_type == "select">
									<#assign select_options_map = get_options(item) />
									<#assign select_options_start = 0 />
									<#assign select_options_end = select_options_map.length() - 1 />
									<#assign select_options_range = select_options_start..select_options_end />

									<select class="${field_input_css_class}" id="${item.getString('name')}-${.vars['reserved-article-title'].data}" name="${item.getString('name')}" ${required}>
										<option value="">${label_text}</option>

										<#list select_options_range as i>
											<#assign option = select_options_map.getJSONObject(i) />
											<#assign selected = "" />

											<#if value == option.getString('value') || ((item.getString("name") == "country") && country_from_ip?? && (option.getString('value') == country_from_ip))>

												<#assign selected = "selected" />
											</#if>

											<option value="${option.getString('value')}" ${selected}>${option.getString('label')}</option>
										</#list>
									</select>

									<#if item.getString("name") == "state">
										<#assign states_options_json = jsonFactoryUtil.createJSONObject() />

										<#list select_options_range as i>
											<#assign option = select_options_map.getJSONObject(i) />
											<#assign country_name = "other" />
											<#assign option_value = htmlUtil.escape(option.getString("value")) />
											<#-- <#assign country_name = state_country_map.get(option_value) /> -->

											<#if !states_options_json.has(country_name)>
												<#assign void = states_options_json.put(country_name, jsonFactoryUtil.createJSONObject()) />
											</#if>

											<#if value == option_value>
												<#assign void = states_options_json.put("selected_option", option_value) />
											</#if>

											<#assign state_option_json = states_options_json.getJSONObject(country_name) />

											<#assign void = state_option_json.put(option_value, htmlUtil.escape(option.getString("label"))) />

											<#if !state_option_json.has("key")>
												<#assign void = state_option_json.put("key", jsonFactoryUtil.createJSONArray()) />
											</#if>

											<#assign void = state_option_json.getJSONArray("key").put(option_value) />
										</#list>

										<#if item.getString("unselectedLabel") != "">
											<#assign void = states_options_json.put("unselected_label", label_text) />
										</#if>
									</#if>
								<#elseif field_type == "richtext">
									<span class="hs-richtext">${item.getString('defaultValue')}</span>
								<#elseif field_type == "textarea">
									<textarea class="${field_input_css_class}" id="${item.getString('name')}-${.vars['reserved-article-title'].data}" name="${item.getString('name')}" placeholder="${label_text}" ${required}>${value}</textarea>
								<#elseif field_type == "booleancheckbox">
									<label class="aui-field-label">
										<input class="${field_input_css_class}" name="${item.getString('name')}" type="checkbox" value="false" />${label_text}
									</label>
								<#elseif field_type == "checkbox" || field_type == "radio">
									<#assign checkbox_options_map = get_options(item) />
									<#assign checkbox_options_start = 0 />
									<#assign checkbox_options_end = checkbox_options_map.length() - 1 />
									<#assign checkbox_options_range = checkbox_options_start..checkbox_options_end />


									<div class="input">
										<#list checkbox_options_range as i>
											<#assign option = checkbox_options_map.getJSONObject(i) />

											<#if value.contains(option.getString("value"))>
												<#assign checked = "checked" />
											<#else>
												<#assign checked = "" />
											</#if>

											<label class="aui-field-label">
												<input class="${field_input_css_class}" ${checked} name="${item.getString('name')}" type="${field_type}" value="${option.getString('value')}" />${option.getString("label")}
											</label>
										</#list>
									</div>
								<#else>
									<input
										class="${field_input_css_class}"
										id="${item.getString('name')}-${.vars['reserved-article-title'].data}"
										name="${item.getString('name')}"
										placeholder="${label_text}"

										<#if item.getString("name") == "email">
											type="email"
										<#else>
											type="${field_type}"
										</#if>

										<#if item.getString('placeholder') != "">
											placeholder="item.getString('placeholder')"
										</#if>

										${required}

										value="${value}"
									/>
								</#if>

								<#if field_description != "">
									<div class="aui-field-desc">${field_description}</div>
								</#if>
							</div>

							<#if number_of_fields_first_col?has_content && (field_count == number_of_fields_first_col.data) && !hidden>
				</div>
				<div class="form-col form-col-2">
							</#if>
						</#if>
					</#list>

					<#assign btn_text = submit_text.data />

					<#if btn_text == "">
						<#assign btn_text = hs_form.getSubmitText() />
					</#if>

					<div class="btn-wrapper">
						<input class="aui-button-input aui-button-input-submit btn" type="submit" value="${btn_text}" />
					</div>
				</div>
			</form>
		</div>
	</#if>

	<#-- <#assign ip_address = request.attributes.OSB_REMOTE_ADDRESS /> -->
	<#assign page_url = request.attributes.FRIENDLY_URL />
	<#assign page_name = "" />

	<#assign redirect_asset_url = "" />

	<#assign redirect_url = "" />

	<#if hs_form.getRedirect()?has_content>
		<#assign redirect_url = hs_form.getRedirect() />
	</#if>

	<#assign salesforce_campaign_id = "" />

	<#-- <#assign salesforce_campaign_id = hs_form.getHSFormJSONObject().getJSONArray("metaData").getJSONObject(0).getString("value") /> -->

	<script type="text/javascript">
		function submitHSForm${.vars['reserved-article-title'].data}(formId, primaryTacticFields, secondaryTacticFields) {
			AUI().ready(
				'aui-base',
				'aui-io-plugin',
				'aui-io-request',
				'json-parse',
				function(A) {
					var form = A.one(formId);
					var msg = A.one('#${article_namespace}msg');

					if (!form) {
						return;
					}

					var fields = {};

					if (primaryTacticFields && (primaryTacticFields != "")) {
						fields = A.JSON.parse(primaryTacticFields);
					}

					var leave = false;

					form.all('.aui-field-input').each(
						function(node) {
							var value = node.get('value');

							if (node.hasClass('aui-field-input-booleancheckbox') && (node.get('checked') == true)) {
								value = true;
							}

							if ((node.hasClass('aui-field-required') && value == '') || (node.hasClass('aui-field-required') && value == 'false')) {
								leave = true;

								return;
							}

							if (!node.hasClass('hidden-field') && (node.hasClass('aui-field-input-booleancheckbox') || node.hasClass('aui-field-input-checkbox') || node.hasClass('aui-field-input-radio'))) {
								if (node.get('checked') == true) {
									if (fields[node.get('name')]) {
										fields[node.get('name')] += ',' + value;
									}
									else {
										fields[node.get('name')] = value;
									}
								}
							}
							else if (value != '') {
								fields[node.get('name')] = value;
							}
						}
					);

					if (leave) {
						return;
					}

					if (secondaryTacticFields) {
						secondaryTacticFields = A.JSON.parse(secondaryTacticFields);

						if (secondaryTacticFields["asset_id"]) {
							fields["asset_id"] = secondaryTacticFields["asset_id"];
						}
						if (secondaryTacticFields["asset_name"]) {
							fields["asset_name"] = secondaryTacticFields["asset_name"];
						}
						if (secondaryTacticFields["asset_type"]) {
							fields["asset_type"] = secondaryTacticFields["asset_type"];
						}
						if (secondaryTacticFields["asset_url"]) {
							fields["asset_url"] = secondaryTacticFields["asset_url"];
						}
					}

					var fieldsString = "";

					for(field in fields) {
						fieldsString = fieldsString + field + ':;:' + fields[field] + ':;:';
					}

					var guid = '${hs_form_id.data}';
					<#if ip_address??>
						var ipAddress = '${ip_address}';
					<#else>
						var ipAddress = '';
					</#if>
					var pageURL = '${page_url}';
					var pageName = document.title;
					var redirectAssetURL = '${redirect_asset_url}';

					if (fields["asset_url"]) {
						redirectAssetURL = fields["asset_url"];
					}

					var redirectURL = '${redirect_url}';
					var salesforceCampaignId = '${salesforce_campaign_id}';

					if (fields["campaign"]) {
						salesforceCampaignId = fields["campaign"];
					}

					<#if hsutk??>
						var userToken = '${hsutk}';
					<#else>
						var userToken = '';
					</#if>

					if ((redirectAssetURL != "") && (form.getAttribute('data-asset-new-tab') == "true")) {
						window.open(redirectAssetURL, '_blank');
					}

					if (fields["asset_primary_buyers_stage"]) {
						var assetPrimaryBuyersStage = fields["asset_primary_buyers_stage"];

						if (assetPrimaryBuyersStage == "Awareness") {
							var trackEventId = "000000245927";
						}
						else if (assetPrimaryBuyersStage == "Education") {
							var trackEventId = "000000245928";
						}
						else if (assetPrimaryBuyersStage == "Evaluation") {
							var trackEventId = "000000245929";
						}
						else if (assetPrimaryBuyersStage == "Justification") {
							var trackEventId = "000000245931";
						}

						try {
							_hsq.push(
								[
									"trackEvent", {
										id: trackEventId,
										value: null
									}
								]
							);
						}
						catch (error) {
							console.log('_hsq error caught');
						}
					}

					A.io.request(
						'${request["portlet-namespace"]}',
						{
							data: {
								${namespace}fields: fieldsString,
								${namespace}guid: guid,
								${namespace}ipAddress: ipAddress,
								${namespace}pageURL: pageURL,
								${namespace}pageName: pageName,
								${namespace}redirectURL: redirectURL,
								${namespace}salesforceCampaignId: salesforceCampaignId,
								${namespace}userToken: userToken
							},
							dataType: 'json',
							on: {
								success: function(event, id, obj) {
									<#if on_success_js?has_content && (on_success_js.data != "")>
										${on_success_js.data}
									<#else>
										if (redirectURL != "") {
											window.location.href = redirectURL;
										}
										else {
											msg.setContent('<div class="portlet-msg-success">Your request completed successfully.</div><p class="thank-you-msg">${thank_you_text.getData()}</p>');

											form.hide();
										}
									</#if>
								},
								failure: function(event, id, obj) {
									msg.setContent('<div class="portlet-msg-error">Your request failed to complete.</div>');
								}
							}
						}
					);
				}
			);
		};

		AUI().ready(
			'aui-base',
			'aui-form-validator',
			'json-parse',
			function(A) {
				new A.FormValidator(
					{
						boundingBox: '#${article_namespace}fm',
						fieldContainer: '.aui-field',
						fieldStrings: A.JSON.parse('${form_field_strings_json}'),
						rules: A.JSON.parse('${form_rules_json}')
					}
				);

				A.all('#${article_namespace}fm .aui-field').each(
					function(node) {
						node.on(
							'focus',
							function() {
								node.addClass('field-focused');
							}
						);

						node.on(
							'blur',
							function() {
								node.removeClass('field-focused');

								if (node.one('.aui-field-input').get('value') != "") {
									node.addClass('field-filled');
								}
								else {
									node.removeClass('field-filled');
								}
							}
						);
					}
				);

				var countrySelect = A.one('#country-${.vars['reserved-article-title'].data}');
				var stateSelect = A.one('#state-${.vars['reserved-article-title'].data}');

				if (stateSelect) {
					var stateWrapper = stateSelect.ancestor('.aui-field');
				}

				<#if states_options_json?has_content>
					var stateJSON = A.JSON.parse('${states_options_json}');
				</#if>

				if (!countrySelect || !stateSelect || !stateWrapper || !stateJSON) {
					return;
				}

				var populateStateField = function() {
					var stateOptions = stateJSON[countrySelect.val()];

					stateSelect.empty();

					if (stateOptions) {
						if (stateJSON['unselected_label']) {
							stateSelect.appendChild('<option value="">' + stateJSON['unselected_label'] + '</option>');
						}

						var keyArray = stateOptions["key"];

						for (var key in keyArray) {
							var stateValue = keyArray[key];
							var selected = "";

							if (stateValue == stateJSON['selected_option']) {
								selected = "selected";
							}

							stateSelect.appendChild('<option value="' + stateValue + '"' + selected + '>' + stateOptions[stateValue] + '</option>');
						}

						stateWrapper.removeClass('aui-helper-hidden');
					}
					else {
						stateWrapper.addClass('aui-helper-hidden');
					}
				};

				populateStateField();

				countrySelect.on('change', populateStateField);
			}
		);
	</script>
<#elseif request.lifecycle == 'RESOURCE_PHASE'>
	<#assign fields = stringUtil.split(request.parameters.fields, ":;:") />

	<#assign guid = request.parameters.guid />
	<#assign ipAddress = request.parameters.ipAddress />
	<#assign pageURL = request.parameters.pageURL />
	<#assign pageName = request.parameters.pageName />
	<#assign redirectURL = request.parameters.redirectURL />
	<#assign salesforceCampaignId = request.parameters.salesforceCampaignId />
	<#assign userToken = request.parameters.userToken />

	<#assign VOID = hs_form_local_service.submitHSForm(guid, userToken, ipAddress, pageURL, pageName, redirectURL, salesforceCampaignId, fields) />
</#if>