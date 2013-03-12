${ ui.includeFragment("kenyaui", "standardIncludes") }

<% if (config.beforeContent) { %>${ config.beforeContent }<% } %>

${ ui.includeFragment("kenyaui", "notifications") }

<div id="content">
	<%= config.content %>
</div>