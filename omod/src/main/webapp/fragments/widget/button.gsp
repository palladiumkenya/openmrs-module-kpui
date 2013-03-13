<%
	// Supports icon, iconProvider, iconOverlay, label, extra
	// Supports onClick (javascript snippet)
	// Supports href (link url)
	// Supports classes (applied to button)

	def id = config.id ?: ui.randomId("button")

	def classes = [ "ke-control", "ke-button" ];

	if (config.classes) {
		classes.addAll(config.classes)
	}
%>
<div id="${ id }" class="${ classes.join(' ') }">
	<% if (config.icon && config.iconProvider) { %>
		${ ui.includeFragment("kenyaui", "widget/icon", [ iconProvider: config.iconProvider, icon: config.icon, iconOverlay: config.iconProvider, iconOverlayProvider: config.iconOverlayProvider ]) }
	<% } %>
	<div style="float: left">
	<% if (config.label) { %>
		<span class="ke-label">${ config.label }</span>
	<% } %>
	<% if (config.extra) { %>
		<br/>
		<span class="ke-extra">${ config.extra }</span>
	<% } %>
	</div>
</div>

<% if (config.href || config.onClick) { %>
<script type="text/javascript">
jq(function() {
	jq('#${ id }').click(function() {
		<% if (config.onClick) { %>
			${ config.onClick }
		<% } %>
		<% if (config.href) { %>
			location.href = '${ ui.escapeJs(config.href) }'
		<% } %>
	});
});
</script>
<% } %>