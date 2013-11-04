<%
	// Supports icon, iconProvider
	// Supports onClick (javascript snippet)
	// Supports href (link url)

	def id = config.id ?: ui.randomId("button")

	def icons = [ view: "view.png", edit: "edit.png", add: "add.png", void: "void.png", switch: "switch.png", excel: "excel.png" ]

	def icon = config.type ? icons[config.type] : config.icon
%>
<div id="${ id }" class="ke-buttonlet">
	<% if (icon) { %><img src="${ ui.resourceLink("kenyaui", "images/glyphs/" + icons[config.type]) }" /><% } %>
	<% if (config.label) { %><span class="ke-label">${ config.label }</span><% } %>
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