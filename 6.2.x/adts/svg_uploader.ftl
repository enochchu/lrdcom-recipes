<#assign aui = taglibLiferayHash["/WEB-INF/tld/aui.tld"] />
<#assign liferay_portlet = taglibLiferayHash["/WEB-INF/tld/liferay-portlet.tld"] />
<#assign liferay_ui = taglibLiferayHash["/WEB-INF/tld/liferay-ui.tld"] />

<#assign sourceFileName = paramUtil.getString(request, "sourceFileName", "empty") />

<#if sourceFileName?has_content>
	<#assign mimeType = paramUtil.getString(request, "mimeType") />
	<#assign title = paramUtil.getString(request, "title") />
	<#assign description = paramUtil.getString(request, "description") />
	<#assign changeLog = "" />

	<#assign dlApps = dlAppLocalService.addFileEntry(themeDisplay.getUserId(), repositoryId, 189699, sourceFileName, mimeType, title, description, changeLog, bytes, serviceContext ) />
</#if>

test: ${sourceFileName}

<@aui.form action="" method="post" name="filterForm">
	<@aui.input name="sourceFileName" id="sourceFileName" type="text" value="" label="sourceFileName" placeholder=""/>
	<@aui.select name="mycategoryId" id="mycategoryId" label="Category">
		<@aui.option label="Sports" value="100" first="true" />
		<@aui.option label="Games" value="101"/>
	</@aui.select>
	<@aui.button type="submit" value="Submit"></@aui.button>
</@aui.form>