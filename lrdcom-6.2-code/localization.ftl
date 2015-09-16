<#assign localization_json_object = jsonFactoryUtil.createJSONObject("
	{
		country: {
			en_US: 'Country',
			zh_CN: 'Test Translation for Country'
		},

		first_name: {
			en_US: 'First Name',
			zh_CN: 'Test Translation for First Name'
		},

		your_request_completed_successfully: {
			en_US: 'Your request completed successfully.',
			zh_CN: 'Your request completed successfully (zh)'
		},

		your_request_failed_to_complete: {
			en_US: 'Your request failed to complete.'
		}
	}
") />

<#function localize key>
	<#if localization_json_object.getJSONObject(key)?? && localization_json_object.getJSONObject(key).getString(locale)?has_content>
		<#return localization_json_object.getJSONObject(key).getString(locale)>
	<#elseif localization_json_object.getJSONObject(key)?? && localization_json_object.getJSONObject(key).getString("en_US")?has_content>
		<#return localization_json_object.getJSONObject(key).getString("en_US")>
	<#else>
		<#return key>
	</#if>
</#function>