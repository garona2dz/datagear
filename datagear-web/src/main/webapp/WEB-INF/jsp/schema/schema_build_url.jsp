<%--
/*
 * Copyright 2018 datagear.tech. All Rights Reserved.
 */
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/jsp_import.jsp" %>
<%@ include file="../include/jsp_ajax_request.jsp" %>
<%@ include file="../include/jsp_jstl.jsp" %>
<%@ include file="../include/jsp_method_get_string_value.jsp" %>
<%@ include file="../include/jsp_page_id.jsp" %>
<%@ include file="../include/html_doctype.jsp" %>
<%
boolean isPreview = "1".equals(getStringValue(request, "preview"));
%>
<html>
<head>
<%@ include file="../include/html_head.jsp" %>
<title><%@ include file="../include/html_title_app_name.jsp" %><fmt:message key='schema.schemaBuildUrl' /></title>
</head>
<body>
<div id="${pageId}" class="page-form page-form-buildSchemaUrl">
	<div id="dbUrlBuilderScriptCode" style="display: none;">
		$.schemaUrlBuilder.add(
		<%=request.getAttribute("scriptCode")%>
		);
	</div>
	<form id="${pageId}-form" action="#" method="POST">
		<div class="form-head"></div>
		<div class="form-content">
			<div class="form-item">
				<div class="form-item-label">
					<label><fmt:message key='schema.url.dbType' /></label>
				</div>
				<div class="form-item-value">
					<select name="dbType">
					</select>
				</div>
			</div>
			<div class="form-item">
				<div class="form-item-label">
					<label><fmt:message key='schema.url.host' /></label>
				</div>
				<div class="form-item-value">
					<input type="text" name="host" value="" class="ui-widget ui-widget-content" />
				</div>
			</div>
			<div class="form-item">
				<div class="form-item-label">
					<label><fmt:message key='schema.url.port' /></label>
				</div>
				<div class="form-item-value">
					<input type="text" name="port" value="" class="ui-widget ui-widget-content" />
				</div>
			</div>
			<div class="form-item">
				<div class="form-item-label">
					<label><fmt:message key='schema.url.name' /></label>
				</div>
				<div class="form-item-value">
					<input type="text" name="name" value="" class="ui-widget ui-widget-content" />
				</div>
			</div>
		</div>
		<div class="form-foot" style="text-align:center;">
			<input type="submit" value="<fmt:message key='confirm' />" class="recommended" />
		</div>
	</form>
	<%if(isPreview){%>
	<div class="url-preview"></div>
	<%}%>
</div>
<%@ include file="../include/page_js_obj.jsp" %>
<script type="text/javascript">
(function(pageObj)
{
	pageObj.form = pageObj.element("#${pageId}-form");
	pageObj.dbTypeSelect = pageObj.element("select[name='dbType']");

	pageObj.initUrl = "<c:out value='${url}' />";
	
	$("input:submit, input:button, input:reset, button", pageObj.page).button();
	
	$.schemaUrlBuilder.clear();
	var scriptCode = pageObj.element("#dbUrlBuilderScriptCode").text();
	try
	{
		eval(scriptCode);
	}
	catch(e)
	{
		$.tipError("<fmt:message key='schema.loadUrlBuilderScriptError' /><fmt:message key='colon' />" + e.message);
	}
	
	var builderInfos = $.schemaUrlBuilder.list();
	for(var i=0; i<builderInfos.length; i++)
	{
		var builderInfo = builderInfos[i];
		$("<option>").attr("value", builderInfo.dbType).html(builderInfo.dbDesc).appendTo(pageObj.dbTypeSelect);
	}
	
	pageObj.dbTypeSelect.selectmenu(
	{
		"classes" : { "ui-selectmenu-button" : "schema-build-url-dbtype-select" },
		change : function(event, ui)
		{
			var dbType = ui.item.value;
			
			var defaultUrlInfo = $.schemaUrlBuilder.defaultValue(dbType);
			pageObj.setFormUrlValue(defaultUrlInfo);
		}
	});
	
	pageObj.setFormUrlValue = function(value)
	{
		if(!value)
			return;
		
		for(var name in value)
		{
			var inputValue = value[name];
			
			if(inputValue)
				pageObj.element("input[name='"+name+"']").val(inputValue);
		}
	};
	
	pageObj.buildFormUrl = function()
	{
		var dbType = pageObj.dbTypeSelect.val();
		
		var value = {};
		
		var inputs = pageObj.element("input[type='text']");
		for(var i=0; i<inputs.length; i++)
		{
			var input = $(inputs[i]);
			value[input.attr("name")] = input.val();
		}
		
		return $.schemaUrlBuilder.build(dbType, value);
	};
	
	pageObj.form.validate(
	{
		submitHandler : function(form)
		{
			var url = pageObj.buildFormUrl();
			
			<%if(isPreview){%>
			pageObj.element(".url-preview").text(url);
			<%}else{%>
			var pageParam = pageObj.pageParam();
			
			var close = true;
			
			if(pageParam && pageParam.setSchemaUrl)
				close = (pageParam.setSchemaUrl(url) != false);
			
			if(close)
				pageObj.close();
			<%}%>
			
			return false;
		},
		errorPlacement : function(error, element)
		{
			error.appendTo(element.closest(".form-item-value"));
		}
	});
	
	var initUrlValue = undefined;
	
	if(pageObj.initUrl)
	{
		var urlInfo = $.schemaUrlBuilder.extract(pageObj.initUrl);
		
		if(urlInfo != null)
		{
			pageObj.dbTypeSelect.val(urlInfo.dbType);
			pageObj.dbTypeSelect.selectmenu("refresh");
			initUrlValue = urlInfo.value;
		}
	}
	
	if(!initUrlValue)
		initUrlValue = $.schemaUrlBuilder.defaultValue(pageObj.dbTypeSelect.val());
	
	pageObj.setFormUrlValue(initUrlValue);
})
(${pageId});
</script>
</body>
</html>