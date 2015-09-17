<#assign localization_json_object = jsonFactoryUtil.createJSONObject("
	{
		company: {
			de_DE: 'Unternehmen',
			en_US: 'Company',
			es_ES: 'Empresa',
			fr_FR: 'Société',
			it_IT: 'Azienda',
			ja_JP: '会社名',
			pt_BR: 'Empresa',
			zh_CN: '公司'
		},

		country: {
			de_DE: 'Land',
			en_US: 'Country',
			es_ES: 'País',
			fr_FR: 'Pays',
			it_IT: 'Paese',
			ja_JP: '国',
			pt_BR: 'País',
			zh_CN: '国家'
		},

		department: {
			de_DE: 'Abteilung',
			en_US: 'Department',
			es_ES: 'Departamento',
			fr_FR: 'Département',
			it_IT: 'Reparto',
			ja_JP: '部署',
			pt_BR: 'Departamento',
			zh_CN: '部门'
		},

		email: {
			de_DE: 'E-Mail',
			en_US: 'Email',
			it_IT: 'E-mail',
			ja_JP: 'メールアドレス',
			zh_CN: '邮箱'
		},

		firstname: {
			de_DE: 'Vorname',
			en_US: 'First Name',
			es_ES: 'Nombre',
			fr_FR: 'Prénom',
			it_IT: 'Nome',
			ja_JP: '名',
			pt_BR: 'Primeiro Nome',
			zh_CN: '名'
		},

		get_a_quote: {
			de_DE: 'Angebot anfordern',
			en_US: 'Get a Quote',
			zh_CN: '获取企业版报价'
		},

		job_role__c: {
			de_DE: 'Funktionsbezeichnung',
			en_US: 'Job Role',
			fr_FR: 'Fonction',
			it_IT: 'Ruolo professionale',
			ja_JP: '役割',
			pt_BR: 'Posição',
			zh_CN: '职位'
		},

		lastname: {
			de_DE: 'Nachname',
			en_US: 'Last Name',
			es_ES: 'Apellido',
			fr_FR: 'Nom',
			it_IT: 'Cognome',
			ja_JP: '姓',
			pt_BR: 'Último Nome',
			zh_CN: '姓'
		},

		phone: {
			de_DE: 'Telefon',
			en_US: 'Phone',
			es_ES: 'Teléfono',
			fr_FR: 'Téléphone',
			it_IT: 'Telefono',
			ja_JP: '電話番号',
			pt_BR: 'Telefone',
			zh_CN: '联系电话'
		},

		project_use_case: {
			de_DE: 'Anwendungsfall',
			en_US: 'Project Use Case',
			zh_CN: '项目使用场景'
		},

		show_me_liferay: {
			de_DE: 'Ich möchte Liferay kennen lernen',
			en_US: 'Show Me Liferay',
			es_ES: 'Muéstrame Liferay',
			fr_FR: 'Je veux découvrir Liferay',
			it_IT: 'Mostrami Liferay',
			ja_JP: 'デモを希望',
			pt_BR: 'Mostre-me a Liferay',
			zh_CN: '了解并体验'
		},

		solution_interest: {
			de_DE: 'Wofür möchten Sie Liferay nutzen?',
			en_US: 'What are you building?',
			es_ES: '¿Qué proyectos estás construyendo?',
			fr_FR: 'Projet en cours',
			it_IT: 'Che cosa sta costruendo',
			ja_JP: '構築するサイト',
			pt_BR: 'Qual o seu projeto com Liferay?'
		},

		state: {
			de_DE: 'Region',
			en_US: 'State/Province *',
			es_ES: 'Región *',
			fr_FR: 'Région *',
			it_IT: 'Stato/Regione',
			ja_JP: '県/州 *',
			pt_BR: 'Estado/Região *',
			zh_CN: '省份 *'
		},

		your_request_completed_successfully: {
			en_US: 'Your request completed successfully.',
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

<#--

Missing translations:

de_DE: 'get_a_quote', 'project_use_case',
es_ES: 'get_a_quote', 'job_role__c', 'project_use_case',
fr_FR: 'get_a_quote', 'project_use_case',
it_IT: 'get_a_quote', 'project_use_case',
ja_JP: 'get_a_quote', 'project_use_case',
pt_BR: 'get_a_quote', 'project_use_case',
zh_CN: 'get_a_quote', 'solution_interest'

-->