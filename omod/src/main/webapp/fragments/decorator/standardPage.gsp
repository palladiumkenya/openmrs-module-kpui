<!-- Oddly resource ordering values are highest-first -->
<% ui.includeJavascript("kenyaui", "jquery.js", 100) %>
<% ui.includeJavascript("kenyaui", "angular.js", 99) %>
<% ui.includeJavascript("kenyaui", "select2.js", 98) %>
<% ui.includeJavascript("kenyaui", "jquery-ui.js", 97) %>
<% ui.includeJavascript("kenyaui", "jquery.toastmessage.js", 96) %>
<% ui.includeJavascript("kenyaui", "pagebus/simple/pagebus.js", 95) %>
<% ui.includeJavascript("kenyaui", "ui.js", 94) %>
<% ui.includeJavascript("kenyaui", "kenyaui.js", 93) %>

<% ui.includeCss("kenyaui", "select2.css", 100) %>
<% ui.includeCss("kenyaui", "jquery-ui.css", 99) %>
<% ui.includeCss("kenyaui", "toastmessage/css/jquery.toastmessage.css", 98) %>
<% ui.includeCss("kenyaui", "kenyaui.css", 97) %>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<% if (config.pageTitle) { %><title>${ config.pageTitle }</title><% } %>
		<% if (config.faviconIco) { %><link rel="shortcut icon" type="image/ico" href="${ config.faviconIco }"><% } %>
		<% if (config.faviconPng) { %><link rel="icon" type="image/png" href="${ config.faviconPng }"><% } %>

		<%= ui.resourceLinks() %>
	</head>
	<body ng-app="kenyaemr">
		<script type="text/javascript">
			var OPENMRS_CONTEXT_PATH = '${ contextPath }';
		</script>

		${ ui.includeFragment("kenyaui", "notifications") }

		<% if (config.beforeContent) { %>
			${ config.beforeContent }
		<% } %>

		<div class="ke-page-container">
			<%= config.content %>
		</div>
	</body>
</html>