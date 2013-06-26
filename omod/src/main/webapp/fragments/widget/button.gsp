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
		${ ui.includeFragment("kenyaui", "widget/icon", [ iconProvider: config.iconProvider, icon: config.icon, iconOverlay: config.iconOverlay, iconOverlayProvider: config.iconOverlayProvider ]) }
	<% } %>
	<div class="ke-button-text">
	<% if (config.label) { %>
		<div class="ke-label">${ config.label }</div>
	<% } %>
	<% if (config.extra) { %>
		<div class="ke-extra">${ config.extra }</div>
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