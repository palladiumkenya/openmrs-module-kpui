${ ui.includeFragment("kenyaui", "standardIncludes") }

<% if (config.beforeContent) { %>${ config.beforeContent }<% } %>

${ ui.includeFragment("kenyaui", "notifications") }

<style type="text/css">
	.ke-loading {
		background-image: url('${ ui.resourceLink("kenyaui", "images/loader_small.gif") }');
	}
</style>
<div id="content">
	<%= config.content %>
</div>