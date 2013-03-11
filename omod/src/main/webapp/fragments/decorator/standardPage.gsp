${ ui.includeFragment("kenyaui", "standardIncludes") }

<% if (config.beforeContent) { %>${ config.beforeContent }<% } %>

${ ui.includeFragment("kenyaui", "flashMessage") }

<div id="content">
	<%= config.content %>
</div>