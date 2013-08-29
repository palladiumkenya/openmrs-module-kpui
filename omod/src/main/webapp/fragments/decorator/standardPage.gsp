<% ui.includeJavascript("kenyaui", "jquery.js") %>
<% ui.includeJavascript("kenyaui", "jquery-ui.js") %>
<% ui.includeJavascript("kenyaui", "select2.js") %>
<% ui.includeJavascript("kenyaui", "jquery.toastmessage.js") %>
<% ui.includeJavascript("kenyaui", "pagebus/simple/pagebus.js") %>
<% ui.includeJavascript("kenyaui", "ui.js") %>
<% ui.includeJavascript("kenyaui", "kenyaui.js") %>

<% ui.includeCss("kenyaui", "jquery-ui.css") %>
<% ui.includeCss("kenyaui", "select2.css") %>
<% ui.includeCss("kenyaui", "toastmessage/css/jquery.toastmessage.css") %>
<% ui.includeCss("kenyaui", "kenyaui.css") %>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<% if (config.pageTitle) { %><title>${ config.pageTitle }</title><% } %>
		<% if (config.faviconIco) { %><link rel="shortcut icon" type="image/ico" href="${ config.faviconIco }"><% } %>
		<% if (config.faviconPng) { %><link rel="icon" type="image/png" href="${ config.faviconPng }"><% } %>

		<%= ui.resourceLinks() %>
	</head>
	<body>
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