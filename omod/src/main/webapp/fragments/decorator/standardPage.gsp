${ ui.includeFragment("kenyaui", "standardIncludes") }

<% if (config.beforeContent) { %>
	${ config.beforeContent }
<% } %>

${ ui.includeFragment("kenyaui", "notifications") }

<style type="text/css">
	.ke-loading {
		background-image: url('${ ui.resourceLink("kenyaui", "images/loader_small.gif") }');
	}
	/**
	 * Override styles for toasts
	 */
	.toast-item {
		background-color: #464640;
		border-radius: 3px;
		border: 0;
	}
</style>
<div class="ke-page-container">
	<%= config.content %>
</div>