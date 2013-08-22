<%
	// Supports icon, iconProvider
	// Supports onClick (javascript snippet)
	// Supports href (link url)

	def id = config.id ?: ui.randomId("button")

	def icons = [ edit: "edit.png", add: "add.png", void: "void.png" ]
%>
<div id="${ id }" class="ke-buttonlet">
	<img src="${ ui.resourceLink("kenyaui", "images/buttonlets/" + icons[config.type]) }" />
	<% if (config.label) { %>
		<span class="ke-label">${ config.label }</span>
	<% } %>
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